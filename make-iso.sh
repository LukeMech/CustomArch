#!/usr/bin/env bash
set -e

# Run pulling from aur
sh ./scripts/pullFromAur.sh

# Run build
sh ./scripts/build.sh

# Run cleanup
sh ./scripts/cleanup.sh