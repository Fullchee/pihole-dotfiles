# Prune older Pi-hole teleporter files in .dotfiles/, keeping only the latest.
prune-teleporter:
    #!/usr/bin/env bash
    set -euo pipefail
    shopt -s nullglob

    # Define the target directory
    TARGET_DIR=".dotfiles"

    # Use an array to catch the files with the path included
    files=("$TARGET_DIR"/pi-hole_pihole_teleporter_*)

    # If 1 or 0 files, nothing to do
    if (( ${#files[@]} <= 1 )); then
        echo "No redundant teleporter files found in $TARGET_DIR."
        exit 0
    fi

    # Sort files and pick the last one (the most recent timestamp)
    latest=$(printf "%s\n" "${files[@]}" | sort | tail -n 1)

    for f in "${files[@]}"; do
        if [[ "$f" != "$latest" ]]; then
            # Check if tracked by git, then remove
            if git ls-files --error-unmatch "$f" >/dev/null 2>&1; then
                git rm --quiet "$f"
            else
                rm -f "$f"
            fi
        fi
    done

    echo "✅ Pruning complete in $TARGET_DIR."
    echo "   Kept: $(basename "$latest")"

ssh-update-settings:
    ssh -t pihole "zsh -ci \"cd .dotfiles && sudo pihole-FTL --teleporter && configpush 'Update pihole settings'\""

mac-setup:
    brew install --cask raspberry-pi-imager
    brew install prek
    prek install

linux-setup:
    # install prek
    curl --proto '=https' --tlsv1.2 -LsSf https://github.com/j178/prek/releases/download/v0.3.3/prek-installer.sh | sh
    prek install
