# 🖥️ Day 08 & 09: EC2 Mastery

Welcome to the **EC2 Mastery** module of the 30-Day Cloud Support Engineer Preparation. This directory covers core concepts, architecture, operations, and troubleshooting methodologies for Amazon Elastic Compute Cloud (EC2). As a Cloud Support Engineer, EC2 is one of the most critical services to master, as it forms the compute backbone of AWS and is at the center of many customer support cases.

---

## 📌 Table of Contents
1. [EC2 Fundamentals](#1-ec2-fundamentals)
2. [EC2 Storage Deep Dive](#2-ec2-storage-deep-dive)
3. [Networking & Security](#3-networking-security)
4. [Operations & Advanced Concepts](#4-operations--advanced-concepts)
5. [Cloud Support Troubleshooting Guide (Crucial)](#5-cloud-support-troubleshooting-guide-crucial)
6. [AWS CLI Cheat Sheet for EC2](#6-aws-cli-cheat-sheet-for-ec2)

---

## 1. EC2 Fundamentals

### Instance Types Nomenclature
AWS naming conventions follow a structured pattern:
$$\text{[Instance Family][Generation].[Size]}$$
*Example:* `t3.medium`
* `t`: **Instance Family** (Burstable performance)
* `3`: **Generation** (3rd generation hardware)
* `medium`: **Size** (allocates vCPU, memory, and network performance)

### Instance Categories
Depending on the workload, AWS offers specialized instance families:
* **General Purpose (`T`, `M`):** Balanced compute, memory, and networking. Ideal for web servers, code repositories, and development environments.
* **Compute Optimized (`C`):** High-performance processors. Best for batch processing, media transcoding, scientific modeling, high-performance web servers, and gaming.
* **Memory Optimized (`R`, `X`, `z`):** Large memory footprints. Designed for in-memory databases (Redis, Memcached), high-performance databases, and real-time big data processing.
* **Storage Optimized (`I`, `D`, `H`):** High-speed local NVMe storage or dense HDD storage. Great for distributed file systems, data warehousing, and transactional databases.
* **Accelerated Computing (`P`, `G`, `F`):** Hardware accelerators (GPUs, FPGAs). Used for machine learning, graphics rendering, and hardware acceleration.

### Purchase Options
Choosing the right pricing model can save up to 90% in costs:
| Purchase Option | Discount | Use Case | Lifecycle / Behavior |
| :--- | :--- | :--- | :--- |
| **On-Demand** | 0% (Baseline) | Short-term, unpredictable workloads | Paid by the second; cannot be interrupted by AWS. |
| **Savings Plans** | Up to 72% | Consistent compute usage (1 or 3 years commitment) | Commitment to a usage rate ($\text{\$/hour}$). Flexible across families/regions. |
| **Reserved Instances** | Up to 72% | Steady-state, predictable workloads | Commitment to specific instance configuration (Standard vs. Convertible). |
| **Spot Instances** | Up to 90% | Stateless, fault-tolerant, or batch workloads | AWS can reclaim capacity with a **2-minute warning**. Uses spare capacity. |
| **Dedicated Hosts** | N/A | Strict compliance, licensing (BYOL) | Physical server dedicated to your use. Full control over socket/core placement. |

---

## 2. EC2 Storage Deep Dive

### EBS (Elastic Block Store) vs. Instance Store
* **EBS (Network Attached):** Persistent virtual disk. Data survives instance stop/start and hardware failure. Can be detached and attached to other instances.
* **Instance Store (Ephemeral / Physically Attached):** High-performance, low-latency NVMe/SSD storage physically connected to the host server. **Data is lost** if the instance is stopped, hibernated, or if the underlying host hardware fails (data survives simple OS-level reboots).

### EBS Volume Types
| Volume Type | API Name | Max IOPS / Volume | Max Throughput / Vol | Primary Use Case |
| :--- | :--- | :--- | :--- | :--- |
| **gp3 (SSD)** | `gp3` | 16,000 | 1,000 MiB/s | Default choice. Scales IOPS and throughput independently of size. |
| **gp2 (SSD)** | `gp2` | 16,000 | 250 MiB/s | Older generation SSD. IOPS performance is tied to volume size (3 IOPS/GiB). |
| **io2 Block Express** | `io2` | 256,000 | 4,000 MiB/s | High-performance, sub-millisecond latency. Mission-critical databases. |
| **Throughput Opt. HDD** | `st1` | 500 | 500 MiB/s | Low-cost storage for streaming workloads, big data, log processing. |
| **Cold HDD** | `sc1` | 250 | 250 MiB/s | Lowest cost storage for infrequently accessed data. |

### Snapshots & Encryption
* **Snapshots:** Incremental backups stored in Amazon S3. Only blocks that changed since the last snapshot are backed up.
* **Encryption:** Uses KMS (Key Management Service) with AES-256. When an EBS volume is encrypted:
  * Data at rest inside the volume is encrypted.
  * Data in transit between the instance and the volume is encrypted.
  * All snapshots created from the volume are encrypted.

---

## 3. Networking & Security

### Security Groups vs. Network ACLs (NACLs)
These two security layers act as firewalls at different levels:

```
                  Internet / VPC
                        │
                  ┌─────▼─────┐
                  │   NACL    │  <-- Stateless Firewall (Subnet Level)
                  └─────┬─────┘
                        │
                  ┌─────▼─────┐
                  │Sec. Group │  <-- Stateful Firewall (Instance Level)
                  └─────┬─────┘
                        │
                  ┌─────▼─────┐
                  │EC2 Instance│
                  └───────────┘
```

| Feature | Security Group (SG) | Network ACL (NACL) |
| :--- | :--- | :--- |
| **Scope** | Instance / ENI Level | Subnet Level |
| **Statefulness** | **Stateful**: Outbound traffic is automatically allowed for allowed inbound requests. | **Stateless**: Return traffic must be explicitly allowed by outbound rules. |
| **Rules Support** | Allow rules only. | Allow and Deny rules. |
| **Rule Order** | Evaluates all rules before deciding. | Evaluates rules in numerical order (lowest number first). |

### IP Addressing & ENI
* **Primary Private IP:** Fixed for the lifetime of the instance within the VPC CIDR.
* **Public IP:** Dynamic IP address assigned from AWS's pool. Lost when the instance is stopped/started.
* **Elastic IP (EIP):** Static public IPv4 address that you allocate and can associate/re-associate with any instance in the region. *Note: Charges apply if allocated but not associated.*
* **Elastic Network Interface (ENI):** Virtual network card. You can attach multiple ENIs to an instance to enable multi-homing (connecting to different subnets).

### Placement Groups
* **Cluster:** Packs instances close together inside a single Availability Zone. Delivers low-latency, high-throughput network performance (up to 100 Gbps). Best for High-Performance Computing (HPC).
* **Spread:** Places instances on distinct host hardware racks across different AZs to reduce correlated failures. Best for critical instances that shouldn't share a single point of failure.
* **Partition:** Divides the group into logical partitions. Each partition contains its own set of racks. Instances in one partition do not share racks with instances in other partitions. Best for distributed workloads like Hadoop, Cassandra, or Kafka.

---

## 4. Operations & Advanced Concepts

### User Data (Bootstrapping)
A script executed **only once** during the initial launch of the instance. Used for installing software, configuring packages, or pulling updates.
* **Execution privilege:** Runs as the root user.
* **Logs location:** `/var/log/cloud-init-output.log`

### Instance Metadata Service (IMDS)
Allows instances to query their own configuration details (e.g., public IP, IAM role credentials, instance ID).
* **Metadata endpoint:** `http://169.254.169.254/latest/meta-data/`
* **IMDSv1 vs. IMDSv2:**
  * **IMDSv1:** Request/response model. Vulnerable to SSRF (Server-Side Request Forgery) attacks.
  * **IMDSv2:** Session-oriented token-based model. Requires a `PUT` request to retrieve a token first, then a `GET` request using that token in the header.

```bash
# IMDSv2 Example to get Instance ID
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id
```

---

## 5. Cloud Support Troubleshooting Guide (Crucial)

As a Cloud Support Engineer, customers will frequently reach out with EC2 issues. Here are the logical troubleshooting workflows.

### 🔌 Scenario A: "I cannot connect via SSH (Timeout / Connection Refused)"

#### 1. Connection Timeout (`ssh: connect to host X.X.X.X port 22: Connection timed out`)
This means the network packet is being dropped before reaching the server.
* **Check Security Group:** Ensure port 22 is open to the source IP.
* **Check Route Table:** If the instance is in a Public Subnet, ensure there is a route `0.0.0.0/0` pointing to the Internet Gateway (IGW).
* **Check NACLs:** Ensure there are allow rules for port 22 (Inbound) and Ephemeral Ports 1024-65535 (Outbound).
* **Check Elastic/Public IP:** Ensure the instance actually has a public IP if trying to connect over the internet.
* **Check Host Firewall:** Local OS-level firewalls (iptables, UFW) could be blocking the connection.

#### 2. Connection Refused (`ssh: connect to host X.X.X.X port 22: Connection refused`)
This means the network packet reached the server, but the server actively rejected it.
* **Is the SSH daemon running?** The service may have crashed or stopped.
* **Is SSH listening on another port?** Check if the default port was changed in `/etc/ssh/sshd_config`.

#### 3. Permission Denied (`Permission denied (publickey)`)
* **Incorrect SSH Private Key:** Verify you are using the correct `.pem` file.
* **Incorrect Username:** Verify the username matches the AMI default:
  * Amazon Linux 2 / AL2023: `ec2-user`
  * Ubuntu: `ubuntu`
  * CentOS: `centos`
  * RHEL: `ec2-user` or `root`
  * Debian: `admin`
* **Incorrect Permissions on Key:** Ensure the private key file has secure permissions: `chmod 400 key.pem`.
* **Incorrect Permissions on Server Files:** On the server, `~/.ssh` should be `700`, and `~/.ssh/authorized_keys` should be `600`.

---

### 🚦 Scenario B: Status Check Failures

AWS monitors EC2 instances using two types of status checks:

```
              ┌──────────────────────────────────────┐
              │           System Status              │  <-- AWS Hypervisor / Hardware Level
              └──────────────────┬───────────────────┘
                                 │
              ┌──────────────────▼───────────────────┐
              │          Instance Status             │  <-- Customer OS / Software Level
              └──────────────────────────────────────┘
```

#### 1. System Status Check Failure (0/2 or 1/2 Checks Passed)
Indicates issues with the underlying physical host (hardware failure, loss of power, network issues at the hypervisor level).
* **How to Resolve:** **Stop and Start** the instance. This forces the instance to launch on a different, healthy physical host machine in the AWS pool. (Note: Do not do this if your instance uses local Instance Store, as data will be lost).

#### 2. Instance Status Check Failure (1/2 Checks Passed)
Indicates issues inside the operating system (kernel panic, corrupt filesystem, failing network configuration, resource exhaustion, or misconfigured firewall).
* **How to Troubleshoot:**
  1. **Get Instance Console Screenshot / Serial Console:** View the boot logs to see if there is a Kernel Panic, filesystem check error, or networking initialization failure.
  2. **EC2 Rescue Tool:** Use AWS Systems Manager (SSM) Session Manager or EC2 Rescue runbooks to fix common configuration errors.
  3. **Offline Recovery Method (Detaching Root Volume):**
     * Stop the broken instance (Instance A).
     * Detach its EBS root volume.
     * Attach this volume as a secondary disk to a healthy running temporary instance (Instance B) in the same AZ.
     * Mount the disk on Instance B, examine the logs (`/var/log/messages` or `/var/log/syslog`), correct files (e.g., revert `/etc/fstab` changes, repair GRUB, or fix network configs).
     * Unmount, detach, and re-attach back to Instance A as the root device (`/dev/xvda` or `/dev/sda1`).
     * Start Instance A.

---

### 💾 Scenario C: Expanding an EBS Volume
When a customer complains that the root disk is full, you can expand it dynamically without downtime.

```
Step 1: Increase EBS Size in AWS Console -> Step 2: Resize Partition -> Step 3: Expand Filesystem
```

1. **Modify Volume in AWS Console:** Increase the size (e.g., from 20 GiB to 40 GiB).
2. **SSH into the Instance** and check the filesystem structure using `lsblk`:
   ```bash
   lsblk
   # Example output:
   # xvda    202:0    0   40G  0 disk
   # └─xvda1 202:1    0   20G  0 part /
   ```
3. **Resize the Partition:** Use `growpart` (note the space between disk and partition number):
   ```bash
   sudo growpart /dev/xvda 1
   ```
4. **Expand the Filesystem:**
   * For **EXT4** filesystems:
     ```bash
     sudo resize2fs /dev/xvda1
     ```
   * For **XFS** filesystems:
     ```bash
     sudo xfs_growfs -d /
     ```
5. **Verify the New Size:**
   ```bash
   df -h
   ```

---

## 6. AWS CLI Cheat Sheet for EC2

Ensure you have the AWS CLI configured with proper IAM permissions before running these commands.

### Describe Instances
```bash
# List all running instances in the current region
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[InstanceId,InstanceType,PublicIpAddress]" --output table
```

### Start / Stop / Reboot Instances
```bash
# Stop an instance
aws ec2 stop-instances --instance-ids i-0123456789abcdef0

# Start an instance
aws ec2 start-instances --instance-ids i-0123456789abcdef0

# Reboot an instance
aws ec2 reboot-instances --instance-ids i-0123456789abcdef0
```

### Modify Security Groups
```bash
# Authorize SSH ingress from a specific IP
aws ec2 authorize-security-group-ingress --group-id sg-0123456789abcdef0 --protocol tcp --port 22 --cidr 203.0.113.50/32
```

### Modify Volume Size
```bash
# Modify EBS volume to 50 GiB
aws ec2 modify-volume --volume-id vol-0123456789abcdef0 --size 50
```

### View Instance Console Output
```bash
# Retrieve console log (useful for troubleshooting failed boot)
aws ec2 get-console-output --instance-id i-0123456789abcdef0 --output text
```
