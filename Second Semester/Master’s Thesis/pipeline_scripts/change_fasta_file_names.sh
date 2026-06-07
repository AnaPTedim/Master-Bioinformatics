#!/bin/zsh

# Este codigo sirve para cambiar los nombre de los assembly al nombre de las cepas y colocarno en un unica carpeta creada previamente.

for i in */; do
    cp "${i}/assembly.fasta" genomes/"${i%/}.fasta"
done
