#!/bin/bash
set -e

# ============================
#   GF‑MECA TLS/WSS Build Script
# ============================

FC="gfortran"
CC="gcc"
FFLAGS="-Wall -O2"
CFLAGS="-Wall -O2"
LDFLAGS="-lssl -lcrypto"

BUILDDIR="build"

# ----------------------------
# Source files
# ----------------------------
CORE_F90=(
    net/core/tcp.f90
    net/core/tls.f90
)

SERVER_F90=(
    net/server/router.f90
    net/server/tls_server.f90
)

CLIENT_F90=(
    net/client/tls_client.f90
)

WEBSOCKET_F90=(
    net/websocket/websocket.f90
    net/websocket/wss_server.f90
)

C_WRAPPERS=(
    net/c/tcp_wrapper.c
    net/c/tls_wrapper.c
    net/websocket/ws_crypto.c
)

# ----------------------------
# Output binaries
# ----------------------------
SERVER_BIN="$BUILDDIR/tls_server"
CLIENT_BIN="$BUILDDIR/tls_client"
WSS_BIN="$BUILDDIR/wss_server"

# ----------------------------
# Create build directory
# ----------------------------
mkdir -p "$BUILDDIR"

echo "===================================="
echo "  Building C wrappers"
echo "===================================="

C_OBJ=()
for src in "${C_WRAPPERS[@]}"; do
    obj="${src%.c}.o"
    echo "Compiling $src → $obj"
    $CC $CFLAGS -c "$src" -o "$obj"
    C_OBJ+=("$obj")
done

echo
echo "===================================="
echo "  Building core Fortran modules"
echo "===================================="

CORE_OBJ=()
for src in "${CORE_F90[@]}"; do
    obj="${src%.f90}.o"
    echo "Compiling $src → $obj"
    $FC $FFLAGS -c "$src" -o "$obj"
    CORE_OBJ+=("$obj")
done

echo
echo "===================================="
echo "  Building TLS server"
echo "===================================="

SERVER_OBJ=()
for src in "${SERVER_F90[@]}"; do
    obj="${src%.f90}.o"
    echo "Compiling $src → $obj"
    $FC $FFLAGS -c "$src" -o "$obj"
    SERVER_OBJ+=("$obj")
done

echo "Linking → $SERVER_BIN"
$FC "${C_OBJ[@]}" "${CORE_OBJ[@]}" "${SERVER_OBJ[@]}" $LDFLAGS -o "$SERVER_BIN"

echo
echo "===================================="
echo "  Building TLS client"
echo "===================================="

CLIENT_OBJ=()
for src in "${CLIENT_F90[@]}"; do
    obj="${src%.f90}.o"
    echo "Compiling $src → $obj"
    $FC $FFLAGS -c "$src" -o "$obj"
    CLIENT_OBJ+=("$obj")
done

echo "Linking → $CLIENT_BIN"
$FC "${C_OBJ[@]}" "${CORE_OBJ[@]}" "${CLIENT_OBJ[@]}" $LDFLAGS -o "$CLIENT_BIN"

echo
echo "===================================="
echo "  Building WebSocket (WSS) server"
echo "===================================="

WS_OBJ=()
for src in "${WEBSOCKET_F90[@]}"; do
    obj="${src%.f90}.o"
    echo "Compiling $src → $obj"
    $FC $FFLAGS -c "$src" -o "$obj"
    WS_OBJ+=("$obj")
done

echo "Linking → $WSS_BIN"
$FC "${C_OBJ[@]}" "${CORE_OBJ[@]}" "${WS_OBJ[@]}" $LDFLAGS -o "$WSS_BIN"

echo
echo "===================================="
echo "  Build complete!"
echo "===================================="
echo "Binaries:"
echo "  $SERVER_BIN"
echo "  $CLIENT_BIN"
echo "  $WSS_BIN"
echo
