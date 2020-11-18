
`r if (knitr::is_latex_output()) '<!--'`
# A membrane protein expression predictor
`r if (knitr::is_latex_output()) '-->'`

`r if (knitr::is_html_output()) '<!--'`
# A statistical model for improved membrane protein expression using sequence-derived features
`r if (knitr::is_html_output()) '-->'`

The heterologous expression of integral membrane proteins (IMPs) remains
a major bottleneck in the characterization of this important protein
class. IMP expression levels are currently unpredictable, which renders
the pursuit of IMPs for structural and biophysical characterization
challenging and inefficient. Experimental evidence demonstrates that
changes within the nucleotide or amino-acid sequence for a given IMP can
dramatically affect expression levels; yet these observations have not
resulted in generalizable approaches to improve expression levels. Here,
we develop a data-driven statistical predictor named IMProve, that,
using only sequence information, increases the likelihood of selecting
an IMP that expresses in *E. coli.* The IMProve model, trained on
experimental data, combines a set of sequence-derived features resulting
in an IMProve score, where higher values have a higher probability of
success. The model is rigorously validated against a variety of
independent datasets that contain a wide range of experimental outcomes
from various IMP expression trials. The results demonstrate that use of
the model can more than double the number of successfully expressed
targets at any experimental scale. IMProve can immediately be used to
identify favorable targets for characterization. Most notably, IMProve
demonstrates for the first time that IMP expression levels can be
predicted directly from sequence.


### Citation

A version of this work is published as

Saladi, Javed, Müller, Clemons. A statistical model for improved membrane protein expression using sequence-derived
features. J Biol Chem (2018). 10.1074/jbc.RA117.001052.

Code available openly on Github: clemlab/IMProve, clemlab/impweb; web application at IMProve.caltech.edu

Caltech filed US patent application 15/444,247 filed based on this publication as well.
