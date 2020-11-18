
`r if (knitr::is_latex_output()) '<!--'`
# Moltemplate
`r if (knitr::is_latex_output()) '-->'`

`r if (knitr::is_html_output()) '<!--'`
# Moltemplate: A Tool for Ultra-Coarse-Grained Modeling of Complex Biological Matter and Soft Condensed Matter Physics.
`r if (knitr::is_html_output()) '-->'`

Coarse-grained models have long been considered indispensable tools in the investigation of biomolecular dynamics and assembly. However, the process of simulating such models is arduous because unconventional force fields are often needed, and some systems are not in thermal equilibrium. Software for building general coarse-grained simulations at the mesoscale is not available, consequently, the use of such models has remained largely inaccessible. Moltemplate is a program for preparing particle-based coarse-grained molecular simulations in LAMMPS with broad scope and an emphasis on generality. Arbitrary forces between particles may be specified, including motors and many-body forces. Moltemplate accommodates new force descriptors as they are developed, making moltemplate a popular tool with thousands of users in computational chemistry, materials science, and structural biology. To demonstrate its wide functionality, we provide examples of using moltemplate to prepare simulations of many-body fluids, coarse-grained organic semiconductors, and the supercoiling and condensation of an entire bacterial chromosome.


### Citation

A version of this work is in review as follows

Moltemplate: A Tool for Ultra-Coarse-Grained Modeling of Complex Biological Matter and Soft Condensed Matter Physics. Andrew I. Jewett\*, David Stelter, Jason Lambert, Shyam M. Saladi, Otello M. Roscioni, Matteo Ricci, Ludovic Autin, Martina Maritan, Saeed M. Bashusqeh, Tom Keyes, Remus T. Dame, Joan-Emma Shea, Grant J. Jensen, David S. Goodsell\*


### Contributions

Built the continuous integration bits to help avoid bugs/functionality (link to commits)

