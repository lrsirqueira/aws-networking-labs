# AWS Networking Labs

Este repositório contém laboratórios práticos usados para estudar a certificação **AWS Advanced Networking Specialty**.  
Cada laboratório está em um branch separado, com código **Terraform** que pode ser aplicado automaticamente via **GitHub Actions**.

---

## 📚 Estrutura

- **Branch `main`** → contém arquivos compartilhados:
  - `.gitignore`
  - `.github/workflows/terraform.yml` (workflow do GitHub Actions)
  - `README.md` (este índice)

- **Branches de labs** → cada branch contém os arquivos Terraform de um laboratório específico, por exemplo:
  - `vpc-basico`
  - `peering-vpc`
  - `transit-gateway`
  - `site-to-site-vpn`
  - `route53`

---

## 🚀 Como usar

1. Clone o repositório:
   ```bash
   git clone https://github.com/lrsirqueira/aws-networking-labs.git
   cd aws-networking-labs
