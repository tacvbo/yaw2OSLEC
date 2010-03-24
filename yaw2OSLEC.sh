#!/bin/bash
#####################################################################
# Copyright 2010 Neocenter, S.A. de CV.
# $Id: oslec.sh,v 1.1 2010/03/24 00:38:44 tacvbo Exp $
#
#   Download OSLEC source from Kernel GitWEB interface
#
# Author:
#       Octavio Ruiz (Ta^3) <octavio@neocenter.com>
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY. YOU USE AT YOUR OWN RISK. THE AUTHOR
# WILL NOT BE LIABLE FOR DATA LOSS, DAMAGES, LOSS OF PROFITS OR ANY
# OTHER  KIND OF LOSS WHILE USING OR MISUSING THIS SOFTWARE.
#####################################################################

SPIN='|/-\'
URL=http://git.kernel.org/
TREE=linux/kernel/git/torvalds/linux-2.6.git
DIR=drivers/staging/echo
FILES=(Kconfig Makefile TODO echo.c echo.h fir.h oslec.h )
WGET="$(which wget) -qcnH"

mkdir -p ${DIR#*/}

echo -n "Downloading...  "
for N_file in ${!FILES[@]}
  do
    ${WGET} -O ${DIR#*/}/${FILES[$N_file]} \
      ${URL}?p=${TREE};a=blob_plain;f=${DIR}/${FILES[$N_file]};hb=master
    echo -ne "\b${SPIN:$N_file%${#SPIN}:1}"
done
echo -e \
  "ifdef DAHDI_USE_MMX\nEXTRA_CFLAGS += -DUSE_MMX\nendif\nobj-m += echo.o" > ${DIR#*/}/Kbuild 
echo -e "\bDone!"
