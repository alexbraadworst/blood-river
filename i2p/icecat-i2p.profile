# Firejail profile for IceCat hardened for i2p use

# Restrict network - allow full outbound for i2p, disable incoming


# Drop capabilities that browsers don’t need
caps.drop all

# Disable ptrace and other debugging
seccomp

# Hide USB devices and other hardware
nodvd
no3d
noroot

# Limit process visibility
private-dev

# Read-only access to /usr (system binaries)
read-only /usr

# Enable seccomp with default profile
seccomp

# Deny access to /proc/kcore and other sensitive files
blacklist /proc/kcore

# Drop all networking except loopback (optional)
# Uncomment if you want no external network (won't work with i2p obviously)
# net none


