# Docker Read-Only Filesystem Command Reference Guide

- [Section 1: Container Operations](#section-1-container-operations)
- [Section 2: Filesystem Management](#section-2-filesystem-management)
- [Section 3: Security Verification](#section-3-security-verification)
- [Section 4: Troubleshooting](#section-4-troubleshooting)

> **Author**: Md Toriqul Islam  
> **Description**: Reference guide for Docker read-only filesystem implementation  
> **Learning Focus**: Docker security and filesystem management  
> **Note**: This is a reference guide. Do not execute commands without understanding their implications.

## Section 1: Container Operations

### Basic Container Management
```bash
# Build the read-only container image
docker build -t readonly-test .

# Run container with read-only filesystem
docker run --rm -it --read-only readonly-test

# Run with temporary storage
docker run --rm -it --read-only --tmpfs /tmp readonly-test
```

### Advanced Container Operations
```bash
# Run with specific mount points
docker run --rm -it \
    --read-only \
    --tmpfs /tmp:rw,noexec,nosuid \
    --tmpfs /run:rw,noexec,nosuid \
    readonly-test

# Run with volume mount
docker run --rm -it \
    --read-only \
    -v data-volume:/data:ro \
    readonly-test
```

## Section 2: Filesystem Management

### Filesystem Verification
```bash
# Check mount points
docker inspect container_name | grep -A 10 Mounts

# Verify read-only status
docker inspect container_name | grep ReadonlyRootfs

# List mounted volumes
docker inspect container_name | grep -A 10 Volumes
```

### Storage Operations
```bash
# Create a named volume
docker volume create data-volume

# Inspect volume details
docker volume inspect data-volume

# Clean up volumes
docker volume rm data-volume
```

## Section 3: Security Verification

### Security Checks
```bash
# View container security options
docker inspect container_name | grep -A 10 SecurityOpt

# Check container privileges
docker inspect container_name | grep Privileged

# Verify AppArmor profile
docker inspect container_name | grep AppArmorProfile
```

### Permission Testing
```bash
# Test file creation (should fail)
touch /data/test.txt

# Test file modification (should fail)
echo "test" > /data/existing.txt

# Test directory creation (should fail)
mkdir /data/newdir
```

## Section 4: Troubleshooting

### Common Issues
```bash
# Check container logs
docker logs container_name

# View container processes
docker top container_name

# Container resource usage
docker stats container_name
```

### Debug Operations
```bash
# Run with debug shell
docker run --rm -it --read-only readonly-test sh

# Check mounted filesystems
mount | grep "/data"

# View process information
ps aux
```

## Learning Notes

1. Read-only filesystem prevents runtime modifications
2. Temporary storage can be allocated with --tmpfs
3. Volume mounts can be read-only or read-write
4. Security verification is crucial
5. Always verify mount points and permissions

---

> 💡 **Best Practice**: Always verify read-only status after container creation

> ⚠️ **Warning**: Modifying security settings can impact container isolation

> 📝 **Note**: Some applications may require writable temporary storage