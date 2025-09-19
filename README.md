# AWS Networking Labs

Este repositório contém laboratórios práticos usados para estudar a certificação **AWS Advanced Networking Specialty**.  
Cada laboratório está em um branch separado, com código **Terraform** que é aplicado automaticamente via **GitHub Actions**.

---

## 📚 Estrutura

- **Branch `main`** → contém arquivos compartilhados:
  - `.gitignore`
  - `.github/workflows/terraform.yml` (workflow do GitHub Actions)
  - `main.tf` (configuração base do Terraform com backend S3)
  - `README.md` (este índice)

- **Branches de labs** → cada branch contém os arquivos Terraform de um laboratório específico:
  - `vpc-basico`
  - `peering-vpc`
  - `transit-gateway`
  - `site-to-site-vpn`
  - `route53`

---

## 🏗️ Infraestrutura do Backend

O Terraform utiliza um backend S3 para armazenar o state file, garantindo consistência entre as execuções:

- **Bucket S3:** `aws-networking-labs-terraform-state-lrsirqueira`
- **Tabela DynamoDB:** `terraform-locks-aws-networking-labs`
- **Região:** `us-east-1`

---

## 🚀 Fluxo Completo de Uso

### **Cenário: Estudar um novo tópico**

### 1. Clone o repositório:
```bash
git clone https://github.com/lrsirqueira/aws-networking-labs.git
cd aws-networking-labs
```

### 2. Criar e estudar um lab:
```bash
# Estar na branch main
git checkout main

# Fazer modificações nos arquivos Terraform (main.tf, etc.)
# ... editar arquivos conforme o lab ...

# Commit e push para aplicar os recursos
git add .
git commit -m "Implementar lab de VPC Peering"
git push origin main
# ✅ Recursos serão criados automaticamente
```

### 3. Salvar o lab numa branch específica:
```bash
# Salvar o lab atual numa branch nomeada
git checkout -b vpc-peering  # ou nome descritivo do seu lab
git push origin vpc-peering

# Voltar para main
git checkout main
```

### 4. Destruir recursos após estudo:
```bash
# Fazer commit com [destroy] para limpar ambiente
git commit --allow-empty -m "Finalizar estudo do lab [destroy]"
git push origin main
# 🔥 Recursos serão destruídos automaticamente
```

### 5. Recriar um lab salvo (futuro):
```bash
# Pegar uma branch de lab existente
git checkout vpc-peering  # nome da branch do lab

# Aplicar na main novamente
git checkout main
git merge vpc-peering
git push origin main
# ✅ Recursos do lab serão recriados
```

### **Resumo do fluxo:**
1. **Criar/Modificar** → commit na main → recursos aplicados
2. **Salvar lab** → criar branch específica
3. **Destruir** → commit com `[destroy]` → recursos removidos  
4. **Recriar lab** → merge da 

---

## 🤖 Automação GitHub Actions

O workflow é acionado automaticamente quando há **push/merge na branch `main`**:

### ✅ **Apply Resources** (padrão)
- Detectado quando o commit message **NÃO** contém "destroy"
- Executa `terraform plan` e `terraform apply`
- Cria/atualiza recursos na AWS

### 🔥 **Destroy Resources**
- Detectado quando o commit message contém **"destroy"** ou **"[destroy]"**
- Executa `terraform plan -destroy` e `terraform destroy`
- Remove todos os recursos da AWS

### 📝 **Feedback**
- Comentários automáticos na **Issue #1** informando o resultado
- Logs detalhados no GitHub Actions

---

## 🔧 Setup Inicial (Executar uma vez)

### 1. Criar recursos do backend manualmente na AWS:

```bash
# Criar bucket S3
aws s3 mb s3://aws-networking-labs-terraform-state-lrsirqueira --region us-east-1

# Habilitar versionamento
aws s3api put-bucket-versioning \
    --bucket aws-networking-labs-terraform-state-lrsirqueira \
    --versioning-configuration Status=Enabled

# Habilitar criptografia
aws s3api put-bucket-encryption \
    --bucket aws-networking-labs-terraform-state-lrsirqueira \
    --server-side-encryption-configuration '{
        "Rules": [{
            "ApplyServerSideEncryptionByDefault": {
                "SSEAlgorithm": "AES256"
            }
        }]
    }'

# Criar tabela DynamoDB para locks
aws dynamodb create-table \
    --table-name terraform-locks-aws-networking-labs \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region us-east-1
```

### 2. Configurar Secrets no GitHub:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY` 
- `GH_TOKEN` (para comentários nas issues)

### 3. Criar Issue #1 no repositório:
- Título: "Lab Status Updates"
- Descrição: "Este issue receberá atualizações automáticas sobre o status dos labs."

---

## 📋 Laboratórios Disponíveis

- [ ] **VPC Básico** (`vpc-basico`) - VPC com subnet pública e Internet Gateway
- [ ] **VPC Peering** (`peering-vpc`) - Conexão entre duas VPCs
- [ ] **Transit Gateway** (`transit-gateway`) - Hub centralizado para múltiplas VPCs
- [ ] **Site-to-Site VPN** (`site-to-site-vpn`) - Conexão VPN com ambiente on-premises
- [ ] **Route 53** (`route53`) - DNS e resolução de nomes

---

## 🎯 Próximos Passos

1. **Criar os recursos do backend** (bucket S3 + DynamoDB)
2. **Configurar secrets** no GitHub
3. **Criar Issue #1** para feedback
4. **Testar o workflow** com merge de uma branch de lab
5. **Expandir labs** conforme necessário para a certificação

---

## 🔍 Troubleshooting

### Erro: "Backend not initialized"
- Verifique se o bucket S3 e tabela DynamoDB foram criados
- Confirme as credenciais AWS nos secrets

### Workflow não detecta "destroy"
- Verifique se o commit message contém a palavra "destroy"
- Exemplo: `git commit -m "Finalizar lab [destroy]"`

### State file inconsistente
- O backend S3 mantém o state centralizado
- Em caso de problemas, verifique o arquivo no bucket S3