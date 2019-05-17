# Causal Inference Final
# Dec 2018
#Roberta Barnett rb4075

#IV analysis
use "/Users/rbarnett/Downloads/ihdp.final.dta"

#1- Intent to treat effect

regress iqsb_36 access

#2- Create an indicator var if ncdct>0
tab ncdct
generate some = ncdct 
replace some = 1 if ncdct>0
replace some = . if missing(ncdct)

#Calculate IV estimate w/ some as treatment and access as instrument
ivreg iqsb_36 (some=access)


#3- Assumptions 

#4- Create indicator for both ncdct and nvisitt 
#remember: instrument only affects outcome thru treatment 
#note: we're assuming here that the instrument only affects outcome thru treatment, but 
#we should acknowledge that it's possible those who are low-propensity users of these services
#find alt services for their children 

tab ncdct 
tab nvisitt

#note: use at least equivalent to 1 year of childcare (assume M-F, so 365-104 days= >261)
#visits: at least 2 per year = 6


generate some_of_both = 0
replace some_of_both = 1 if ncdct>260 & nvisitt>6


#IV analysis 
ivreg iqsb_36 (some_of_both=access)

#5 assumptions in 4
#SUTVA, Ignorability, Monotonicity, Exclusion, Nonzero correlation between treatment and instrument 


#6 we can only have one treatment var that affects the outcome thru the treatment. 

#7
tab access some
tab access some_of_both

##1- 100%
##2- 97% (exclude those who were assigned but not treated)
##4- 86% (exclude those who were assigned but not treated)

#8



############### 

#Propensity Scores
use "/Users/rbarnett/Downloads/ihdp.final2.dta"

#1

#2  

#2.	(Create a variable for child care days 
(ncdct) greater than 350 and call it highdose. Drop observations in the 
treatment group (random=1) with dose less than or equal to 350 
(i.e. for whom highdose=0).


tab ncdct
tab random

gen highdose= 0
replace highdose = 1 if ncdct>350
replace highdose = 0 if random= 1

#dropped random=1 and highdose =0 in R

#3 regression on unmatched sample 
#delimit;
reg ppvtr_36 highdose momblack momhisp momwhite b_marr work_dur prenatal 
first bw bwg preterm b_head momage mom_lths mom_hs mom_scoll mom_coll 
ppvtmom sex nnhealth dadhisp dadblack dadwhite
;

#4
#delimit;
psmatch2 highdose momblack momhisp momwhite b_marr work_dur prenatal 
first bw bwg preterm b_head momage mom_lths mom_hs mom_scoll mom_coll 
ppvtmom sex nnhealth dadhisp dadblack dadwhite
;

#MODEL 1- all vars 
#delimit;
psbal2 momblack momhisp momwhite b_marr work_dur prenatal 
first bw bwg preterm b_head momage mom_lths mom_hs mom_scoll mom_coll 
ppvtmom sex nnhealth dadhisp dadblack dadwhite
;

#MODEL 2- log bw 
gen lbw = log(bw)

#delimit;
psbal2 momblack momhisp momwhite b_marr work_dur prenatal 
first lbw bwg preterm b_head momage mom_lths mom_hs mom_scoll mom_coll 
ppvtmom sex nnhealth dadhisp dadblack dadwhite
;


#MODEL 3- log bw, try logging nnhealth, bhead
gen lnnhealth= log(nnhealth)
gen lb_head = log(b_head)

#delimit;
psbal2 momblack momhisp momwhite b_marr work_dur prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_hs mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite
;

#MODEL 4- add interaction term between work_dur and mom_hs

gen work_hs_int = work_dur*mom_hs

#delimit;
psbal2 momblack momhisp momwhite b_marr work_dur prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_hs mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int
;

#MODEL 5- only interaction term, no work and momhs (best balance)

#delimit;
psbal2 momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int
;


#5
# run model 
#delimit;
psmatch2 highdose momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int
;

psgraph


#6
#delimit;
regress ppvtr_36 highdose momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int [pw=_weight]
;

#7!!!! NOT SURE HERE
scatter _pdif _pscore

psmatch2 treat age educ black hisp married re74 re75, out(re78)

#delimit;
psmatch2 highdose momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int, out(ppvtr_36)
;

#delimit;
regress ppvtr_36 highdose momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int [pw=_weight]
;

#delimit;
regress ppvtr_36 highdose momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int 
;

#delimit;
psmatch highdose momblack momhisp momwhite b_marr prenatal 
first lbw bwg preterm lb_head momage mom_lths mom_scoll mom_coll 
ppvtmom sex lnnhealth dadhisp dadblack dadwhite work_hs_int, out(ppvtr_36)
;
