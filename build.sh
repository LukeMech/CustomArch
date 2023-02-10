#!/usr/bin/env bash
pacman -Syu archiso --noconfirm

mkarchiso -v -w /archiso -o /build ./archFiles; 