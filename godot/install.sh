#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/../lib.sh"

GODOT_VERSION="4.6.2"
GODOT_DIR="/opt/godot"
GODOT_BIN="${GODOT_DIR}/Godot_v${GODOT_VERSION}-stable_linux.x86_64"

if [ ! -f "${GODOT_BIN}" ]; then
    step "${YELLOW}" "Godot ${GODOT_VERSION} not found, downloading..."
    TMP_ZIP="$(mktemp --suffix=.zip)"
    curl -fL --progress-bar -o "${TMP_ZIP}" \
        "https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip"

    sudo mkdir -p "${GODOT_DIR}"
    sudo unzip -q -o "${TMP_ZIP}" -d "${GODOT_DIR}"
    rm -f "${TMP_ZIP}"
fi

mkdir -p "${HOME}/.local/bin"
ln -sf "${GODOT_BIN}" "${HOME}/.local/bin/godot"

DESKTOP_FILE="${HOME}/.local/share/applications/org.godotengine.Godot.desktop"
EXEC_LINE="Exec=${HOME}/.local/bin/godot %f"

# Exec is machine-specific ($HOME), so it's not tracked in the repo's copy of the file.
# Only touch the installed file if it doesn't already have the correct line.
if ! grep -qxF "${EXEC_LINE}" "${DESKTOP_FILE}" 2>/dev/null; then
    mkdir -p "${HOME}/.local/share/applications"
    cp "${SCRIPT_DIR}/org.godotengine.Godot.desktop" "${DESKTOP_FILE}"
    sed -i '/^Exec=/d' "${DESKTOP_FILE}"
    echo "${EXEC_LINE}" >> "${DESKTOP_FILE}"
fi

sudo cp "${SCRIPT_DIR}/godot.svg" /usr/share/pixmaps/godot.svg
