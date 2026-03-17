# Prompt: Evolution API + MinIO – Mídias do WhatsApp

Use este prompt ao integrar a Evolution API com MinIO/S3 ou ao configurar sistemas que consomem o webhook de mensagens com mídia.

---

## Prompt

```
Contexto: Integração da Evolution API com MinIO/S3 para armazenar mídias do WhatsApp (imagens, vídeos, áudios, documentos, stickers).

Quando a Evolution recebe uma mensagem com mídia, ela:
1. Baixa o arquivo do CDN do WhatsApp
2. Envia para o MinIO/S3 (se configurado)
3. Retorna dois links no webhook/banco:

   - url: Link original do CDN do WhatsApp (ex: https://mmg.whatsapp.net/v/t62.xxx/...)
     • Temporário, expira
     • Indica de onde a Evolution baixou o arquivo
     • NÃO usar para persistência ou exibição

   - mediaUrl: Link do arquivo no MinIO (ex: https://s3minio.synkicrm.com.br/evolution/...)
     • Persistente
     • É o que deve ser usado para exibir, armazenar e compartilhar a mídia

Regra obrigatória: Ao processar mensagens com mídia no webhook da Evolution API (ou em views SQL, integrações como Chatwoot, N8N, Make, etc.), SEMPRE usar o campo mediaUrl como fonte principal do arquivo. O campo url deve ser ignorado para persistência e exibição.

Configuração Evolution API necessária:
- S3_ENABLED=true
- S3_SAVE_VIDEO=true (para incluir vídeos no MinIO)

Problema comum: Sistemas que usam url em vez de mediaUrl resultam em links quebrados ou expirados.
```

---

## Na view SQL (message_view)

| Coluna | Use? | Origem |
|--------|------|--------|
| `media_url` | ✅ Sim | MinIO (persistente) |
| `image_url` | ❌ Não | WhatsApp (temporário) |
| `video_url` | ❌ Não | WhatsApp (temporário) |
| `audio_url` | ❌ Não | WhatsApp (temporário) |
| `document_url` | ❌ Não | WhatsApp (temporário) |
| `sticker_url` | ❌ Não | WhatsApp (temporário) |

---

## Versão curta (para copiar em contextos limitados)

```
Evolution API + MinIO: usar mediaUrl (MinIO persistente), NÃO url (CDN WhatsApp temporário). S3_ENABLED=true, S3_SAVE_VIDEO=true.
```
