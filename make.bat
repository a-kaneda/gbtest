@echo off

SET SRC_NAME=main.asm
SET APP_NAME=gbtest

cd src

FOR %%f in (%SRC_NAME%) DO (
    rgbasm -o %%~nf.o %%f
)

rgblink -o ..\rom\%APP_NAME%.gb %SRC_NAME:.asm=.o%
rgbfix -v -p 0 ..\rom\%APP_NAME%.gb
