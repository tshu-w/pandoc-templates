% markdown, pandoc and make
% Christian Groll

# [Markdown](http://daringfireball.net/projects/markdown/)

## Headers

````

# New section

## New slides
````


## Lists

````

* Candy.
* Gum.
* Booze.
  
- Candy.
- Gum.
- Booze.
````

- Candy.
- Gum.
- Booze.
  
## 

````

1. Red
2. Green
3. Blue
````

1. Red
2. Green
3. Blue
   
   
## Links

````

This link points to [Google](http://www.google.de).
````

This link points to [Google](http://www.google.de).

## Emphasis

````

- normal text
- *single asterisks*
- **double asterisks**
````

- normal text
- *single asterisks*
- **double asterisks**
  
  
## Code blocks

- indicated by **backticks** or **indentation**
  
. . .


			````
	function addTwo(x)
	return x+2
	end
	````

````
		function addTwo(x)
return x+2
end
````



# [pandoc](http://johnmacfarlane.net/pandoc/)

##

[pandoc.org](http://www.pandoc.org):

> "If you need to convert files from one markup format into another,
> pandoc is your swiss-army knife."




## 

What for?

- enable **markdown usage**
  
. . .

- **multiple output formats** for single content file
  
## Installation

On windows:

- [Video: Pandoc installation, windows](https://youtu.be/N9zVyggYeyU)
  
. . .

On Linux:

- download debian package provided on homepage
  
  
# Example: [Reveal.js](https://github.com/hakimel/reveal.js/) slides

## Download reveal.js

In project directory:

````
git clone https://github.com/hakimel/reveal.js.git
````

##

Starting small:

- input and output **formats**
- input and output **files**
  
````sh

pandoc -t revealjs -f markdown \
-o output/content.slides.html src/content.md
````
##

Add **`-s`** option for **standalone** html file:

````sh

pandoc -s -t revealjs -f markdown \
-o output/content.slides.html src/content.md
````

##

- inspect html source in browser: `Inspect element`
  
. . .

- adapt **reveal.js path** variable
  
````sh

pandoc -s -V revealjs-url=../reveal.js -t revealjs \
-f markdown -o output/content.slides.html src/content.md
````

##

- at some point file **paths** were **out of sync** between latest
  reveal.js version and pandoc version
  
. . .

- pandoc requires `reveal.min.js` and `reveal.min.css`
  
. . .

- first solution: create symbolic links
  
````sh

cd reveal.js/js
ln -s reveal.js reveal.min.js 
cd ../css
ln -s reveal.css reveal.min.css 
````

# Excursion: pandoc details

## 

- how is output file created?
  
. . .

- how are command line **arguments** included?
  
. . .

[pandoc-templates](https://github.com/jgm/pandoc-templates)

[default.revealjs](https://github.com/jgm/pandoc-templates/blob/master/default.revealjs)

##

Better solution for setting paths:

- use customized pandoc [template
  files](https://github.com/cgroll/pandoc_custom)
  
	````sh
	
	git clone https://github.com/cgroll/pandoc_custom.git
	````
  
. . .

- or as **git subtree**:
  
	````sh
	
	git subtree add --prefix pandoc_custom \
	https://github.com/cgroll/pandoc_custom.git master --squash
	````
  
##

- set reveal.js **path** in **template** according to your needs
  
. . .

- **point to** customized pandoc settings during call
  
````
	pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
-o output/content.slides.html src/content.md
````

## [MathJax](http://www.mathjax.org/)

- rendering mathematical formulas:
  
````latex

$$
\gamma(n)=\sum_{i=1}^{n}x^{2}
$$
````

. . .

- clone from github: 
  
````
git clone https://github.com/mathjax/MathJax.git
````

. . .

$\Rightarrow$ configure `MathJax` to correctly render formulas


## 

- include **MathJax** code in reveal.js **template**:
  
````
		<!-- include local MathJax -->
<script type="text/x-mathjax-config">
MathJax.Hub.Config({
"HTML-CSS": {
scale: 80,
},
extensions: ["tex2jax.js"],
TeX: { equationNumbers: { autoNumber: "AMS" } },
jax: ["input/TeX","output/HTML-CSS"],
tex2jax: {inlineMath: [["$$","$$"],["\\(","\\)"]]}});
</script>
<script type="text/javascript" src="../MathJax/MathJax.js"></script>

````

. . .

$\Rightarrow$ set MathJax path according to your needs!


## MathJax rendered

- equation without number
  
````latex
$$\alpha^{2} = \beta^{2}$$
````

$$\alpha^{2} = \beta^{2}$$

##

- using latex equation environment currently requires **different
  syntax** for `html` and `pdf` output
  
. . .

- labeled and numbered equation, **html**:
  
	````latex
	
	$$\begin{equation}
	\alpha = \beta
	\label{eq:sample}
	\end{equation}$$
	````
  
. . .


- same formula for **pdf** output:
  
	````latex
	
	\begin{equation}
	\alpha = \beta
	\label{eq:sample}
	\end{equation}
	````
  
## pandoc **core**

- both options are parsed differently
  
. . .

- to get **parsed contents**, export to **native** format
  
````sh

pandoc -t native src/content.md -o output/content_native.txt
````

##

- the equations will appear as
  
````

,Para [Math DisplayMath "\\begin{equation}\n\\alpha = \\beta\n\\label{eq:sample}\n\\end{equation}"]
,RawBlock (Format "latex") "\\begin{equation}\n\\alpha = \\beta\n\\label{eq:sample}\n\\end{equation}"
````

. . .


- using **--filter** option allows **pre-processing** of the parsed
  document 
  
. . .

$\Rightarrow$ **convert** RawBlock to Math DisplayMath for **html**
output

## 

- **amsmath.hs** filter allows raw latex syntax for html
  
````
pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
--filter pandoc_custom/filters/amsmath.hs \
-o output/content.slides.html src/content.md
````

. . .

$\Rightarrow$ writing equations without $$

##

- labeled and numbered equation:
  
````latex

\begin{equation}
\alpha = \beta
\label{eq:sample}
\end{equation}
````

\begin{equation}
\alpha = \beta
\label{eq:sample}
\end{equation}

##

- labeled aligned equations, single number:
  
````latex

\begin{equation}
\begin{split} 
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\end{split}
\label{eq:splitSample}
\end{equation}

````

\begin{equation}
\begin{split} 
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\end{split}
\label{eq:splitSample}
\end{equation}

## 

- aligned equations, one number per line, single label
  
````latex

\begin{align}
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\label{eq:alignedSample}
\end{align}
````


\begin{align}
\gamma(n)&=\sum_{i=1}^{n}x^{2}\\
&=\sum_{i=1}^{n}x\cdot x
\label{eq:alignedSample}
\end{align}



##

- **referring** to equations in text
  
````

Referring to equations $\eqref{eq:sample}$, $\eqref{eq:splitSample}$
and $\eqref{eq:alignedSample}$.
````

Referring to equations $\eqref{eq:sample}$, $\eqref{eq:splitSample}$
and $\eqref{eq:alignedSample}$.

## debugging

- especially for latex, **errors** can be hard to find
  
. . .

- it might help to look at the **raw** produced **`tex` file**
  
````sh

pandoc -t latex -f markdown -s -o output/content.tex
````

## TODO

Theorem environments: [AphoFilters](https://github.com/aphorisme/AphoFilters/blob/master/src/Text/Pandoc/AphoFilters/MathThm.hs)

# Citations: CSL
##

-
 [pandoc-citeproc](http://hackage.haskell.org/package/pandoc-citeproc):
 
> "a library for rendering bibliographic reference citations into a
> variety of styles using a macro language called Citation Style
> Language (CSL)"

##

- Linux **installation**, if not already included by pandoc:
  
````sh

sudo apt-get install pandoc-citeproc
````

##

- keep list of references in **bibtex** format
  
````
@article{citeulike:1232469,
author = {Rubinstein, Mark},
citeulike-article-id = {1232469},
citeulike-linkout-0 = {http://www.jstor.org/stable/2697771},
journal = {The Journal of Finance},
number = {3},
pages = {1041--1045},
posted-at = {2007-04-17 17:49:48},
priority = {0},
title = {{Markowitz's \"Portfolio Selection\";: A Fifty-Year Retrospective}},
url = {http://www.jstor.org/stable/2697771},
volume = {57},
year = {2002}
}
````

##

- meanwhile bibtex entries for most references are readily available
  
. . .

- simply google for reference + bibtex
  
. . .

- **export bibtex** from
  [page](http://www.citeulike.org/user/felixroudier/author/Rubinstein) 
  
  
## [Citation Style Language](http://citationstyles.org/)

- define **style** of references and bibliography in **.csl** file
  
. . .

- find appropriate style: [search citation styles](http://editor.citationstyles.org/about/)
  
## 

- **pre-process** citations through **filter**
  
````

pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o output/content.slides.html src/content.md
````

## 

- cite reference:
  
  ````
  ... according to [@citeulike:1232469].
  ````
  
. . .

**Output**: ... according to [@citeulike:1232469].

. . .

- references will appear automatically in bibliography at the end
  
## Internal links

- link to section
  
````

Still remember [the pandoc introduction](#pandoc)?
````

. . .

**Output**: Still remember [the pandoc introduction](#pandoc)?

## Resources

- [John MacFarlane, slides](http://johnmacfarlane.net/BayHac2014/#/)
- [John MacFarlane, video](https://youtu.be/6TBpB-BEiIg)
  
  
- [Video: markdown to html slides using pandoc](https://youtu.be/idD5pNAXL3s)
  
  
## Pandoc alternatives

You could also circumvent raw LaTeX with:

- [LyX](www.lyx.org)
- [emacs org-mode](http://orgmode.org/)
  
# [Make](http://www.gnu.org/software/make/)

## Automation

- using command line allows for easy **automation** of **repetitive
  tasks**
- GUIs and mouse clicks are a lot less easy to automate
  
##

Starting small

- **bash script**: create file `export.sh` with content
  
	````sh
	
	pandoc --template=pandoc_custom/templates/revealjs.template \
	-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
	--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \   
	--bibliography=refs.bib \
	-o output/content.slides.html src/content.md
	````
  
. . .

- call script with
  
	````sh
	sh export.sh   
	````
  
##

Wishful improvements:

- only execute command, **if** source file was **modified**
  
. . .

- subsume multiple commands with **pattern rules**
  
. . .

$\Rightarrow$ use a `Makefile`

## 

- specify **target files** together with **dependencies**
  
. . .

**conditional execution**: command is executed, if

. . .

- target file does not exist
  
. . .

- timestamp of last modification of dependency is more recent than
  last modification of target file
  
##

- create file called **Makefile**
  
. . .

- syntax:
  
	````make
	target: dependency1 dependency2
	target rule
	````
  
. . .

- important: line with target rule MUST start with **TAB**
  
## Example

pandoc slide creation:

. . .

- **target**: *output/content.slides.html*
  
. . .

- **dependencies**: *src/content.md*, *Makefile* and *refs.bib*
  
. . .

````make
output/content.slides.html: src/content.md Makefile refs.bib
pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o output/content.slides.html src/content.md
````

## Build targets

- you can build **individual targets** by calling `Make` on them:
  
	````sh
	
	make output/content.slides.html
	````
  
. . .

- if no argument is specified, `Make` automatically builds the **first
  target** appearing in a `Makefile`
  
  
##

- additional **pdf** output target:
  
````make
output/content.pdf: src/content.md Makefile refs.bib
pandoc -s -t beamer -f markdown \
--slide-level=2 \
-V theme=CambridgeUS -V colortheme=dolphin \
-V header-includes=\\hypersetup{colorlinks\=true} \
-V header-includes=\\hypersetup{urlcolor\=blue} \
-V header-includes=\\hypersetup{linkcolor\=blue} \
-V header-includes=\\usepackage{hyperref} \
-V urlcolor=blue \
-V linkcolor=blue \
--mathjax \
--filter pandoc_custom/filters/skip_pause.hs \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o output/content.pdf src/content.md
````

## [Automatic variables](http://www.gnu.org/software/make/manual/html_node/Automatic-Variables.html)

- targets and dependencies are frequently referenced in make rule
  
. . .

$\Rightarrow$ shortcuts: **automatic variables**

. . .

- `$@` represents target
  
. . .

- `$<` represents first dependency
  
## Example

````
output/content.pdf: src/content.md Makefile refs.bib
pandoc -s -t beamer -f markdown \
--slide-level=2 \
-V theme=CambridgeUS -V colortheme=dolphin \
-V header-includes=\\hypersetup{colorlinks\=true} \
-V header-includes=\\hypersetup{urlcolor\=blue} \
-V header-includes=\\hypersetup{linkcolor\=blue} \
-V header-includes=\\usepackage{hyperref} \
-V urlcolor=blue \
-V linkcolor=blue \
--mathjax \
--filter pandoc_custom/filters/skip_pause.hs \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o $@ $<
````

## Dummy targets

- to subsume multiple targets create **dummy target** that will never
  be created itself:
  
. . .

````
all: output/content.pdf output/content.slides.html
````

## Variables

- define re-occuring parts at single location
  
. . .

$\Rightarrow$ use variables

````

OUTDIR = output

$(OUTDIR)/content.slides.html: src/content.md Makefile refs.bib
pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o $@ $<
````

## [Pattern rules](http://www.gnu.org/software/make/manual/html_node/Pattern-Rules.html#Pattern-Rules)

- applying identical rules to multiple targets
  
. . .

````
$(OUTDIR)/*.slides.html: src/*.md Makefile refs.bib
pandoc --template=pandoc_custom/templates/revealjs.template \
-s -V revealjs-url=../reveal.js -t revealjs -f markdown \
--filter pandoc-citeproc --csl=pandoc_custom/csl/elsevier-harvard.csl \
--bibliography=refs.bib \
-o $@ $<
````


## Resources

- Make lessons at [Software Carpentry](http://software-carpentry.org/v4/make/index.html)
  
# References

## 

### Cited in pandoc chapter:

