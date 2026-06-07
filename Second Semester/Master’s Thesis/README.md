# Comparative Genomics & Pangenome Analysis of Enterococcus Species

This repository contains the complete production-ready bioinformatic workflow and data-mining scripts developed for my **Master's Thesis in Bioinformatics**. 
The project addresses the genomic assembly, high-throughput characterisation, variant calling, and comparative pangenomics of three major bacterial species:
*Enterococcus faecium*, *Enterococcus faecalis*, and *Enterococcus lactis*.

---

## 📂 Master's Thesis File Architecture

### 1. `Codigo_TFM_final.txt` (Comprehensive Reference Manual)
This file contains the macro log and extended logical sequence of all global commands executed throughout the thesis. 

### 2. `pipeline_scripts/` (Automated Bash Operations)
* Post-assembly data logistics and naming standardisations across multiple sample directories (`change_fasta_file_names.sh`).
*  Batch scripts to interface with CGE tools and screen raw sequences against tailored databases:
    * Taxonomic refinement (`compilar_results_kraken.sh`).
    * Plasmidome, Virulome, and Resistome profiling (`plasmid_rep_genomes.sh`, `virulence_genomes.sh`, `resfinder_genomones_efc.sh`, `resfinder_genomones_efm.sh`).
* Large-scale comparative genomics and molecular epidemiology utilities:
    * Variant calling pipelines (`bcftools_bucle.sh`, `bcftools_informe.sh`).
    * Genome similarity indexers (`fastANI_bucle.sh`, `fastANI_informe.sh`).
    * High-resolution SNP phylogenies mapping (`snippy_efm.sh`, `snippy_efc.sh`, `snippy_ela.sh`).

### 3. `utils_parsing/` (Custom Python Data-Mining Engines)
A collection of Python scripts utilising *Pandas* and regex patterns to read raw output directories, prune headers, and transform unstructured datasets into tidy epidemiological matrices (0/1 binary presence/absence or quantitative summaries):
* FASTA-header formatting to avoid downstream Biopython syntax conflicts (`cambio_nombres_contigs.py`).
* Quality scoring (`compilar_quast_results.py`) and mapping depth metrics (`compilar_minimap2.py`).
* Compilation matrices for epidemiologic tracing (`compilar_plasmidfinder.py`, `compilar_resfinder.py`, `compilar_pointfinder.py`, `compilar_virulencefinder.py`).
* Extraction of SNP counts from alignment cores (`compilar_SNPs_snippy.py`).
* Abricate data aggregation for custom markers (`compilar_bac_abricate.py`, `compilar_gluP_abricate.py`).
* Before clustering analyses, draft assemblies are subjected to structural header standardisations to inject the specific isolate identifier across every single sequence: (`utils_parsing/cambio_nombres_contigs.py`)
