# Comparative Genomics & Pangenome Analysis of Enterococcus Species

This repository contains the complete production-ready bioinformatic workflow and data-mining scripts developed for my **Master's Thesis in Bioinformatics**. 
The project addresses the genomic assembly, high-throughput characterisation, variant calling, and comparative pangenomics of three major bacterial species:
*Enterococcus faecium*, *Enterococcus faecalis*, and *Enterococcus lactis*.

---

## 📂 Master's Thesis File Architecture

The scripts are structurally classified based on their role in the computational pipeline:

### 1. `pipeline_scripts/` (Automated Bash Operations)
* **`01_qc_assembly/`**: Post-assembly data logistics and naming standardisations across multiple sample directories (`change_fasta_file_names.sh`).
* **`02_typing_characterization/`**: Batch scripts to interface with CGE tools and screen raw sequences against tailored databases:
    * Taxonomic refinement (`compilar_results_kraken.sh`).
    * Plasmidome, Virulome, and Resistome profiling (`plasmid_rep_genomes.sh`, `virulence_genomes.sh`, `resfinder_genomones_efc.sh`, `resfinder_genomones_efm.sh`).
* **`03_mapping_phylogeny_pan/`**: Large-scale comparative genomics and molecular epidemiology utilities:
    * Variant calling pipelines (`bcftools_bucle.sh`, `bcftools_informe.sh`).
    * Genome similarity indexers (`fastANI_bucle.sh`, `fastANI_informe.sh`).
    * High-resolution SNP phylogenies mapping (`snippy_efm.sh`, `snippy_efc.sh`, `snippy_ela.sh`).
    * Targeted validation (`point_finder_cepas_ind.sh`).
    * Accessory genome partitioners and Pangenome input optimization (`strain_diferences.sh`, `archivos_panaroo.sh`).

### 2. `utils_parsing/` (Custom Python Data-Mining Engines)
A collection of Python scripts utilizing *Pandas* and regex patterns to read raw output directories, prune headers, and transform unstructured datasets into tidy epidemiological matrices (0/1 binary presence/absence or quantitative summaries):
* **Sanitisation:** FASTA-header formatting to avoid downstream Biopython syntax conflicts (`cambio_nombres_contigs.py`).
* **QC & Alignment:** Quality scoring (`compilar_quast_results.py`) and mapping depth metrics (`compilar_minimap2.py`).
* **Genomic Characterization:** Compilation matrices for epidemiologic tracing (`compilar_plasmidfinder.py`, `compilar_resfinder.py`, `compilar_pointfinder.py`, `compilar_virulencefinder.py`).
* **Phylogenomics:** Extraction of SNP counts from alignment cores (`compilar_SNPs_snippy.py`).
* **Screening Summaries:** Abricate data aggregation for custom markers (`compilar_bac_abricate.py`, `compilar_gluP_abricate.py`).

---

## 🛠️ Environment Configuration & Dependencies

The processing pipeline relies on standard Conda environments managing the following tools:
* **QC & Assembly:** Unicycler, QUAST, Samtools (v1.19), Minimap2.
* **Epidemiological Characterization:** Kraken2, Abricate, ResFinder, VirulenceFinder, PlasmidFinder, PointFinder.
* **Phylogeny & Evolution:** Snippy, bcftools, fastANI, Panaroo, Gubbins, IQ-TREE.
* **Data Parsing:** Python 3.10+ (Pandas, glob, json, re libraries).

---

## 🚀 Key Operational Highlights

### Contig Optimization & Sanitization
Before clustering analyses, draft assemblies are subjected to structural header standardizations to inject the specific isolate identifier across every single sequence:
```bash
python3 utils_parsing/cambio_nombres_contigs.py
