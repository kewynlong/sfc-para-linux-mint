#!/bin/bash
echo "🔎 Ferramenta de verificação do sistema (Linux Mint) - Equivalente ao sfc /scannow"

# Atualizar repositórios
read -p "👉 Deseja atualizar a lista de pacotes (apt update)? [s/n] " resp
if [[ "$resp" =~ ^[Ss]$ ]]; then
    sudo apt update
fi

# Verificar integridade com debsums
read -p "👉 Deseja verificar integridade dos pacotes com debsums? [s/n] " resp
if [[ "$resp" =~ ^[Ss]$ ]]; then
    sudo apt install -y debsums
    echo "➡️ Verificando integridade dos pacotes..."
    sudo debsums -s | tee /tmp/pacotes_corrompidos.txt

    if [ -s /tmp/pacotes_corrompidos.txt ]; then
        echo "⚠️ Foram encontrados pacotes corrompidos:"
        cut -d' ' -f2 /tmp/pacotes_corrompidos.txt | sort -u

        read -p "👉 Deseja reinstalar automaticamente esses pacotes? [s/n] " resp2
        if [[ "$resp2" =~ ^[Ss]$ ]]; then
            for pkg in $(cut -d' ' -f2 /tmp/pacotes_corrompidos.txt | sort -u); do
                sudo apt install --reinstall -y "$pkg"
            done
        else
            echo "ℹ️ Reinstalação ignorada."
        fi
    else
        echo "✅ Nenhum pacote corrompido encontrado."
    fi
fi

# Corrigir dependências
read -p "👉 Deseja corrigir dependências quebradas (apt-get install -f)? [s/n] " resp
if [[ "$resp" =~ ^[Ss]$ ]]; then
    sudo apt-get install -f -y
fi

# Agendar verificação de disco
read -p "👉 Deseja agendar verificação de disco (fsck) no próximo reboot? [s/n] " resp
if [[ "$resp" =~ ^[Ss]$ ]]; then
    sudo touch /forcefsck
    echo "🖥️ O fsck será executado automaticamente no próximo boot."
fi

echo "✅ Verificação concluída!"
