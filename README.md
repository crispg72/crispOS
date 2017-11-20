# crispOS - An 'experimental' OS just for fun

Currently just consists of a simple multiboot loader and a bare kernel that attempts to write 'crispOS' to the console.

Tested on Ubuntu 17.04

## Building

Step 1: Clone this repo
Step 2: `cd boot && make iso`

With any luck this will create a bootable iso at `./build/x86_64/os-x86_64.iso`

## Running under qemu

`make run` should run the iso using qemu.
