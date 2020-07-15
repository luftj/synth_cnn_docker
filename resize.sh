inputpath=$1
cd $inputpath
convert *.png -resize x31 -set filename:base "%[basename]" "%[filename:base]_32.png"
rm imagelist.txt
touch imagelist.txt
ls *_32.png > imagelist.txt
sed 's/^/\/app\/images\//' imagelist.txt