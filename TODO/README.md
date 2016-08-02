# travis
- use travis test plan for private repository
- make branch to not use too much build !! see for build specific branch : https://docs.travis-ci.com/user/customizing-the-build/#Building-Specific-Branches
- build the article and deploy it on github

# README of the project
- Make the section How to reproduce everything: put here all the procedure to reproduce anything

# find a way to test experiment script whithout running them
- ... or not ...

# Makefile
- make experiements

# Install ENV
- do a make install_environment
- so make sh script to install vep
- WHY? because you do not want necessary be in a docker image (travis for exemple). This is possible because they both can start with ubuntu trusty .... see : https://github.com/harshjv/travis-ci-latex-pdf/blob/master/.travis.yml


# Article
- ajouter à l’article l’etude AT (enrichissement etc) (avec la biblio)
- relire (rmk : verifier les ref au figure)
- verifier les notations maths
- verifier certains param de simu

## dernier paragraphe de la section résultats 354 à 347 (modif dans le tex)
- target of selections (tout au pif pour le moment)
- ajouter test enrichissement
- plus la top list
- plus les annotations vep (les stat renvoyé par vep) (reférence)
- ligne 360 : les genes de flowering qu’on trouve (cf horton)

## comparaison avec sNMF
- faire la même que avec TESS3 avec sNMF
