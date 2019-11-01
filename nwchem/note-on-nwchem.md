# Note on NWChem

*NWChem is Northwest Computational Chemistry Package developed at EMSL, PNNL, USA*

## NWChem Packages

  All NWChem runtimes will be built by using Intel Parallel Studio XE.

Module  | Description
--------|-------------
NWChem + OpenIB                 | small calculation
NWChem + ARMCI Casper           | medium & large calculations
NWChem + ARMCI MPI-PR           | medium & large calculations  
NWchem + ARMCI MPI-PR + Casper  | medium & large calculations

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

    NWChem job can be submitted easily to SGE queue by using **subnwchem**, an interactive NWChem job controller. Clone or copy subnwchem from [my repository](https://github.com/rangsimanketkaew/QM-on-TAIWANIA/blob/master/subnwchem) to your system, and tweak it to satisfy your system and suite your need. 
    Then execute subnwchem in the working directory where your NWChem input file is, e.g.

    ```
    subnwchem ex_nwchem.nw
    ```  

    or

    ```
    subnwchem ex_nwchem.nw ex_nwchem.out
    ```

2. Single run:

    ```
    $NWCHEM_TOP/bin/LINUX64/nwchem INPUT.nw >& OUTPUT &
    ```

3. Parallel run:

    ```
    mpirun -np N $NWCHEM_TOP/bin/LINUX64/nwchem INPUT.nw >& OUTPUT &
    ```

    where *N* is the total number of processing cores.

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
