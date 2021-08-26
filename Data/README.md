This folder contains the configuration and scripts for generating the data. The data itself is too much to fit onto GitHub, but with these two files for each treatment, you should be able to regenerate all data.

To regenerate the data in a folder, first make the executable of Symbulation in SymbulationEmp, then go into the folder of interest and run
```
python3 simple_repeat.py
```
## InductionOff_BenefitOn_NonRandomIncVals
Started on 8/26/21, this run isolates the effect of the benefit without including induction. We use three prophage loss rates (0.0, 0.025, and 0.05) with a constant host incorporation value of 1 and starting phage incorporation values of 1.0, 0.5, and 0.0. Both incorporation values were permitted to mutate and benefit to the host was on. We set the chance of induction to 0 for all phage and do not allow it to mutate.

## InductionOn_BenefitOff
Started on 8/23/21, this run was intended to verify that the system behavior stayed the same before and after implementing a potential benefit to the host from lysogenic phage. In this run, that benefit has been switched off via the config setting. The data, when graphed, should be the same as the data in ChanceOfInductionMutationTest.

## InductionOn_BenefitOn_NonRandomIncVals
Started on 8/17/21, this run was intended to see the effect of lysogenic phage helping or hurting their hosts through resource availability. It tested three different prophage loss rates (0.0, 0.025, and 0.05) with a constant host incorporation value of 1 and starting phage incorporation values of 1.0, 0.5, and 0.0. Both incorporation values were permitted to mutate and benefit to the host was on.

## InductionOn_BenefitOn_NonRandomIncVals_Extended
Started on 8/26/21, this run is an extension of the experiment ran in InductionOn_BenefitOn_NonRandomIncVals. This means we used the same settings and setup, but for twice the amount of updates and 30 seeds rather than 10 seeds.

## InductionOn_BenefitOn_RandomIncVals
Started on 8/24/21, this run was intended to see the effect of lysogenic phage helping or hurting their hosts through resource availability when the populations of phage and bacteriums start with a random distribution of incorporation vals. It was run with three prophage loss rates (0.0, 0.025, and 0.05). The incorporation values, chance of lysis, and chance of induction all had mutations enabled and the benefit to the host was on.

## InductionOn_NoBenefit_Test
Started on 8/6/21, this run was intended to check that the addition of lysogenic induction did not significantly change the evolutionary dynamics. It tested three different prophage loss rates (0.0, 0.025, and 0.05) with two different starting chances of induction (0 and 0.1). The chance of induction was permitted to mutate.