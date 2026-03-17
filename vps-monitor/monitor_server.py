#!/usr/bin/env python3
"""
Monitor VPS - Servidor HTTP simples para monitoramento de recursos.
Roda na rede interna, sem autenticação.
Uso: python3 monitor_server.py [--port 8888]
"""

import json
import subprocess
import re
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import argparse
from datetime import datetime


def get_stats():
    """Coleta estatísticas do sistema via comandos nativos."""
    stats = {"erro": False, "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
    try:
        # Uptime e Load
        uptime_out = subprocess.run(["uptime"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        stats["uptime_raw"] = uptime_out.stdout.strip()
        load_match = re.search(r"load average[s]?:\s*(.+)", uptime_out.stdout)
        stats["load"] = load_match.group(1).strip() if load_match else "N/A"
        stats["uptime"] = uptime_out.stdout.split("up")[1].split(",")[0].strip()

        # Memória (free -b para precisão)
        free_out = subprocess.run(["free", "-b"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        lines = free_out.stdout.strip().split("\n")
        mem_line = lines[1].split()
        total = int(mem_line[1])
        used = int(mem_line[2])
        avail = int(mem_line[6]) if len(mem_line) > 6 else int(mem_line[3])
        stats["mem_total"] = f"{total // (1024**3)}Gi"
        stats["mem_used"] = f"{used // (1024**3)}Gi"
        stats["mem_free"] = f"{int(mem_line[3]) // (1024**3)}Gi"
        stats["mem_available"] = f"{avail // (1024**3)}Gi"
        stats["mem_percent"] = round((used / total * 100), 1) if total > 0 else 0

        # Disco (df -h /)
        df_out = subprocess.run(["df", "-h", "/"], stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
        df_parts = df_out.stdout.strip().split("\n")[1].split()
        stats["disk_total"] = df_parts[1]
        stats["disk_used"] = df_parts[2]
        stats["disk_avail"] = df_parts[3]
        stats["disk_percent"] = df_parts[4].replace("%", "")

        # Top 10 processos por CPU
        ps_out = subprocess.run(
            ["ps", "aux", "--sort=-%cpu"],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            universal_newlines=True,
        )
        lines = ps_out.stdout.strip().split("\n")[1:11]
        stats["top_cpu"] = []
        for l in lines:
            parts = re.split(r"\s+", l, 10)
            if len(parts) >= 11:
                stats["top_cpu"].append(
                    {"user": parts[0], "cpu": parts[2], "mem": parts[3], "cmd": parts[10][:60]}
                )

        # Top 10 processos por memória
        ps_mem = subprocess.run(
            ["ps", "aux", "--sort=-%mem"],
            stdout=subprocess.PIPE, stderr=subprocess.PIPE,
            universal_newlines=True,
        )
        lines = ps_mem.stdout.strip().split("\n")[1:11]
        stats["top_mem"] = []
        for l in lines:
            parts = re.split(r"\s+", l, 10)
            if len(parts) >= 11:
                stats["top_mem"].append(
                    {"user": parts[0], "cpu": parts[2], "mem": parts[3], "cmd": parts[10][:60]}
                )

    except Exception as e:
        stats["erro"] = True
        stats["erro_msg"] = str(e)
    return stats


def get_html():
    """Retorna o HTML da página de monitoramento."""
    return """<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Monitor VPS - Recursos</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Segoe UI', system-ui, sans-serif;
      background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
      color: #e2e8f0;
      min-height: 100vh;
      padding: 1.5rem;
    }
    .container { max-width: 1100px; margin: 0 auto; }
    h1 {
      font-size: 1.75rem;
      margin-bottom: 0.5rem;
      color: #f8fafc;
    }
    .sub { color: #94a3b8; font-size: 0.9rem; margin-bottom: 1.5rem; }
    .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1rem; margin-bottom: 1.5rem; }
    .card {
      background: rgba(30, 41, 59, 0.8);
      border-radius: 12px;
      padding: 1.25rem;
      border: 1px solid rgba(148, 163, 184, 0.2);
    }
    .card h2 { font-size: 0.95rem; color: #94a3b8; margin-bottom: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; }
    .card .value { font-size: 1.75rem; font-weight: 700; color: #22c55e; }
    .card .value.warn { color: #f59e0b; }
    .card .value.danger { color: #ef4444; }
    .bar {
      height: 8px;
      background: rgba(15, 23, 42, 0.6);
      border-radius: 4px;
      overflow: hidden;
      margin-top: 0.5rem;
    }
    .bar-fill { height: 100%; background: linear-gradient(90deg, #22c55e, #3b82f6); border-radius: 4px; transition: width 0.3s; }
    .bar-fill.warn { background: #f59e0b; }
    .bar-fill.danger { background: #ef4444; }
    table { width: 100%; font-size: 0.85rem; border-collapse: collapse; }
    th, td { text-align: left; padding: 0.5rem 0.75rem; }
    th { color: #94a3b8; font-weight: 500; }
    tr:nth-child(even) { background: rgba(15, 23, 42, 0.4); }
    .full { grid-column: 1 / -1; overflow-x: auto; }
    .refresh { color: #64748b; font-size: 0.8rem; }
    .dot { display: inline-block; width: 8px; height: 8px; border-radius: 50%; background: #22c55e; animation: pulse 2s infinite; }
    @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.5} }
    .error { color: #ef4444; padding: 1rem; background: rgba(239,68,68,0.2); border-radius: 8px; }
    .actions { display: flex; gap: 0.75rem; flex-wrap: wrap; margin-bottom: 1rem; }
    .btn {
      padding: 0.6rem 1.2rem;
      border: none;
      border-radius: 8px;
      font-size: 0.9rem;
      cursor: pointer;
      font-weight: 500;
    }
    .btn-restart { background: #f59e0b; color: #1e293b; }
    .btn-restart:hover { background: #fbbf24; }
    .btn-restart:disabled { opacity: 0.6; cursor: not-allowed; }
  </style>
</head>
<body>
  <div class="container">
    <h1>Monitor VPS</h1>
    <p class="sub"><span class="dot"></span> Atualiza a cada 5 segundos | Rede interna</p>
    <div class="actions">
      <button class="btn btn-restart" onclick="restartService('glassfish')" title="Reinicia o servidor GlassFish (Tecnicon)">Reiniciar GlassFish</button>
      <button class="btn btn-restart" onclick="restartService('monitor')" title="Reinicia esta página de monitoramento">Reiniciar Monitor</button>
    </div>
    <div id="content">
      <p>Carregando...</p>
    </div>
  </div>
  <script>
    async function load() {
      try {
        const r = await fetch('/stats');
        const d = await r.json();
        if (d.erro) throw new Error(d.erro_msg || 'Erro ao obter dados');
        render(d);
      } catch (e) {
        document.getElementById('content').innerHTML = '<div class="error">Erro: ' + e.message + '</div>';
      }
    }
    function pct(p) { return Math.min(100, parseFloat(p) || 0); }
    function barClass(p) { return p > 85 ? 'danger' : p > 70 ? 'warn' : ''; }
    function render(d) {
      const memP = pct(d.mem_percent);
      const diskP = pct(d.disk_percent);
      let html = '<div class="grid">';
      html += '<div class="card"><h2>Memória</h2><div class="value ' + barClass(memP) + '">' + (d.mem_used || '') + ' / ' + (d.mem_total || '') + '</div><div class="bar"><div class="bar-fill ' + barClass(memP) + '" style="width:' + memP + '%"></div></div></div>';
      html += '<div class="card"><h2>Disco (/)</h2><div class="value ' + barClass(diskP) + '">' + (d.disk_used || '') + ' / ' + (d.disk_total || '') + '</div><div class="bar"><div class="bar-fill ' + barClass(diskP) + '" style="width:' + diskP + '%"></div></div></div>';
      html += '<div class="card"><h2>Uptime</h2><div class="value">' + (d.uptime || 'N/A') + '</div></div>';
      html += '<div class="card"><h2>Load Average</h2><div class="value">' + (d.load || 'N/A') + '</div></div>';
      html += '</div>';
      html += '<div class="grid"><div class="card full"><h2>Top 10 - CPU</h2><table><tr><th>Usuário</th><th>CPU%</th><th>MEM%</th><th>Processo</th></tr>';
      (d.top_cpu || []).forEach(p => { html += '<tr><td>'+p.user+'</td><td>'+p.cpu+'%</td><td>'+p.mem+'%</td><td>'+p.cmd+'</td></tr>'; });
      html += '</table></div></div>';
      html += '<div class="grid"><div class="card full"><h2>Top 10 - Memória</h2><table><tr><th>Usuário</th><th>CPU%</th><th>MEM%</th><th>Processo</th></tr>';
      (d.top_mem || []).forEach(p => { html += '<tr><td>'+p.user+'</td><td>'+p.cpu+'%</td><td>'+p.mem+'%</td><td>'+p.cmd+'</td></tr>'; });
      html += '</table></div></div>';
      html += '<p class="refresh">Última atualização: ' + (d.timestamp || '') + '</p>';
      document.getElementById('content').innerHTML = html;
    }
    load();
    setInterval(load, 5000);
    async function restartService(name) {
      if (!confirm('Reiniciar ' + (name === 'glassfish' ? 'GlassFish' : 'Monitor') + '? A operação pode levar alguns segundos.')) return;
      const btn = event.target;
      btn.disabled = true;
      btn.textContent = 'Reiniciando...';
      try {
        const r = await fetch('/restart?service=' + name);
        const d = await r.json();
        if (d.ok) alert(d.msg || 'Comando enviado.');
        else alert('Erro: ' + (d.msg || r.status));
      } catch (e) { alert('Erro: ' + e.message); }
      btn.disabled = false;
      btn.textContent = name === 'glassfish' ? 'Reiniciar GlassFish' : 'Reiniciar Monitor';
    }
  </script>
</body>
</html>"""


def run_restart(service):
    """Executa systemctl restart para o serviço indicado. Retorna (ok, msg)."""
    if service == "glassfish":
        cmd = ["systemctl", "restart", "GlassFish_DominioTecnicon.service"]
    elif service == "monitor":
        cmd = ["systemctl", "restart", "vps-monitor.service"]
    else:
        return False, "Serviço inválido. Use: glassfish ou monitor"
    try:
        r = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True, timeout=30)
        if r.returncode == 0:
            return True, "Reinício solicitado com sucesso."
        return False, r.stderr or r.stdout or f"Código de saída: {r.returncode}"
    except subprocess.TimeoutExpired:
        return True, "Comando em execução (pode levar até 1 minuto)."
    except Exception as e:
        return False, str(e)


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        path = urlparse(self.path).path
        query = urlparse(self.path).query
        if path == "/stats":
            try:
                stats = get_stats()
                body = json.dumps(stats, ensure_ascii=False).encode("utf-8")
            except Exception as e:
                body = json.dumps({"erro": True, "erro_msg": str(e)}).encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.send_header("Access-Control-Allow-Origin", "*")
            self.end_headers()
            self.wfile.write(body)
        elif path == "/restart":
            params = parse_qs(query)
            service = (params.get("service") or [""])[0]
            ok, msg = run_restart(service)
            body = json.dumps({"ok": ok, "msg": msg}, ensure_ascii=False).encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "application/json; charset=utf-8")
            self.end_headers()
            self.wfile.write(body)
        else:
            body = get_html().encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/html; charset=utf-8")
            self.end_headers()
            self.wfile.write(body)

    def log_message(self, format, *args):
        print(f"[{datetime.now().strftime('%H:%M:%S')}] {args[0]}")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--port", type=int, default=8888, help="Porta do servidor")
    ap.add_argument("--host", default="0.0.0.0", help="Host (0.0.0.0 = rede interna)")
    args = ap.parse_args()
    addr = (args.host, args.port)
    print(f"Monitor VPS rodando em http://{addr[0]}:{addr[1]}/")
    print("Rede interna - sem autenticação")
    while True:
        try:
            server = HTTPServer(addr, Handler)
            server.serve_forever()
        except KeyboardInterrupt:
            print("Encerrado pelo usuario.")
            break
        except Exception as e:
            print(f"[ERRO] {e}. Reiniciando em 5s...")
            import time
            time.sleep(5)


if __name__ == "__main__":
    main()
