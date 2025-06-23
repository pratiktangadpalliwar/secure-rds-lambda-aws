# SSH Tunnel Setup for MySQL Workbench Access to Private RDS

Since the RDS MySQL instance is deployed in a **private subnet**, you need to use an **EC2 instance (bastion host)** in the public subnet to tunnel into it.

---

## Prerequisites

- EC2 instance (Amazon Linux) in public subnet
- RDS MySQL in private subnet
- `.pem` key file downloaded during EC2 setup
- MySQL Workbench installed

---

## SSH Tunnel Command

On your local terminal, run:

```bash
ssh -i /path/to/your-key.pem -L 3307:<rds-endpoint>:3306 ec2-user@<ec2-public-ip>
