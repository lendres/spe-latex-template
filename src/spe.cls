% File obtained from https://github.com/agurwicz/spe-latex-template.


% Original template
\LoadClass[10pt, twoside]{article}

\RequirePackage[letterpaper, portrait, margin=1in]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage[scaled]{helvet}

\renewcommand{\familydefault}{\sfdefault}

% Additional

% Conference and journal options
\newif\if@isconference \@isconferencefalse \DeclareOption{conference}{\@isconferencetrue}
\newif\if@isjournal \@isjournalfalse \DeclareOption{journal}{\@isjournaltrue}
\ProcessOptions\relax

\if@isjournal \if@isconference
    \PackageError{spe}{Cannot load both "journal" and "conference" options}
\fi \fi
\unless\if@isjournal \unless\if@isconference
    \PackageError{spe}{One of the "journal" or "conference" options needs to be loaded}
\fi \fi

% Header
\newcommand{\@spevenuename}{}
\newcommand{\spevenuename}[1]{\renewcommand{\@spevenuename}{#1}}

\newcommand{\@spemanuscriptnumber}{}
\newcommand{\spemanuscriptnumber}[1]{\renewcommand{\@spemanuscriptnumber}{#1}}

\newcommand{\@spetitle}{}
\newcommand{\spetitle}[1]{\renewcommand{\@spetitle}{#1}}

\newcommand{\@speauthors}{}
\newcommand{\speauthors}[1]{\renewcommand{\@speauthors}{#1}}

\newcommand{\@speaffiliations}{}
\newcommand{\speaffiliations}[1]{\renewcommand{\@speaffiliations}{#1}}

\newcommand{\@speauthoraffiliations}{}
\newcommand{\speauthoraffiliations}[1]{\renewcommand{\@speauthoraffiliations}{#1}}

\newcommand{\@specorrespondingauthor}{}
\newcommand{\specorrespondingauthor}[1]{\renewcommand{\@specorrespondingauthor}{#1}}

\newcommand{\@spekeywords}{}
\newcommand{\spekeywords}[1]{\renewcommand{\@spekeywords}{#1}}

\newcommand{\specheckargument}[1]{%
    \ifx#1\@empty
        \begingroup
            \edef\spe@name{\expandafter\@gobbletwo\string#1}%
            \PackageError{spe}
                {Required command "\expandafter\string\csname\spe@name\endcsname" has not been specified}
                {Please define \expandafter\string\csname\spe@name\endcsname\space before using this package.}%
        \endgroup
    \fi
}
\newcommand{\specheckarguments}{%
    \specheckargument{\@spevenuename}%
    \specheckargument{\@spemanuscriptnumber}%
    \specheckargument{\@spetitle}%
    \specheckargument{\@speauthors}%
    \specheckargument{\@speaffiliations}%
    \specheckargument{\@speauthoraffiliations}%
    \if@isjournal%
        \specheckargument{\@specorrespondingauthor}%
        \specheckargument{\@spekeywords}%
    \fi%
}

\RequirePackage{xcolor}
\definecolor{spelink}{HTML}{172b81}

\RequirePackage[hidelinks, urlcolor=spelink, citecolor=black, linkcolor=black, colorlinks=true]{hyperref}
\RequirePackage{listofitems}
\RequirePackage{pgffor}
\RequirePackage{float}
\RequirePackage{graphicx}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{mathtools}

% Captions
\RequirePackage{caption}
\floatstyle{plaintop}
\restylefloat{table}
\DeclareCaptionLabelSeparator{spelabelseparator}{—}
\captionsetup[figure]{name={Fig.}, labelsep={spelabelseparator}, font={bf,footnotesize}}
\captionsetup[table]{name={Table}, labelsep={spelabelseparator}, font={footnotesize}}

% References
\RequirePackage[capitalize, nameinlink]{cleveref}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\creflabelformat{equation}{#2\textup{#1}#3}
\newcommand{\speref}[1]{\cref{#1}}
\newcommand{\sperefp}[1]{(\speref{#1})}
\newcommand{\spefirstref}[1]{\textbf{\speref{#1}}}
\newcommand{\spefirstrefp}[1]{\textbf{\sperefp{#1}}}
\newcommand\setcurrentname[1]{\def\@currentlabelname{``\textit{#1}''}}

% Citations
\usepackage[
  backend=biber,
  style=spe,
  citestyle=spe
]{biblatex}

% Section headings
\RequirePackage{titlesec}
\titleformat{\section}[hang]{\Large \bfseries}{\thesection.}{1em}{}
\titleformat{\subsection}[hang]{\normalsize \bfseries}{\thesubsection.}{1em}{}
\titleformat{\subsubsection}[runin]{\normalsize \bfseries \itshape}{\thesubsubsection.}{1em}{}[.]

\titlespacing*{\section}{0pt}{2.0ex plus 0.5ex minus 0.2ex}{0.6ex}
\titlespacing*{\subsection}{0pt}{1.5ex plus 0.4ex minus 0.2ex}{0.4ex}

% Prevent numbering for the unstarred versions of the section commands.
\setcounter{secnumdepth}{0}

% Has to be done after loading the "hyperref" package, which loads the "nameref" package.
\NewCommandCopy{\@nameref}{\nameref}
\RenewDocumentCommand{\nameref}{s m}{%
    \textit{%
        \IfBooleanTF{#1}
            {\@nameref*{#2}}
            {\@nameref{#2}}%
    }%
}

\newcommand{\subsubsubsection}[1]{~\newline \indent \textit{#1.}}

% Title
\newcommand{\latexmath}[1]{
    \numexpr #1 \relax
}
\newcommand{\parselist}[1]{
    \readlist*{#1}{#1}
}

\newcommand{\spemaketitle}{
    \specheckarguments

    \setsepchar{;}

    \parselist{\@speauthors}
    \parselist{\@speaffiliations}
    \parselist{\@speauthoraffiliations}
    \if@isjournal
        \parselist{\specorrespondingauthor}
        \parselist{\spekeywords}
    \fi

    \begin{flushleft}

        \@spevenuename \vspace{5mm}

        \@spemanuscriptnumber \vspace{5mm}

        \begin{center}
        \huge \@spetitle \vspace{5mm}
        \end{center}

        \textbf{%
            \foreach \index in {1, ..., \@speauthorslen} {%
                \newcommand{\spetempauthor}{%
                    \@speauthors[\index]%
                    \textsuperscript{\@speauthoraffiliations[\index]}%
                    \if@isjournal \ifnum \index = \latexmath{\@specorrespondingauthor[1]}%
                        *%
                    \fi\fi%
                }%
                \ifnum \index < \latexmath{\@speauthorslen - 1}%
                    \spetempauthor, %
                \else \ifnum \index = \latexmath{\@speauthorslen - 1}%
                    \spetempauthor~and %
                \else%
                    \spetempauthor%
                \fi%
                \fi%
            }
        }

        \vspace{5mm}
        \foreach \index in {1, ..., \@speaffiliationslen} {
            \textsuperscript{\index}%
            \@speaffiliations[\index]%
            \par%
        }

        \if@isjournal
            \vspace{3mm}

            *Corresponding author; email: \url{\@specorrespondingauthor[2]}
            \vspace{3mm}

            \textbf{Keywords:}
            \foreach \index in {1, ..., \@spekeywordslen} {%
                \@spekeywords[\index]%
                \ifnum \index < \latexmath{\@spekeywordslen}%
                    ;
                \fi%
            }
        \fi

    \end{flushleft}
}
