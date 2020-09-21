include	"hardware.inc"
include "image_font.inc"
include "image_back.inc"
include "image_player.inc"
include "image_monster01.inc"
include "map001.inc"

; ================================================================
; Constnt definitions
; ================================================================

TILE_SIZE           equ 16
TILE_SIZE_HALF      equ 8
TILE_WIDTH          equ 8
TILE_HEIGHT         equ 8
TILE_NUM_16x16      equ 4
BG_WIDTH            equ 32
BG_HEIGHT           equ 32
TILENUM_BACK_001    equ 0
TILELEN_BACK_001    equ 8
TILENUM_FONT        equ (16 * 4)
TILENUM_PLAYER_01   equ (TILENUM_FONT + ImageFontLen)
TILELEN_PLAYER      equ 8
TILENUM_MONSTER_01  equ (TILENUM_PLAYER_01 + TILELEN_PLAYER)
TILELEN_MONSTER_01  equ 8
SPRNUM_PLAYER       equ 0
SPRNUM_ENEMY        equ 4
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
PLAYER_ANIM_SPEED   equ $20
MAP_TILE            equ %00111111
MAP_ATTRIBUTE       equ %11000000
MAP_BLOCK           equ %01000000
FALL_ACCEL          equ $80
MAX_FALL_SPEED      equ 4
CHARACTER_SIZE      equ 16
CH_POS_X            equ 0
CH_POS_Y            equ 1
CH_TILE             equ 2
CH_ATTR             equ 3
CH_POS_X_DEC        equ 4
CH_SPEED_Y          equ 5
CH_ACCEL_Y          equ 6
CH_ANIMATION        equ 7
CH_ANIM_WAIT        equ 8
CH_JUMP_TIME        equ 9
CH_STATUS           equ 10
CH_DATA_SIZE        equ 11
SPRITE_OFFSET_X     equ 8
SPRITE_OFFSET_Y     equ 16
STATUS_LANDED       equ %00000001
JUMP_SPEED          equ -4
JUMP_ACCEL          equ $30
JUMP_TIME           equ 20
WINDOW_OFFSET_X     equ 7
STATUS_WIN_POS_X    equ 0
STATUS_WIN_POS_Y    equ 128
STATUS_WIN_HP_LABEL equ (_SCRN1 + 1)
STATUS_WIN_HP_NOW   equ (_SCRN1 + 4)
STATUS_WIN_HP_SLASH equ (_SCRN1 + 7)
STATUS_WIN_HP_MAX   equ (_SCRN1 + 8)
STATUS_WIN_MP_LABEL equ (_SCRN1 + 33)
STATUS_WIN_MP_NOW   equ (_SCRN1 + 36)
STATUS_WIN_MP_SLASH equ (_SCRN1 + 39)
STATUS_WIN_MP_MAX   equ (_SCRN1 + 40)
STATUS_WIN_GOLD_LABEL   equ (_SCRN1 + 12)
STATUS_WIN_GOLD_VALUE   equ (_SCRN1 + 14)
STATUS_WIN_EXP_LABEL    equ (_SCRN1 + 44)
STATUS_WIN_EXP_VALUE    equ (_SCRN1 + 46)

FONT_BLANK          equ (TILENUM_FONT + 0)
FONT_NUM_0          equ (TILENUM_FONT + 1)
FONT_NUM_1          equ (TILENUM_FONT + 2)
FONT_NUM_2          equ (TILENUM_FONT + 3)
FONT_NUM_3          equ (TILENUM_FONT + 4)
FONT_NUM_4          equ (TILENUM_FONT + 5)
FONT_NUM_5          equ (TILENUM_FONT + 6)
FONT_NUM_6          equ (TILENUM_FONT + 7)
FONT_NUM_7          equ (TILENUM_FONT + 8)
FONT_NUM_8          equ (TILENUM_FONT + 9)
FONT_NUM_9          equ (TILENUM_FONT + 10)
FONT_ENG_A          equ (TILENUM_FONT + 11)
FONT_ENG_B          equ (TILENUM_FONT + 12)
FONT_ENG_C          equ (TILENUM_FONT + 13)
FONT_ENG_D          equ (TILENUM_FONT + 14)
FONT_ENG_E          equ (TILENUM_FONT + 15)
FONT_ENG_F          equ (TILENUM_FONT + 16)
FONT_ENG_G          equ (TILENUM_FONT + 17)
FONT_ENG_H          equ (TILENUM_FONT + 18)
FONT_ENG_I          equ (TILENUM_FONT + 19)
FONT_ENG_J          equ (TILENUM_FONT + 20)
FONT_ENG_K          equ (TILENUM_FONT + 21)
FONT_ENG_L          equ (TILENUM_FONT + 22)
FONT_ENG_M          equ (TILENUM_FONT + 23)
FONT_ENG_N          equ (TILENUM_FONT + 24)
FONT_ENG_O          equ (TILENUM_FONT + 25)
FONT_ENG_P          equ (TILENUM_FONT + 26)
FONT_ENG_Q          equ (TILENUM_FONT + 27)
FONT_ENG_R          equ (TILENUM_FONT + 28)
FONT_ENG_S          equ (TILENUM_FONT + 29)
FONT_ENG_T          equ (TILENUM_FONT + 30)
FONT_ENG_U          equ (TILENUM_FONT + 31)
FONT_ENG_V          equ (TILENUM_FONT + 32)
FONT_ENG_W          equ (TILENUM_FONT + 33)
FONT_ENG_X          equ (TILENUM_FONT + 34)
FONT_ENG_Y          equ (TILENUM_FONT + 35)
FONT_ENG_Z          equ (TILENUM_FONT + 36)
FONT_HIRA_A         equ (TILENUM_FONT + 37)
FONT_HIRA_I         equ (TILENUM_FONT + 38)
FONT_HIRA_U         equ (TILENUM_FONT + 39)
FONT_HIRA_E         equ (TILENUM_FONT + 40)
FONT_HIRA_O         equ (TILENUM_FONT + 41)
FONT_HIRA_KA        equ (TILENUM_FONT + 42)
FONT_HIRA_KI        equ (TILENUM_FONT + 43)
FONT_HIRA_KU        equ (TILENUM_FONT + 44)
FONT_HIRA_KE        equ (TILENUM_FONT + 45)
FONT_HIRA_KO        equ (TILENUM_FONT + 46)
FONT_HIRA_SA        equ (TILENUM_FONT + 47)
FONT_HIRA_SI        equ (TILENUM_FONT + 48)
FONT_HIRA_SU        equ (TILENUM_FONT + 49)
FONT_HIRA_SE        equ (TILENUM_FONT + 50)
FONT_HIRA_SO        equ (TILENUM_FONT + 51)
FONT_HIRA_TA        equ (TILENUM_FONT + 52)
FONT_HIRA_TI        equ (TILENUM_FONT + 53)
FONT_HIRA_TU        equ (TILENUM_FONT + 54)
FONT_HIRA_TE        equ (TILENUM_FONT + 55)
FONT_HIRA_TO        equ (TILENUM_FONT + 56)
FONT_HIRA_NA        equ (TILENUM_FONT + 57)
FONT_HIRA_NI        equ (TILENUM_FONT + 58)
FONT_HIRA_NU        equ (TILENUM_FONT + 59)
FONT_HIRA_NE        equ (TILENUM_FONT + 60)
FONT_HIRA_NO        equ (TILENUM_FONT + 61)
FONT_HIRA_HA        equ (TILENUM_FONT + 62)
FONT_HIRA_HI        equ (TILENUM_FONT + 63)
FONT_HIRA_HU        equ (TILENUM_FONT + 64)
FONT_HIRA_HE        equ (TILENUM_FONT + 65)
FONT_HIRA_HO        equ (TILENUM_FONT + 66)
FONT_HIRA_MA        equ (TILENUM_FONT + 67)
FONT_HIRA_MI        equ (TILENUM_FONT + 68)
FONT_HIRA_MU        equ (TILENUM_FONT + 69)
FONT_HIRA_ME        equ (TILENUM_FONT + 70)
FONT_HIRA_MO        equ (TILENUM_FONT + 71)
FONT_HIRA_YA        equ (TILENUM_FONT + 72)
FONT_HIRA_YU        equ (TILENUM_FONT + 73)
FONT_HIRA_YO        equ (TILENUM_FONT + 74)
FONT_HIRA_RA        equ (TILENUM_FONT + 75)
FONT_HIRA_RI        equ (TILENUM_FONT + 76)
FONT_HIRA_RU        equ (TILENUM_FONT + 77)
FONT_HIRA_RE        equ (TILENUM_FONT + 78)
FONT_HIRA_RO        equ (TILENUM_FONT + 79)
FONT_HIRA_WA        equ (TILENUM_FONT + 80)
FONT_HIRA_WO        equ (TILENUM_FONT + 81)
FONT_HIRA_N         equ (TILENUM_FONT + 82)
FONT_HIRA_LA        equ (TILENUM_FONT + 83)
FONT_HIRA_LI        equ (TILENUM_FONT + 84)
FONT_HIRA_LU        equ (TILENUM_FONT + 85)
FONT_HIRA_LE        equ (TILENUM_FONT + 86)
FONT_HIRA_LO        equ (TILENUM_FONT + 87)
FONT_HIRA_LTU       equ (TILENUM_FONT + 88)
FONT_HIRA_LYA       equ (TILENUM_FONT + 89)
FONT_HIRA_LYU       equ (TILENUM_FONT + 90)
FONT_HIRA_LYO       equ (TILENUM_FONT + 91)
FONT_HIRA_LWA       equ (TILENUM_FONT + 92)
FONT_KATA_A         equ (TILENUM_FONT + 93)
FONT_KATA_I         equ (TILENUM_FONT + 94)
FONT_KATA_U         equ (TILENUM_FONT + 95)
FONT_KATA_E         equ (TILENUM_FONT + 96)
FONT_KATA_O         equ (TILENUM_FONT + 97)
FONT_KATA_KA        equ (TILENUM_FONT + 98)
FONT_KATA_KI        equ (TILENUM_FONT + 99)
FONT_KATA_KU        equ (TILENUM_FONT + 100)
FONT_KATA_KE        equ (TILENUM_FONT + 101)
FONT_KATA_KO        equ (TILENUM_FONT + 102)
FONT_KATA_SA        equ (TILENUM_FONT + 103)
FONT_KATA_SI        equ (TILENUM_FONT + 104)
FONT_KATA_SU        equ (TILENUM_FONT + 105)
FONT_KATA_SE        equ (TILENUM_FONT + 106)
FONT_KATA_SO        equ (TILENUM_FONT + 107)
FONT_KATA_TA        equ (TILENUM_FONT + 108)
FONT_KATA_TI        equ (TILENUM_FONT + 109)
FONT_KATA_TU        equ (TILENUM_FONT + 110)
FONT_KATA_TE        equ (TILENUM_FONT + 111)
FONT_KATA_TO        equ (TILENUM_FONT + 112)
FONT_KATA_NA        equ (TILENUM_FONT + 113)
FONT_KATA_NI        equ (TILENUM_FONT + 114)
FONT_KATA_NU        equ (TILENUM_FONT + 115)
FONT_KATA_NE        equ (TILENUM_FONT + 116)
FONT_KATA_NO        equ (TILENUM_FONT + 117)
FONT_KATA_HA        equ (TILENUM_FONT + 118)
FONT_KATA_HI        equ (TILENUM_FONT + 119)
FONT_KATA_HU        equ (TILENUM_FONT + 120)
FONT_KATA_HE        equ (TILENUM_FONT + 121)
FONT_KATA_HO        equ (TILENUM_FONT + 122)
FONT_KATA_MA        equ (TILENUM_FONT + 123)
FONT_KATA_MI        equ (TILENUM_FONT + 124)
FONT_KATA_MU        equ (TILENUM_FONT + 125)
FONT_KATA_ME        equ (TILENUM_FONT + 126)
FONT_KATA_MO        equ (TILENUM_FONT + 127)
FONT_KATA_YA        equ (TILENUM_FONT + 128)
FONT_KATA_YU        equ (TILENUM_FONT + 129)
FONT_KATA_YO        equ (TILENUM_FONT + 130)
FONT_KATA_RA        equ (TILENUM_FONT + 131)
FONT_KATA_RI        equ (TILENUM_FONT + 132)
FONT_KATA_RU        equ (TILENUM_FONT + 133)
FONT_KATA_RE        equ (TILENUM_FONT + 134)
FONT_KATA_RO        equ (TILENUM_FONT + 135)
FONT_KATA_WA        equ (TILENUM_FONT + 136)
FONT_KATA_WO        equ (TILENUM_FONT + 137)
FONT_KATA_N         equ (TILENUM_FONT + 138)
FONT_KATA_LA        equ (TILENUM_FONT + 139)
FONT_KATA_LI        equ (TILENUM_FONT + 140)
FONT_KATA_LU        equ (TILENUM_FONT + 141)
FONT_KATA_LE        equ (TILENUM_FONT + 142)
FONT_KATA_LO        equ (TILENUM_FONT + 143)
FONT_KATA_LTU       equ (TILENUM_FONT + 144)
FONT_KATA_LYA       equ (TILENUM_FONT + 145)
FONT_KATA_LYU       equ (TILENUM_FONT + 146)
FONT_KATA_LYO       equ (TILENUM_FONT + 147)
FONT_KATA_LWA       equ (TILENUM_FONT + 148)
FONT_DAKUTEN        equ (TILENUM_FONT + 149)
FONT_HANDAKUTEN     equ (TILENUM_FONT + 150)
FONT_TYOUON         equ (TILENUM_FONT + 151)
FONT_QUESTION       equ (TILENUM_FONT + 152)
FONT_EXLAMATION     equ (TILENUM_FONT + 153)
FONT_DOT            equ (TILENUM_FONT + 154)
FONT_L_BRACKET      equ (TILENUM_FONT + 155)
FONT_R_BRACKET      equ (TILENUM_FONT + 156)
FONT_L_BRACKET2     equ (TILENUM_FONT + 157)
FONT_R_BRACKET2     equ (TILENUM_FONT + 158)
FONT_SLASH          equ (TILENUM_FONT + 159)

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
work2               ds 1
work3               ds 1
work4               ds 1
player_data         ds CH_DATA_SIZE
player_hp           ds 2
enemy_data          ds CH_DATA_SIZE
map_width           ds 1
map_address_h       ds 1
map_address_l       ds 1
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

    ld hl, ImageFont
    ld de, _VRAM + TILENUM_FONT * TILE_SIZE
    ld bc, ImageFontLen * TILE_SIZE_HALF
    call CopyFont

    ld hl, ImagePlayer
    ld de, _VRAM + TILENUM_PLAYER_01 * TILE_SIZE
    ld bc, TILELEN_PLAYER * TILE_SIZE
    call CopyMemory

    ld hl, ImageMonster01
    ld de, _VRAM + TILENUM_MONSTER_01 * TILE_SIZE
    ld bc, TILELEN_MONSTER_01 * TILE_SIZE
    call CopyMemory

    ld hl, _SCRN0
    ld bc, BG_WIDTH * BG_HEIGHT
    call ClearMemory

    ld hl, _SCRN1
    ld bc, BG_WIDTH * BG_HEIGHT
    call ClearMemory

    ld hl, _SCRN0
    ld de, Map001
    ld bc, Map001Height * $100 + Map001Width
    call CopyMap


    ; マップの幅を設定する。
    ld a, Map001Width
    ld [map_width], a

    ; ウィンドウを作成する。
    call CreateStatusWindow

    ; プレイヤーキャラの初期状態を設定する。
    ld a, 16 + SPRITE_OFFSET_X
    ld [player_data + CH_POS_X], a
    ld a, 16 + SPRITE_OFFSET_Y
    ld [player_data + CH_POS_Y], a
    ld a, TILENUM_PLAYER_01
    ld [player_data + CH_TILE], a
    ld a, OAMF_PAL1
    ld [player_data + CH_ATTR], a

    ; スライムを作成する。
    call CreateMonster01

    call UpdatePlayer
    call UpdateCharacter
    call UpdateStatusWindow
    call OAM_DMA

    ld a, LCDCF_ON | LCDCF_BG8000 | LCDCF_BG9800 | LCDCF_BGON | LCDCF_OBJ8 | LCDCF_OBJON | LCDCF_WIN9C00 | LCDCF_WINON
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
    call UpdateCharacter
    call UpdateStatusWindow

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

CopyFont:
    ld a, [hl+]
    ld [de], a
    inc de
    ld [de], a
    inc de
    dec bc
    ld a, b
    or c
    jr nz, CopyFont
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

    ; 左方向への歩行処理を行う。
    ld b, BUTTON_LEFT
    ld c, -1
    ld d, -1
    call WalkPlayer

    ; 右方向への歩行処理を行う。
    ld b, BUTTON_RIGHT
    ld c, 1
    ld d, CHARACTER_SIZE
    call WalkPlayer

    ; 床に接触しているか調べる。
    ld hl, player_data
    ld d, CHARACTER_SIZE
    call CheckVertical
    ld b, a

    ; プレイヤーキャラの状態に着地状態を保存する。
    ld a, [player_data + CH_STATUS]
    and a, ~STATUS_LANDED
    or a, b
    ld [player_data + CH_STATUS], a

    ; ジャンプ処理を行う。
    call JumpPlayer

    ; ジャンプキャンセル処理を行う。
    call CancelJump

    ; 落下処理を行う。
    call FallCharacter

    ; テスト用にHPをインクリメントする。
    ld a, [player_hp]
    inc a
    daa
    ld [player_hp], a
    ld a, [player_hp + 1]
    adc a, 0
    daa
    ld [player_hp + 1], a

    ; プレイヤーの状態を取得する。
    ld a, [player_data + CH_STATUS]

    ; ジャンプ中の場合は0番目固定とする。
    and a, STATUS_LANDED
    jr nz, .setTilePos
    xor a
    ld [player_data + CH_ANIMATION], a
    ld [player_data + CH_ANIM_WAIT], a

.setTilePos

    ; 各タイルのy座標を設定する。
    ld a, [player_data + CH_POS_Y]
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_Y], a
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_Y], a
    add TILE_HEIGHT
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_Y], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_Y], a

    ; 各タイルのx座標を設定する。
    ld a, [player_data + CH_ATTR]
    and a, OAMF_XFLIP
    jr nz, .xflip
    ld a, [player_data + CH_POS_X]
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_X], a
    add TILE_WIDTH
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_X], a
    jr .setTileNumber
.xflip
    ld a, [player_data + CH_POS_X]
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_POS_X], a
    add TILE_WIDTH
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_POS_X], a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_POS_X], a

.setTileNumber
    ; 各タイルのタイル番号を設定する。
    ld a, [player_data + CH_TILE]
    ld b, a
    ld a, [player_data + CH_ANIMATION]
    add a, b
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_NUM], a
    inc a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_NUM], a
    inc a
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_NUM], a
    inc a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_NUM], a

    ; 各タイルのattributeを設定する。
    ld a, [player_data + CH_ATTR]
    ld [sprites + SPRNUM_PLAYER * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld [sprites + (SPRNUM_PLAYER + 1) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld [sprites + (SPRNUM_PLAYER + 2) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a
    ld [sprites + (SPRNUM_PLAYER + 3) * SPRITE_SIZE + SPRITE_ATTRIBUTE], a

    ret

; バックグラウンドマップをコピーする。
; コピー元は16x16のタイルを前提とする。
; @param hl [in/out] コピー先のVRAM
; @param de [in/out] コピー元のROM
; @param b [in/out] マップの高さ
; @param c [in/out] マップの幅
CopyMap:

    ; マップの幅をメモリに保持しておく。
    ld a, c
    ld [work1], a

    ; マップのアドレスをメモリに保持しておく。
    ld a, d
    ld [map_address_h], a
    ld a, e
    ld [map_address_l], a

    ; コピー元アドレスをスタックに保持する。
    push de

.loop
    ; コピー元のマップデータを取得する。
    ld a, [de]

    ; タイル番号を取り出す。
    and a, MAP_TILE

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

    ; タイル番号を取り出す。
    and a, MAP_TILE

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
    and a, $0f

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

; プレイヤーキャラの歩く処理を行う。
; @param b [in] チェックするボタン
; @param c [in] x方向の移動量
; @param d [in] 左なら-1、右ならキャラクターの幅を設定する。
WalkPlayer:

    ; bで指定されたキーが押されているかチェックする。
    ld a, [holdedButton]
    and b
    ret z

    ; cで指定された移動量分移動する。
    ld a, [player_data + CH_POS_X]
    add a, c
    ld [player_data + CH_POS_X], a

    ; ブロックに衝突したか調べる。
    push bc
    call CheckSideBlock
    pop bc
    ld d, a

    ; 移動量がプラスかマイナスかチェックする。
    ld a, c
    cp a, $80
    jr nc, .left

    ; 右向きにする。
    ld a, [player_data + CH_ATTR]
    and a, ~OAMF_XFLIP
    ld [player_data + CH_ATTR], a

    ; ブロック衝突時の補正値を設定しておく。
    ld e, 0

    jr .animation

.left

    ; 左向きにする。
    ld a, [player_data + CH_ATTR]
    or a, OAMF_XFLIP
    ld [player_data + CH_ATTR], a

    ; ブロック衝突時の補正値を設定しておく。
    ld e, $0f

.animation

    ; ブロックに接触している場合はアニメーションせずに位置を補正する。
    ld a, d
    and a
    jr nz, .correctPosition

    ; アニメーションを進める。
    ld a, [player_data + CH_ANIM_WAIT]
    add a, PLAYER_ANIM_SPEED
    ld [player_data + CH_ANIM_WAIT], a
    ret nc

    ; アニメーション待機フレームが終わっている場合はスプライトを変える。
    ld a, [player_data + CH_ANIMATION]
    xor a, TILE_NUM_16x16
    ld [player_data + CH_ANIMATION], a
    ret

.correctPosition

    ; x座標をブロックの位置に補正する。
    ld a, [player_data + CH_POS_X]
    sub a, SPRITE_OFFSET_X
    add a, e
    and a, $f0
    add a, SPRITE_OFFSET_X
    ld [player_data + CH_POS_X], a

    ret

; プレイヤーキャラのジャンプする処理を行う。
JumpPlayer:

    ; 着地していない場合は処理を終了する。
    ld a, [player_data + CH_STATUS]
    and a, STATUS_LANDED
    ret z

    ; Aボタンが押されているかチェックする。
    ld a, [pressedButton]
    and BUTTON_A
    ret z

    ; ジャンプスピードを設定する。
    ld a, JUMP_SPEED
    ld [player_data + CH_SPEED_Y], a

    ; ジャンプ時間を設定する。
    ld a, JUMP_TIME
    ld [player_data + CH_JUMP_TIME], a
    
    ret

; ジャンプボタンがジャンプ途中で離された場合は
; ジャンプ時間を0にし、小ジャンプとする。
CancelJump:

    ; ジャンプ時間が設定されていない場合は処理を終了する。
    ld a, [player_data + CH_JUMP_TIME]
    and a
    ret z

    ; Aボタンが離されているかチェックする。
    ld a, [holdedButton]
    and BUTTON_A
    ret nz

    ; ジャンプ時間を0にする。
    xor a
    ld [player_data + CH_JUMP_TIME], a

    ret

; キャラクターの落下処理を行う。
; @param hl [in] キャラクターデータ
FallCharacter:

    ; スタックにキャラクターデータのアドレスを保持しておく。
    push hl

    ; ジャンプ時間を取得する。
    ld bc, CH_JUMP_TIME
    add hl, bc
    ld a, [hl]

    ; ジャンプ時間が設定されていなければ落下処理を行う。
    and a
    jr z, .fall

    ; ジャンプ時間を減らす。
    dec a
    ld [hl], a

    ld d, JUMP_ACCEL
    ld e, 0
    jr .setYAccel

.fall

    ; 状態のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_STATUS
    add hl, bc

    ; 地面に接触している場合は処理を終了する。
    ld a, [hl]
    and a, STATUS_LANDED
    jr nz, .finish

    ; 地面に接触していない場合は落下加速度を設定する。
    ld d, FALL_ACCEL
    ld e, MAX_FALL_SPEED

.setYAccel

    ; 加速度のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_ACCEL_Y
    add hl, bc

    ; 加速度を加算する。
    ld a, [hl]
    add a, d
    ld [hl], a

    ; 加速度が256に満たない場合は速度は増加させない。
    jr nc, .getYSpeed

    ; 速度を取得する。
    pop hl
    push hl
    ld bc, CH_SPEED_Y
    add hl, bc
    ld a, [hl]

    ; 速度が上限に達している場合は速度を変更しない。
    cp a, e
    jr z, .setYPosition

    ; 速度を加算する。
    inc a
    ld [hl], a
    jr .setYPosition

.getYSpeed

    ; 速度のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_SPEED_Y
    add hl, bc

    ; 速度を取得する。
    ld a, [hl]

.setYPosition

    ; 速度を記憶する。
    ld d, a

    ; 位置のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_POS_Y
    add hl, bc

    ; 位置を加算する。
    add a, [hl]
    ld [hl], a

    ; 速度が0の場合は処理を終了する。
    ld a, d
    and a
    jr z, .finish

    ; 速度が正か負か調べる。
    cp a, $80
    jr c, .checkFloor

    ; 速度が負数（上昇）の場合、天井と接触したかチェックする。
    ld d, -1
    ld e, $0f
    jr .checkHitBlock

.checkFloor

    ; 速度が正数（落下）の場合、地面と接触したかチェックする。
    ld d, CHARACTER_SIZE
    ld e, 0

.checkHitBlock

    pop hl
    push hl
    call CheckVertical

    ; 接触していなければ、処理を終了する。
    and a, STATUS_LANDED
    jr z, .finish

    ; 位置のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_POS_Y
    add hl, bc

    ; 位置をブロックの位置に補正する。
    ld a, [hl]
    add a, e
    and a, $f0
    ld [hl], a

    ; 速度のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_SPEED_Y
    add hl, bc

    ; 速度を0にする。
    xor a
    ld [hl], a

    ; 加速度のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_ACCEL_Y
    add hl, bc

    ; 加速度を0にする。
    ld [hl], a

    ; ジャンプ時間のアドレスを計算する。
    pop hl
    push hl
    ld bc, CH_JUMP_TIME
    add hl, bc

    ; ジャンプ時間を0にする。
    ld [hl], a

.finish

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ret

; キャラクターが地面に接触しているか調べる。
; @param a [out] 接触している場合1、そうでない場合は0
; @param d [in] 上なら-1、下ならキャラクターの高さを設定する。
; @param hl [in] キャラクターデータ
CheckVertical:

    ; スタックにキャラクターデータのアドレスを保持しておく。
    push hl

    ; y座標を取得する。
    pop hl
    push hl
    ld bc, CH_POS_Y
    add hl, bc
    ld a, [hl]

    ; スプライト座標のオフセット分を減算する。
    sub a, SPRITE_OFFSET_Y

    ; 上を調べる場合は-1、下を調べる場合はキャラクター高さを加算して、
    ; チェックするx座標を計算する。
    add a, d
    
    ; 16で割って、座標からマップインデックスに換算する。
    srl a
    srl a
    srl a
    srl a

    ; y座標マップインデックスをメモリに保持しておく。
    ld [work1], a

    ; x座標を取得する。
    pop hl
    push hl
    ld a, [hl]

    ; スプライト座標のオフセット分を減算する。
    sub a, SPRITE_OFFSET_X

    ; x座標が16の倍数でない場合は一つ右側のマップタイルも調べる。
    ld b, a
    and a, $0f
    ld [work3], a
    ld a, b

    ; 16で割って、座標からマップインデックスに換算する。
    srl a
    srl a
    srl a
    srl a

    ; x座標マップインデックスをメモリに保持しておく。
    ld [work2], a

    ; 足元のマップタイル情報を取得する。
    call GetMapInfo

    ; 足元がブロックかどうか調べる。
    cp a, MAP_BLOCK
    jr z, .setLanded

    ; 2つのタイルにまたいでいる場合は右側のタイルもチェックする。
    ld a, [work3]
    and a
    jr z, .finish

    inc hl
    ld a, [hl]
    and a, MAP_ATTRIBUTE

    ; 足元がブロックかどうか調べる。
    cp a, MAP_BLOCK
    jr nz, .finish

.setLanded

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ; 足元にブロックがある場合はaを1として終了する。
    ld a, STATUS_LANDED

    ret

.finish

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ; 足元にブロックがない場合はaを0として終了する。
    xor a

    ret

; キャラクターが横のブロックに接触しているか調べる。
; @param a [out] 接触している場合1、そうでない場合は0
; @param d [in] 左なら-1、右ならキャラクターの幅を設定する。
; @param hl [in] キャラクターデータ
CheckSideBlock:

    ; スタックにキャラクターデータのアドレスを保持しておく。
    push hl

    ; y座標を取得する。
    pop hl
    push hl
    ld bc, CH_POS_Y
    add hl, bc
    ld a, [hl]

    ; スプライト座標のオフセット分を減算する。
    sub a, SPRITE_OFFSET_Y

    ; y座標が16の倍数でない場合は一つ下のマップタイルも調べる。
    ld b, a
    and a, $0f
    ld [work3], a
    ld a, b

    ; 16で割って、座標からマップインデックスに換算する。
    srl a
    srl a
    srl a
    srl a

    ; y座標マップインデックスをメモリに保持しておく。
    ld [work1], a

    ; x座標を取得する。
    pop hl
    push hl
    ld a, [hl]

    ; スプライト座標のオフセット分を減算する。
    sub a, SPRITE_OFFSET_X

    ; 左を調べる場合は-1、右を調べる場合はキャラクター幅を加算して、
    ; チェックするx座標を計算する。
    add a, d

    ; 16で割って、座標からマップインデックスに換算する。
    srl a
    srl a
    srl a
    srl a

    ; x座標マップインデックスをメモリに保持しておく。
    ld [work2], a

    ; 横のマップタイル情報を取得する。
    call GetMapInfo

    ; 横がブロックかどうか調べる。
    cp a, MAP_BLOCK
    jr z, .hitFloor

    ; 2つのタイルにまたいでいる場合は下のタイルもチェックする。
    ld a, [work3]
    and a
    jr z, .finish

    ld b, 0
    ld a, [map_width]
    ld c, a
    add hl, bc
    ld a, [hl]
    and a, MAP_ATTRIBUTE

    ; 横がブロックかどうか調べる。
    cp a, MAP_BLOCK
    jr nz, .finish

.hitFloor

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ; 横にブロックがある場合はaを1として終了する。
    ld a, 1

    ret

.finish

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ; 横にブロックがない場合はaを0として終了する。
    xor a

    ret

; 指定した座標のマップ情報を取得する。
; @param a [out] マップ情報
; @param hl [out] マップタイルのアドレス
; @param work1 [in] y座標マップインデックス
; @param work2 [in] x座標マップインデックス
GetMapInfo:

    ; マップインデックスを計算する。
    ; y * width + x
    ld a, [work1]
    ld d, a
    ld a, [map_width]
    ld e, a
    xor a
    ld b, 0
    ld c, 0
.loop
    add a, e
    jr nc, .cont
    inc b
.cont
    dec d
    jr nz, .loop

    ld d, a
    ld a, [work2]
    add a, d
    ld c, a

    ; マップのアドレスを取得する。
    ld a, [map_address_h]
    ld h, a
    ld a, [map_address_l]
    ld l, a

    ; マップタイル情報を取得する。
    add hl, bc
    ld a, [hl]
    and a, MAP_ATTRIBUTE
    
    ret

; モンスター01(スライム)を作成する。
CreateMonster01:

    ld hl, enemy_data
    ld d, 144
    ld e, 96

    ; スタックにキャラクターデータのアドレスを保持しておく。
    push hl

    ; X座標を設定する。
    ld a, d
    add a, SPRITE_OFFSET_X
    ld [hl], a

    ; y座標を設定する。
    pop hl
    push hl
    ld bc, CH_POS_Y
    add hl, bc
    ld a, e
    add a, SPRITE_OFFSET_Y
    ld [hl], a

    ; タイル番号を設定する。
    pop hl
    push hl
    ld bc, CH_TILE
    add hl, bc
    ld a, TILENUM_MONSTER_01
    ld [hl], a

    ; 属性を設定する。
    pop hl
    push hl
    ld bc, CH_ATTR
    add hl, bc
    ld a, OAMF_XFLIP
    ld [hl], a

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ret 

; キャラクターの状態を更新する。
UpdateCharacter:

    ld hl, enemy_data

    ; スタックにキャラクターデータのアドレスを保持しておく。
    push hl

    ; キャラクターの移動処理を行う。
    call MoveMonster01

    ; y座標を取得する。
    pop hl
    push hl
    ld bc, CH_POS_Y
    add hl, bc
    ld a, [hl]

    ; 各タイルのy座標を設定する。
    ld hl, sprites + SPRNUM_ENEMY * SPRITE_SIZE + SPRITE_POS_Y
    ld bc, SPRNUM_ENEMY * SPRITE_SIZE
    ; 左上のタイルを設定する。
    ld [hl], a
    ; 左下のタイルを設定する。
    add TILE_HEIGHT
    add hl, bc
    ld [hl], a
    ; 右上のタイルを設定する。
    sub TILE_HEIGHT
    add hl, bc
    ld [hl], a
    ; 右下のタイルを設定する。
    add TILE_HEIGHT
    add hl, bc
    ld [hl], a

    ; x座標を取得する。
    pop hl
    push hl
    ld a, [hl]

    ; 各タイルのy座標を設定する。
    ld hl, sprites + SPRNUM_ENEMY * SPRITE_SIZE + SPRITE_POS_X
    ld bc, SPRNUM_ENEMY * SPRITE_SIZE
    ; 左上のタイルを設定する。
    ld [hl], a
    ; 左下のタイルを設定する。
    add hl, bc
    ld [hl], a
    ; 右上のタイルを設定する。
    add TILE_WIDTH
    add hl, bc
    ld [hl], a
    ; 右下のタイルを設定する。
    add hl, bc
    ld [hl], a

    ; 属性を取得する。
    pop hl
    push hl
    ld bc, CH_ATTR
    add hl, bc
    ld a, [hl]
    ld [work1], a

    ; 左右反転しているか調べる。
    and a, OAMF_XFLIP
    jr nz, .xflip

    ld d, 0
    jr .serTileNumber

.xflip

    ld d, 2

.serTileNumber

    ; タイル番号を取得する。
    pop hl
    push hl
    ld bc, CH_TILE
    add hl, bc
    ld a, [hl]
    ld e, a
    
    ; アニメーションを取得する。
    pop hl
    push hl
    ld bc, CH_ANIMATION
    add hl, bc
    ld a, [hl]
    add a, e
    ld e, a

    ; 各タイルのタイル番号を設定する。
    ld hl, sprites + SPRNUM_ENEMY * SPRITE_SIZE + SPRITE_NUM
    ld bc, SPRNUM_ENEMY * SPRITE_SIZE

    ; 左上のタイルを設定する。
    ld a, d
    add a, e
    ld [hl], a

    ; 左下のタイルを設定する。
    inc d
    ld a, d
    add a, e
    add hl, bc
    ld [hl], a

    ; 右上のタイルを設定する。
    inc d
    ld a, d
    and a, $03
    ld d, a
    add a, e
    add hl, bc
    ld [hl], a

    ; 右下のタイルを設定する。
    inc d
    ld a, d
    add a, e
    add hl, bc
    ld [hl], a

    ; 各タイルのattributeを設定する。
    ld a, [work1]
    ld hl, sprites + SPRNUM_ENEMY * SPRITE_SIZE + SPRITE_ATTRIBUTE
    ld bc, SPRNUM_ENEMY * SPRITE_SIZE

    ; 左上のタイルを設定する。
    ld [hl], a
    ; 左下のタイルを設定する。
    add hl, bc
    ld [hl], a
    ; 右上のタイルを設定する。
    add hl, bc
    ld [hl], a
    ; 右下のタイルを設定する。
    add hl, bc
    ld [hl], a

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl
    
    ret

; モンスター01(スライム)を移動する。
MoveMonster01:

    ; スタックにキャラクターデータのアドレスを保持しておく。
    push hl

    ; x座標小数部を取得する。
    pop hl
    push hl
    ld bc, CH_POS_X_DEC
    add hl, bc
    ld a, [hl]

    ; 左へ移動する。
    sub a, $20
    ld [hl], a

    jr nc, .finish

    ; x座標を取得する。
    pop hl
    push hl
    ld a, [hl]

    ; 左へ移動する。
    dec a
    
    ; x座標を設定する。
    ld [hl], a

    ; アニメーションを進める。
    pop hl
    push hl
    ld bc, CH_ANIMATION
    add hl, bc
    ld a, [hl]
    xor a, TILE_NUM_16x16
    ld [hl], a
       
.finish

    ; キャラクターデータのアドレスをスタックから復元する。
    pop hl

    ret

; ステータスウィンドウを作成する。
CreateStatusWindow:

    ; ウィンドウの位置を設定する。
    ld a, STATUS_WIN_POS_X + WINDOW_OFFSET_X
    ld [rWX], a
    ld a, STATUS_WIN_POS_Y
    ld [rWY], a

    ; HP欄を作成する。
    ld a, FONT_ENG_H
    ld [STATUS_WIN_HP_LABEL], a
    ld a, FONT_ENG_P
    ld [STATUS_WIN_HP_LABEL + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_HP_NOW], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_HP_NOW + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_HP_NOW + 2], a
    ld a, FONT_SLASH
    ld [STATUS_WIN_HP_SLASH], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_HP_MAX], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_HP_MAX + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_HP_MAX + 2], a

    ; MP欄を作成する。
    ld a, FONT_ENG_M
    ld [STATUS_WIN_MP_LABEL], a
    ld a, FONT_ENG_P
    ld [STATUS_WIN_MP_LABEL + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_MP_NOW], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_MP_NOW + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_MP_NOW + 2], a
    ld a, FONT_SLASH
    ld [STATUS_WIN_MP_SLASH], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_MP_MAX], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_MP_MAX + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_MP_MAX + 2], a

    ; GOLD欄を作成する。
    ld a, FONT_ENG_G
    ld [STATUS_WIN_GOLD_LABEL], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_GOLD_VALUE], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_GOLD_VALUE + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_GOLD_VALUE + 2], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_GOLD_VALUE + 3], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_GOLD_VALUE + 4], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_GOLD_VALUE + 5], a

    ; Exp欄を作成する。
    ld a, FONT_ENG_E
    ld [STATUS_WIN_EXP_LABEL], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_EXP_VALUE], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_EXP_VALUE + 1], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_EXP_VALUE + 2], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_EXP_VALUE + 3], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_EXP_VALUE + 4], a
    ld a, FONT_NUM_0
    ld [STATUS_WIN_EXP_VALUE + 5], a

    ret

; ステータスウィンドウの現在値の表示を更新する。
UpdateStatusWindow:

    ; HP現在値の3桁目を表示する。
    ld a, [player_hp + 1]
    and a, $0f
    ld b, a
    jr z, .setBlankToHP3
    add a, FONT_NUM_0
    jr .setTileToHP3
.setBlankToHP3
    xor a
.setTileToHP3
    ld [STATUS_WIN_HP_NOW], a

    ; HP現在値の2桁目を表示する。
    ld a, [player_hp]
    swap a
    and a, $0f
    ld c, a
    or a, b
    jr z, .setBlankToHP2
    ld a, c
    add a, FONT_NUM_0
    jr .setTileToHP2
.setBlankToHP2
    xor a
.setTileToHP2
    ld [STATUS_WIN_HP_NOW + 1], a

    ; HP現在値の1桁目を表示する。
    ld a, [player_hp]
    and a, $0f
    add a, FONT_NUM_0
    ld [STATUS_WIN_HP_NOW + 2], a

    ret 