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

<img src="https://github.com/user-attachments/assets/aa6b66f0-b6c4-4225-82d7-b8b0e9f70f6a" width="300" />
<img src="https://github.com/user-attachments/assets/f586604e-263f-4ef6-9af0-c52e2a4428e7" width="300" />
<img src="https://github.com/user-attachments/assets/e1afcdfe-b645-478d-8ccc-39c886e7b7bd" width="300" />
<img src="https://github.com/user-attachments/assets/d7b30c10-d1dd-4b90-a861-58f26a5982a1" width="300" />
<img src="https://github.com/user-attachments/assets/6addb3dc-e2a3-4f1d-bf81-2d789de3a9a2" width="300" />
<img src="https://github.com/user-attachments/assets/d0e98193-fabe-4e9e-9b2b-fc865fee53ac" width="300" />
<img src="https://github.com/user-attachments/assets/8078c024-6263-4cb4-bdca-f1f0b7f36f1f" width="300" />
<img src="https://github.com/user-attachments/assets/2d9ada44-1bd9-4fea-9bc7-9b075f4ec018" width="300" />
<img src="https://github.com/user-attachments/assets/a27237c2-3fb3-49c8-902c-b1759850d807" width="300" />
<img src="https://github.com/user-attachments/assets/fa58e538-c917-4bc3-9cda-3b789c89bb2e" width="300" />
<img src="https://github.com/user-attachments/assets/28a193a6-1024-4cf5-92f9-33cefeecc1c4" width="300" />


![Screenshot_20250325-173341](https://github.com/user-attachments/assets/aa6b66f0-b6c4-4225-82d7-b8b0e9f70f6a)
![Screenshot_20250325-173330](https://github.com/user-attachments/assets/f586604e-263f-4ef6-9af0-c52e2a4428e7)
![Screenshot_20250325-173323_One UI Home](https://github.com/user-attachments/assets/e1afcdfe-b645-478d-8ccc-39c886e7b7bd)
![Screenshot_20250325-173500](https://github.com/user-attachments/assets/d7b30c10-d1dd-4b90-a861-58f26a5982a1)
![Screenshot_20250325-173445](https://github.com/user-attachments/assets/6addb3dc-e2a3-4f1d-bf81-2d789de3a9a2)
![Screenshot_20250325-173433](https://github.com/user-attachments/assets/d0e98193-fabe-4e9e-9b2b-fc865fee53ac)
![Screenshot_20250325-173415](https://github.com/user-attachments/assets/8078c024-6263-4cb4-bdca-f1f0b7f36f1f)
![Screenshot_20250325-173410](https://github.com/user-attachments/assets/2d9ada44-1bd9-4fea-9bc7-9b075f4ec018)
![Screenshot_20250325-173404](https://github.com/user-attachments/assets/a27237c2-3fb3-49c8-902c-b1759850d807)
![Screenshot_20250325-173352](https://github.com/user-attachments/assets/fa58e538-c917-4bc3-9cda-3b789c89bb2e)
![Screenshot_20250325-173348](https://github.com/user-attachments/assets/28a193a6-1024-4cf5-92f9-33cefeecc1c4)
