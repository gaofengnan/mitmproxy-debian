#!/bin/bash
set -euo pipefail

mitmproxy_VERSION=$1
BUILD_VERSION=$2

if [ -z "$mitmproxy_VERSION" ] || [ -z "$BUILD_VERSION" ]; then
    echo "Usage: $0 <mitmproxy_version> <build_version>"
    echo "Example: $0 12.2.3 1"
    exit 1
fi

PACKAGE_NAME="mitmproxy"
ORIG_TARBALL="${PACKAGE_NAME}_${mitmproxy_VERSION}.orig.tar.gz"
BUILD_DIR="${PACKAGE_NAME}-${mitmproxy_VERSION}"

echo "Creating the source package for mitmproxy ${mitmproxy_VERSION}-${BUILD_VERSION}..."

# Download upstream source tarball (shared .orig.tar.gz across all distributions).
# Upstream tags carry a "v" prefix, but GitHub strips it from the archive's top
# level directory, so the archive already extracts as mitmproxy-<version>/ and is
# used byte-for-byte with no repacking.
if [ ! -f "$ORIG_TARBALL" ]; then
    echo "Downloading upstream source from GitHub..."
    wget -q "https://github.com/mitmproxy/mitmproxy/archive/refs/tags/v${mitmproxy_VERSION}.tar.gz" -O "$ORIG_TARBALL"
    echo "  Downloaded $ORIG_TARBALL"
else
    echo "  Using existing $ORIG_TARBALL"
fi

build_source_package() {
    local FULL_VERSION="${mitmproxy_VERSION}-${BUILD_VERSION}~gaofn"

    echo "  Building source package ${FULL_VERSION}..."

    # Clean and recreate build directory from orig tarball
    rm -rf "$BUILD_DIR"
    tar -xf "$ORIG_TARBALL"
    # GitHub archives extract as mitmproxy-12.x.y/ which matches our BUILD_DIR

    # Copy Debian packaging directory
    cp -r debian "$BUILD_DIR/"

    # Generate the changelog (overwrites placeholder)
    cat > "$BUILD_DIR/debian/changelog" << EOC
mitmproxy (${FULL_VERSION}) stable; urgency=medium

  * New upstream release ${mitmproxy_VERSION}.

 -- Fengnan Gao <gao.fengnan@gmail.com>  $(date -R)
EOC

    # Build source package (.dsc + .debian.tar.xz); reuses existing .orig.tar.gz
    dpkg-source -b "$BUILD_DIR"

    rm -rf "$BUILD_DIR"
    echo "    ${FULL_VERSION}"
}

echo ""
# One source package for every suite, as with the binaries (see build_debian.sh).
build_source_package

echo ""
echo "Source packages created successfully!"
echo ""
echo "Generated files:"
ls -la "${PACKAGE_NAME}_"*.dsc "${PACKAGE_NAME}_"*.orig.tar.gz "${PACKAGE_NAME}_"*.debian.tar.xz 2>/dev/null || true
