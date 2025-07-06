echo "\033[1mStarting pdfLaTeX...\033[0m"
pdflatex --file-line-error --synctex=1 "example.tex"

echo
echo "\033[1mRemoving AUX files...\033[0m"
rm example.aux
rm example.log
rm example.synctex.gz
# open ./example.pdf


echo
echo "\033[1mDone.\033[0m"
