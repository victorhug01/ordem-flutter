# cabeleleila

Um projeto de teste para DSIN tecnologia

# Download

[📥 Download APK](https://github.com/victorhug01/cabeleleila-leila/blob/main/assets/app-release.apk)

# Relato do Desenvolvimento do Sistema para o Salão Cabeleleïla Leila

## Visão Geral
Durante o desafio proposto, optei por utilizar **Flutter** para o desenvolvimento do aplicativo, garantindo uma experiência multiplataforma (Android e iOS) e uma interface intuitiva para os clientes e para a Leila. Para o backend e autenticação, escolhi o **Supabase**, uma solução robusta e escalável que oferece autenticação, banco de dados em tempo real e armazenamento.

## Funcionalidades Implementadas

### ✅ Autenticação Segura
- Cadastro de clientes com e-mail e senha.
- Login com validação de credenciais.
- Recuperação de senha via token (envio de e-mail com código para redefinição).


## 💡 Próximas Etapas (Planejadas)
- Implementação do agendamento online com restrições de alteração (até 2 dias antes).
- Histórico de agendamentos com filtros por período.
- Sugestão de reagendamento automático para clientes com múltiplos serviços na mesma semana.
- Painel administrativo para a Leila gerenciar agendamentos (alterações, confirmações, status).
- Dashboard gerencial com métricas de desempenho semanal (faturamento, serviços mais populares).

## 💻 Tecnologias Utilizadas
- **Flutter**: Para a interface do usuário responsiva.
- **Supabase**: Autenticação, banco de dados PostgreSQL e armazenamento de arquivos.
- **Provider**: Gerenciamento de estado para controle de fluxo.
- **MVVM**: Arquitetura.

## 📚 Configuração e Execução

### Requisitos
- Flutter SDK instalado ([Instalação](https://flutter.dev/docs/get-started/install))
- Conta no [Supabase](https://supabase.io/)
- Editor de código (VS Code, Android Studio, etc.)

### Passos para Execução
1. Clone o repositório:
   ```sh
   git clone https://github.com/seu-usuario/cabeleleila-leila.git
   cd cabeleleila-leila
   ```

2. Instale as dependências:
   ```sh
   flutter pub get
   ```

3. Configure as variáveis de ambiente no arquivo `.env`:
   ```env
   SUPABASE_URL=https://seu-supabase-url
   SUPABASE_API_KEY=sua-chave-anonima
   ```

4. Execute o aplicativo:
   ```sh
   flutter run
   ```

## 💡 Desafios e Aprendizados
Apesar de não ter concluído todas as funcionalidades no prazo devido a imprevistos pessoais, a estrutura base está sólida e funcional. O **Supabase** mostrou-se uma excelente escolha para acelerar o desenvolvimento, especialmente na parte de autenticação e gerenciamento de dados.


