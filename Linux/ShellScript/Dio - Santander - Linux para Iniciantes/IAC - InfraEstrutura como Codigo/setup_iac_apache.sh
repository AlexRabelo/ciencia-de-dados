#!/bin/bash

#===================================================================================
# SCRIPT: setup_iac_apache.sh
# AUTOR: Alex Luiz Rabelo
# DATA: 05/04/2025
# DESCRIÇÃO: Este script atualiza automaticamente o SO Ubuntu, 
#            instala o Apache2 e ajusta as permissões.
#
# USO: Execute o script como root:
#      ./setup_iac_apache.sh
#
# DEFINIÇÕES:
# - Atualiza o servidor,
# - Instala o Apache2,
# - Instala o unzip,
# - Baixa uma aplicação web,
# - Descompacta a aplicação,
# - Implanta a aplicação no servidor Apache.
#
# REQUISITOS:
# - Sistema operacional Linux (Ubuntu recomendado).
# - Permissões de administrador para executar o script.
#
# VERSÃO: 0.2
#===================================================================================

# Variáveis
APP_URL="https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip"
APP_ZIP="/tmp/app.zip"
APP_DIR="/tmp/linux-site-dio-main"
APACHE_DIR="/var/www/html"

# Verificar se o script está sendo executado como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Erro: Este script deve ser executado como root."
    exit 1
fi

# Passo 1: Atualizar o servidor
echo "Atualizando o servidor..."
if ! apt update && apt upgrade -y; then
    echo "Erro ao atualizar o servidor."
    exit 1
fi

# Passo 2: Instalar o Apache2
echo "Instalando o Apache2..."
if ! apt install apache2 -y; then
    echo "Erro ao instalar o Apache2."
    exit 1
fi

# Verificar se o Apache2 está rodando
if ! systemctl is-active --quiet apache2; then
    echo "Iniciando o Apache2..."
    if ! systemctl start apache2; then
        echo "Erro ao iniciar o Apache2."
        exit 1
    fi
fi

# Passo 3: Instalar o unzip
echo "Instalando o unzip..."
if ! apt install unzip -y; then
    echo "Erro ao instalar o unzip."
    exit 1
fi

# Passo 4: Baixar a aplicação
echo "Baixando a aplicação..."
if ! wget "$APP_URL" -O "$APP_ZIP"; then
    echo "Erro ao baixar a aplicação."
    exit 1
fi

# Passo 5: Descompactar a aplicação
echo "Descompactando a aplicação..."
if ! unzip "$APP_ZIP" -d /tmp/; then
    echo "Erro ao descompactar a aplicação."
    exit 1
fi

# Passo 6: Copiar os arquivos para o diretório padrão do Apache
echo "Copiando os arquivos para o diretório do Apache..."
if ! cp -R "$APP_DIR"/* "$APACHE_DIR/"; then
    echo "Erro ao copiar os arquivos para o diretório do Apache."
    exit 1
fi

# Passo 7: Ajustar as permissões
echo "Ajustando as permissões..."
if ! chown -R www-data:www-data "$APACHE_DIR" && chmod -R 755 "$APACHE_DIR"; then
    echo "Erro ao ajustar as permissões."
    exit 1
fi

# Passo 8: Reiniciar o Apache para aplicar as alterações
echo "Reiniciando o Apache..."
if ! systemctl restart apache2; then
    echo "Erro ao reiniciar o Apache."
    exit 1
fi

# Passo 9: Limpeza
echo "Limpando arquivos temporários..."
if ! rm -rf "$APP_ZIP" "$APP_DIR"; then
    echo "Erro ao limpar os arquivos temporários."
    exit 1
fi

echo "Processo concluído com sucesso!"
echo "A aplicação está disponível em http://$(hostname -I | awk '{print $1}')"