#!/usr/bin/env bash
# Doesn't work with obsidian since they use their tag in the filename

# Default values
REPO_URL="https://github.com/Floorp-Projects/Floorp"
PKG_FILENAME="floorp-linux-x86_64.tar.xz"

# Usage information
usage() {
  echo "Usage: $0 [-r repo_url] [-p pkg_filename] [-h]"
  echo "  -r  Set the GitHub repository URL (default: $REPO_URL)"
  echo "  -p  Set the package filename (default: $PKG_FILENAME)"
  echo "  -h  Show this help message"
}

# Parse options
while getopts ":r:p:h" opt; do
  case $opt in
    r) REPO_URL="$OPTARG" ;;
    p) PKG_FILENAME="$OPTARG" ;;
    h) usage; exit 0 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; usage; exit 1 ;;
  esac
done
shift $((OPTIND -1))

getLatestDownload() {
  curl -sIL "${REPO_URL}/releases/latest" | strings | grep location | cut -d' ' -f2- | sed 's/tag/download/g'
}

LATEST_URL=$(getLatestDownload)

echo "Download latest package from ${LATEST_URL}? [y/N]"
read -r confirm
if [[ "$confirm" != [yY] ]]; then
  echo "Aborted."
  exit 0
fi
curl -LO "${LATEST_URL}/${PKG_FILENAME}"
