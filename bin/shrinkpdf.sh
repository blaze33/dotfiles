#!/bin/bash
DPI=150

gs	-q -dNOPAUSE -dBATCH -dSAFER \
	-sDEVICE=pdfwrite \
	-dCompatibilityLevel=1.3 \
	-dPDFSETTINGS=/screen \
	-dEmbedAllFonts=true \
	-dSubsetFonts=true \
	-dColorImageDownsampleType=/Bicubic \
	-dColorImageResolution=$DPI \
	-dGrayImageDownsampleType=/Bicubic \
	-dGrayImageResolution=$DPI \
	-dMonoImageDownsampleType=/Bicubic \
	-dMonoImageResolution=$DPI \
	-sOutputFile="compressed-$1" \
	 "$1"