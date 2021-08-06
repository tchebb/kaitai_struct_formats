meta:
  id: mach_o_fat
  title: macOS Mach-O multiarch ("fat") binary
  license: CC0-1.0
  imports:
    - mach_o
  endian: be

doc: |
  This is a simple container format that encapsulates multiple Mach-O files,
  each generally for a different architecture. XNU can execute these files just
  like single-arch Mach-Os and will pick the appropriate entry.

doc-ref: https://opensource.apple.com/source/xnu/xnu-7195.121.3/EXTERNAL_HEADERS/mach-o/fat.h.auto.html

seq:
  - id: magic
    contents: [0xca, 0xfe, 0xba, 0xbe]
  - id: nfat_arch
    type: u4
  - id: fat_archs
    type: fat_arch
    repeat: expr
    repeat-expr: nfat_arch

types:
  fat_arch:
    seq:
      - id: cputype
        type: u4
        enum: mach_o::cpu_type
      - id: cpusubtype
        type: u4
      - id: offset
        type: u4
      - id: size
        type: u4
      - id: align
        type: u4

    instances:
      object:
        pos: offset
        size: size
        type: mach_o
