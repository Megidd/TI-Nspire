# Objective

To develop Lua scripts for TI-Nspire™ calculators by [this guide](https://education.ti.com/en/resources/lua-scripting).

* Math and science simulations.
* Dynamic, interactive programs.
* Custom applications that function like TI-Nspire™ built-in app.
* ...

# Benchmark

This repository can be used as a benchmark: https://github.com/skayo/TI-Nspire-Minesweeper

# How

## 1. Dependency

On Linux, build a dependency used by our *make* file. Tested on openSUSE Leap.

```bash
git clone https://github.com/ndless-nspire/Luna
cd Luna/
make
sudo make install
```

## 2. Build TNS file

For example, TNS file for `addition` project can be built like this:

```bash
cd addition/
make
```

## 3. Transfer

On Linux, built `*.tns` files can be transferred to TI-Nspire device by: https://github.com/lights0123/n-link/releases

On Linux, these instructions must be followed too: https://lights0123.com/n-link/#linux

# Device used

![TI-Nspire™ calculator being used](https://github.com/Megidd/TI-Nspire/assets/17475482/e4e76ee5-fea1-4fa3-97b4-342a835aef4b)
