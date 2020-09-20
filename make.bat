@echo off

SET SRC_NAME=main.asm

SET IMG_NAME=^
image_font.z80 ^
image_player.z80 ^
image_monster01.z80 ^
image_back.z80 ^
map001.z80

SET APP_NAME=gbtest

cd src

FOR %%f in (%SRC_NAME%) DO (
    rgbasm -o %%~nf.o %%f
)

FOR %%f in (%IMG_NAME%) DO (
    rgbasm -o %%~nf.o %%f
)

rgblink -o ..\rom\%APP_NAME%.gb -n ..\rom\%APP_NAME%.sym %SRC_NAME:.asm=.o% %IMG_NAME:.z80=.o%
rgbfix -v -p 0 ..\rom\%APP_NAME%.gb

cd ..
