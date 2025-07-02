#!/bin/bash

# Usage: ./install-local.sh <version>

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <version>"
    exit 1
fi

VERSION="$1"
DEST_DIR="$HOME/AppData/Roaming/typst/packages/preview/wenyuan-campaign"
TARGET="$DEST_DIR/$VERSION"
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd)"

# --- Step 1: Check version exists in typst.toml ---
if ! grep -q "\"$VERSION\"" "$SCRIPT_DIR/typst.toml"; then
    echo "Error: Version '$VERSION' not found in typst.toml."
    exit 1
fi

# --- Step 2: Check version exists in first 5 lines of docs.typ ---
if ! head -5 "$SCRIPT_DIR/docs.typ" | grep -q "$VERSION"; then
    echo "Error: Version '$VERSION' not found in first 5 lines of docs.typ."
    exit 1
fi

# --- Step 3: Check version exists in first 5 lines of template/main.typ ---
if ! head -5 "$SCRIPT_DIR/template/main.typ" | grep -q "$VERSION"; then
    echo "Error: Version '$VERSION' not found in first 5 lines of template/main.typ."
    exit 1
fi

# --- Step 4: Prompt about overwriting if the target exists ---
if [ -d "$TARGET" ]; then
    read -r -p "Version '$VERSION' already exists. Are you sure you want to replace the current package? [y/N] " RESP
    case "$RESP" in
        [yY][eE][sS]|[yY])
            rm -rf "$TARGET"
            ;;
        *)
            echo "Aborted."
            echo "Existing versions:"
            ls -1 "$DEST_DIR"
            exit 1
            ;;
    esac
fi

# --- Step 5: Copy everything to the target directory ---
mkdir -p "$DEST_DIR"
cp -r "$SCRIPT_DIR" "$TARGET"

# --- Step 6: Compile docs.typ ---
typst compile "$SCRIPT_DIR/docs.typ"

# --- Step 7: Compile template/main.typ ---
typst compile "$SCRIPT_DIR/template/main.typ"

# --- Step 8: Move template/main.pdf to sample.pdf (in source) ---
mv -f "$SCRIPT_DIR/template/main.pdf" "$SCRIPT_DIR/sample.pdf"

# --- Step 9: Re-copy docs.pdf and sample.pdf into the package directory ---
cp -f "$SCRIPT_DIR/docs.pdf" "$TARGET/"
cp -f "$SCRIPT_DIR/sample.pdf" "$TARGET/"

echo "Installed version $VERSION."
