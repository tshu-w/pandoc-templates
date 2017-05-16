all:
	pandoc -t html5 -f markdown -s -S --toc --toc-depth 3 --template github.html5 --css html/css/github.css README.md -o index.html
