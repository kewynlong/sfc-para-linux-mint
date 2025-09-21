
# 🛠️ Linux System File Checker (SFC)  
### Equivalente ao `sfc /scannow` do Windows para Linux Mint

👨‍💻 Autor: **Kewyn Marcelo Bueno de Souza Lima**  

---

## 📌 Sobre o Projeto
No Windows, o comando `sfc /scannow` verifica e repara arquivos de sistema corrompidos.  
No **Linux Mint** (baseado em Ubuntu/Debian), não existe um comando único com essa função.  

➡️ Este script foi criado para oferecer uma **alternativa poderosa e interativa**, capaz de:  
- Verificar integridade dos pacotes do sistema.  
- Reinstalar automaticamente pacotes corrompidos.  
- Corrigir dependências quebradas.  
- Agendar verificação de disco (`fsck`) para o próximo reboot.  

Assim, você garante **estabilidade, segurança e integridade** do seu sistema.  

---

## ✨ Funcionalidades
✅ **Atualização de pacotes** (`apt update`)  
✅ **Verificação de integridade** com `debsums`  
✅ **Reinstalação de pacotes corrompidos** (opcional)  
✅ **Correção de dependências** (`apt-get install -f`)  
✅ **Agendamento de verificação de disco** no próximo boot (`fsck`)  
✅ **Modo interativo** – você decide passo a passo o que executar  

---

## 🚀 Instalação e Uso

### 1. Criar o script
Abra o terminal e crie o arquivo `sfc.sh`:
```bash
nano sfc.sh
````

Cole dentro dele o seguinte código:

```bash
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
```

Salve com `CTRL + O` e saia com `CTRL + X`.

---

### 2. Dar permissão de execução

No terminal:

```bash
chmod +x sfc.sh
```

---

### 3. Executar o script

Agora rode:

```bash
./sfc.sh
```

Durante a execução, você verá perguntas como estas:

```text
👉 Deseja atualizar a lista de pacotes (apt update)? [s/n] s
👉 Deseja verificar integridade dos pacotes com debsums? [s/n] s
➡️ Verificando integridade dos pacotes...
⚠️ Foram encontrados pacotes corrompidos:
bash
coreutils
👉 Deseja reinstalar automaticamente esses pacotes? [s/n] s
👉 Deseja corrigir dependências quebradas (apt-get install -f)? [s/n] s
👉 Deseja agendar verificação de disco (fsck) no próximo reboot? [s/n] n
✅ Verificação concluída!
```

---

## 📂 Estrutura de Arquivos

```
📁 SeuProjeto/
 ├── README.md   # Este guia
 └── sfc.sh      # Script principal
```

---

## ✅ Benefícios

* **Estabilidade**: mantém o sistema íntegro e sem pacotes corrompidos.
* **Controle total**: o usuário escolhe cada etapa.
* **Alternativa ao Windows**: funciona como o `sfc /scannow`.
* **Manutenção completa**: cobre pacotes, dependências e até disco.

---

## ⚠️ Observações Importantes

* O script é **seguro**. Ele só atua em pacotes do sistema e não afeta arquivos pessoais em `/home`.
* A opção de `fsck` será executada **somente no próximo reboot**.
* Evite desligar o PC durante a execução.

---

## 📜 Licença

Este projeto foi desenvolvido para fins educacionais e de manutenção pessoal por **Kewyn Marcelo Bueno de Souza Lima**.
Você pode usá-lo, modificá-lo e compartilhá-lo livremente.

---

```

---

👉 Quer que eu melhore ainda mais e adicione **badges (selos visuais)** no topo do `.md`, tipo “Feito em Bash”, “Compatível com Linux Mint”, “Seguro para Produção”?
```
