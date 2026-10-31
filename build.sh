echo "\033[1mStarting XeLaTeX for example...\033[0m"
xelatex --file-line-error --synctex=1 "example.tex"

echo
echo "\033[1mRemoving AUX files...\033[0m"
rm example.aux
rm example.log
rm example.synctex.gz
open ./example.pdf


echo "\033[1mStarting XeLaTeX for documentation...\033[0m"
xelatex --file-line-error --synctex=1 "documentation.tex"
xelatex --file-line-error --synctex=1 "documentation.tex"

echo
echo "\033[1mRemoving AUX files...\033[0m"
rm documentation.aux
rm documentation.log
rm documentation.synctex.gz
open ./documentation.pdf


echo
echo "\033[1mDone.\033[0m"
