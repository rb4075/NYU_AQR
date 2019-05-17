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




