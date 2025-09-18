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

## 🚀 Como usar

### 1. Clone o repositório:
```bash
git clone https://github.com/lrsirqueira/aws-networking-labs.git
cd aws-networking-labs
```

### 2. Para aplicar um laboratório:
```bash
# Mude para a branch do lab desejado
git checkout vpc-basico

# Faça suas modificações (se necessário)
# ...

# Merge na main para aplicar
git checkout main
git merge vpc-basico
git push origin main
```

### 3. Para destruir todos os recursos:
```bash
# Crie/use a branch destroy
git checkout -b destroy

# Faça um commit com a palavra "destroy" na mensagem
git commit --allow-empty -m "Destruir recursos do lab [destroy]"

# Merge na main para destruir
git checkout main
git merge destroy
git push origin main
```

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