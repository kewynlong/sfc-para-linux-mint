# 🛠️ Script de Verificação do Sistema (Equivalente ao `sfc /scannow` no Linux Mint)

Autor: **Kewyn Marcelo Bueno de Souza Lima**

---

## 📌 Propósito
No Windows, o comando `sfc /scannow` verifica e repara arquivos de sistema corrompidos.  
No **Linux Mint (baseado em Ubuntu/Debian)** não existe um comando único equivalente, por isso este script foi criado.  

O objetivo do script é oferecer uma alternativa que:
- Verifique a integridade dos pacotes do sistema.  
- Reinstale automaticamente pacotes corrompidos.  
- Corrija dependências quebradas.  
- Agende a verificação de disco (`fsck`) para o próximo reboot.  

Assim, você tem um **mecanismo de manutenção completo** para manter o sistema íntegro e estável.

---

## ⚙️ O que o script faz
1. **Atualização dos pacotes**  
   - Executa `apt update` para garantir que a lista de pacotes está atualizada.  

2. **Verificação de integridade com `debsums`**  
   - Instala o `debsums` (caso não esteja presente).  
   - Verifica a integridade dos pacotes instalados comparando com os checksums originais.  
   - Caso encontre pacotes corrompidos, oferece a opção de **reinstalá-los automaticamente**.  

3. **Correção de dependências quebradas**  
   - Executa `apt-get install -f` para reparar dependências de pacotes.  

4. **Verificação de disco com `fsck` (opcional)**  
   - Se habilitado, agenda a checagem automática do disco no próximo reboot criando o arquivo `/forcefsck`.  

---

## 🚀 Como usar

### 1. Criar o script
Crie um arquivo chamado `sfc.sh` e copie o código:

```bash
nano sfc.sh
