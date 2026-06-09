# 📚 Learning Log: Day 08 & 09 EC2 Mastery

## 🎯 Objectives
- Understand EC2 instance types, sizes, and purchasing options to recommend optimal configurations for customers.
- Deep dive into EBS volumes (performance, types, snapshots, encryption) and compare them with Instance Store.
- Master security group statefulness vs. NACL statelessness and design correct ingress/egress rules.
- Develop systematic troubleshooting strategies for SSH connection timeouts, status check failures, and storage full issues.

## 📝 Concepts Learned
- **IMDSv2 Session Token security:** Learned how IMDSv2 protects against SSRF vulnerabilities by requiring a dynamic token fetched via a `PUT` request before retrieving metadata.
- **Stateful vs. Stateless Firewalls:** Solidified how Security Groups track state (automatically allowing outbound responses) while NACLs do not (requiring manual outbound rule configuration for Ephemeral Ports `1024-65535`).
- **EBS Volume Types:** Learned that `gp3` is the modern standard allowing independent IOPS and throughput provisioning, unlike `gp2` where performance is tied to disk size.
- **System vs. Instance Status Checks:** Understood that a System Status Check failure indicates underlying AWS hardware problems (solved by stopping/starting the instance to move hosts), whereas an Instance Status Check failure indicates OS/software level issues (kernel panic, full disk, bad configs).

## 🛠 Hands-on / Practical 
Tested EBS Volume expansion without downtime on a live test instance:
```bash
# 1. Check disk block devices
lsblk

# 2. Grow the partition on the raw volume
sudo growpart /dev/nvme0n1 1

# 3. Grow the XFS filesystem on the volume
sudo xfs_growfs -d /

# 4. Verify filesystem space
df -h
```

Querying instance metadata using IMDSv2:
```bash
# Obtain session token
TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Fetch Public IP
curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4
```

## ⚠️ Challenges & Troubleshooting
- **Issue:** Attempted to SSH into an instance and received a `Permission denied (publickey)` error.
- **Solution:** 
  1. Verified default username for Amazon Linux 2 is `ec2-user` (was accidentally using `admin`).
  2. Set correct local private key permissions using `chmod 400 key.pem` to prevent SSH client rejection.
- **Issue:** Handled a mock scenario of a corrupted `/etc/fstab` causing Instance Status Check failures.
- **Solution:** Detached the root volume, mounted it as a secondary disk on a healthy recovery instance, commented out the bad fstab line, and re-attached it to boot successfully.

## ❓ Outstanding Questions
- How does AWS handle KMS envelope encryption key rotations on active EBS snapshots?

## ✅ Action Items
- [x] Review notes and draft comprehensive README
- [x] Populate the LEARNING_LOG.md
- [x] Push notes and documentation to GitHub

