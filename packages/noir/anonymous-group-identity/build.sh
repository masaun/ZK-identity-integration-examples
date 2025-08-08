#!/bin/bash

# Clean previous build
rm -rf target

# Align the Noir/Nargo version and bb.js version of the local machine.
echo "Update the bb.js version of the local machine to v0.85.0..."
bbup --version 0.85.0

echo "Check the Noir/Nargo version - This version is supposed to be v1.0.0-beta.6)..."
nargo -V

# Compile the ZK circuit
echo "Compiling circuit..."
if ! nargo compile; then
    echo "Compilation failed. Exiting..."
    exit 1
fi

echo "Gate count:"
bb gates -b target/anonymous_group_identity.json | jq '.functions[0].circuit_size'
