# Third-Party Licenses

The GF‑Fortran‑SDK redistributes several third‑party components as part of its
portable toolchain. Each component retains its original license. Full license
texts are provided in `docs/legal/<component>/LICENSE`.

This document provides an overview of all third‑party software included in the
SDK, along with their respective licenses and official sources.

---

## GCC — GNU Compiler Collection
- License: GNU General Public License v3 (GPLv3) + GCC Runtime Library Exception  
- Source: https://gcc.gnu.org  
- License files: `gcc/`

GCC is distributed under GPLv3. Runtime libraries (libgcc, libstdc++, libgfortran)
include the GCC Runtime Library Exception, allowing linking with proprietary code.

---

## MinGW‑w64 — Windows API headers and runtime libraries
- License: Zope Public License 2.1 (ZPL) with exceptions  
- Source: https://mingw-w64.org  
- License files: `mingw-w64/`

MinGW‑w64 provides Windows headers, import libraries, and CRT components. It is
licensed under ZPL 2.1 with additional exceptions permitting redistribution.

---

## GDB — GNU Debugger
- License: GNU General Public License v3 (GPLv3)  
- Source: https://www.gnu.org/software/gdb/  
- License files: `gdb/`

GDB is licensed under GPLv3. Redistribution requires including the full license text.

---

## GNU Binutils
- License: GNU General Public License v3 (GPLv3)  
- Source: https://www.gnu.org/software/binutils/  
- License files: `binutils/`

Binutils includes ld, as, objdump, and related tools. Licensed under GPLv3.

---

## GNU Make
- License: GNU General Public License v3 (GPLv3)  
- Source: https://www.gnu.org/software/make/  
- License files: `make/`

GNU Make is licensed under GPLv3. Redistribution requires including the full license.

---

## Yasm — Assembler
- License: BSD 2‑Clause License  
- Source: https://yasm.tortall.net  
- License files: `yasm/`

Yasm is a permissively licensed assembler under the BSD‑2‑Clause license.

---

## NASM — Netwide Assembler
- License: BSD 2‑Clause License  
- Source: https://www.nasm.us  
- License files: `nasm/`

NASM is licensed under the BSD‑2‑Clause license. Redistribution requires including
the license text.

---

## JWasm — MASM-compatible assembler
- License: Sybase Open Watcom Public License 1.0 (OWPL)  
- Source: https://github.com/JWasm/JWasm  
- License files: `jwasm/`

JWasm is distributed under the OWPL 1.0 license, an OSI‑approved open‑source license.

---

## LLVM / Clang / LLD / LLDB
- License: Apache License 2.0 with LLVM Exception  
- Source: https://llvm.org  
- License files: `llvm/`

LLVM and Clang are licensed under Apache 2.0 with the LLVM Exception, which permits
linking without imposing copyleft requirements.

---

# Redistribution Requirements

When redistributing the GF‑Fortran‑SDK:

- You **must** include all third‑party license texts found in `docs/legal/`.
- You **must** preserve all copyright notices.
- You **may** modify or extend the SDK under the terms of the MIT License (for original code).
- You **must** comply with GPLv3 requirements for components such as GCC, GDB, Binutils, and Make.
- You **must** comply with ZPL, BSD, OWPL, and Apache 2.0 requirements for their respective components.

For questions regarding licensing or redistribution, please refer to the official
license texts or contact the maintainers of the respective projects.
