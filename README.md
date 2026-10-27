![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/gaofengnan/mitmproxy-debian/total)
![GitHub Downloads (all assets, latest release)](https://img.shields.io/github/downloads/gaofengnan/mitmproxy-debian/latest/total)
![GitHub Release](https://img.shields.io/github/v/release/gaofengnan/mitmproxy-debian)
![GitHub Release Date](https://img.shields.io/github/release-date/gaofengnan/mitmproxy-debian)

<h1>
   <p align="center">
     <a href="https://mitmproxy.org"><img src="https://github.com/gaofengnan/mitmproxy-debian/blob/main/mitmproxy.png" alt="mitmproxy Logo" width="128" style="margin-right: 20px"></a>
     <a href="https://www.debian.org/"><img src="https://github.com/gaofengnan/mitmproxy-debian/blob/main/debian-logo.png" alt="Debian Logo" width="104" style="margin-left: 20px"></a>
     <br>mitmproxy for Debian
   </p>
</h1>
<p align="center">
 mitmproxy is an interactive TLS-capable intercepting HTTP proxy for penetration testers and software developers.
</p>

# mitmproxy for Debian

> Fork of [dariogriffo/mitmproxy-debian](https://github.com/dariogriffo/mitmproxy-debian) (MIT); the original packaging is by Dario Griffo. Served at [deb.gaofn.xyz](https://deb.gaofn.xyz) for Debian 12 (bookworm) and 13 (trixie).

This repository contains build scripts to produce the _unofficial_ Debian packages
(.deb) for [mitmproxy](https://github.com/mitmproxy/mitmproxy/) hosted at [deb.gaofn.xyz](https://deb.gaofn.xyz)

Currently supported Debian distros are:
- Bookworm (v12)
- Trixie (v13)
- Forky (v14)
- Sid (testing)

Currently supported Ubuntu distros are:
- Jammy (22.04)
- Noble (24.04)
- Questing (25.10)
- Resolute (26.04)

Supported architectures:
- amd64 (x86_64) - All distributions
- arm64 (aarch64) - All distributions

Upstream publishes no i386, armel, armhf or riscv64 binaries, so those
architectures are not available.

The packages install the three upstream commands:

- `mitmproxy`: interactive console interface
- `mitmdump`: command-line version, "tcpdump for HTTP"
- `mitmweb`: web interface (http://127.0.0.1:8081 by default)

Upstream ships no shell completions and no man pages; run `mitmproxy --help`
or see the [documentation](https://docs.mitmproxy.org/stable/).

> ℹ️ The packages repackage upstream's **self-contained standalone builds**
> from [downloads.mitmproxy.org](https://mitmproxy.org/downloads/), which bundle
> their own Python interpreter and OpenSSL. They therefore have **no
> dependencies**, and they upgrade over the (much older) `mitmproxy` package in
> the official Debian/Ubuntu archives. The flip side is that addon scripts
> (`-s script.py`) can only import modules bundled with mitmproxy, not Python
> packages installed on the system.

This is an unofficial community project to provide a package that's easy to
install on Debian. If you're looking for the mitmproxy source code, see
[mitmproxy](https://github.com/mitmproxy/mitmproxy/).

## Install/Update

### The Debian way

```sh
sudo install -d -m 0755 /etc/apt/keyrings
sudo curl -fsSL https://deb.gaofn.xyz/deb.gaofn.xyz.gpg -o /etc/apt/keyrings/deb.gaofn.xyz.gpg
sudo curl -fsSL https://deb.gaofn.xyz/deb.gaofn.xyz.sources -o /etc/apt/sources.list.d/deb.gaofn.xyz.sources
# Debian 12 (bookworm): fetch deb.gaofn.xyz-bookworm.sources instead
sudo apt update
sudo apt install -y mitmproxy
```

### Manual Installation

1. Download the .deb package for your Debian version available on
   the [Releases](https://github.com/gaofengnan/mitmproxy-debian/releases) page.
2. Install the downloaded .deb package.

```sh
sudo dpkg -i <filename>.deb
```
## Updating

To update to a new version, just follow any of the installation methods above. There's no need to uninstall the old version; it will be updated correctly.

## Building

### Build for single architecture
```sh
./build.sh <mitmproxy_version> <build_version> <architecture>
# Example: ./build.sh 12.2.3 1 arm64
```

### Build for all architectures
```sh
./build.sh <mitmproxy_version> <build_version> all
# Example: ./build.sh 12.2.3 1 all
```

## Roadmap

- [x] Produce a .deb package on GitHub Releases
- [x] Set up a debian mirror for easier updates
- [x] Multi-architecture support (amd64, arm64)

## Disclaimer

- This repo is not open for issues related to mitmproxy. This repo is only for _unofficial_ Debian packaging.
