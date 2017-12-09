% !TEX encoding = UTF-8 Unicode
%%
%% This is file `canzoniereonline.cls',
%%
%%  Copyright by Francesco Endrici
%% 
%%  This program is provided under the terms of the
%%  LaTeX Project Public License distributed from CTAN
%%  archives in directory macros/latex/base/lppl.txt.
%% 
%%  Author: Francesco Endrici
%%          francescoendrici+tex at gmail dot com
%% 
%%  This work has the LPPL maintenance status "author-maintained".
%% 
\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{canzoniereonline}[2017/09/10 v0.5 Una classe per la creazione di canzonieri on line]
\RequirePackage{ifxetex}
\ifxetex
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setdefaultlanguage{italian}
\else
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[italian]{babel}
\fi
\RequirePackage{xkeyval}
\newif\iflibertine
\newif\ifcanzsingole
\newif\ifaquattrovert
\newif\ifacinquevert
\newif\ifacinqueor
\newif\ifaseivert
\newif\ifsmart
\newif\iftitleindex
\newif\ifauthorsindex
\newif\iftematicindex
\newif\ifcover
\DeclareOption{palatino}{\libertinefalse}
\DeclareOption{libertine}{\libertinetrue}
\DeclareOption{singoli}{\canzsingoletrue\aquattrovertfalse\acinquevertfalse\acinqueorfalse\aseivertfalse\coverfalse\smartfalse}
\DeclareOption{standard}{\aquattroverttrue\canzsingolefalse\acinquevertfalse\acinqueorfalse\aseivertfalse\smartfalse}
\DeclareOption{a5vert}{\acinqueverttrue\canzsingolefalse\aquattrovertfalse\acinqueorfalse\aseivertfalse\smartfalse}
\DeclareOption{a5oriz}{\acinqueortrue\canzsingolefalse\aquattrovertfalse\acinquevertfalse\aseivertfalse\smartfalse}
\DeclareOption{a6vert}{\aseiverttrue\canzsingolefalse\aquattrovertfalse\acinquevertfalse\acinqueorfalse\smartfalse}
\DeclareOption{smart}{\smarttrue\aseivertfalse\canzsingolefalse\aquattrovertfalse\acinquevertfalse\acinqueorfalse}
\DeclareOption{titleindex}{\titleindextrue}
\DeclareOption{authorsindex}{\authorsindextrue}
\DeclareOption{tematicindex}{\tematicindextrue}
\DeclareOption{cover}{\covertrue}
\DeclareOption{nocover}{\coverfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\DeclareOption{lyric}{\PassOptionsToPackage{lyric}{songs}}
\DeclareOption{chorded}{\PassOptionsToPackage{chorded}{songs}}

\DeclareOptionX{minorsign}{\def\canzonline@myminor{#1}}
\ExecuteOptions{standard,libertine,cover}
\ExecuteOptionsX{minorsign=m}
\ProcessOptions\relax
\ProcessOptionsX\relax
%corpo del font
\ifcanzsingole
  \RequirePackage{lastpage}
  \newcommand{\FontSize}{11pt}
\else
   \ifaquattrovert
    \newcommand{\FontSize}{11pt}
   \else
     \newcommand{\FontSize}{10pt}
   \fi
\fi
%preambolo
\LoadClass[\FontSize]{book}

\RequirePackage{graphicx}
\RequirePackage{amssymb}
\RequirePackage{fancyhdr} 
\RequirePackage{tabularx,booktabs,colortbl}
\RequirePackage{multirow}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{xcolor}
\RequirePackage{pdfpages}
\RequirePackage{url}
\RequirePackage{xparse}
\RequirePackage{etoolbox,xstring}
\RequirePackage{ccicons}
\RequirePackage{imakeidx} 
\usepackage{titlesec}% cambio la formattazione dei titolo dei capitoli (mi serve per l'indice tematico)
\ifxetex
	\iftitleindex
		\makeindex[name=alfabetico,title=Indice alfabetico,program=truexindy,options=-M texindy -C utf8 -L italian -M xindystyle]
	\else
	\fi
	\ifauthorsindex
		\makeindex[name=autori,title=Indice degli autori,program=truexindy,options= -M texindy -C utf8 -L italian -M xindystyle]
	\else
	\fi
	\iftematicindex
		\makeindex[name=tematico,title=Indice tematico,program=truexindy,options= -M texindy -C utf8 -L italian -M xindytematic]
	\else
	\fi
\else
	\iftitleindex
		\makeindex[title=Indice alfabetico,options=-s canzstyle.ist]
	\else
	\fi
	\ifauthorsindex
		\makeindex[name=autori,title=Indice degli autori,options=-s canzstyle.ist]%***
	\else
	\fi
	\iftematicindex
		\makeindex[name=tematico,title=Indice tematico,options=-s tematicstyle.ist]%***
	\else
	\fi
\fi


%FONT
\iflibertine
	\RequirePackage[tt=false]{libertine}
\else
	\RequirePackage[]{mathpazo}
\fi
%GEOMETRIA
\ifcanzsingole
	\RequirePackage[top=16mm, left=14mm, right=13mm,  bottom= 20mm, a4paper]{geometry}
\fi
\ifaquattrovert
	\RequirePackage[paperheight=297mm, paperwidth=210mm, inner=10mm, outer=10mm, top=10mm, bottom=10mm]{geometry}
\fi
\ifacinquevert
	\RequirePackage[paperheight=210mm, paperwidth=148mm, inner=8mm, outer=10mm, top=10mm, bottom=10mm]{geometry}
\fi
\ifacinqueor
	\RequirePackage[paperheight=148mm, paperwidth=210mm, inner=8mm, outer=10mm, top=10mm, bottom=10mm]{geometry}
\fi
\ifaseivert
	\RequirePackage[paperheight=148mm, paperwidth=105mm, inner=6mm, outer=8mm, top=9mm, bottom=9mm]{geometry}
\fi
\ifsmart
	\RequirePackage[paperheight=182mm, paperwidth=110mm, inner=2mm, outer=2mm, top=7mm, bottom=1mm]{geometry}
\fi


%TESTATINE
\ifcanzsingole
	\pagestyle{fancy}%
	\setlength{\headheight}{0pt}
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\fancyfoot[RE]{\setlength{\unitlength}{1mm} \begin{picture}(0,0)
	\put(-5,-10){\includegraphics[width=16mm]{logo-co}}\end{picture}}
	\fancyfoot[LO]{\setlength{\unitlength}{1mm} \begin{picture}(0,0)
	\put(-5,-10){\includegraphics[width=16mm]{logo-co}}\end{picture}}
	\fancyfoot[RO]{\sffamily\small\thepage\ di \pageref{LastPage}}
	\fancyfoot[LE]{\sffamily\small\thepage\ di \pageref{LastPage}}  
	\fancyfoot[C]{\footnotesize\sffamily I testi delle canzoni sono proprietà dei rispettivi autori.\\ La Legge n. 159 del 22 maggio 1993 ne consente l'uso solo per attività didattica, di studio e di ricerca. \\Gli autori potranno richiederne la rimozione in qualsiasi momento scrivendo a canzoniereonline@gmail.com.}
	\fancypagestyle{plain}{%
	\fancyhead{} % leva l'intestazione
	%\fancyfoot[RO]{\thepage} %mette il numero di pagina in basso al centro
	\renewcommand{\headrulewidth}{0pt} % e leva la linea dalle pagine di inizio capitolo
}
\else
	\pagestyle{fancy}%
	\setlength{\headheight}{0pt}
	\fancyhf{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
	\fancyfoot[RO]{} 
	\fancyfoot[LE]{}  
	\fancypagestyle{plain}{%
	\fancyhead{} % leva l'intestazione
	\fancyfoot[C]{} 
	\renewcommand{\headrulewidth}{0pt} % e leva la linea dalle pagine di inizio capitolo
}
\fi
%%%%%%%%%%%%%%Impostazioni del pacchetto Songs
\RequirePackage[nomeasures,noshading,noindexes]{songs}
\MultiwordChords	
\notenamesin{A}{B}{C}{D}{E}{F}{G}  			% scriverò gli accordi secondo la notazione anglosassone
\notenamesout{La}{Si}{Do}{Re}{Mi}{Fa}{Sol} 	% e lui me li restituirà secondo la notazione italiana
\renewcommand{\sharpsymbol}{\ensuremath{\raisebox{0.5mm}{\footnotesize$\sharp$}}}  % diesis
\renewcommand{\flatsymbol}{\raisebox{0.1ex}{$\flat$}}				% bemolle
\setlength{\cbarwidth}{0pt}						% linea laterale ritornelli
\setlength{\sbarheight}{0pt}						%linee sopra e sotto
\renewcommand{\chorusfont}{\itshape}					%font ritornelli
\renewcommand{\rep}[1]{{\normalfont($\times$#1)}}		% cambia la x nelle ripetizioni
\setlength{\parindent}{0pt}
\setlength\columnsep{5mm}
%ACCORDI
\iflibertine
	\renewcommand{\printchord}[1]{\normalfont\small\bfseries#1}
\else
	\ifcanzsingole
   		\renewcommand{\printchord}[1]{\normalfont\small\bfseries\sffamily#1}
   	\else
   		\renewcommand{\printchord}[1]{\normalfont\bfseries\sffamily#1}
  	\fi
\fi
%RIENTRO DELLE STROFE
\ifcanzsingole
	\versenumwidth=0pt
	\renewcommand\placeversenum[1]{%      modifichiamo il posizionamento dei numeri di strofa
 		\hskip-\leftskip\hskip-\parindent\relax%
 		\llap{\box#1\ }%
 	}
\else
	\versenumwidth=1.2em
	\renewcommand{\everychorus}{\setlength{\leftskip}{\versenumwidth}}
\fi

%Per modificare il font delle seconde voci-risposte
\renewcommand\SB@echo[1]{%
	\endgroup% 
	\begingroup%
		\ifdim\fontdimen\@ne\font>\z@\upshape\else\itshape\fi% 
		\endlinechar\m@ne% 
		\scantokens{(#1)}%
	\endgroup% 
}

%pre- and postlude separation
\ifcanzsingole
	\afterpreludeskip=-0.7em
\else
	\ifchorded
		\afterpreludeskip=-7pt plus 3pt minus 3pt
		\setlength{\versesep}{0.3\baselineskip plus 4pt minus 2pt}
	\else
		\afterpreludeskip=2pt
		\setlength{\versesep}{0.6\baselineskip plus 4pt minus 2pt}
	\fi
\fi
\renewcommand{\makepostlude}{\vskip10pt plus 10pt minus 3pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modificare l'interlinea
\iflyric
	\renewcommand{\colbotglue}{0pt plus .5\textheight minus 0pt}
	\baselineadj=2pt plus 0pt minus 0pt  % nel canzoniere senza accordi regolo l'interline di TUTTE le strofe
\fi
\ifchorded  % nel canzoniere con accordi regolo l'interline delle:
	\baselineadj=1pt plus 0pt minus 0pt  %strofe con accordi (interlinea generale)
	\newcommand{\mychordsoff}{}
	\let\mychordsoff\chordsoff
	\renewcommand{\chordsoff}{\baselineadj=1pt\mychordsoff} %strofe senza accordi
\fi
%
\renewcommand{\clineparams}{%
\iflibertine
	\baselineskip=9pt
\else
	\baselineskip=10pt
\fi
\lineskiplimit=0pt 
\lineskip=0pt
}


\renewcommand\textnote[1]{% note in senza grazie e senza sfondo
  \ifhmode\par\fi%
  \ifnum\lastpenalty=12345\else%
    \ifSB@inverse%
      \vskip2\p@\relax%
    \else\ifSB@inchorus%
      \vskip2\p@\relax%
    \else\ifSB@stanza%
      \nobreak\vskip\versesep%
    \fi\fi\fi%
  \fi%
  \begingroup%
    \everypar{}%
    \ifchorded\chordedfalse\SB@setbaselineskip\chordedtrue\fi%
    \placenote{\normalfont\sffamily{\SB@boxup{#1}}}%
  \endgroup%
  \nobreak%
  \ifSB@inverse%
    \vskip2\p@\relax%
  \else\ifSB@inchorus%
    \vskip2\p@\relax%
  \else\ifSB@stanza\else%
    \nobreak\vskip\versesep%
  \fi\fi\fi%
}

%modifico il comando per i titoli secondari, in modo da generare l'indice
\renewcommand\indextitleentry[1]{%
\ifxetex
	\iftitleindex\index[alfabetico]{#1|indexanchor{\thesongnum}}
	\else
	\fi
\else
  	\iftitleindex\index{#1|indexanchor{\thesongnum}}
	\else
	\fi
\fi
}

%note di basso
\def\bassfont{\futurelet\next\@bassverify}
\def\@basstrue{\hspace{-0.2em}/\hspace{-0.05em}\scriptsize}
\def\@bassfalse{/}
\def\@bassverify{%
  \ifcat\next f
    \@basstrue
  \else
    \@bassfalse
  \fi}
%\newcommand{\canzonline@myminor}{m}% per modificare il segno di minore si ridefinisca questo comando, ad esempio con {\textendash} al posto di {m}
\renewcommand{\chordlocals}{%
\catcode`/\active
\catcode`-\active}
{\chordlocals\global\let/\bassfont
\global\let-=\canzonline@myminor}

%SONGPOS
\ifaseivert
\songpos{0}
\else
	\ifacinqueor\songpos{1}
	\else
	\ifacinquevert\songpos{1}
	\fi\fi%
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%
% TITOLI
\newcommand{\stampatitolo}{}
\iflibertine
 \ifaseivert
  \renewcommand{\stampatitolo}{\fontsize{12}{15}\selectfont\bfseries}
 \else
  \renewcommand{\stampatitolo}{\fontsize{14}{18}\selectfont\bfseries}
 \fi
\else
 \ifaseivert
  \renewcommand{\stampatitolo}{\fontsize{12}{15}\selectfont\bfseries\sffamily}
 \else
  \renewcommand{\stampatitolo}{\fontsize{14}{18}\selectfont\bfseries\sffamily}
 \fi
\fi
\newcommand{\stampanumero}{}
\iflibertine
 \ifaseivert
   \renewcommand{\stampanumero}{\bfseries\fontsize{30}{18}\selectfont}
 \else
   \renewcommand{\stampanumero}{\bfseries\fontsize{36}{28}\selectfont}
 \fi
\else
 \ifaseivert
   \renewcommand{\stampanumero}{\fontsize{30}{18}\selectfont}
 \else
  \renewcommand{\stampanumero}{\fontsize{36}{28}\selectfont}
 \fi
\fi
\newlength{\titlength}
\newlength{\numerwidth}
\newlength{\larcolonna}
\ifcanzsingole
	\renewcommand\makeprelude{%
	\resettitles%
	\newcommand{\titolo}{\LARGE\bfseries\sffamily\songtitle}
	\settowidth{\titlength}{\titolo}
 	\begin{tabularx}{\hsize}{X}
	\ifdim\titlength<\hsize \hspace{-0.5em}\titolo
	\else \hspace{-0.5em}\resizebox{\hsize}{!}{\titolo}
	\fi\\
	\hline
	\hfill\small\itshape\songauthors
 	\end{tabularx}
    \nexttitle%
    \foreachtitle{(\songtitle)\par}%
}
\else
\renewcommand\makeprelude{%
\resettitles%
\settowidth{\numerwidth}{\stampanumero\thesongnum}
\newcommand{\titolo}{\stampatitolo\songtitle}
\settowidth{\titlength}{\titolo}
\setlength{\larcolonna}{\hsize-\numerwidth-30pt}
\begin{tabularx}{\hsize}{@{}r@{}X}
\renewcommand{\arraystretch}{0} 
	& \ifdim\titlength<\larcolonna \titolo \else \resizebox{\larcolonna}{!}{\titolo} \fi\\
\cline{2-2}  
\multirow{-2}{*}{\raisebox{-3pt}{\stampanumero\textcolor{gray}{\thesongnum}\hspace{3pt}}} & \ifthenelse{\equal{\songauthors}{}}{}{\hfill\footnotesize{\itshape\songauthors}%
	\ifauthorsindex\expandafter\authindex\expandafter{\songauthors}\else\fi}%
	\end{tabularx}
%
\hypertarget{canto-\thesongnum}{}% and I put an anchor in my song.
\iftitleindex\StrSubstitute{\songtitle}{!}{"!}[\indexsongtitle]
	\ifxetex
		\index[alfabetico]{\indexsongtitle|indexanchor{\thesongnum}}
	\else%
		\expandafter\noaccentindex\expandafter{\songtitle}%
	\fi%
\else\fi
       \nexttitle%
       %\foreachtitle{(\songtitle)\par}%
}
\fi

%INDICI grazie a Enrico Gregorio
\def\accents@list{\do\IeC\do\`\do\'}
\def\letters@list{\do\i{i}}
\newcommand{\noaccentindex}[1]{%
  \begingroup
  \protected@edef\next{#1}%
  \ifnum\pdfstrcmp{\detokenize\expandafter{\next}}{\detokenize{#1}}=\z@
    \endgroup\index{#1|indexanchor{\thesongnum}}%
  \else
    \def\do##1{\def##1####1{####1}}\accents@list
    \def\do##1##2{\def##1{##2}}\letters@list
    \edef\next{\endgroup\def\noexpand\next{\next}}\next
    \expandafter\index\expandafter{\next @\detokenize{#1}|indexanchor{\thesongnum}}%
  \fi}


\DeclareListParser*{\authsep}{,}
\newcommand{\authindex}[1]{%
\authsep{\authsingleindex}{#1}}
\newcommand\authsingleindex[1]{\index[autori]{#1|indexanchor{\thesongnum}}}



\ExplSyntaxOn
\seq_clear_new:N \l_co_hyperlinks_seq
\NewDocumentCommand{\singleindexanchor}{m}
	{
	\seq_clear_new:N \l_co_indexanchors_seq
	\seq_set_split:Nnn \l_co_indexanchors_seq {;} {#1}
	\seq_clear:N \l_co_hyperlinks_seq
	\seq_map_inline:Nn \l_co_indexanchors_seq 
		{
		\seq_put_right:Nn \l_co_hyperlinks_seq {\hyperlink{canto-##1}{##1}}
		 }
	\seq_use:Nnnn \l_co_hyperlinks_seq {,~}{,~}{,~}
	}
\ExplSyntaxOff

\ifxetex
	\newcommand{\indexanchor}[1]{\singleindexanchor{#1}}%
\else% makeindex tiene già divise le voci, non serve fare il parsing dell'argomento di \indexanchor
	\newcommand{\indexanchor}[2]{\hyperlink{canto-#1}{#1}}%
\fi

%indice tematico
%Affinché si possa creare un indice tematico serve che dopo \beginsong si inserisca il comando \momenti{}
%L'argomento di \momenti{} è la lista dei momenti liturgici in cui la canzone viene usata, separati da punto e virgola
%ad esempio \momenti{Ingresso;Comunione;Congedo}
%è possibile usare la definizione che si vuole, anche inserendo spazi

\DeclareListParser*{\momentsep}{;}
\newcommand{\momenti}[1]{%
\momentsep{\momentindex}{#1}}
\ExplSyntaxOn
\prop_new:N \g_moment_ordr_prop
\tl_new:N \l_index_tl
\NewDocumentCommand{\setposition}{mm}{\prop_gput:Nnn \g_moment_ordr_prop {#1} {#2} }
\NewDocumentCommand{\getposition}{m}{\prop_get:NnNTF \g_moment_ordr_prop {#1} \l_index_tl  {\def\momentnumber{\l_index_tl}} {} }
\NewDocumentCommand{\veditoken}{}{\tl_show:N \l_index_tl}
\ExplSyntaxOff
%creo l'ordine dei ``momenti''. I momenti della messa sono in un primo gruppo, i tempi liturgici in un secondo (che inizia con il 21), le attribuzioni particolari iniziano col 31  e le canzoni scout col 51. Questo solo per comodità, nel caso in cui si dovesse inserire qualche nuovo momento non servirebbe cambiare i numeri di tutti i momenti successivi, ma solo di alcuni.
\setposition{Ingresso}{01}
\setposition{Atto penitenziale}{02}
\setposition{Gloria}{03}
\setposition{Salmi}{04}
\setposition{Acclamazione al Vangelo}{05}
\setposition{Alleluia}{06}
\setposition{Offertorio}{07}
\setposition{Santo}{08}
\setposition{Mistero della fede}{09}
\setposition{Padre nostro}{10}
\setposition{Rito della pace}{11}
\setposition{Agnello di Dio}{12}
\setposition{Canto di comunione}{13}
\setposition{Canto di congedo}{14}

\setposition{Avvento}{20}
\setposition{Natale}{21}
\setposition{Quaresima}{22}
\setposition{Pasqua}{23}

\setposition{Canti di Taizé}{30}
\setposition{Canti francescani}{31}
\setposition{Canti mariani}{32}

\setposition{Riconciliazione}{33}
\setposition{Conversione}{34}

\setposition{L/C}{51}
\setposition{E/G}{52}
\setposition{R/S}{53}

\ifxetex
\newcommand*{\momentindex}[1]{%
  \getposition{#1}% al posto del nome del momento metto un numero
  \StrSubstitute{\songtitle}{!}{"!}[\indexsongtitle]
  \edef\doindexentry{\noexpand\index[tematico]{\momentnumber @#1!{\expandonce\indexsongtitle}|indexanchor{\thesongnum}}}
{\doindexentry}
}
\else
\newcommand*{\momentindex}[1]{%
  \getposition{#1}% al posto del nome del momento metto un numero
  %\StrSubstitute{\songtitle}{!}{"!}[\indexsongtitle]
  \index[tematico]{\momentnumber @#1!\songtitle|indexanchor{\thesongnum}}}
\fi


%righe per la copertina
\newcommand{\titolettocop}{}
\newcommand{\titolocop}{}
\newcommand{\sottotitolocop}{}
\newcommand{\piede}{}
\newcommand{\printtitoletto}{\Large\titolettocop}
\newcommand{\printtitolo}{\Huge\titolocop}
\newcommand{\printsottotitolo}{\large\scshape\sottotitolocop}
\newcommand{\printpiede}{\normalfont\piede}
\newcommand{\firstpage}{%
\begin{titlepage}
\begin{center}
\null
\vspace*{\stretch{1}}
\printtitoletto
\bigskip

\printtitolo
\bigskip

\printsottotitolo
\vspace*{\stretch{2}}

\printpiede
\end{center}
\end{titlepage}}

\newcommand{\colophon}{%
\pagebreak
\null
\vfill

\ifaseivert
\begin{minipage}{\textwidth}
\else
\begin{minipage}{0.4\textwidth}
\fi
\small
Questo canzoniere è stato composto il giorno \today{} utilizzando il servizio \hbox{\url{www.canzoniereonline.it}} 
che si basa sul pacchetto \textsf{songs}\footnote{\url{http://songs.sourceforge.net}} di Kevin W. Hamlen. 
È distribuito con licenza Creative Commons.
\smallskip

Il font utilizzato è il \iflibertine\textsf{Libertine}\footnote{\url{www.linuxlibertine.org}}\else Palatino\fi.

\smallskip
I testi delle canzoni sono proprietà dei rispettivi autori.
La Legge n.~159 del 22 maggio 1993 ne consente l'uso solo per attività didattica, di studio e di ricerca. \\
Gli autori potranno richiederne la rimozione in qualsiasi momento scrivendo a \url{canzoniereonline@gmail.com}.

\smallskip
Qualora doveste trovare errori vi preghiamo di segnalarli scrivendo a: \url{canzoniereonline@gmail.com}

\smallskip
{\hspace*{3.3em}\Large\ccbyncsaeu}
\end{minipage}
\clearpage}

\let\songlink\hyperlink
\endinput
