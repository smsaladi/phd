
`r if (knitr::is_latex_output()) '<!--'`
# Sequence search in an instant
`r if (knitr::is_latex_output()) '-->'`

`r if (knitr::is_html_output()) '<!--'`
# Alignment-free, low dimensional numerical embedding accelerates protein sequence lookup
`r if (knitr::is_html_output()) '-->'`

The deluge of biological sequence data necessitates the development new approaches to manage and search the evergrowing databases. Classical tools for searching sequence searching, a semi-exact string lookup problem, are bespoke,
special-purpose tools built for biologists, e.g. BLAST. A rapid improvement could be achieved if the sequence lookup
problem could be transformed into a standard, numerical lookup problem, think k-d tree. By building off of recent work
showing that any protein sequence can be represented as 3 floating point numbers, this is a proof-of-concept application that can search the protein sequence archives many fold faster than the best tools available.

### Citation

A version of this will will be available as

Saladi, Wang, Mai, Clemons. Alignment-free, low dimensional numerical embedding accelerates protein sequence
lookup. in prep.

eastdb.herokuapp.com; Github: smsaladi/EASTdb

