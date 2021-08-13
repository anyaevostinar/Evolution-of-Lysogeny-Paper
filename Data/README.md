This folder contains the configuration and scripts for generating the data. The data itself is too much to fit onto GitHub, but with these two files for each treatment, you should be able to regenerate all data.

To regenerate the data in a folder, first make the executable of Symbulation in SymbulationEmp, then go into the folder of interest and run
```
python3 simple_repeat.py
```

## ChanceOfInductionMutationTest
Started on 8/6/21, this run was intended to check that the addition of lysogenic induction did not significantly change the evolutionary dynamics. It tested three different prophage loss rates (0.0, 0.025, and 0.05) with two different starting chances of induction (0 and 0.1). The chance of induction was permitted to mutate.