//AQA Final 

///Re-code data on race and income 
"/Users/rbarnett/Desktop/psid data/AQA I Final/AQA Final II.dta"

*create income thirds 2007
xtile inc3 = ER41027, nquantiles(3)
label define inc31 1 "low" 2 "med" 3 "high"
label values inc3 inc31
label var inc3 "income thirds 2007"

*income thirds 2015
xtile inc3_15 = ER65349, nquantiles(3)
label define inc3_151 1 "low" 2 "med" 3 "high"
label values inc3_15 inc3_151
label var inc3_15 "income thirds 2015"

*recoding race white/black
label define ER405651 1 "white" 2 "black" 3 "native" 4 "asian" 5 "pacific" 7 "other" 0 "wild" 9 "N/A"
label values ER40565 ER405651

label define ER648101 1 "white" 2 "black" 3 "native" 4 "asian" 5 "pacific" 7 "other" 9 "N/A"
label values ER64810 ER648101

gen race07 = ER40565 if ER40565 < 3
label var race07 "white or black 2007"
label define race071 0 "." 1 "white" 2 "black"
drop if race07 <1
replace race07 = 0 if race07==1
replace race07 = 1 if race07==2
label def race07 0 "white" 1 "black"


gen race15 = ER64810 if ER64810 < 3
label var race15 "white or black 2015"
replace race15 = 0 if race15==1
replace race15 = 1 if race15==2
label def race15 0 "white" 1 "black"


*generate home equity
gen equity07 = S817-S816
label var equity07 "primary home equity"

gen equity15 = ER65408-ER65406
label var equity15 "primary home equity"


*create 2015 dataset 
drop ER36001 ER36002 ER36017 ER36019 ER36020 ER36023 ER36311 ER36312 ER36314 ER36316
drop ER37705 ER40472 ER40473 ER40474 ER40475 ER40565 ER40566 ER40567
drop ER40568 ER41027 ER41033 ER41033A ER41037 ER41038 S802 S803 S804
drop S805 S806 S807 S808 S809 S810 S811 S813 S814 S815 S818 S819 S816 S817 inc3 race07
*save as a new dataset

*create 2007 dataset
drop ER60001 ER60002 ER60017 ER60019 ER60021 ER60024 ER60366 ER60367 ER60369 ER60371 
drop ER61908 ER64671 ER64672 ER64673 ER64674 ER64810 ER64811 ER64812 ER64813 ER65349
drop ER65350 ER65352 ER65354 ER65356 ER65358 ER65360 ER65362 ER65364 ER65366 ER65368
drop ER65370 ER65372 ER65374 ER65376 ER65378 ER65380 ER65382 ER65384 ER65386 ER65388
drop ER65390 ER65392 ER65394 ER65396 ER65398 ER65400 ER65402 ER65406 ER65408 ER65452
drop ER65453 ER65459 ER65460
drop inc3_15 race15
*save as a new dataset

* examine crosstabs of income and race 
tab inc3 race07
tab inc3_15 race15

/// Find pre and post recession wealth
use "/Users/rbarnett/Desktop/psid data/AQA Final II.dta"
*wealth w/out equity 2007


summarize S816 [aw= ER34413], detail, if race07==1 & inc3==1 & analysissample1==1
summarize S816 [aw= ER34413], detail,if race07==1 & inc3==2 & analysissample1==1
summarize S816 [aw= ER34413], detail,if race07==1 & inc3==3 & analysissample1==1
summarize S816 [aw= ER34413], detail,if race07==0 & inc3==1 & analysissample1==1
summarize S816 [aw= ER34413], detail,if race07==0 & inc3==2 & analysissample1==1
summarize S816 [aw= ER34413], detail,if race07==0 & inc3==3 & analysissample1==1
*wealth with equity 2007
summarize S817 [aw= ER34413], detail,if race07==1 & inc3==1 & analysissample1==1
summarize S817 [aw= ER34413], detail,if race07==1 & inc3==2 & analysissample1==1
summarize S817 [aw= ER34413], detail,if race07==1 & inc3==3 & analysissample1==1
summarize S817 [aw= ER34413], detail,if race07==0 & inc3==1 & analysissample1==1
summarize S817 [aw= ER34413], detail,if race07==0 & inc3==2 & analysissample1==1
summarize S817 [aw= ER34413], detail,if race07==0 & inc3==3 & analysissample1==1

use "/Users/rbarnett/Desktop/psid data/AQA Final II.dta"
*wealth w/out equity 2015

summarize ER65406 [aw= ER34413], detail, if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65406 [aw= ER34413], detail, if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65406 [aw= ER34413], detail, if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65406 [aw= ER34413], detail, if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65406 [aw= ER34413], detail, if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65406 [aw= ER34413], detail, if race15==0 & inc3_15==3 & analysissample1==1
*wealth with equity 2015
summarize ER65408 [aw= ER34413], detail, if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65408 [aw= ER34413], detail, if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65408 [aw= ER34413], detail, if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65408 [aw= ER34413], detail, if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65408 [aw= ER34413], detail, if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65408 [aw= ER34413], detail, if race15==0 & inc3_15==3 & analysissample1==1



summarize S816, detail, if race07==1 & inc3==1 & analysissample1==1
summarize S816 , detail,if race07==1 & inc3==2 & analysissample1==1
summarize S816 , detail,if race07==1 & inc3==3 & analysissample1==1
summarize S816 , detail,if race07==0 & inc3==1 & analysissample1==1
summarize S816 , detail,if race07==0 & inc3==2 & analysissample1==1
summarize S816 , detail,if race07==0 & inc3==3 & analysissample1==1
*wealth with equity 2007
summarize S817 , detail,if race07==1 & inc3==1 & analysissample1==1
summarize S817 , detail,if race07==1 & inc3==2 & analysissample1==1
summarize S817 , detail,if race07==1 & inc3==3 & analysissample1==1
summarize S817 , detail,if race07==0 & inc3==1 & analysissample1==1
summarize S817 , detail,if race07==0 & inc3==2 & analysissample1==1
summarize S817 , detail,if race07==0 & inc3==3 & analysissample1==1

*wealth w/out equity 2015

summarize ER65406 , detail, if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65406 , detail, if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65406 , detail, if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65406 , detail, if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65406 , detail, if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65406 , detail, if race15==0 & inc3_15==3 & analysissample1==1
*wealth with equity 2015
summarize ER65408 , detail, if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65408 , detail, if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65408 , detail, if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65408 , detail, if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65408 , detail, if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65408 , detail, if race15==0 & inc3_15==3 & analysissample1==1


/// Examine asset composition by race and income level 
use "/Users/rbarnett/Desktop/psid data/AQA Final II.dta"
*recode debts for 2015
gen debts = ER65354 + ER65364 + ER65382 + ER65386 + ER65390 + ER65394 + ER65398 + ER65402
label var debts "sum of all debts 15"

use "/Users/rbarnett/Desktop/psid data/AQA Final II.dta"
*asset/debt composition 2007
summarize equity07 if race07==0 & inc3==1
summarize equity07 if race07==0 & inc3==2
summarize equity07 if race07==0 & inc3==3
summarize equity07 if race07==1 & inc3==1
summarize equity07 if race07==1 & inc3==2
summarize equity07 if race07==1 & inc3==3
*farm/business
summarize S803 if race07==1 & inc3==1
summarize S803 if race07==1 & inc3==2
summarize S803 if race07==1 & inc3==3
summarize S803 if race07==0 & inc3==1
summarize S803 if race07==0 & inc3==2
summarize S803 if race07==0 & inc3==3
*checkings/savings
summarize S805 if race07==1 & inc3==1
summarize S805 if race07==1 & inc3==2
summarize S805 if race07==1 & inc3==3
summarize S805 if race07==0 & inc3==1
summarize S805 if race07==0 & inc3==2
summarize S805 if race07==0 & inc3==3
*other real estate
summarize S809 if race07==1 & inc3==1
summarize S809 if race07==1 & inc3==2
summarize S809 if race07==1 & inc3==3
summarize S809 if race07==0 & inc3==1
summarize S809 if race07==0 & inc3==2
summarize S809 if race07==0 & inc3==3
*stocks
summarize S811 if race07==1 & inc3==1
summarize S811 if race07==1 & inc3==2
summarize S811 if race07==1 & inc3==3
summarize S811 if race07==0 & inc3==1
summarize S811 if race07==0 & inc3==2
summarize S811 if race07==0 & inc3==3
*vehicles
summarize S813 if race07==1 & inc3==1
summarize S813 if race07==1 & inc3==2
summarize S813 if race07==1 & inc3==3
summarize S813 if race07==0 & inc3==1
summarize S813 if race07==0 & inc3==2
summarize S813 if race07==0 & inc3==3
*retirement accts
summarize S819 if race07==1 & inc3==1
summarize S819 if race07==1 & inc3==2
summarize S819 if race07==1 & inc3==3
summarize S819 if race07==0 & inc3==1
summarize S819 if race07==0 & inc3==2
summarize S819 if race07==0 & inc3==3
*other assets
summarize S815 if race07==1 & inc3==1
summarize S815 if race07==1 & inc3==2
summarize S815 if race07==1 & inc3==3
summarize S815 if race07==0 & inc3==1
summarize S815 if race07==0 & inc3==2
summarize S815 if race07==0 & inc3==3
*debts
summarize S807 if race07==1 & inc3==1
summarize S807 if race07==1 & inc3==2
summarize S807 if race07==1 & inc3==3
summarize S807 if race07==0 & inc3==1
summarize S807 if race07==0 & inc3==2
summarize S807 if race07==0 & inc3==3


*asset/debt composition 2015
*home equity
summarize equity15 if race15==1 & inc3_15==1
summarize equity15 if race15==1 & inc3_15==2
summarize equity15 if race15==1 & inc3_15==3
summarize equity15 if race15==0 & inc3_15==1
summarize equity15 if race15==0 & inc3_15==2
summarize equity15 if race15==0 & inc3_15==3
*farm/business
summarize ER65352 if race15==1 & inc3_15==1
summarize ER65352 if race15==1 & inc3_15==2
summarize ER65352 if race15==1 & inc3_15==3
summarize ER65352 if race15==0 & inc3_15==1
summarize ER65352 if race15==0 & inc3_15==2
summarize ER65352 if race15==0 & inc3_15==3
*checkings/savings
summarize ER65358 if race15==1 & inc3_15==1
summarize ER65358 if race15==1 & inc3_15==2
summarize ER65358 if race15==1 & inc3_15==3
summarize ER65358 if race15==0 & inc3_15==1
summarize ER65358 if race15==0 & inc3_15==2
summarize ER65358 if race15==0 & inc3_15==3
*other real estate
summarize ER65362 if race15==1 & inc3_15==1
summarize ER65362 if race15==1 & inc3_15==2
summarize ER65362 if race15==1 & inc3_15==3
summarize ER65362 if race15==0 & inc3_15==1
summarize ER65362 if race15==0 & inc3_15==2
summarize ER65362 if race15==0 & inc3_15==3
*stocks
summarize ER65368 if race15==1 & inc3_15==1
summarize ER65368 if race15==1 & inc3_15==2
summarize ER65368 if race15==1 & inc3_15==3
summarize ER65368 if race15==0 & inc3_15==1
summarize ER65368 if race15==0 & inc3_15==2
summarize ER65368 if race15==0 & inc3_15==3
*vehicles
summarize ER65370 if race15==1 & inc3_15==1
summarize ER65370 if race15==1 & inc3_15==2
summarize ER65370 if race15==1 & inc3_15==3
summarize ER65370 if race15==0 & inc3_15==1
summarize ER65370 if race15==0 & inc3_15==2
summarize ER65370 if race15==0 & inc3_15==3
*retirement accts
summarize ER65378 if race15==1 & inc3_15==1
summarize ER65378 if race15==1 & inc3_15==2
summarize ER65378 if race15==1 & inc3_15==3
summarize ER65378 if race15==0 & inc3_15==1
summarize ER65378 if race15==0 & inc3_15==2
summarize ER65378 if race15==0 & inc3_15==3
*other assets
summarize ER65374 if race15==1 & inc3_15==1
summarize ER65374 if race15==1 & inc3_15==2
summarize ER65374 if race15==1 & inc3_15==3
summarize ER65374 if race15==0 & inc3_15==1
summarize ER65374 if race15==0 & inc3_15==2
summarize ER65374 if race15==0 & inc3_15==3
*debts
summarize debts if race15==1 & inc3_15==1
summarize debts if race15==1 & inc3_15==2
summarize debts if race15==1 & inc3_15==3
summarize debts if race15==0 & inc3_15==1
summarize debts if race15==0 & inc3_15==2
summarize debts if race15==0 & inc3_15==3


///Examine social characteristics by race and income level 
use "/Users/rbarnett/Desktop/psid data/AQAfinal07.dta"
*inheritance 
codebook ER37705 if race07==1 & inc3==1
codebook ER37705 if race07==1 & inc3==2
codebook ER37705 if race07==1 & inc3==3
codebook ER37705 if race07==0 & inc3==1
codebook ER37705 if race07==0 & inc3==2
codebook ER37705 if race07==0 & inc3==3
*years of education 
summarize ER41037 if race07==1 & inc3==1
summarize ER41037 if race07==1 & inc3==2
summarize ER41037 if race07==1 & inc3==3
summarize ER41037 if race07==0 & inc3==1
summarize ER41037 if race07==0 & inc3==2
summarize ER41037 if race07==0 & inc3==3
*age
summarize ER36017 if race07==1 & inc3==1
summarize ER36017 if race07==1 & inc3==2
summarize ER36017 if race07==1 & inc3==3
summarize ER36017 if race07==0 & inc3==1
summarize ER36017 if race07==0 & inc3==2
summarize ER36017 if race07==0 & inc3==3
*marital status
codebook ER36023 if race07==1 & inc3==1
codebook ER36023 if race07==1 & inc3==2
codebook ER36023 if race07==1 & inc3==3
codebook ER36023 if race07==0 & inc3==1
codebook ER36023 if race07==0 & inc3==2
codebook ER36023 if race07==0 & inc3==3
*children 
summarize ER36020 if race07==1 & inc3==1
summarize ER36020 if race07==1 & inc3==2
summarize ER36020 if race07==1 & inc3==3
summarize ER36020 if race07==0 & inc3==1
summarize ER36020 if race07==0 & inc3==2
summarize ER36020 if race07==0 & inc3==3
*unemployment
codebook ER36311 if race07==1 & inc3==1
codebook ER36311 if race07==1 & inc3==2
codebook ER36311 if race07==1 & inc3==3
codebook ER36311 if race07==0 & inc3==1
codebook ER36311 if race07==0 & inc3==2
codebook ER36311 if race07==0 & inc3==3
*urban/rural
tab ER41033A if race07==1 & inc3==1
tab ER41033A if race07==1 & inc3==2
tab ER41033A if race07==1 & inc3==3
tab ER41033A if race07==0 & inc3==1
tab ER41033A if race07==0 & inc3==2
tab ER41033A if race07==0 & inc3==3

use "/Users/rbarnett/Desktop/psid data/AQAfinal15.dta"
*inheritance
tab ER61908 if race15==1 & inc3_15==1
tab ER61908 if race15==1 & inc3_15==2
tab ER61908 if race15==1 & inc3_15==3
tab ER61908 if race15==0 & inc3_15==1
tab ER61908 if race15==0 & inc3_15==2
tab ER61908 if race15==0 & inc3_15==3
*years of education ER65459
summarize ER65459 if race15==1 & inc3_15==1
summarize ER65459 if race15==1 & inc3_15==2
summarize ER65459 if race15==1 & inc3_15==3
summarize ER65459 if race15==0 & inc3_15==1
summarize ER65459 if race15==0 & inc3_15==2
summarize ER65459 if race15==0 & inc3_15==3
*age
summarize ER60017 if race15==1 & inc3_15==1
summarize ER60017 if race15==1 & inc3_15==2
summarize ER60017 if race15==1 & inc3_15==3
summarize ER60017 if race15==0 & inc3_15==1
summarize ER60017 if race15==0 & inc3_15==2
summarize ER60017 if race15==0 & inc3_15==3
*marital status
tab ER60024 if race15==1 & inc3_15==1
tab ER60024 if race15==1 & inc3_15==2
tab ER60024 if race15==1 & inc3_15==3
tab ER60024 if race15==2 & inc3_15==1
tab ER60024 if race15==2 & inc3_15==2
tab ER60024 if race15==2 & inc3_15==3
*children
summarize ER60021 if race15==1 & inc3_15==1
summarize ER60021 if race15==1 & inc3_15==2
summarize ER60021 if race15==1 & inc3_15==3
summarize ER60021 if race15==2 & inc3_15==1
summarize ER60021 if race15==2 & inc3_15==2
summarize ER60021 if race15==2 & inc3_15==3
*unemployment
tab ER60366 if race15==1 & inc3_15==1
tab ER60366 if race15==1 & inc3_15==2
tab ER60366 if race15==1 & inc3_15==3
tab ER60366 if race15==2 & inc3_15==1
tab ER60366 if race15==2 & inc3_15==2
tab ER60366 if race15==2 & inc3_15==3
*urban/rural ER65452
tab ER65452 if race15==1 & inc3_15==1
tab ER65452 if race15==1 & inc3_15==2
tab ER65452 if race15==1 & inc3_15==3
tab ER65452 if race15==2 & inc3_15==1
tab ER65452 if race15==2 & inc3_15==2
tab ER65452 if race15==2 & inc3_15==3

*generate pre post wealth difference var 
gen wealthdiff = ER65408-S817
label var wealthdiff "'15 wealth- '07 wealth"

*generate pre post w/ out equity 
gen wealthdiff_ = ER65406-S816
label var wealthdiff_ "'15 wealth- '07 wealth"

*binary wealth difference
gen wealthdiff1 = 0 if wealthdiff<0
replace wealthdiff1 = 1 if wealthdiff>=0
replace wealthdiff1 = . if wealthdiff==.
lab var wealthdiff1 "lost wealth"
lab def binary 0 "0: yes" 1 "1: no"

*percent difference in wealth
gen wealthpd = ((ER65408-S817)/ER65408)*100
label var wealthpd "percent change wealth"

*recode binary vars
*inheritance
tab ER37705
replace ER37705 = 0 if ER37705==5
replace ER37705 = . if ER37705>5
lab def binary 0 "0: none" 1 "1: inheritance"
tab ER37705
*marital status
tab ER36023
replace ER36023 = 1 if ER36023==1
replace ER36023 = 0 if ER36023==2
replace ER36023 = 0 if ER36023==3
replace ER36023 = 0 if ER36023==4
replace ER36023 = 0 if ER36023==5
replace ER36023 = . if ER36023==9
tab ER36023
label def ER36023 0 "0: married" 1 "1: unmarried"
*Unemployed
tab ER36311
replace ER36311 = 0 if ER36311==5
replace ER36311 = . if ER36311==9
label var ER36311 0 "0:no" 1 "1: yes"
tab ER36311
*Urban/Rural
replace ER41033A = . if ER41033A==0
replace ER41033A = 0 if ER41033A==1
replace ER41033A = 0 if ER41033A==2
replace ER41033A = 0 if ER41033A==3
replace ER41033A = 1 if ER41033A==4
replace ER41033A = 1 if ER41033A==5
replace ER41033A = 1 if ER41033A==6
replace ER41033A = 1 if ER41033A==7
replace ER41033A = 1 if ER41033A==8
replace ER41033A = 1 if ER41033A==9
tab ER41033A

*what determines wealth of low income whites?
*for low income whites in 2015, what pre-recession factors best predicted post-recession wealth?

use "/Users/rbarnett/Desktop/psid data/J238854/AQAfinal.dta"
*just social predictors - poor predictors alone 
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==0 & inc3_15==1)
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==1 & inc3_15==1)

*just social predictors- entire population (significant but does not explain a lot of variation in this sample)- 36%
regress ER65408 ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A equity07 race15
rvfplot
*financial (values)r2=55%
regress ER65408 S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
rvfplot
*scatter plot of residuals indicates a clustered pattern
avplots
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S803 S805 S809 S811 S813 S819 S807 S815 if (race15==0 & inc3_15==1)
*corr matrix
graph matrix ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S803 S805 S809 S811 S813 S819 S807 S815 if (race15==1 & inc3_15==1), half maxis(ylabel(none) xlabel(none))
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S803 S805 S809 S811 S813 S819 S807 S815 if (race15==1 & inc3_15==1), robust
*w/out equity r2 worse
regress ER65406 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S803 S805 S809 S811 S813 S819 S807 S815 if (race15==1 & inc3_15==1)
regress ER65406 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S803 S805 S809 S811 S813 S819 S807 S815 if (race15==0 & inc3_15==1)

*regress w/ binary asset variables- poor predict
regress ER65406 S802 S804 S806 S808 S810 S814 S818 ER36311 if (race15==1 & inc3_15==1)
regress ER65406 S802 S804 S806 S808 S810 S814 S818 ER36311 if (race15==0 & inc3_15==1)
*binary asset whole population- poor 
regress ER65406 S802 S804 S806 S808 S810 S814 S818 ER36311
*social and asset vars- ok 33, 45
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S802 S804 S806 S808 S810 S814 S818 equity07 if (race15==1 & inc3_15==1)
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S802 S804 S806 S808 S810 S814 S818 equity07 if (race15==0 & inc3_15==1)
*all cross sections social and asset vars (50%)
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 S802 S804 S806 S808 S810 S814 S818 equity07 race15
regress ER65408 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A ER41027 race15

*percent wealth diff- VERY SMALL R2
regress wealthpd ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==1 & inc3_15==1)
regress wealthpd ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==0 & inc3_15==1)
*just social predictors- r2 very very small 
regress wealthpd ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A race15
*social and financial values (whole dataset)
regress wealthpd ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 race15
*just financial- v small r2
regress wealthpd S803 S805 S809 S811 S813 S819 S807 S815
*social and financial- very small r2
regress wealthpd ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
regress wealthpd ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)



*wealth diff reg- poor social, good predictor w/ finances 
*just social predictors - poor predictors alone 
regress wealthdiff ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==1 & inc3_15==1)
regress wealthdiff ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==0 & inc3_15==1)
*just social predictors- entire population (significant but does not explain a lot of variation in this sample)
regress wealthdiff ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A race15 equity07
*social and financial values (whole dataset)- r2 38%
regress wealthdiff ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 race15
*social and financial (values- good 86 for blacks, 22 for whites)
regress wealthdiff ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
regress wealthdiff ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)


*wealth diff w/ out equity- BEST r2 for blacks
*just social predictors - poor predictors alone 
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==1 & inc3_15==1)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==0 & inc3_15==1)
*just social predictors- entire population- very small r2
regress wealthdiff_ ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A race15
*social and financial values (whole dataset)- r2 51%
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race15
*social and financial (values, low black)- r2 91%
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
*social and financial (values, low white)- r2  30%
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
*robust- similar to above (outliers not very influential- same regression)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1), robust
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1), robust
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race15, robust
*just financial lower for whites
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)


regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
* LR test for welath diff w/ out equity- not significant 
regress wealthdiff_ ER37705 S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
est store A
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 /// 
ER37705#ER37705 c.ER41037#c.ER41037 c.ER36017#c.ER36017 ER36023#ER36023 c.ER36020#c.ER36020 ER36311#ER36311 ER41033A#ER41033A /// 
c.S803#c.S803 c.S805#c.S805 c.S809#c.S809 c.S811#c.S811 c.S813#c.S813 c.S819#c.S819 c.S807#c.S807 c.S815#c.S815 c.equity07#c.equity07 if (race15==1 & inc3_15==1)
est store B
lrtest A B
*LR test whites- not significant 
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
est store A
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 /// 
ER37705#ER37705 c.ER41037#c.ER41037 c.ER36017#c.ER36017 ER36023#ER36023 c.ER36020#c.ER36020 ER36311#ER36311 ER41033A#ER41033A /// 
c.S803#c.S803 c.S805#c.S805 c.S809#c.S809 c.S811#c.S811 c.S813#c.S813 c.S819#c.S819 c.S807#c.S807 c.S815#c.S815 c.equity07#c.equity07 if (race15==0 & inc3_15==1)
est store B
lrtest A B

*regression diagnostics blacks low income
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
predict yhat
predict e, res
twoway (scatter e yhat)
avplots

*regression diagnostics blacks middle income 
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2)
predict yhat
predict e, res
twoway (scatter e yhat)
avplots

*regression whites
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
predict yhat
predict e, res
twoway (scatter e yhat)
avplots

*regression full
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 race07
predict yhat
predict e, res
twoway (scatter e yhat)
avplots

*full skew non norm
kdensity e, normal
sktest e
swilk e
sktest wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 race07

*Black middle income- shorter than normal density curve, but shape correct
kdensity e, normal
*skewness-kurtosis- significant (reject null of normality)
sktest e
*reject null of normality 
swilk e

*Blacks- shorter than normal density curve, but shape correct
kdensity e, normal
*skewness-kurtosis- significant (reject null of normality)
sktest e
*reject null of normality 
swilk e


*extreme cases low income (largest is .037)
predict Cooksd, cooksd
predict standresid, rstandard
predict studente, rstudent
predict leverage, hat
sort Cooksd
list standresid studente leverage if _n <= 5

*extreme cases middle income (largest is .003)
predict Cooksd, cooksd
predict standresid, rstandard
predict studente, rstudent
predict leverage, hat
sort Cooksd
list standresid studente leverage if _n <= 5

*extreme cases full (largest is .0005)
predict Cooksd, cooksd
predict standresid, rstandard
predict studente, rstudent
predict leverage, hat
sort Cooksd
list standresid studente leverage if _n <= 5

*whites- 
*shorter than normal density curve, but shape about correct
kdensity e, normal
*skewness-kurtosis- significant (reject null of normality)
sktest e
*reject null of normality 
swilk e
*extreme cases (largest resid is .009)
predict Cooksd, cooksd
predict standresid, rstandard
predict studente, rstudent
predict leverage, hat
sort Cooksd
list standresid studente leverage if _n <= 5


*exreme cases (full)- hetero
regress wealthdiff_ inherit i.edu married children unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race07 
*extreme cases- the lowest values of studentized residuals occur for cases w/ high leverage mostly. They should not affect parameter estimates too badly.
predict leverage, hat
predict estudent, rstudent
twoway scatter estudent leverage
*heteroskedasiticity
regress wealthdiff_ inherit i.edu married children unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race07 
*residuals vs fitted- some dispersed unevenly (where y and x =0)
rvfplot
*heteroskedastic (significant)
estat hettest
*shows heteroskedasticity not skewness
estat imtest, white


*exreme cases (black low)- not hetero
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1) & Cooksd < 1
*extreme cases- the highest values of studentized residuals occur for cases w/ low leverage, and those with highest leverage are 0. They should not affect parameter estimates too badly.
predict leverage, hat
predict estudent, rstudent
twoway scatter estudent leverage
*heteroskedasiticity
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
*residuals vs fitted- some dispersed unevenly (where y and x =0)
rvfplot
*not heteroskedastic (not significant)
estat hettest
*does not suggest heteroskedasticity nor skewness
estat imtest, white

*exreme cases (black middle)- hetero 
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2) & Cooksd < 1
*extreme cases- the highest values of studentized residuals occur for cases w/ low leverage, and those with highest leverage are 0. They should not affect parameter estimates too badly.
predict leverage, hat
predict estudent, rstudent
twoway scatter estudent leverage
*heteroskedasiticity
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2)
*residuals vs fitted- some dispersed unevenly (mostly cluster where y and x =0)
rvfplot
*heteroskedastic 
estat hettest
*suggests heteroskedasicity + skewness
estat imtest, white

hetero
*extreme cases, white- (dropping hurts the predictive power of the model)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1) & Cooksd < 1
*extreme cases- the highest values of studentized residuals occur for cases w/ low leverage, and those with highest leverage are 0. They should not affect parameter estimates too badly.
predict leverage, hat
predict estudent, rstudent
twoway scatter estudent leverage
*heteroskedasiticity
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
*residuals vs fitted- some dispersed unevenly (where y and x =0)
rvfplot
*heteroskedastic
estat hettest
*suggests heteroskedasticity, not skewness
estat imtest, white

*Fix heteroskedasticity (whites)
*robust
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1), vce(robust)

*Fix heteroskedasticity (middle blacks)
*robust
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2), vce(robust)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2)



*multicollinearity 
*high vifs for S809 (secondary real estate wealth) that is very collinear with the difference in wealth
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
collin wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1), rinv 
*however, if dropped, model explains only 33% of variation in data
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
*LR test- indicates S809 has as significant impact on wealth difference 
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
est store A
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
est store B
lrtest A B

*can try adding S803 and S809 together- doesn't do much to change VIFs
gen S803_9 = S803+S809
label var S803_9 "S803+S809"
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803_9 S805  S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
collin wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803_9 S805 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1), rinv

*center S803 S809- VIFs unchanged 
center S803
center S809
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A c_S803 S805 c_S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
collin wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A c_S803 S805 c_S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1), rinv

*ridge regression
ridgereg wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1), model(orr)

*corr matrix
*all data
pwcorr wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 race15, star(0.05) sig
*low white
pwcorr wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 if (race15==1 & inc3_15==1), star(0.05) sig


*multicollinearity whites
*multicollinearity not a problem
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
collin wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1), rinv 

*multicollinearity mid blacks 
*not an issue
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2)
collin wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==2), rinv 


*multicollinearity all
*not an issue
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 [aw= ER34413]
collin wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07, rinv 

*merge
use "/Users/rbarnett/Desktop/psid data/FAM2007ER.dta"
merge 1:1 ER36002 using "/Users/rbarnett/Desktop/psid data/wlth2007/wlth2007.dta"
use "/Users/rbarnett/Desktop/psid data/fam2007er/FAM2007ER_.dta"
merge m:m ER60009 using "/Users/rbarnett/Desktop/psid data/FAM2015ER.dta"



///Re-code data on race and income 
use "/Users/rbarnett/Desktop/AQRThesisPSID.dta"
* analysis sample
gen analysissample1 = (wealthdiff_!=.)&(inherit!=.)&(edu!=.)&(married!=.)&(children!=.)&(unemp!=.)&(urban!=.)&(S803!=.)&(S805!=.)&(S809!=.)&(S811!=.)&(S813!=.)&(S819!=.)&(S807!=.)&(S815!=.)&(equity07!=.)&(ER41027!=.)&(S819!=.)&(S815!=.)
tab analysissample1, m
analysissample1==1

*create income thirds 2007
xtile inc3 = ER41027, nquantiles(3)
label define inc31 1 "low" 2 "med" 3 "high"
label values inc3 inc31
label var inc3 "income thirds 2007"

*redo based on 2007 income stats
gen inc3 = ER41027
replace inc3 = 1 if ER41027 <= 33488
replace inc3 = 2 if ER41027 > 33488 & ER41027 <= 100466
replace inc3 = 3 if ER41027 > 100466
label var inc3 "income thirds 2007"
tab inc3

*income thirds 2015
xtile inc3_15 = ER65349, nquantiles(3)
label define inc3_151 1 "low" 2 "med" 3 "high"
label values inc3_15 inc3_151
label var inc3_15 "income thirds 2015"

*redo based on 2015 income stats
gen inc3_15 = ER65349
replace inc3_15 = 1 if ER65349 <= 37677
replace inc3_15 = 2 if ER65349 > 37677 & ER65349 <= 113032
replace inc3_15 = 3 if ER65349 > 113032
label var inc3_15 "income thirds 2015"
tab inc3_15

*homeownership 
gen homeown07 = ER36028
replace homeown07=0 if ER36028==1
replace homeown07=1 if ER36028==5
replace homeown07=1 if ER36028==8
replace homeown07=. if ER36028==9
lab def homeown 0 "homeowner" 1 "non-homeowner"
label val homeown07 homeown 
tab homeown07, m

gen homeown15 = ER60030
replace homeown15=0 if ER60030==1
replace homeown15=1 if ER60030==5
replace homeown15=1 if ER60030==8
replace homeown15=. if ER60030==9
label val homeown15 homeown 
tab homeown15, m

*age
gen age07 = ER36017
replace age07 = . if ER36017==999
tab age07, m



*recoding race white/black
label define ER405651 1 "white" 2 "black" 3 "native" 4 "asian" 5 "pacific" 7 "other" 0 "wild" 9 "N/A"
label values ER40565 ER405651

label define ER648101 1 "white" 2 "black" 3 "native" 4 "asian" 5 "pacific" 7 "other" 9 "N/A"
label values ER64810 ER648101

gen race07 = ER40565 
replace race07 = . if ER40565 < 1 | ER40565 >= 3
replace race07 = 0 if ER40565==1
replace race07 = 1 if ER40565==2
label var race07 "white or black 2007"
label define race071 0 "white" 1 "black"
label def race071 0 "white" 1 "black"
label val race07 race071
tab race07, m
tab ER40565, m


gen race15 = ER64810 
replace race15 = . if ER64810 < 1 | ER64810 >= 3
replace race15 = 0 if ER64810==1
replace race15 = 1 if ER64810==2
label var race15 "white or black 2015"
label define race071 0 "white" 1 "black"
label val race15 race071
tab race15, m
label var race15 "white or black 2015"
replace race15 = 0 if ER64810==1
replace race15 = 1 if ER64810==2
label val race15 race071


*generate home equity
gen equity07 = S817-S816
label var equity07 "primary home equity"

gen equity15 = ER65408-ER65406
label var equity15 "primary home equity"


* examine crosstabs of income and race 
tab inc3 race07
tab inc3_15 race15

/// Find pre and post recession wealth
use "/Users/rbarnett/Desktop/psid data/AQA Final II.dta"
*wealth w/out equity 2007
summarize S816 if race07==1 & inc3==1 
summarize S816 if race07==1 & inc3==2 
summarize S816 if race07==1 & inc3==3
summarize S816 if race07==0 & inc3==1 
summarize S816 if race07==0 & inc3==2 
summarize S816 if race07==0 & inc3==3 
*wealth with equity 2007
summarize S817 if race07==1 & inc3==1 
summarize S817 if race07==1 & inc3==2 
summarize S817 if race07==1 & inc3==3
summarize S817 if race07==0 & inc3==1 
summarize S817 if race07==0 & inc3==2 
summarize S817 if race07==0 & inc3==3 

*wealth w/out equity 2015
summarize ER65406 if race07==1 & inc3==1 
summarize ER65406 if race07==1 & inc3==2 
summarize ER65406 if race07==1 & inc3==3 
summarize ER65406 if race07==0 & inc3==1 
summarize ER65406 if race07==0 & inc3==2 
summarize ER65406 if race07==0 & inc3==3 
*wealth with equity 2015
summarize ER65408 if race07==1 & inc3==1 
summarize ER65408 if race07==1 & inc3==2 
summarize ER65408 if race07==1 & inc3==3 
summarize ER65408 if race07==0 & inc3==1 
summarize ER65408 if race07==0 & inc3==2 
summarize ER65408 if race07==0 & inc3==3 


/// Examine asset composition by race and income level 
*recode debts for 2015
gen debts15 = ER65354 + ER65364 + ER65382 + ER65386 + ER65390 + ER65394 + ER65398 + ER65402
label var debts "sum of all debts 15"

use "/Users/rbarnett/Desktop/psid data/AQA Final II.dta"
*asset/debt composition 2007
summarize equity07 if race07==0 & inc3==1 & analysissample1==1 
summarize equity07 if race07==0 & inc3==2 & analysissample1==1
summarize equity07 if race07==0 & inc3==3 & analysissample1==1
summarize equity07 if race07==1 & inc3==1 & analysissample1==1
summarize equity07 if race07==1 & inc3==2 & analysissample1==1
summarize equity07 if race07==1 & inc3==3 & analysissample1==1
*farm/business
summarize S803 if race07==1 & inc3==1 & analysissample1==1
summarize S803 if race07==1 & inc3==2 & analysissample1==1
summarize S803 if race07==1 & inc3==3 & analysissample1==1
summarize S803 if race07==0 & inc3==1 & analysissample1==1
summarize S803 if race07==0 & inc3==2 & analysissample1==1
summarize S803 if race07==0 & inc3==3 & analysissample1==1
*checkings/savings
summarize S805 if race07==1 & inc3==1 & analysissample1==1
summarize S805 if race07==1 & inc3==2 & analysissample1==1
summarize S805 if race07==1 & inc3==3 & analysissample1==1
summarize S805 if race07==0 & inc3==1 & analysissample1==1
summarize S805 if race07==0 & inc3==2 & analysissample1==1
summarize S805 if race07==0 & inc3==3 & analysissample1==1
*other real estate
summarize S809 if race07==1 & inc3==1 & analysissample1==1
summarize S809 if race07==1 & inc3==2 & analysissample1==1
summarize S809 if race07==1 & inc3==3 & analysissample1==1
summarize S809 if race07==0 & inc3==1 & analysissample1==1
summarize S809 if race07==0 & inc3==2 & analysissample1==1
summarize S809 if race07==0 & inc3==3 & analysissample1==1
*stocks
summarize S811 if race07==1 & inc3==1 & analysissample1==1
summarize S811 if race07==1 & inc3==2 & analysissample1==1
summarize S811 if race07==1 & inc3==3 & analysissample1==1
summarize S811 if race07==0 & inc3==1 & analysissample1==1
summarize S811 if race07==0 & inc3==2 & analysissample1==1
summarize S811 if race07==0 & inc3==3 & analysissample1==1
*vehicles
summarize S813 if race07==1 & inc3==1 & analysissample1==1
summarize S813 if race07==1 & inc3==2 & analysissample1==1
summarize S813 if race07==1 & inc3==3 & analysissample1==1
summarize S813 if race07==0 & inc3==1 & analysissample1==1
summarize S813 if race07==0 & inc3==2 & analysissample1==1
summarize S813 if race07==0 & inc3==3 & analysissample1==1
*retirement accts
summarize S819 if race07==1 & inc3==1 & analysissample1==1
summarize S819 if race07==1 & inc3==2 & analysissample1==1
summarize S819 if race07==1 & inc3==3 & analysissample1==1
summarize S819 if race07==0 & inc3==1 & analysissample1==1
summarize S819 if race07==0 & inc3==2 & analysissample1==1
summarize S819 if race07==0 & inc3==3 & analysissample1==1
*other assets
summarize S815 if race07==1 & inc3==1 & analysissample1==1
summarize S815 if race07==1 & inc3==2 & analysissample1==1
summarize S815 if race07==1 & inc3==3 & analysissample1==1
summarize S815 if race07==0 & inc3==1 & analysissample1==1
summarize S815 if race07==0 & inc3==2 & analysissample1==1
summarize S815 if race07==0 & inc3==3 & analysissample1==1
*debts
summarize S807 if race07==1 & inc3==1 & analysissample1==1
summarize S807 if race07==1 & inc3==2 & analysissample1==1
summarize S807 if race07==1 & inc3==3 & analysissample1==1
summarize S807 if race07==0 & inc3==1 & analysissample1==1
summarize S807 if race07==0 & inc3==2 & analysissample1==1
summarize S807 if race07==0 & inc3==3 & analysissample1==1


*asset/debt composition 2015
*home equity
summarize equity15 if race15==1 & inc3_15==1 & analysissample1==1
summarize equity15 if race15==1 & inc3_15==2 & analysissample1==1
summarize equity15 if race15==1 & inc3_15==3 & analysissample1==1
summarize equity15 if race15==0 & inc3_15==1 & analysissample1==1
summarize equity15 if race15==0 & inc3_15==2 & analysissample1==1
summarize equity15 if race15==0 & inc3_15==3 & analysissample1==1
*farm/business
summarize ER65352 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65352 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65352 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65352 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65352 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65352 if race15==0 & inc3_15==3 & analysissample1==1
*checkings/savings
summarize ER65358 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65358 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65358 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65358 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65358 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65358 if race15==0 & inc3_15==3 & analysissample1==1
*other real estate
summarize ER65362 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65362 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65362 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65362 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65362 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65362 if race15==0 & inc3_15==3 & analysissample1==1
*stocks
summarize ER65368 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65368 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65368 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65368 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65368 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65368 if race15==0 & inc3_15==3 & analysissample1==1
*vehicles
summarize ER65370 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65370 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65370 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65370 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65370 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65370 if race15==0 & inc3_15==3 & analysissample1==1
*retirement accts
summarize ER65378 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65378 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65378 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65378 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65378 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65378 if race15==0 & inc3_15==3 & analysissample1==1
*other assets
summarize ER65374 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER65374 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER65374 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER65374 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER65374 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER65374 if race15==0 & inc3_15==3 & analysissample1==1
*debts
summarize debts if race15==1 & inc3_15==1 & analysissample1==1
summarize debts if race15==1 & inc3_15==2 & analysissample1==1
summarize debts if race15==1 & inc3_15==3 & analysissample1==1
summarize debts if race15==0 & inc3_15==1 & analysissample1==1
summarize debts if race15==0 & inc3_15==2 & analysissample1==1
summarize debts if race15==0 & inc3_15==3 & analysissample1==1


///Examine social characteristics by race and income level 
use "/Users/rbarnett/Desktop/psid data/AQAfinal07.dta"
*homeownership 
tab homeown07 if race07==1 & inc3==1 & analysissample1==1
tab homeown07 if race07==1 & inc3==2 & analysissample1==1
tab homeown07 if race07==1 & inc3==3 & analysissample1==1
tab homeown07 if race07==0 & inc3==1 & analysissample1==1
tab homeown07 if race07==0 & inc3==2 & analysissample1==1
tab homeown07 if race07==0 & inc3==3 & analysissample1==1
*inheritance 
tab inherit if race07==1 & inc3==1 & analysissample1==1
tab inherit if race07==1 & inc3==2 & analysissample1==1
tab inherit if race07==1 & inc3==3 & analysissample1==1
tab inherit if race07==0 & inc3==1 & analysissample1==1
tab inherit if race07==0 & inc3==2 & analysissample1==1
tab inherit if race07==0 & inc3==3 & analysissample1==1
*years of education 
summarize yrsedu if race07==1 & inc3==1 & analysissample1==1
summarize yrsedu if race07==1 & inc3==2 & analysissample1==1
summarize yrsedu if race07==1 & inc3==3 & analysissample1==1
summarize yrsedu if race07==0 & inc3==1 & analysissample1==1
summarize yrsedu if race07==0 & inc3==2 & analysissample1==1
summarize yrsedu if race07==0 & inc3==3 & analysissample1==1
*age
summarize age07 if race07==1 & inc3==1 & analysissample1==1
summarize age07 if race07==1 & inc3==2 & analysissample1==1
summarize age07 if race07==1 & inc3==3 & analysissample1==1
summarize age07 if race07==0 & inc3==1 & analysissample1==1
summarize age07 if race07==0 & inc3==2 & analysissample1==1
summarize age07 if race07==0 & inc3==3 & analysissample1==1
*marital status
tab ER36023 if race07==1 & inc3==1 & analysissample1==1
tab ER36023 if race07==1 & inc3==2 & analysissample1==1
tab ER36023 if race07==1 & inc3==3 & analysissample1==1
tab ER36023 if race07==0 & inc3==1 & analysissample1==1
tab ER36023 if race07==0 & inc3==2 & analysissample1==1
tab ER36023 if race07==0 & inc3==3 & analysissample1==1
*children 
summarize ER36020 if race07==1 & inc3==1 & analysissample1==1
summarize ER36020 if race07==1 & inc3==2 & analysissample1==1
summarize ER36020 if race07==1 & inc3==3 & analysissample1==1
summarize ER36020 if race07==0 & inc3==1 & analysissample1==1
summarize ER36020 if race07==0 & inc3==2 & analysissample1==1
summarize ER36020 if race07==0 & inc3==3 & analysissample1==1
*unemployment
tab ER36311 if race07==1 & inc3==1 & analysissample1==1
tab ER36311 if race07==1 & inc3==2 & analysissample1==1
tab ER36311 if race07==1 & inc3==3 & analysissample1==1
tab ER36311 if race07==0 & inc3==1 & analysissample1==1
tab ER36311 if race07==0 & inc3==2 & analysissample1==1
tab ER36311 if race07==0 & inc3==3 & analysissample1==1
*urban/rural
tab urban if race07==1 & inc3==1 & analysissample1==1
tab urban if race07==1 & inc3==2 & analysissample1==1
tab urban if race07==1 & inc3==3 & analysissample1==1
tab urban if race07==0 & inc3==1 & analysissample1==1
tab urban if race07==0 & inc3==2 & analysissample1==1
tab urban if race07==0 & inc3==3 & analysissample1==1

*homeownership 
tab homeown15 if race15==1 & inc3_15==1 & analysissample1==1
tab homeown15 if race15==1 & inc3_15==2 & analysissample1==1
tab homeown15 if race15==1 & inc3_15==3 & analysissample1==1
tab homeown15 if race15==0 & inc3_15==1 & analysissample1==1
tab homeown15 if race15==0 & inc3_15==2 & analysissample1==1
tab homeown15 if race15==0 & inc3_15==3 & analysissample1==1
*inheritance
tab ER61908 if race15==1 & inc3_15==1 & analysissample1==1
tab ER61908 if race15==1 & inc3_15==2 & analysissample1==1
tab ER61908 if race15==1 & inc3_15==3 & analysissample1==1
tab ER61908 if race15==0 & inc3_15==1 & analysissample1==1
tab ER61908 if race15==0 & inc3_15==2 & analysissample1==1
tab ER61908 if race15==0 & inc3_15==3 & analysissample1==1
*years of education ER65459
summarize yrsedu15 if race15==1 & inc3_15==1 & analysissample1==1
summarize yrsedu15 if race15==1 & inc3_15==2 & analysissample1==1
summarize yrsedu15 if race15==1 & inc3_15==3 & analysissample1==1
summarize yrsedu15 if race15==0 & inc3_15==1 & analysissample1==1
summarize yrsedu15 if race15==0 & inc3_15==2 & analysissample1==1
summarize yrsedu15 if race15==0 & inc3_15==3 & analysissample1==1
*age
summarize ER60017 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER60017 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER60017 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER60017 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER60017 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER60017 if race15==0 & inc3_15==3 & analysissample1==1
*marital status
tab ER60024 if race15==1 & inc3_15==1 & analysissample1==1
tab ER60024 if race15==1 & inc3_15==2 & analysissample1==1
tab ER60024 if race15==1 & inc3_15==3 & analysissample1==1
tab ER60024 if race15==0 & inc3_15==1 & analysissample1==1
tab ER60024 if race15==0 & inc3_15==2 & analysissample1==1
tab ER60024 if race15==0 & inc3_15==3 & analysissample1==1
*children
summarize ER60021 if race15==1 & inc3_15==1 & analysissample1==1
summarize ER60021 if race15==1 & inc3_15==2 & analysissample1==1
summarize ER60021 if race15==1 & inc3_15==3 & analysissample1==1
summarize ER60021 if race15==0 & inc3_15==1 & analysissample1==1
summarize ER60021 if race15==0 & inc3_15==2 & analysissample1==1
summarize ER60021 if race15==0 & inc3_15==3 & analysissample1==1
*unemployment
tab ER60366 if race15==1 & inc3_15==1 & analysissample1==1
tab ER60366 if race15==1 & inc3_15==2 & analysissample1==1
tab ER60366 if race15==1 & inc3_15==3 & analysissample1==1
tab ER60366 if race15==0 & inc3_15==1 & analysissample1==1
tab ER60366 if race15==0 & inc3_15==2 & analysissample1==1
tab ER60366 if race15==0 & inc3_15==3 & analysissample1==1
*urban/rural ER65452
tab ER65452 if race15==1 & inc3_15==1 & analysissample1==1
tab ER65452 if race15==1 & inc3_15==2 & analysissample1==1
tab ER65452 if race15==1 & inc3_15==3 & analysissample1==1
tab ER65452 if race15==0 & inc3_15==1 & analysissample1==1
tab ER65452 if race15==0 & inc3_15==2 & analysissample1==1
tab ER65452 if race15==0 & inc3_15==3 & analysissample1==1

*generate pre post wealth difference var 
gen wealthdiff = ER65408-S817
label var wealthdiff "'15 wealth- '07 wealth"

*generate pre post w/ out equity 
gen wealthdiff_ = ER65406-S816
label var wealthdiff_ "'15 wealth- '07 wealth"

*binary wealth difference
gen wealthdiff1 = 0 if wealthdiff<0
replace wealthdiff1 = 1 if wealthdiff>=0
replace wealthdiff1 = . if wealthdiff==.
lab var wealthdiff1 "lost wealth"
lab def binary 0 "0: yes" 1 "1: no"

*percent difference in wealth
gen wealthpd = ((ER65408-S817)/ER65408)*100
label var wealthpd "percent change wealth"

*recode binary vars
*inheritance
tab ER37705
gen inherit = ER37705
replace inherit = 0 if ER37705==5
replace inherit = . if ER37705>5
lab def binary 0 "0: none" 1 "1: inheritance"
tab inherit, m

*marital status
tab ER36023
gen married = ER36023
replace married = 1 if ER36023==1
replace married = 0 if ER36023==2
replace married = 0 if ER36023==3
replace married = 0 if ER36023==4
replace married = 0 if ER36023==5
replace married = . if ER36023>=8
tab married, m
label def m 0 "0: unmarried" 1 "1: married"
*Unemployed
tab ER36311
gen unemp = ER36311
replace unemp = 1 if ER36311==1
replace unemp = 0 if ER36311==5
replace unemp = . if ER36311==9
label var unemp "unemployed lst yr" 
label def unemp 0 "no" 1 "yes"
tab unemp, m
*Urban/Rural
gen urban = ER41033A
replace urban = . if ER41033A==0
replace urban = . if ER41033A==99
replace urban = 0 if ER41033A==1
replace urban = 0 if ER41033A==2
replace urban = 0 if ER41033A==3
replace urban = 1 if ER41033A==4
replace urban = 1 if ER41033A==5
replace urban = 1 if ER41033A==6
replace urban = 1 if ER41033A==7
replace urban = 1 if ER41033A==8
replace urban = 1 if ER41033A==9
tab urban, m
lab var urban "urban/rural" 
label define urban0 0 "0: urban" 1 "1: rural"
label val urban urban0 
tab urban, m

*Edu 
gen yrsedu = ER41037
replace yrsedu = . if ER41037==99
tab yrsedu, m

gen yrsedu15 = ER65459
replace yrsedu15 = . if ER65459==99
tab yrsedu15, m

*edu cat
gen edu = ER41037
replace edu = . if ER41037==99
replace edu = 1 if ER41037<12
replace edu = 2 if ER41037==12
replace edu = 3 if ER41037>12&ER41037<16
replace edu = 4 if ER41037==16 | ER41037==17
label var edu "completed edu"
label define edu1 1 "1: Less than HS" 2 "2: HS or equiv" 3 "3: some coll, tech" 4 "4: coll or grad"
label val edu edu1
tab edu, m
*children 
gen children = ER36020


*what determines wealth of low income whites?
*for low income whites in 2015, what pre-recession factors best predicted post-recession wealth?

use "/Users/rbarnett/Desktop/psid data/J238854/AQAfinal.dta"
*wealth diff w/ out equity- BEST r2 for blacks
*just social predictors - poor predictors alone 
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==1 & inc3_15==1)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A if (race15==0 & inc3_15==1)
*just social predictors- entire population- very small r2
regress wealthdiff_ ER40565 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A race15
*social and financial values (whole dataset)- r2 51%
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race15
*social and financial (values, low black)- r2 91%
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
*social and financial (values, low white)- r2  30%
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)
*robust- similar to above (outliers not very influential- same regression)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1), robust
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1), robust
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race15, robust
*just financial lower for whites
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==1 & inc3_15==1)
regress wealthdiff_ ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 if (race15==0 & inc3_15==1)


///FINAL MODELS

regress wealthdiff_ inherit i.edu married children unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race07, robust, [aw= ER34413] if analysissample1==1
regress wealthdiff_ inherit i.edu married ER36020 unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027, robust, [aw= ER34413] if race07==0 & inc3==1 & analysissample1==1 
regress wealthdiff_ inherit i.edu married ER36020 unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 [aw= ER34413] if race07==1 & inc3==1 & analysissample1==1 
regress wealthdiff_ inherit i.edu married ER36020 unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027, robust, [aw= ER34413] if race07==1 & inc3==2 & analysissample1==1 



***** PROPENSITY SCORE WEIGHTING 

regress wealthdiff ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race15

regress 
psmatch2 homeown07 S808 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 ER41027, out(wealthdiff_) logit
psbal2 S808 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 ER41027




teffects psmatch (wealthdiff) (homeown07 ER41027 race15)
psmatch2 homeown07 race15 inc3, out(lostwealth) logit ate
psmatch2 homeown07 race15 inc3, out(wealthdiff) logit ate

psmatch2 homeown07 race15 inc3 S816 edu married urban unemp, out(lostwealth) logit ate
psmatch2 homeown07 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027, out(wealthdiff) logit ate

*** Dichotomize homeownership
gen homeown07 = ER36028
replace homeown07 = 0 if ER36028>1
lab var homeown07 "Homeownership 2007"
lab def yesno 1 Yes 0 No, modify
lab val homeown07 yesno
tab homeown07, m

*** 
gen lostwealth = wealthdiff_
replace lostwealth = 0 if wealthdiff_<=0
replace lostwealth = 1 if wealthdiff_>0
replace lostwealth = . if wealthdiff_==.
lab def yesno 1 Yes 0 No, modify
lab val lostwealth yesno
tab lostwealth, m

** lost second home how many
tab S808 if ER65360==0
tab S808 if ER65360==0 & race15==0 & inc3==1
tab S808 if ER65360==0 & race15==1 & inc3==1
tab S808 if ER65360==0 & race15==0 & inc3==2
tab S808 if ER65360==0 & race15==1 & inc3==2
tab S808 if ER65360==0 & race15==0 & inc3==3
tab S808 if ER65360==0 & race15==1 & inc3==3

gen logS816= log(S816)

gen edumarr=  edu*married 

gen marrunemp = married*unemp

gen logequity= log(equity07)

gen incrace= inc3*race15

gen incedu= inc3*edu

gen loginc= log(ER41027)

gen loginc2= loginc^2

gen logincsq= sqrt(loginc)


gen lninc= ln(ER41027)


** second home 
psmatch2 S808 race15 inc3 S816 edu married urban unemp homeown07, out(lostwealth) logit

psbal2 race15 inc3 S816 edu married urban unemp homeown07


psmatch2 S808 homeown07 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 ER41027, out(wealthdiff) logit 

psbal2 homeown07 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 ER41027



psmatch2 S808 homeown07 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 ER41027, out(wealthdiff_) logit ate

psmatch2 S808 homeown07 race15 ER37705 ER41037 ER36017 ER36023 ER36020 ER36311 ER41033A S803 S805 S811 S813 S819 S807 S815 equity07 ER41027, out(lostwealth) logit ate






psmatch2 S808 race15 inc3 S816 edu married urban unemp homeown07 equity07, out(wealthdiff) logit 

psbal2 race15 inc3 S816 edu married urban unemp homeown07 equity07

psmatch2 S808 race15 inc3 logS816 edu married urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu married urban unemp homeown07

*log wealth

psmatch2 S808 race15 inc3 logS816 edu married urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu married urban unemp homeown07

*add back equity

psmatch2 S808 race15 inc3 logS816 edu married urban unemp homeown07 equity07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu married urban unemp homeown07 equity07

*del married

psmatch2 S808 race15 inc3 logS816 edu urban unemp homeown07 equity07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu urban unemp homeown07 equity07

*married edu interaction

psmatch2 S808 race15 inc3 logS816 edu urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu urban unemp homeown07

psmatch2 S808 race15 inc3 logS816 edumarr married edu urban unemp homeown07 equity07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edumarr married edu urban unemp homeown07 equity07


psmatch2 S808 race15 inc3 logS816 edumarr married edu urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edumarr married edu urban unemp homeown07 

*log equity

psmatch2 S808 race15 inc3 logS816 edu married urban unemp homeown07 logequity, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu married urban unemp homeown07 logequity


*married unemp interaction + log equity

psmatch2 S808 race15 inc3 logS816 edu married marrunemp urban unemp homeown07 logequity, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu married marrunemp urban unemp homeown07 logequity


*married unemp interaction + log equity + drop married

psmatch2 S808 race15 inc3 logS816 edu marrunemp urban unemp homeown07 logequity, out(wealthdiff) logit 

psbal2 race15 inc3 logS816 edu marrunemp urban unemp homeown07 logequity


*married unemp interaction + log equity + drop married + incrace- NOPE

psmatch2 S808 race15 incrace logS816 edu marrunemp urban unemp homeown07 logequity, out(wealthdiff) logit 

psbal2 race15 incrace logS816 edu marrunemp urban unemp homeown07 logequity

*married unemp interaction + log equity + drop married + incrace- NOPE

psmatch2 S808 race15 incrace logS816 edu marrunemp urban unemp homeown07 logequity, out(wealthdiff) logit 

psbal2 race15 incrace logS816 edu marrunemp urban unemp homeown07 logequity


*married unemp interaction + log equity + drop married + income

psmatch2 S808 race15 ER41027 logS816 edu marrunemp urban unemp homeown07 logequity, out(wealthdiff) logit 

psbal2 race15 ER41027 logS816 edu marrunemp urban unemp homeown07 logequity

*married unemp interaction + log equity + drop married + income

psmatch2 S808 race15 loginc logS816 edu marrunemp urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 loginc logS816 edu marrunemp urban unemp homeown07

*married unemp interaction + log equity + drop married + lnincome

psmatch2 S808 race15 lninc logS816 edu marrunemp urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 lninc logS816 edu marrunemp urban unemp homeown07

*married unemp interaction + log equity + drop married + log sqrt inc- GETS BALANCE

psmatch2 S808 race15 logincsq logS816 edu marrunemp urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 logincsq logS816 edu marrunemp urban unemp homeown07


*married unemp interaction + drop married + log sqrt inc- GETS BALANCE

psmatch2 S808 race15 logincsq logS816 edu marrunemp urban unemp homeown07, out(wealthdiff) logit 

psbal2 race15 logincsq logS816 edu marrunemp urban unemp homeown07

*married unemp interaction + drop married + log sqrt inc- GETS BALANCE

psmatch2 S808 race15 logincsq logS816 edu marrunemp urban unemp homeown07 inherit, out(wealthdiff) logit ate

psbal2 race15 logincsq logS816 edu marrunemp urban unemp homeown07 inherit


*married unemp interaction + drop married + log sqrt inc- LOST WEALTH

psmatch2 S808 race15 logincsq logS816 edu marrunemp urban unemp homeown07 inherit, out(lostwealth) logit ate 

psbal2 race15 logincsq logS816 edu marrunemp urban unemp homeown07 inherit


*overlap doesn't look as good bc high # of untreated, but it's okay in reality
psgraph2


regress lostwealth S808 race15 logincsq logS816 edu marrunemp urban unemp homeown07 inherit [pw=_weight]

regress wealthdiff S808 race15 logincsq logS816 edu marrunemp urban unemp homeown07 inherit [pw=_weight]


