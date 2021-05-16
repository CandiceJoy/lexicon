#!/bin/bash

# Lexicon Main file automata script

# Header
echo "
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
----------------------------------       Lexicon Main File Automata      -----------------------------------------
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
"
echo ""

echo "Environment Settings:
Branch: ${GIT_BRANCH}
Build Number: ${BUILD_NUMBER}
Workspace Location: ${WORKSPACE}

Build URL: ${BUILD_URL}
"

# Processing
whoami

# Setting Varibles
FILE_NAME="Lexicon"
COMPILE_PATH='./compiler'
GAME_PATH='./pk3'

# Compile BCS Code
chmod +x $COMPILE_PATH/bcc
$COMPILE_PATH/bcc -acc-err-file -x bcs $GAME_PATH/Acs/lexicon.c $GAME_PATH/Acs/Lexicon.o

# Pack game files
cd $GAME_PATH
7za a -r -ssw -mx9 -tzip  ../${FILE_NAME}.pk3 ./*

# Create proper Jenkins filenames
cd ..
mv ./${FILE_NAME}.pk3 ./${FILE_NAME}_beta_build_${BUILD_NUMBER}.pk3

# Copy file to the lexicon zandronum folder for server use

cp ./${FILE_NAME}_beta_build_${BUILD_NUMBER}.pk3 /home/lexicon/.config/zandronum

# Export varible to use in other scripts
echo LEX_MAINFILE="${FILE_NAME}_beta_build_${BUILD_NUMBER}.pk3" >> lexmainfile