#!/bin/sh

mkdir "./tmp"
palette="./tmp/palette.png"
tmp_gif="./tmp/output_tmp.gif"
filters="fps=30"
ffmpeg -i "$1" -vf "$filters,palettegen" -y $palette
ffmpeg -i "$1" -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y "$tmp_gif"
echo "Doing transparency"
convert -loop 1 "$tmp_gif" -transparent "#$2" "$3"
rm -rf "./tmp"