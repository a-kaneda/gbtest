include	"hardware.inc"
include "image_player.inc"

; ================================================================
; Constnt definitions
; ================================================================

TILE_SIZE           equ 16
BG_WIDTH            equ 32
BG_HEIGHT           equ 32
TILENUM_PLAYER_01   equ 1
TILELEN_PLAYER      equ 4
SPRNUM_PLAYER       equ 0
SPRITE_POS_Y        equ 0
SPRITE_POS_X        equ 1
SPRITE_NUM          equ 2
SPRITE_ATTRIBUTE    equ 3
SPRITE_SIZE         equ 4

; ================================================================
; Variable definitions
; ================================================================

SECTION	"Variables", WRAM0[$C000]

sprites             ds 160
hasHandledVBlank    ds 1

SECTION "Temporary", HRAM

OAM_DMA             ds 10

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
    ld [rOBP0], a

    xor a
    ld [rSCX], a
    ld [rSCY], a

    ld hl, OAM_DMA_
    ld bc, (10 * $100) + (OAM_DMA % $100)
.copyOAM_DMA
    ld a, [hl+]
    ld [c], a
    inc c
    dec b
    jr nz, .copyOAM_DMA

    xor a
    ld hl, sprites
    ld b, 160
    call CopyByte

    ld hl, _VRAM
    ld bc, $2000
    call ClearMemory

    ld hl, ImagePlayer
    ld de, _VRAM + TILENUM_PLAYER_01 * TILE_SIZE
    ld bc, TILELEN_PLAYER * TILE_SIZE
    call CopyMemory

    ld hl, _SCRN0
    ld bc, BG_WIDTH * BG_HEIGHT
    call ClearMemory

    ld a, 30
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_Y], a
    ld a, 30
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_X], a
    ld a, TILENUM_PLAYER_01
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_NUM], a
    ld a, 0
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld a, 38
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_Y], a
    ld a, 30
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_X], a
    ld a, TILENUM_PLAYER_01 + 1
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_NUM], a
    ld a, 0
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld a, 30
    ld hl, ImagePlayerTLE0
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_Y], a
    ld a, 38
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_X], a
    ld a, TILENUM_PLAYER_01 + 2
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_NUM], a
    ld a, 0
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld a, 38
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_Y], a
    ld a, 38
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_X], a
    ld a, TILENUM_PLAYER_01 + 3
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_NUM], a
    ld a, 0
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a

    call OAM_DMA

    xor a
    ld [hasHandledVBlank], a

    ld a, LCDCF_ON | LCDCF_BG8000 | LCDCF_BG9800 | LCDCF_BGON | LCDCF_OBJ8 | LCDCF_OBJON
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

    call OAM_DMA

    jp MainLoop

OAM_DMA_:
    ld a, sprites / $100
    ld [rDMA], a
    ld a, 40
.wait
    dec a
    jr nz, .wait
    ret

CopyMemory:
    ld a, [hl+]
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyMemory
    ret

ClearMemory:
    xor a
    ld [hl+], a
    dec bc
    ld a, b
    or c
    jr nz, ClearMemory
    ret

CopyByte:
    ld [hl+], a
    dec b
    jr nz, CopyMemory
    ret
