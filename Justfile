
mac-setup:
    brew install --cask raspberry-pi-imager
    brew install prek
    prek install

linux-setup:
    sudo apt -y install just;  # for better Makefiles
    # install prek
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/j178/prek/releases/download/v0.3.3/prek-installer.sh | sh

# Prune older Pi-hole teleporter files, keeping only the latest.
prune-teleporter:
    #!/usr/bin/env bash
    files=(pi-hole_pihole_teleporter_*)
    (( ${#files[@]} <= 1 )) && exit 0
    latest=$(printf "%s\n" "${files[@]}" | sort | tail -n 1)
    for f in "${files[@]}"; do
        if [[ "$f" != "$latest" ]]; then
            git rm --quiet "$f" 2>/dev/null || rm -f "$f"
        fi
    done
