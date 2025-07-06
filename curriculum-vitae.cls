\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{curriculum-vitae}[2025/06/06 v2.0 LaTeX class for curriculum vitae]

\LoadClass[onecolumn]{article}
\RequirePackage{titlesec}
\RequirePackage{xparse}
\RequirePackage{microtype}
\RequirePackage{etoolbox}



\def\@name{}
\newcommand{\name}[1]{%
	\def\@name{#1}%
}
\def\@webpage{}
\newcommand{\webpage}[1]{%
	\def\@webpage{#1}%
}
\def\@phone{}
\newcommand{\phone}[1]{%
	\def\@phone{#1}%
}
\def\@desc{}
\newcommand{\desc}[1]{%
	\def\@desc{#1}%
}
\def\@email{}
\newcommand{\email}[1]{%
	\def\@email{#1}%
}
\def\@mailingaddr{}
\newcommand{\mailingaddr}[1]{%
	\def\@mailingaddr{#1}%
}
\renewcommand{\maketitle}{%
	\begin{center}
	\noindent{\bf\Huge\@name}\vspace{0.5cm}\\{\sc\@desc}\vspace{0.5cm}\\{\it\@mailingaddr}\\{\@phone \@webpage \@email}\vspace{0.25cm}\\%
	\noindent\rule{5cm}{0.4pt}\vspace{0.75cm}\\
	\end{center}
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
    {\scshape\Large #1}
  \end{minipage}%
  \hspace{1em}%
  \begin{minipage}[t]{0.7\linewidth}
    #2
  \end{minipage}
  \vspace{1em}
}

% === Detail environment ===
\NewDocumentEnvironment{detail}{O{} m m}{
  \textbf{#1} \hfill {\small #2 -- #3}\\
}{\vspace{0.5em}}