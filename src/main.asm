include	"hardware.inc"

; ================================================================
; Variable definitions
; ================================================================

SECTION	"Variables", WRAM0

hasHandledVBlank    ds 1

; ================================================================
; Reset vectors (actual ROM starts here)
; ================================================================

SECTION	"Reset $00", ROM0[$00]
RST_00:
    ret

SECTION	"Reset $08", ROM0[$08]
RST_08:
    ret

SECTION	"Reset $10", ROM0[$10]
RST_10:
    ret

SECTION	"Reset $18", ROM0[$18]
RST_18:
    ret

SECTION	"Reset $20", ROM0[$20]
RST_20:
    ret

SECTION	"Reset $28", ROM0[$28]
RST_28:
    ret

SECTION	"Reset $30", ROM0[$30]
RST_30:
    ret

SECTION	"Reset $38", ROM0[$38]
RST_38:
    ret

; ================================================================
; Interrupt vectors
; ================================================================

SECTION	"VBlank interrupt", ROM0[$40]
VBlankInterrupt:
    push af
    ld a, 1
    ld [hasHandledVBlank], a
    pop af
    reti

SECTION	"LCD STAT interrupt", ROM0[$48]
LCDCInterrupt:
    reti

SECTION	"Timer interrupt", ROM0[$50]
TimerOverflowInterrupt:
    reti

SECTION	"Serial interrupt", ROM0[$58]
SerialTransferCompleteInterrupt:
	reti

SECTION	"Joypad interrupt", ROM0[$60]
JoypadTransitionInterrupt:
	reti

; ================================================================
; ROM header
; ================================================================

SECTION	"ROM header", ROM0[$100]

Boot:
    nop
    jp Main

HeaderLogo:
    db $CE, $ED, $66, $66, $CC, $0D, $00, $0B, $03, $73, $00, $83, $00, $0C, $00, $0D
    db $00, $08, $11, $1F, $88, $89, $00, $0E, $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99
    db $BB, $BB, $67, $63, $6E, $0E, $EC, $CC, $DD, $DC, $99, $9F, $BB, $B9, $33, $3E

HeaderTitle:
    db "GB TEST", 0, 0, 0, 0            ; ROM title (11 bytes)
HeaderProductCode:
    db 0, 0, 0, 0                       ; product code (4 bytes)
HeaderGBCSupport:
    db 0                                ; GBC support (0 = DMG only, $80 = DMG/GBC, $C0 = GBC only)
HeaderNewLicenseeCode:
    db "MO"                             ; new license code (2 bytes)
HeaderSGBFlag:
    db 0                                ; SGB support
HeaderCartridgeType:
    db CART_ROM_MBC1_RAM_BAT            ; Cart type, see hardware.inc for a list of values
HeaderROMSize:
    db 0                                ; ROM size (0 = 32KB)
HeaderRAMSize:
    db 1                                ; RAM size (0 = 0KB, 1 = 2KB)
HeaderDestinationCode:
    db 0                                ; Destination code (0 = Japan, 1 = All others)
HeaderOldLicenseeCode:
    db $33                              ; Old license code (if $33, check new license code)
HeaderMaskROMVersion:
    db 0                                ; ROM version
HeaderComplementCheck:
    db 0                                ; Header checksum (handled by post-linking tool)
HeaderGlobalChecksum:
    dw 0                                ; ROM checksum (2 bytes) (handled by post-linking tool)

Main:
    di
    ld sp, $D000

.waitVBlank
    ld a, [rLY]
    cp 144
    jr nz, .waitVBlank

    xor	a
    ld [rLCDC], a

    ld a, %11100100
    ld [rBGP], a

    xor a
    ld [rSCX], a
    ld [rSCY], a

    ld hl, _VRAM
    ld b, 16
.clearVRAM
    ld [hl+], a
    dec b
    jr nz, .clearVRAM

    ld hl, _SCRN0
    ld bc, 32 * 32
.clearBG0
    xor a
    ld [hl+], a
    dec bc
    ld a, b
    or c
    jr nz, .clearBG0

    ld [hasHandledVBlank], a

    ld a, LCDCF_ON | LCDCF_BG8000 | LCDCF_BG9800 | LCDCF_BGON | LCDCF_OBJ8 | LCDCF_OBJOFF
    ld [rLCDC], a

    ld a, IEF_VBLANK
    ld [rIE], a
    ei

MainLoop:
    halt
    ld a, [hasHandledVBlank]
    and a
    jr z, MainLoop
    xor a
    ld [hasHandledVBlank], a

    jp MainLoop