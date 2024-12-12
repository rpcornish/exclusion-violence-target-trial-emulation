**Do final analysis of exclusions

cd "P:\XXXXXXXXXXXXX\XXXXXXXXXXXX\XXXXXXXXXXXXXX"
clear all

*Put all years together
use y7matchedall
gen year=7
append using y8matchedall
replace year=8 if year>=.
append using y9matchedall
replace year=9 if year>=.
append using y10matchedall
replace year=10 if year>=.
append using y11matchedall
replace year=11 if year>=.
replace censor=. if censor<. & censor-start>365
replace endsv=start+365 if endsv-start>365
replace endh=start+365 if endh-start>365

*Get exact number of suspensions + offences (for adjustment)
merge m:1 pmra using final_formatching
keep if _merge==3
drop _merge
gen susp=0
gen offence=0
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace susp=y`k'_`i'tot if year==`k' & period==`i'
replace offence=y`k'_off`i' if year==`k' & period==`i'
local i=`i'+1
}
local k=`k'+1
}
drop 
save finalmatchedall, replace

gen offencegp=offence
recode offencegp 11/24=10
gen suspgp=susp
recode suspgp 100/400=100

*Drop those from analysis where exclusion and outcome on same day 
gen drop=1 if endsv-start==0 
replace drop=0 if drop~=1
sort start cem_strata drop
replace drop=1 if start==start[_n+1] & cem_strata==cem_strata[_n+1] & drop==0 & drop[_n+1]==1 & exclude[_n+1]==1 & sv[_n+1]==1 & exclude==0

*Serious violence
stset endsv if drop~=1, failure(sv=1) origin(start)
sts graph if drop~=1, by(exclude)
stcox exclude if drop~=1, vce(cluster pmra)
stcox exclude i.year cla cin i.regnum i.schfsm i.bwhite suspgp offencegp if drop~=1, vce(cluster pmra)
stset, clear

*Homicide or near-miss
gen droph=1 if endh-start==0 
replace droph=0 if droph~=1
sort start cem_strata droph
replace droph=1 if start==start[_n+1] & cem_strata==cem_strata[_n+1] & droph==0 & droph[_n+1]==1 & exclude[_n+1]==1 & homn[_n+1]==1 & exclude==0
stset endh if droph~=1, failure(homn=1) origin(start)
sts graph if droph~=1, by(exclude)
stcox exclude if droph~=1, vce(cluster pmra)
stcox exclude cla cin suspgp offencegp if droph~=1, vce(cluster pmra)
stset, clear

*Sensitivity analysis - exclude those where offence took place within one week 
gen dropsens=1 if endsv-start<=7 & exclude==1 & sv==1
replace dropsens=0 if dropsens~=1
sort start cem_strata dropsens
replace dropsens=1 if start==start[_n+1] & cem_strata==cem_strata[_n+1] & dropsens==0 & dropsens[_n+1]==1 & exclude[_n+1]==1 & sv[_n+1]==1 & ex
stset endsv if dropsens~=1, failure(sv=1) origin(start)
stcox exclude if dropsens~=1, vce(cluster pmra)
stcox exclude i.year cla cin i.regnum i.schfsm i.bwhite suspgp offencegp if dropsens~=1, vce(cluster pmra)
stset, clear
