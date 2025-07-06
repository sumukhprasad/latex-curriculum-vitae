\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{curriculum-vitae}[2025/06/06 v2.0 LaTeX class for curriculum vitae]

\LoadClass[onecolumn]{article}
\RequirePackage{titlesec}
\RequirePackage{xparse}
\RequirePackage{microtype}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage[T1]{fontenc}
\RequirePackage{ragged2e}
\RequirePackage{parskip}
\RequirePackage{setspace}

\RequirePackage[ultralight]{FiraSans}
\renewcommand*\oldstylenums[1]{{\firaoldstyle #1}}

% === User Info Variables ===
\newcommand{\@cvname}{}
\newcommand{\@cvdesc}{}
\newcommand{\@cvemail}{}
\newcommand{\@cvphone}{}
\newcommand{\@cvweb}{}
\newcommand{\@cvaddr}{}
\newcommand{\@cvqualification}{}

% === Setup commands ===
\NewDocumentCommand{\name}{m}{\renewcommand{\@cvname}{#1}}
\NewDocumentCommand{\desc}{m}{\renewcommand{\@cvdesc}{#1}}
\NewDocumentCommand{\email}{m}{\renewcommand{\@cvemail}{#1}}
\NewDocumentCommand{\phone}{m}{\renewcommand{\@cvphone}{#1}}
\NewDocumentCommand{\webpage}{m}{\renewcommand{\@cvweb}{#1}}
\NewDocumentCommand{\mailingaddr}{m}{\renewcommand{\@cvaddr}{#1}}
\NewDocumentCommand{\qualification}{m}{\renewcommand{\@cvqualification}{#1}}

% === Symbols ===
\newcommand*\phoneSymbol{\faIcon{phone-alt}}
\newcommand*\emailSymbol{\faIcon{at}}
\newcommand*\webSymbol{\faIcon{link}}

% === Title block ===
\renewcommand{\maketitle}{%
	\vspace{1em}
	
	\begin{flushright}
		\setstretch{0.6}
		\ifx\@cvphone\empty\else \item {\@cvphone} \fi 
		\ifx\@cvemail\empty\else \item {\@cvemail} \fi
		\ifx\@cvweb\empty\else \item {\@cvweb} \fi
	\end{flushright}\vspace{-30pt}
	
	
	\begin{flushleft}
		{\fontsize{30pt}{30pt}\textsc{\@cvname}} \quad { \fontsize{15pt}{15pt} \textsc{\@cvqualification}}
		\noindent\rule{\textwidth}{0.4pt}
	\end{flushleft}
	
	\ifx\@cvaddr\empty\else \@cvaddr \fi
	
	\vspace{3em}
}

% === Section formatting ===
\titleformat{\section}{\scshape\Large\raggedright}{}{0em}{}[\titlerule]
\titleformat{\subsection}{\bfseries\large}{}{0em}{}
\setcounter{secnumdepth}{0}


% === 2-col cvsection ===
\NewDocumentCommand{\cvsection}{O{}+m}{
	\noindent
	\begin{minipage}[t]{0.25\linewidth}
		\raggedright
		{\huge\sffamily #1}
	\end{minipage}%
	\hspace{1em}%
	\begin{minipage}[t]{0.7\linewidth}
		#2
	\end{minipage}
	\vspace{1em}
}

% === Detail environment ===
\NewDocumentEnvironment{detail}{O{} m m}{
		{{\bfseries#1}\addcontentsline{toc}{subsection}{#1}}\hfill#2 -- #3\\%
}{\noindent\vspace{0.5cm}\\}
