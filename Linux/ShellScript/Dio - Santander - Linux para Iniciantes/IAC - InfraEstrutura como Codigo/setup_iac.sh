#!/bin/bash

#===================================================================================
# SCRIPT: setup_iac.sh
# AUTOR: Alex Luiz Rabelo
# DATA: 22/03/2025
# DESCRIÇÃO: Este script configura uma estrutura de diretórios, grupos e usuários 
#            em um servidor Linux Ubuntu recém-instalado. Ele também ajusta permissões
#            conforme definido.
#
# USO: Execute o script como root ou utilizando sudo:
#      sudo ./setup_iac.sh
#
# DEFINIÇÕES:
# - Exclui diretórios, arquivos, grupos e usuários criados anteriormente.
# - Cria diretórios (/publico, /adm, /ven, /sec) com permissões específicas.
# - Cria grupos (GRP_ADM, GRP_VEN, GRP_SEC) e associa usuários a eles.
# - Configura permissões para que cada grupo tenha acesso restrito ao seu diretório.
# - Todos os usuários têm acesso total ao diretório público (/publico).
#
# REQUISITOS:
# - Sistema operacional Linux (Ubuntu recomendado).
# - Permissões de administrador para executar o script.
#
# VERSÃO: 1.0
#===================================================================================

# Verifica se o script está sendo executado como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script deve ser executado como root. Use sudo."
    exit 1
fi

# Parte 1: Exclusão de diretórios, grupos e usuários criados anteriormente
#===================================================================================
# Função para verificar e excluir diretórios
remove_directory() {
    local dir=$1
    if [ -d "$dir" ]; then
        echo "Diretório $dir encontrado. Removendo..."
        rm -rf "$dir"
    else
        echo "Diretório $dir não existe."
    fi
}

# Função para verificar e excluir grupos
remove_group() {
    local group=$1
    if getent group "$group" >/dev/null; then
        echo "Grupo $group encontrado. Removendo..."
        groupdel "$group"
    else
        echo "Grupo $group não existe."
    fi
}

# Função para verificar e excluir usuários
remove_user() {
    local user=$1
    if id -u "$user" >/dev/null 2>&1; then
        echo "Usuário $user encontrado. Removendo..."
        userdel -r "$user"
    else
        echo "Usuário $user não existe."
    fi
}

# Excluir diretórios criados anteriormente
echo "Verificando e removendo diretórios anteriores..."
remove_directory /publico
remove_directory /adm
remove_directory /ven
remove_directory /sec

# Excluir grupos criados anteriormente
echo "Verificando e removendo grupos anteriores..."
remove_group GRP_ADM
remove_group GRP_VEN
remove_group GRP_SEC

# Excluir usuários criados anteriormente
echo "Verificando e removendo usuários anteriores..."
usuarios=(carlos maria joao debora sebastiana roberto josefina amanda rogerio)
for usuario in "${usuarios[@]}"; do
    remove_user "$usuario"
done

# Parte 2: Criação de diretórios, grupos e usuários 
#===================================================================================
# Criar grupos
echo "Criando grupos..."
groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

# Criar usuários e adicioná-los aos grupos
echo "Criando usuários e adicionando aos grupos..."
# Criar usuários do grupo GRP_ADM
# Configurar senha inicial com troca obrigatória no primeiro login
echo "Criando usuários do grupo GRP_ADM ..."
useradd carlos -m -s /bin/bash -p $(openssl passwd -crypt carlos@2025) -G GRP_ADM && passwd --expire carlos
useradd maria -m -s /bin/bash -p $(openssl passwd -crypt maria@2025) -G GRP_ADM && passwd --expire maria
useradd joao -m -s /bin/bash -p $(openssl passwd -crypt joao@2025) -G GRP_ADM && passwd --expire joao

# Criar usuários do grupo GRP_VEN
# Configurar senha inicial com troca obrigatória no primeiro login
echo "Criando usuários do grupo GRP_VEN ..."
useradd debora -m -s /bin/bash -p $(openssl passwd -crypt debora@2025) -G GRP_VEN && passwd --expire debora
useradd sebastiana -m -s /bin/bash -p $(openssl passwd -crypt sebastiana@2025) -G GRP_VEN && passwd --expire sebastiana
useradd roberto -m -s /bin/bash -p $(openssl passwd -crypt roberto@2025) -G GRP_VEN && passwd --expire roberto

# Criar usuários do grupo GRP_SEC
# Configurar senha inicial com troca obrigatória no primeiro login
echo "Criando usuários do grupo GRP_SEC ..."
useradd josefina -m -s /bin/bash -p $(openssl passwd -crypt josefina@2025) -G GRP_SEC && passwd --expire josefina
useradd amanda -m -s /bin/bash -p $(openssl passwd -crypt amanda@2025) -G GRP_SEC && passwd --expire amanda
useradd rogerio -m -s /bin/bash -p $(openssl passwd -crypt rogerio@2025) -G GRP_SEC && passwd --expire rogerio


# Criar diretórios
echo "Criando diretórios..."
mkdir /publico /adm /ven /sec

# Ajustar permissões dos diretórios
echo "Configurando permissões dos diretórios..."
chown root:root /publico
chmod 777 /publico

chown root:GRP_ADM /adm
chmod 770 /adm

chown root:GRP_VEN /ven
chmod 770 /ven

chown root:GRP_SEC /sec
chmod 770 /sec

# Finalização
echo "Estrutura configurada com sucesso!"
