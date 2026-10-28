\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{curriculum-vitae}[2026/10/29 v3.0 LaTeX class for curriculum vitae]

\LoadClass[onecolumn]{article}
\RequirePackage{expl3}
\RequirePackage{xparse}
\RequirePackage{xcolor}
\RequirePackage{fontspec}
\RequirePackage{microtype}
\RequirePackage{titlesec}
\RequirePackage{ragged2e}
\RequirePackage{parskip}
\RequirePackage{setspace}
\RequirePackage{tikz}
\RequirePackage{fontawesome6}
\RequirePackage[skins,breakable]{tcolorbox}








% configuration...
\ExplSyntaxOn
\tl_new:N \g_cv_layout_tl
\tl_new:N \g_cv_header_tl
\tl_new:N \g_cv_heading_font_tl
\tl_new:N \g_cv_body_font_tl
\tl_new:N \g_cv_accent_color_tl
\tl_new:N \g_cv_heading_color_tl
\tl_new:N \g_cv_body_color_tl

% Defaults
\tl_gset:Nn \g_cv_layout_tl				 { side-by-side }
\tl_gset:Nn \g_cv_header_tl				 { default }
\tl_gset:Nn \g_cv_heading_font_tl	 { sans }
\tl_gset:Nn \g_cv_body_font_tl		 { serif }

\tl_gset:Nn \g_cv_accent_color_tl	 { AA0000 }
\tl_gset:Nn \g_cv_heading_color_tl { AA0000 }
\tl_gset:Nn \g_cv_body_color_tl		 { 000000 }

% Keys
\keys_define:nn { cv }
	{
		layout .choices:nn =
			{ side-by-side, stacked }
			{
				\tl_gset:Nx \g_cv_layout_tl
					{ \l_keys_choice_tl }
			},

		header .choices:nn =
			{ default, compact, centered, original }
			{
				\tl_gset:Nx \g_cv_header_tl
					{ \l_keys_choice_tl }
			},

		headings-font .choices:nn =
			{ sans, serif, tt }
			{
				\tl_gset:Nx \g_cv_heading_font_tl
					{ \l_keys_choice_tl }
			},

		body-font .choices:nn =
			{ sans, serif, tt }
			{
				\tl_gset:Nx \g_cv_body_font_tl
					{ \l_keys_choice_tl }
			},

		accent-color .tl_gset:N = \g_cv_accent_color_tl,
		heading-color .tl_gset:N = \g_cv_heading_color_tl,
		body-color .tl_gset:N = \g_cv_body_color_tl,
	}

% Colours
\cs_new_protected:Npn \cv_update_colors:
	{
		\exp_args:Nnnx \definecolor
			{ cvaccent } { HTML }
			{ \tl_use:N \g_cv_accent_color_tl }

		\exp_args:Nnnx \definecolor
			{ cvheading } { HTML }
			{ \tl_use:N \g_cv_heading_color_tl }

		\exp_args:Nnnx \definecolor
			{ cvbody } { HTML }
			{ \tl_use:N \g_cv_body_color_tl }
	}

% Initialize the default palette.
\cv_update_colors:
\NewDocumentCommand \cvsetup { m }
	{
		\keys_set:nn { cv } { #1 }
		\cv_update_colors:
	}

\ExplSyntaxOff








% === global variables ===
\ExplSyntaxOn

\tl_new:N \g_cv_name_tl
\tl_new:N \g_cv_desc_tl
\tl_new:N \g_cv_email_tl
\tl_new:N \g_cv_phone_tl
\tl_new:N \g_cv_web_tl
\tl_new:N \g_cv_addr_tl
\tl_new:N \g_cv_qualification_tl

\NewDocumentCommand{\name}{m}
	{ \tl_gset:Nn \g_cv_name_tl {#1} }

\NewDocumentCommand{\desc}{m}
	{ \tl_gset:Nn \g_cv_desc_tl {#1} }

\NewDocumentCommand{\email}{m}
	{ \tl_gset:Nn \g_cv_email_tl {#1} }

\NewDocumentCommand{\phone}{m}
	{ \tl_gset:Nn \g_cv_phone_tl {#1} }

\NewDocumentCommand{\webpage}{m}
	{ \tl_gset:Nn \g_cv_web_tl {#1} }

\NewDocumentCommand{\mailingaddr}{m}
	{ \tl_gset:Nn \g_cv_addr_tl {#1} }

\NewDocumentCommand{\qualification}{m}
	{ \tl_gset:Nn \g_cv_qualification_tl {#1} }

\ExplSyntaxOff





% === helpers to apply the correct typefaces ===
\ExplSyntaxOn
\cs_new_protected:Npn \cv_heading_font:
	{
		\str_case:VnF \g_cv_heading_font_tl
			{
				{ sans } { \sffamily }
				{ serif } { \rmfamily }
				{ tt } { \ttfamily }
			}
			{ \sffamily }
	}

\cs_new_protected:Npn \cv_body_font:
	{
		\str_case:VnF \g_cv_body_font_tl
			{
				{ sans } { \sffamily }
				{ serif } { \rmfamily }
				{ tt	} { \ttfamily }
			}
			{ \rmfamily }
	}
	
% === header components ===
\cs_new_protected:Npn \cv_header_name:
	{
		{\cv_heading_font:
			\color{cvheading}
			\tl_use:N \g_cv_name_tl
		}
	}
\cs_new_protected:Npn \cv_header_desc:
	{
		{\cv_heading_font:
			\color{cvheading}
			\tl_use:N \g_cv_desc_tl
		}
	}

\cs_new_protected:Npn \cv_header_qualification:
	{
		\tl_if_empty:NF \g_cv_qualification_tl
			{
				\quad
				{\cv_heading_font:
					\tl_use:N \g_cv_qualification_tl
				}
			}
	}

\cs_new_protected:Npn \cv_header_contacts:
	{
		\tl_if_empty:NF \g_cv_phone_tl
			{ \hspace{10pt} \faIcon{phone} \hspace{4pt} \tl_use:N \g_cv_phone_tl }

		\tl_if_empty:NF \g_cv_email_tl
			{ \hspace{10pt} \faIcon{at} \hspace{4pt} \tl_use:N \g_cv_email_tl }

		\tl_if_empty:NF \g_cv_web_tl
			{ \hspace{10pt} \faIcon{link} \hspace{4pt} \tl_use:N \g_cv_web_tl }
	}

\cs_new_protected:Npn \cv_header_address:
	{
		\tl_if_empty:NF \g_cv_addr_tl
			{ \par \tl_use:N \g_cv_addr_tl }
	}

% === headers ===
\cs_new_protected:Npn \cv_header_default:
	{
		\vspace{1em}

		\begin{flushright}
			\small
			\cv_header_contacts:
		\end{flushright}

		\vspace{-1em}

		\noindent
		{\fontsize{30pt}{30pt}\selectfont\cv_header_name:}
		{\fontsize{15pt}{15pt}\selectfont\cv_header_qualification:}
		\par

		\noindent
		{\color{cvaccent}\rule{\linewidth}{0.4pt}}

		\cv_header_address:

		\vspace{2em}
	}

\cs_new_protected:Npn \cv_header_compact:
	{
		\noindent
		\begin{minipage}{\linewidth}
			\begin{minipage}[c]{0.62\linewidth}
				\raggedright
				{\Large\cv_header_name:}
				
				\cv_header_qualification:
			\end{minipage}
			\hfill
			\begin{minipage}[c]{0.34\linewidth}
				\raggedleft
				\footnotesize
				\cv_header_contacts:
			\end{minipage}
		\end{minipage}

		\par\smallskip
		{\color{cvaccent}\rule{\linewidth}{0.4pt}}

		\cv_header_address:
		\par\medskip
	}

\cs_new_protected:Npn \cv_header_centered:
	{
		\begin{center}
			{\Large\cv_header_name:}\\
			\cv_header_qualification:

			\par\smallskip
			{\small
				\cv_header_contacts:
			}

			\cv_header_address:

			\par\medskip
			{\color{cvaccent}\rule{0.8\linewidth}{0.4pt}}
		\end{center}

		\vspace{1em}
	}

\cs_new_protected:Npn \cv_header_original:
	{	
		\begin{center}
			\noindent{\bf\Huge\cv_header_name:}\vspace{0.5cm}\\
			{\sc\cv_header_desc:}\vspace{0.5cm}\\
			{\cv_header_contacts:}
			\vspace{0.25cm}\\%
			\noindent\rule{5cm}{0.4pt}\vspace{0.75cm}\\
		\end{center}

		\vspace{1em}
	}

% === maketitle ===
\RenewDocumentCommand \maketitle { }
	{
		\str_case:VnF \g_cv_header_tl
			{
				{ default	 } { \cv_header_default: }
				{ compact	 } { \cv_header_compact: }
				{ centered } { \cv_header_centered: }
				{ original } { \cv_header_original: }
			}
			{ \cv_header_default: }
	}

% === apply body style ===
\cs_new_protected:Npn \cv_apply_body_style:
	{
		\cv_body_font:
		\color{cvbody}
	}

\AtBeginDocument{\cv_apply_body_style:}

\ExplSyntaxOff