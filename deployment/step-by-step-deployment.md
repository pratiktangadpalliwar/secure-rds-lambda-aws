# 🚀 Step-by-Step Deployment Guide: AWS RDS + Lambda + MySQL Workbench

This guide walks through setting up a secure AWS environment with RDS, Lambda, and EC2 (bastion host) to interact with a private MySQL instance using MySQL Workbench.

---

## Step 1: Create VPC

- Go to **VPC Console** → Create VPC
- Select **VPC Only**
- Name: `<name>`
- IPv4 CIDR block: `<Ip-range(with CIDR)>`
- Tenancy: Default
- Click **Create VPC**

---

## Step 2: Create & Attach Internet Gateway

- Go to **Internet Gateways** → Create
- Name: `<name>`
- Attach to `<your-VPC>`

---

## Step 3: Create Subnets

### Public Subnet
- Availability Zone: `<choose-AZ-as-per-your-need>`
- CIDR block: `<Ip-range(with CIDR)>`

### Private Subnet
- Availability Zone: `<choose-AZ-as-per-your-need>`
- CIDR block: `<Ip-range(with CIDR)>`

---

## Step 4: Route Tables

### Public Route Table
- Associate public subnet
- Add route: `0.0.0.0/0` → Internet Gateway

### Private Route Table
- Associate private subnet
- Add route: `0.0.0.0/0` → NAT Gateway (next step)

---

## Step 5: NAT Gateway

- Go to **NAT Gateways** → Create
- Subnet: Public Subnet
- Allocate new Elastic IP
- Attach to Private Route Table

---

## Step 6: Security Group

- Create SG: `<name>`
- Attach to VPC: `<your-VPC>`
- Inbound Rules:
  - SSH (22) — Anywhere
  - MySQL/Aurora (3306) — Anywhere
- Attach this SG to RDS, Lambda, and EC2

---

## Step 7: Create RDS Instance (MySQL)

- Go to **RDS Console** → Create Database
- Engine: MySQL 8.x
- Template: Free Tier
- Identifier: `my-rds-instance`
- Username/Password: your choice
- VPC: `<your-VPC>`
- Subnet group: create new, include both private subnets
- Public access: **No**
- Attach `<SG-you-created>`

---

## Step 8: Launch EC2 Bastion Host

- Select AMI: Amazon Linux 2
- Subnet: Public
- Auto-assign Public IP: Yes
- Security Group: `<SG-you-created>`
- Download and save the key pair (.pem)

---

## Step 9: Set Up Lambda

- Create IAM Role: `<name>`
  - Policies: `<neccessary-polices>`
- Create Lambda function:
  - Runtime: Python 3.12
  - VPC config:
    - Subnets: Public + Private
    - Security Group: `<SG-you-created>`
- Upload zipped Lambda code to insert data to RDS

---

## Step 10: Verify with MySQL Workbench

- Use SSH Tunnel via EC2
- Connect MySQL Workbench to private RDS using the tunnel
- Create and test Database:`<your-database-name>`, Table:`<your-table-name>`

---
