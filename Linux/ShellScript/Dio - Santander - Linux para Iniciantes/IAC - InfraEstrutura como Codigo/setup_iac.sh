#!/bin/bash

#===================================================================================
# SCRIPT: setup_iac.sh
# AUTOR: Alex Luiz Rabelo
# DATA: 29/03/2025
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
# VERSÃO: 0.1
#===================================================================================

# Parte 1: Exclusão de diretórios, grupos e usuários criados anteriormente
#===================================================================================
# Excluir diretórios criados anteriormente
echo "Removendo diretórios anteriores..."
rm -rf /publico
rm -rf /adm
rm -rf /ven
rm -rf /sec

# Excluir grupos criados anteriormente
echo "Removendo grupos anteriores..."
groupdel GRP_ADM
groupdel GRP_VEN
groupdel GRP_SEC

# Excluir usuários criados anteriormente
echo "Removendo usuários anteriores..."
userdel -r carlos
userdel -r maria
userdel -r joao
userdel -r debora
userdel -r sebastiana
userdel -r roberto
userdel -r josefina
userdel -r amanda
userdel -r rogerio


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
useradd carlos -m -s /bin/bash -p $(openssl passwd carlos@2025) -G GRP_ADM
passwd --expire carlos
useradd maria -m -s /bin/bash -p $(openssl passwd maria@2025) -G GRP_ADM
passwd --expire maria
useradd joao -m -s /bin/bash -p $(openssl passwd joao@2025) -G GRP_ADM
passwd --expire joao

# Criar usuários do grupo GRP_VEN
# Configurar senha inicial com troca obrigatória no primeiro login
echo "Criando usuários do grupo GRP_VEN ..."
useradd debora -m -s /bin/bash -p $(openssl passwd debora@2025) -G GRP_VEN
passwd --expire debora
useradd sebastiana -m -s /bin/bash -p $(openssl passwd sebastiana@2025) -G GRP_VEN
passwd --expire sebastiana
useradd roberto -m -s /bin/bash -p $(openssl passwd roberto@2025) -G GRP_VEN
passwd --expire roberto

# Criar usuários do grupo GRP_SEC
# Configurar senha inicial com troca obrigatória no primeiro login
echo "Criando usuários do grupo GRP_SEC ..."
useradd josefina -m -s /bin/bash -p $(openssl passwd josefina@2025) -G GRP_SEC
passwd --expire josefina
useradd amanda -m -s /bin/bash -p $(openssl passwd amanda@2025) -G GRP_SEC
passwd --expire amanda
useradd rogerio -m -s /bin/bash -p $(openssl passwd rogerio@2025) -G GRP_SEC
passwd --expire rogerio

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
