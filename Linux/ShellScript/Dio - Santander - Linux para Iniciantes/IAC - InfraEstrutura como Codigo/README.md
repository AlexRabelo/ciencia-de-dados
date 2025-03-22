
## 🏆 **Sobre o Bootcamp Santander - Linux para Iniciantes**

O bootcamp **Santander - Linux para Iniciantes** é oferecido pela [DIO](https://www.dio.me) em parceria com o Santander. Ele tem como objetivo capacitar profissionais a dominar os principais comandos do Linux, criar scripts e configurar servidores no ambiente mais utilizado por desenvolvedores, DevOps e profissionais de cloud.

### **Detalhes do Bootcamp**
- **Carga Horária**: 30 horas.
- **Conteúdo**:
  - Principais comandos Linux.
  - Criação de scripts automatizados.
  - Configuração de servidores Linux.
  - Projetos práticos e mentorias exclusivas com experts da DIO e Santander.

---

## 🚀 **Como Executar o Script**

1. Clone este repositório:
2. Dê permissão de execução ao script:
chmod +x setup_aic.sh

3. Execute o script como administrador (root):
 ./setup_structure.sh

---

## ⚙️ **Funcionamento do Script**

1. Remove diretórios, grupos e usuários previamente criados (se existirem).
2. Cria os diretórios `/publico`, `/adm`, `/ven` e `/sec`.
3. Cria os grupos `GRP_ADM`, `GRP_VEN` e `GRP_SEC`.
4. Cria os usuários e associa-os aos seus respectivos grupos.
5. Configura permissões específicas para cada diretório:
   - Diretório `/publico`: Permissão total para todos (777).
   - Diretórios `/adm`, `/ven` e `/sec`: Permissão total apenas para seus respectivos grupos (770).
6. Define senhas iniciais criptografadas para os usuários.
7. Força a troca de senha no primeiro login.

---

## 📂 **Estrutura Criada pelo Script**

### Diretórios
- `/publico`: Acesso total para todos os usuários.
- `/adm`: Acesso restrito ao grupo `GRP_ADM`.
- `/ven`: Acesso restrito ao grupo `GRP_VEN`.
- `/sec`: Acesso restrito ao grupo `GRP_SEC`.

### Grupos
- `GRP_ADM`
- `GRP_VEN`
- `GRP_SEC`

### Usuários
| Grupo      | Usuários                |
|------------|-------------------------|
| GRP_ADM    | carlos, maria, joao     |
| GRP_VEN    | debora, sebastiana, roberto |
| GRP_SEC    | josefina, amanda, rogerio |

---

## 🛠️ **Tecnologias Utilizadas**

- **Bash Script**: Para automação do provisionamento.
- **Linux Ubuntu**: Ambiente recomendado para execução do script.
- **OpenSSL**: Para criptografia das senhas dos usuários.

---

## 📖 **Exemplo de Uso**

Após executar o script, os seguintes cenários serão configurados:

1. O usuário `carlos` poderá acessar e modificar arquivos no diretório `/adm`, mas não terá permissão nos diretórios `/ven` ou `/sec`.
2. O diretório `/publico` estará acessível para todos os usuários, independentemente do grupo.
3. Todos os usuários deverão alterar suas senhas no primeiro login.

---

## 📝 **Notas Importantes**

- Certifique-se de executar o script como administrador (`root`) para evitar erros de permissão.
- Este script foi projetado para ambientes Linux (Ubuntu recomendado).
- Caso precise ajustar as configurações, edite o arquivo `setup_aic.sh`.

---

## 📌 **Contribuições**

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou enviar pull requests.

---

## 📅 **Histórico de Versões**

- **1.0**: Configuração inicial do script com criação de diretórios, grupos e usuários.
- **1.1**: Adição da configuração de senhas iniciais e troca obrigatória no login.
- **1.2**: Melhorias na lógica de exclusão de estruturas antigas.
- **1.3**: Uso do OpenSSL para criptografia das senhas.

---

## 🧑‍💻 **Autor**

Desenvolvido por [Alex Rabelo].  
Entre em contato pelo [LinkedIn](https://www.linkedin.com/in/alex-rabelo/) ou envie um email para [alexrabelo@gmail.com].
Este projeto faz parte do bootcamp Santander - Linux para Iniciantes da DIO.


---

## 📜 **Licença**

Este projeto está licenciado sob a [MIT License](LICENSE).

---

## 🌟 **Agradecimentos**

Agradeço à [DIO](https://www.dio.me) e ao Santander pela oportunidade incrível oferecida neste bootcamp!
Agradeço à comunidade Linux e aos recursos disponíveis na internet que ajudaram no desenvolvimento deste projeto.

