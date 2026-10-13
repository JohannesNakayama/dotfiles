---
name: initialize-rust-project
description: Initialize a Rust project
---

## What I do

- Initialize a Rust project

I adhere by the following rules:

- Create a `rust-toolchain.toml`. Use the nightly channel and the minimal profile. Include it in the nix flake using `pkgs.rust-bin.fromRustupToolchainFile`.
- Use the `github:oxalica/rust-overlay` rust overlay.
- Add the following development tools to the flake:
    - bacon
    - rust-analyzer
    - cargo-license
    - cargo-deny
    - cargo-info


## When to use me

When you are asked to initialize a project with Rust in the stack.
