# Note on NWChem

*NWChem is Northwest Computational Chemistry Package developed at EMSL, PNNL, USA

## NWChem Packages

  All NWChem runtimes will be built by using Intel Parallel Studio XE.

Module  | Description
--------|-------------
NWChem + OpenIB                 | small calculation
NWChem + ARMCI Casper           | medium
NWChem + ARMCI MPI-PR           | medium & large calculations  
NWchem + ARMCI MPI-PR + Casper  | medium

## Recommendation

   Please carefully specify the number of CPU cores (MPI processors) and memory.
Sensible value of CPU cores is like 2, 4, 8, 16, 24, 32, 48, 64, and 96.
Suitable memory (per process) is like 100 MB, 500 MB, and 1000 MB or 1 GB.

For example,
```
memory total 1000 stack 600 mb heap 50 mb global 450 mb"
```

## Normal Usage

1. Interactive Job Submission on Cluster:

    NWChem job can be submitted easily to SGE queue by using "subnwchem" program.
Copy subnwchem from /share/apps/nwchem-6.8/ to your home directory, then execute
subnwchem in the working directory where your NWChem input file is, e.g.
    ```
    subnwchem ex_nwchem.nw
    ```  

    or

    ```
    subnwchem ex_nwchem.nw ex_nwchem.out
    ```

    where `subnwchem` is an interactive NWChem job controller.

2. Single run:

    ```
    /share/apps/nwchem-6.8/nwchem-6.8.1/bin/LINUX64/nwchem ex_nwchem.nw
    ```

3. Parallel run:

    ```
    mpirun -np 4 /share/apps/nwchem-6.8/nwchem-6.8.1/bin/LINUX64/nwchem ex_nwchem.nw
    ```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
