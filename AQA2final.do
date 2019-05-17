//AQA Final 

regress wealthdiff_ inherit i.edu married children unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 race07, robust, [aw= ER34413] if analysissample1==1
regress wealthdiff_ inherit i.edu married ER36020 unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027, robust, [aw= ER34413] if race07==0 & inc3==1 & analysissample1==1 
regress wealthdiff_ inherit i.edu married ER36020 unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027 [aw= ER34413] if race07==1 & inc3==1 & analysissample1==1 
regress wealthdiff_ inherit i.edu married ER36020 unemp urban S803 S805 S809 S811 S813 S819 S807 S815 equity07 ER41027, robust, [aw= ER34413] if race07==1 & inc3==2 & analysissample1==1 


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




