# Copy over Omarchy configs
mkdir -p ~/.config

#!/usr/bin/env bash

SRC="$HOME/.local/share/omarchy/config"
DST="$HOME/.config"

# Copy all non-.local files first
rsync -a --exclude='*.local' "$SRC/" "$DST/"

# Append/create from .local files
find "$SRC" -type f -name "*.local" | while read -r local_file; do
    base_file="${local_file%.local}"
    relative="${base_file#$SRC/}"
    target="$DST/$relative"

    mkdir -p "$(dirname "$target")"
    [ -f "$target" ] || touch "$target"

    cat "$local_file" >> "$target"
done



# Use default bashrc from Omarchy
cp ~/.local/share/omarchy/default/bashrc ~/.bashrc
