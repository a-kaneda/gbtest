@echo off

SET SRC_NAME=main.asm 
SET IMG_NAME=image_player.z80
SET APP_NAME=gbtest

cd src

FOR %%f in (%SRC_NAME%) DO (
    rgbasm -o %%~nf.o %%f
)

FOR %%f in (%IMG_NAME%) DO (
    rgbasm -o %%~nf.o %%f
)

cd ..

rgblink -o rom\%APP_NAME%.gb src\%SRC_NAME:.asm=.o% src\%IMG_NAME:.z80=.o%
rgbfix -v -p 0 rom\%APP_NAME%.gb
