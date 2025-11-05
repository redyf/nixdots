#!/usr/bin/env sh
wallpapers_dir="$HOME/wallpapers"
file="$wallpapers_dir/$1"

# Mostra a imagem instantaneamente
swww img "$file" --transition-type instant --transition-duration 0.1

