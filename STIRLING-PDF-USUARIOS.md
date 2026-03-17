# Stirling PDF - Versão para Usuário Normal (sem menus de configuração)

## Como funciona

O Stirling PDF usa **roles** (papéis) de usuário:
- **Admin**: vê menus de configuração, pode criar usuários, alterar sistema
- **Usuário normal**: vê apenas as ferramentas PDF, sem configurações

## Acesso

**URL:** http://192.168.56.20:8180

## Credenciais Admin (para você configurar)

- **Usuário:** `admin`
- **Senha:** `admin123`  
  (ou a que você definir em SECURITY_INITIALLOGIN_PASSWORD)

No primeiro acesso como admin, a aplicação pode pedir para alterar a senha.

## Como criar usuários normais

1. Acesse http://192.168.56.20:8180
2. Faça login como **admin**
3. Clique no ícone de **engrenagem** (canto superior direito) → **Configurações da conta**
4. Role até **Configurações de administrador**
5. Na seção **Gerenciamento de usuários**, clique em **Adicionar usuário**
6. Crie o usuário com:
   - Nome de usuário
   - Senha
   - **Role:** `USER` (não marque como admin)

Usuários com role **USER** não veem o menu de configurações.

## Resumo

| Tipo       | Vê configurações? | Vê ferramentas PDF? |
|------------|-------------------|----------------------|
| Admin      | Sim               | Sim                  |
| Usuário normal | Não            | Sim                  |

Usuários normais só usam as ferramentas (juntar, dividir, converter, etc.) sem acessar o painel administrativo.
