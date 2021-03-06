#!/bin/bash

set -euxo pipefail

# sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
apt-get update
apt-get install -y git build-essential wget zlib1g-dev golang-go python-pip python-dev build-essential 
PREFIX=/ sh ./build/llvm.sh

# from https://github.com/rust-lang-nursery/docker-rust-nightly/blob/master/nightly/Dockerfile
url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init"
wget "$url"
chmod +x rustup-init
./rustup-init -y --no-modify-path --default-toolchain nightly
rm rustup-init
chmod -R a+w $RUSTUP_HOME $CARGO_HOME
rustup --version
cargo --version
rustc --version

sh ./build/build.sh

#wllvm and gllvm
sudo pip install wllvm
go get github.com/SRI-CSL/gllvm/cmd/...