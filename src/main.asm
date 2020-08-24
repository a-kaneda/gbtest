include	"hardware.inc"
include "image_back.inc"
include "image_player.inc"
include "map001.inc"

; ================================================================
; Constnt definitions
; ================================================================

TILE_SIZE           equ 16
TILE_WIDTH          equ 8
TILE_HEIGHT         equ 8
BG_WIDTH            equ 32
BG_HEIGHT           equ 32
TILENUM_BACK_001    equ 0
TILELEN_BACK_001    equ 8
TILENUM_PLAYER_01   equ (TILENUM_BACK_001 + TILELEN_BACK_001)
TILELEN_PLAYER      equ 4
SPRNUM_PLAYER       equ 0
SPRITE_POS_Y        equ 0
SPRITE_POS_X        equ 1
SPRITE_NUM          equ 2
SPRITE_ATTRIBUTE    equ 3
SPRITE_SIZE         equ 4
BUTTON_DOWN         equ %10000000
BUTTON_UP           equ %01000000
BUTTON_LEFT         equ %00100000
BUTTON_RIGHT        equ %00010000
BUTTON_START        equ %00001000
BUTTON_SELECT       equ %00000100
BUTTON_B            equ %00000010
BUTTON_A            equ %00000001

; ================================================================
; Variable definitions
; ================================================================

SECTION	"Variables", WRAM0[$C000]

VARIABLES_BEGIN:
sprites             ds 160
hasHandledVBlank    ds 1
pressedButton       ds 1
holdedButton        ds 1
work1               ds 1
player_pos_x        ds 1
player_pos_y        ds 1
player_attribute    ds 1
VARIABLES_END:

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

    ld a, %11100001
    ld [rOBP1], a

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

    ld hl, VARIABLES_BEGIN
    ld bc, VARIABLES_END - VARIABLES_BEGIN
    call ClearMemory

    ld hl, _VRAM
    ld bc, $2000
    call ClearMemory

    ld hl, ImageBack
    ld de, _VRAM + TILENUM_BACK_001 * TILE_SIZE
    ld bc, TILELEN_BACK_001 * TILE_SIZE
    call CopyMemory

    ld hl, ImagePlayer
    ld de, _VRAM + TILENUM_PLAYER_01 * TILE_SIZE
    ld bc, TILELEN_PLAYER * TILE_SIZE
    call CopyMemory

    ld hl, _SCRN0
    ld bc, BG_WIDTH * BG_HEIGHT
    call ClearMemory

    ld hl, _SCRN0
    ld de, Map001
    ld bc, Map001Height * $100 + Map001Width
    call CopyMap

    ; プレイヤーキャラの初期位置を設定する。
    ld a, 30
    ld [player_pos_x], a
    ld a, 128
    ld [player_pos_y], a
    ld a, OAMF_PAL1
    ld [player_attribute], a

    call UpdatePlayer
    call OAM_DMA

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
    call CheckInput
    call UpdatePlayer

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
    jr nz, CopyByte
    ret

UpdatePlayer:

    ; 十字キー左が押されている場合は左へ移動する。
    ld a, [holdedButton]
    and BUTTON_LEFT
    jr z, .checkRightButton

    ld a, [player_pos_x]
    add a, -1
    ld [player_pos_x], a

    ; 左向きにする。
    ld a, [player_attribute]
    or a, OAMF_XFLIP
    ld [player_attribute], a

.checkRightButton

    ; 十字キー右が押されている場合は右へ移動する。
    ld a, [holdedButton]
    and BUTTON_RIGHT
    jr z, .setOAM

    ld a, [player_pos_x]
    add a, 1
    ld [player_pos_x], a

    ; 右向きにする。
    ld a, [player_attribute]
    and a, ~OAMF_XFLIP
    ld [player_attribute], a

.setOAM

    ; 各タイルのy座標を設定する。
    ld a, [player_pos_y]
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_Y], a
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_Y], a
    add TILE_HEIGHT
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_Y], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_Y], a

    ; 各タイルのx座標を設定する。
    ld a, [player_attribute]
    and a, OAMF_XFLIP
    jr nz, .xflip
    ld a, [player_pos_x]
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_X], a
    add TILE_WIDTH
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_X], a
    jr .setTileNumber
.xflip
    ld a, [player_pos_x]
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_X], a
    add TILE_WIDTH
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_X], a

.setTileNumber
    ; 各タイルのタイル番号を設定するｌ
    ld a, TILENUM_PLAYER_01
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_NUM], a
    inc a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_NUM], a
    inc a
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_NUM], a
    inc a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_NUM], a

    ; 各タイルのattributeを設定する。
    ld a, [player_attribute]
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a

    ret

; バックグラウンドマップをコピーする。
; コピー元は16x16のタイルを前提とする。
; @param hl [IN/OUT] コピー先のVRAM
; @param de [IN/OUT] コピー元のWRAM
; @param b [IN/OUT] マップの高さ
; @param c [IN/OUT] マップの幅
CopyMap:

    ; マップの幅をメモリに保持しておく。
    ld a, c
    ld [work1], a

    ; コピー元アドレスをスタックに保持する。
    push de

.loop
    ; コピー元のマップデータを取得する。
    ld a, [de]

    ; 左上のタイルを設定する。
    sla a
    sla a
    ld [hl+], a

    ; 右上のタイルを設定する。
    add a, 2
    ld [hl+], a

    ; コピー元のアドレスを一つ進める。
    inc de
    
    ; マップ幅分処理するまでループする。
    dec c
    jr nz, .loop

    ; マップ幅を元に戻し、マップ幅・高さをスタックに保存する。
    ld a, [work1]
    ld c, a
    push bc

    ; コピー先のアドレスを次の行まで進める。
    ld a, BG_WIDTH
    sub c
    sub c
    ld b, 0
    ld c, a
    add hl, bc

    ; スタックからマップ幅・高さを復元する。
    pop bc

    ; コピー元のアドレスを1行分戻す。
    pop de

.loop2
    ; コピー元のマップデータを取得する。
    ld a, [de]

    ; 左下のタイルを設定する。
    sla a
    sla a
    inc a
    ld [hl+], a

    ; 右下のタイルを設定する。
    add a, 2
    ld [hl+], a

    ; コピー元のアドレスを一つ進める。
    inc de
    
    ; マップ幅分処理するまでループする。
    dec c
    jr nz, .loop2

    ; マップ高さ分処理したら処理を終了する。
    dec b
    jr z, .finish

    ; マップ幅を元に戻し、マップ幅・高さをスタックに保存する。
    ld a, [work1]
    ld c, a
    push bc

    ; コピー先のアドレスを次の行まで進める。
    ld a, BG_WIDTH
    sub c
    sub c
    ld b, 0
    ld c, a
    add hl, bc

    ; スタックからマップ幅・高さを復元する。
    pop bc

    ; コピー元アドレスをスタックに保持する。
    push de

    ; ループの先頭に戻る。
    jr .loop

.finish

    ret

; ボタン入力をチェックする。
CheckInput:

    ; ボタン入力の読み込みを行う。
    ld a, P1F_5
    ld [rP1], a
    ld a, [rP1]
    ld a, [rP1]

    ; ビット反転して、入力あり=1とする。
    cpl 

    ; 入力部分以外のビットを落とす。
    and a, $f

    ; ボタン入力を上位4bitとする。
    swap a
    ld b, a

    ; 十字キーの入力を行う。
    ld a, P1F_4
    ld [rP1], a
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]
    ld a, [rP1]

    ; ビット反転して、入力あり=1とする。
    cpl 

    ; 入力部分以外のビットを落とす。
    and a, $f

    ; 十字キー入力を下位4bitとする。
    or a, b
    ld b, a

    ; 前回押されておらず、今回新たに押されたボタンを記憶する。
    ld a, [holdedButton]
    xor a, b
    and a, b
    ld [pressedButton], a

    ; 押し続けているものを含めて、今回押されているボタンを記憶する。
    ld a, b
    ld [holdedButton], a

    ; ボタン入力を終了する。
    ld a, P1F_5 | P1F_4

    ret