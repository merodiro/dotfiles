# Firejail profile for opencode
# Description: AI coding assistant
# Homepage: https://opencode.ai
#
# Installation:
#   This file lives at ~/.config/firejail/opencode.profile
#   Run with: firejail opencode
#
# Note: opencode is different from a pure API client — it spawns shells,
# git, compilers, and language runtimes as part of its coding workflow.
# disable-exec.inc is intentionally excluded.

# Persistent local customizations (add your overrides here, not in this file)
include opencode.local
# Persistent global definitions
include globals.local

# ============================================================================
# SECURITY HARDENING
# ============================================================================

caps.drop all
nonewprivs
noroot
nogroups

seccomp
seccomp.block-secondary

nodvd
nosound
no3d
notv
nou2f
novideo
noprinters
noinput
machine-id

# Prevent namespace re-entry / privilege escalation paths
restrict-namespaces

# ============================================================================
# FILESYSTEM ISOLATION
# ============================================================================

include allow-common-devel.inc

# pnpm is not covered by allow-common-devel.inc
noblacklist ${HOME}/.local/share/pnpm

include disable-common.inc
include disable-programs.inc
# NOTE: disable-shell.inc and disable-exec.inc are intentionally omitted.
# opencode must be able to invoke git, compilers, and shell commands.

# Isolated /tmp so opencode can't read other processes' temp files
private-tmp

# Minimal /dev: tty, pts, null, zero, random, urandom only
private-dev

# Disable removable media
disable-mnt

# ============================================================================
# WHITELIST — WRITABLE PATHS
# ============================================================================

# opencode state, config, and runtime cache
whitelist ${HOME}/.config/opencode
mkdir ${HOME}/.config/opencode

whitelist ${HOME}/.local/share/opencode
mkdir ${HOME}/.local/share/opencode

whitelist ${HOME}/.cache/opencode
mkdir ${HOME}/.cache/opencode

whitelist ${HOME}/.local/state/opencode
mkdir ${HOME}/.local/state/opencode

whitelist ${HOME}/.local/share/opentui
mkdir ${HOME}/.local/share/opentui

# Working directory is injected at runtime via the wrapper script:
#   firejail --whitelist="$PWD" --profile=opencode.profile opencode
# Do not add whitelist ${PWD} here — firejail does not expand that variable
# in profile files (only ${HOME} and ${RUNUSER} are supported).

# ============================================================================
# WHITELIST — READ-ONLY PATHS
# ============================================================================

# Git identity and config
whitelist ${HOME}/.gitconfig
read-only ${HOME}/.gitconfig
whitelist ${HOME}/.gitignore
read-only ${HOME}/.gitignore
whitelist ${HOME}/.config/git
read-only ${HOME}/.config/git

# Language runtimes and package managers opencode may invoke.
# Writable so package installs and cache updates work correctly.
# Add or remove entries in opencode.local to match your toolchain.
whitelist ${HOME}/.local/bin
whitelist ${HOME}/.local/lib
whitelist ${HOME}/.local/share/mise
whitelist ${HOME}/.config/mise
whitelist ${HOME}/.local/state/mise
whitelist ${HOME}/.cache/mise
whitelist ${HOME}/.npm
whitelist ${HOME}/.local/share/pnpm
whitelist ${HOME}/.cache/node
whitelist ${HOME}/.npmrc
read-only ${HOME}/.npmrc
whitelist ${HOME}/.cache/ms-playwright

# GitHub CLI — sandboxed read-only token, path set via wrapper script
whitelist ${HOME}/.config/gh-sandbox
read-only ${HOME}/.config/gh-sandbox

# GitButler
whitelist ${HOME}/.config/gitbutler
read-only ${HOME}/.config/gitbutler
whitelist ${HOME}/.local/share/com.gitbutler.app

# Force pnpm to use the global content-addressable store rather than falling
# back to a project-local .pnpm-store inside the sandbox.
env npm_config_store_dir=${HOME}/.local/share/pnpm/store

# ============================================================================
# NETWORK
# ============================================================================

# Full network access is required for AI provider API calls
# (Anthropic, OpenAI, etc.) and for package manager operations.
protocol unix,inet,inet6,netlink

# ============================================================================
# MINIMAL /etc
# ============================================================================

# TLS certs for HTTPS, DNS/hostname resolution, and basic POSIX lookups.
# Extend in opencode.local if a tool needs something else from /etc.
private-etc @tls-ca,@network,hostname,localtime,mime.types,services,passwd,group,shells

# ============================================================================
# D-BUS
# ============================================================================

dbus-user none
dbus-system none

