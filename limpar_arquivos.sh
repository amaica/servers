#!/bin/bash

# Script para limpar vídeos e executáveis no servidor
# Preserva executáveis em /mnt/dados/grupos/todos/TI

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Diretório protegido
DIR_PROTEGIDO="/mnt/dados/grupos/todos/TI"

# Extensões de vídeo
EXTENSOES_VIDEO=("mp4" "avi" "mkv" "mov" "wmv" "flv" "webm" "m4v" "mpg" "mpeg" "3gp" "ogv" "divx" "xvid")

# Extensões de executáveis
EXTENSOES_EXEC=("exe" "bin" "deb" "rpm" "app" "dmg" "pkg" "msi")

# Diretórios a serem limpos (ajuste conforme necessário)
DIRS_LIMPAR=(
    "/mnt/dados"
    "/tmp"
    "/var/tmp"
    "/home"
)

# Arquivos temporários
TEMP_VIDEOS="/tmp/videos_para_deletar.txt"
TEMP_EXECS="/tmp/execs_para_deletar.txt"
TEMP_TODOS="/tmp/todos_arquivos.txt"

# Limpar arquivos temporários anteriores
rm -f "$TEMP_VIDEOS" "$TEMP_EXECS" "$TEMP_TODOS"

echo -e "${YELLOW}=== Script de Limpeza de Vídeos e Executáveis ===${NC}"
echo ""
echo "Diretório protegido: $DIR_PROTEGIDO"
echo ""

# Função para verificar se arquivo está no diretório protegido
esta_protegido() {
    local arquivo="$1"
    if [[ "$arquivo" == "$DIR_PROTEGIDO"* ]]; then
        return 0  # Está protegido
    fi
    return 1  # Não está protegido
}

# Função para encontrar vídeos
encontrar_videos() {
    echo -e "${YELLOW}Procurando arquivos de vídeo...${NC}"
    local count=0
    
    for dir in "${DIRS_LIMPAR[@]}"; do
        if [ ! -d "$dir" ]; then
            echo "  Aviso: Diretório $dir não existe, pulando..."
            continue
        fi
        
        for ext in "${EXTENSOES_VIDEO[@]}"; do
            find "$dir" -type f -iname "*.${ext}" 2>/dev/null | while read arquivo; do
                if ! esta_protegido "$arquivo"; then
                    echo "$arquivo" >> "$TEMP_VIDEOS"
                    ((count++))
                fi
            done
        done
    done
    
    echo "  Encontrados: $(wc -l < "$TEMP_VIDEOS" 2>/dev/null || echo 0) arquivos de vídeo"
}

# Função para encontrar executáveis
encontrar_executaveis() {
    echo -e "${YELLOW}Procurando arquivos executáveis...${NC}"
    local count=0
    
    for dir in "${DIRS_LIMPAR[@]}"; do
        if [ ! -d "$dir" ]; then
            continue
        fi
        
        # Buscar por extensão
        for ext in "${EXTENSOES_EXEC[@]}"; do
            find "$dir" -type f -iname "*.${ext}" 2>/dev/null | while read arquivo; do
                if ! esta_protegido "$arquivo"; then
                    echo "$arquivo" >> "$TEMP_EXECS"
                fi
            done
        done
        
        # Buscar por permissão de execução (mas não scripts .sh em diretórios do sistema)
        find "$dir" -type f -perm -111 2>/dev/null | while read arquivo; do
            # Ignorar arquivos em /usr, /bin, /sbin, /lib, /opt (sistema)
            if [[ "$arquivo" =~ ^/(usr|bin|sbin|lib|opt|etc|var/lib) ]]; then
                continue
            fi
            # Ignorar se estiver protegido
            if ! esta_protegido "$arquivo"; then
                # Verificar se não é um script shell comum do sistema
                if ! file "$arquivo" 2>/dev/null | grep -qE "(shell script|ELF.*executable)"; then
                    # Adicionar apenas se não for um arquivo de sistema conhecido
                    local basename_arquivo=$(basename "$arquivo")
                    if [[ ! "$basename_arquivo" =~ ^(bash|sh|dash|zsh|python|perl|ruby)$ ]]; then
                        echo "$arquivo" >> "$TEMP_EXECS"
                    fi
                fi
            fi
        done
    done
    
    # Remover duplicatas
    if [ -f "$TEMP_EXECS" ]; then
        sort -u "$TEMP_EXECS" -o "$TEMP_EXECS"
    fi
    
    echo "  Encontrados: $(wc -l < "$TEMP_EXECS" 2>/dev/null || echo 0) arquivos executáveis"
}

# Função para calcular tamanho total
calcular_tamanho() {
    local arquivo_lista="$1"
    if [ ! -f "$arquivo_lista" ] || [ ! -s "$arquivo_lista" ]; then
        echo "0"
        return
    fi
    
    local tamanho=$(cat "$arquivo_lista" | xargs -r du -cb 2>/dev/null | tail -1 | cut -f1)
    echo "${tamanho:-0}"
}

# Função para formatar tamanho
formatar_tamanho() {
    local bytes=$1
    if [ "$bytes" -gt 1073741824 ]; then
        echo "$(echo "scale=2; $bytes/1073741824" | bc) GB"
    elif [ "$bytes" -gt 1048576 ]; then
        echo "$(echo "scale=2; $bytes/1048576" | bc) MB"
    elif [ "$bytes" -gt 1024 ]; then
        echo "$(echo "scale=2; $bytes/1024" | bc) KB"
    else
        echo "${bytes} bytes"
    fi
}

# Modo DRY-RUN (apenas listar, não deletar)
MODO_DRY_RUN=${1:-"dry-run"}

if [ "$MODO_DRY_RUN" != "executar" ]; then
    echo -e "${GREEN}Modo DRY-RUN: Apenas listando arquivos, nada será deletado${NC}"
    echo ""
fi

# Encontrar arquivos
encontrar_videos
encontrar_executaveis

# Combinar listas
cat "$TEMP_VIDEOS" "$TEMP_EXECS" 2>/dev/null | sort -u > "$TEMP_TODOS"

total_arquivos=$(wc -l < "$TEMP_TODOS" 2>/dev/null || echo 0)

if [ "$total_arquivos" -eq 0 ]; then
    echo ""
    echo -e "${GREEN}Nenhum arquivo encontrado para deletar.${NC}"
    exit 0
fi

# Calcular tamanho total
tamanho_videos=$(calcular_tamanho "$TEMP_VIDEOS")
tamanho_execs=$(calcular_tamanho "$TEMP_EXECS")
tamanho_total=$((tamanho_videos + tamanho_execs))

echo ""
echo -e "${YELLOW}=== Resumo ===${NC}"
echo "Vídeos encontrados: $(wc -l < "$TEMP_VIDEOS" 2>/dev/null || echo 0)"
echo "Executáveis encontrados: $(wc -l < "$TEMP_EXECS" 2>/dev/null || echo 0)"
echo "Total de arquivos: $total_arquivos"
echo "Tamanho total aproximado: $(formatar_tamanho $tamanho_total)"
echo ""

# Mostrar alguns exemplos
echo -e "${YELLOW}Primeiros 10 arquivos a serem deletados:${NC}"
head -10 "$TEMP_TODOS" | nl
echo ""

if [ "$MODO_DRY_RUN" != "executar" ]; then
    echo -e "${GREEN}Para realmente deletar os arquivos, execute:${NC}"
    echo "  $0 executar"
    echo ""
    echo "Ou revise os arquivos listados em:"
    echo "  Vídeos: $TEMP_VIDEOS"
    echo "  Executáveis: $TEMP_EXECS"
    echo "  Todos: $TEMP_TODOS"
    exit 0
fi

# Confirmar antes de deletar
echo -e "${RED}ATENÇÃO: Você está prestes a deletar $total_arquivos arquivos!${NC}"
echo -e "${RED}Tamanho total: $(formatar_tamanho $tamanho_total)${NC}"
echo ""
read -p "Digite 'SIM' para confirmar a exclusão: " confirmacao

if [ "$confirmacao" != "SIM" ]; then
    echo -e "${YELLOW}Operação cancelada.${NC}"
    exit 1
fi

# Deletar arquivos
echo ""
echo -e "${YELLOW}Deletando arquivos...${NC}"
deletados=0
erros=0

while IFS= read -r arquivo; do
    if [ -f "$arquivo" ]; then
        if rm -f "$arquivo" 2>/dev/null; then
            ((deletados++))
            if [ $((deletados % 100)) -eq 0 ]; then
                echo "  Deletados: $deletados arquivos..."
            fi
        else
            ((erros++))
            echo "  Erro ao deletar: $arquivo" >&2
        fi
    fi
done < "$TEMP_TODOS"

echo ""
echo -e "${GREEN}=== Concluído ===${NC}"
echo "Arquivos deletados: $deletados"
echo "Erros: $erros"
echo ""

# Limpar arquivos temporários
rm -f "$TEMP_VIDEOS" "$TEMP_EXECS" "$TEMP_TODOS"

