***To generate matched files ready for analysis

**Data files containing covariates are from previous work 

cd "P:\XXXXXXXX\XXXXXXXX\XXXXXXXXXX"

use final_formatching7
*Fixed covariates (ethnicity, gender, KS2 attainment etc)
merge 1:1 pmra using covars_fixed
keep if _merge==3
drop _merge
*Percent unauthorised absence in each year
merge 1:1 pmra using absence_derived
keep if _merge==3
drop _merge y7punauth y8punauth y9punauth y10punauth
rename y6punauth absence
*Free school meals, SEN status, IDACI scores 
merge 1:1 pmra using fsmsenidaci_clean
keep if _merge==3
rename fsm6 fsm 
rename idaci6 idaci
rename sengp6 sengp
replace idaci=idaci7 if idaci>=.
replace sengp=sengp7 if sengp>=.
replace fsm=fsm7 if fsm>=.
drop _merge fsm7-sengp10
xtile idaciq=idaci, nq(5)
*Child looked after status 
merge 1:1 pmra using cla_derived
drop if _merge==2
drop _merge cla7-cla10 agefirstcla
rename cla6 cla
replace cla=0 if cla>=.
replace clab6=0 if clab6>=.
*Child in need status
merge 1:1 pmra using cin_derived
drop if _merge==2
drop cin7-cin10 _merge
rename cin6 cin
replace cin=0 if cin>=.
replace cinb6=0 if cinb6>=.
*Merge with school-level variables (%FSM, %White British)
merge 1:1 pmra using schoolautumn1
drop if _merge==2
drop _merge lea8-whiteb11 
rename lea7 lea 
rename urn7 urn
rename fsmsch7 fsmsch
rename whiteb7 whiteb
*Recode number of previous offences and total duration of suspensions as both skewed 
recode y7_off1 y7_off2 y7_off3 y7_off4 y7_off5 y7_off6 y7_off7 y7_off8 y7_off9 y7_off10 y7_off11 y7_off12 (1/15=1)
recode y7_off13 y7_off14 y7_off15 y7_off16 y7_off17 y7_off18 y7_off19 (1/15=1)
recode y7_off20 y7_off21 y7_off22 (2/15=2)
recode y7_1tot y7_2tot y7_3tot y7_4tot y7_5tot y7_6tot y7_7tot y7_8tot y7_9tot y7_10tot y7_11tot (2/3=1) (4/9=2) (10/19=3) (20/500=4)
recode y7_12tot y7_13tot y7_14tot y7_15tot y7_16tot y7_17tot y7_18tot y7_19tot y7_20tot y7_21tot y7_22tot (2/3=1) (4/9=2) (10/19=3) (20/500=4)
merge 1:1 pmra using y7start
keep if _merge==3
drop _merge
replace year7=year(y7start) if year7>=.
replace fsmsch=. if fsmsch>100
xtile schfsm=fsmsch, nq(5)
xtile bwhite=whiteb, nq(5)
*Get region
merge m:1 lea using lea_region
drop if _merge==2
drop _merge
*Group percent absence 
gen absgp=absence
recode absgp (1/4=1) (5/9=2) (10/100=3)
egen regnum=group(region)
*Make London reference group
recode regnum (3=0)
**Generate indicator for any missing covariate data
egen y7miss=rowmiss(sex ethnic ks2q absence fsm idaciq sengp cla cin urn lea year7 fsmsch whiteb)
drop if year7==2006
compress
save final_formatching7, replace

**REPEAT FOR EACH SCHOOL YEAR
use final_formatching8
merge 1:1 pmra using covars_fixed
keep if _merge==3
drop _merge
merge 1:1 pmra using absence_derived
keep if _merge==3
rename y7punauth absence
replace absence=y6punauth if absence>=. & y6punauth<.
drop _merge y6punauth y8punauth y9punauth y10punauth
merge 1:1 pmra using fsmsenidaci_clean
keep if _merge==3
rename fsm7 fsm 
rename idaci7 idaci
rename sengp7 sengp
replace idaci=idaci6 if idaci>=.
replace sengp=sengp6 if sengp>=.
replace fsm=fsm6 if fsm>=.
replace idaci=idaci8 if idaci>=.
replace sengp=sengp8 if sengp>=.
replace fsm=fsm8 if fsm>=.
drop _merge fsm6 sengp6 idaci6 fsm8-sengp10
xtile idaciq=idaci, nq(5)
merge 1:1 pmra using cla_derived
drop if _merge==2
rename cla7 cla
replace cla=0 if cla>=.
replace clab6=0 if clab6>=.
drop _merge cla6 cla8-cla10 agefirstcla
merge 1:1 pmra using cin_derived
drop if _merge==2
drop cin6 cin8-cin10 _merge
rename cin7 cin
replace cin=0 if cin>=.
replace cinb6=0 if cinb6>=.
merge 1:1 pmra using schoolautumn1
drop if _merge==2
rename lea8 lea 
rename urn8 urn
rename fsmsch8 fsmsch
rename whiteb8 whiteb
replace lea=lea7 if lea>=.
replace urn=urn7 if urn>=.
replace fsmsch=fsmsch7 if fsmsch>=.
replace whiteb=whiteb7 if whiteb>=.
drop _merge lea7 urn7 fsmsch7 whiteb7 lea9-whiteb11 
*Recode number of previous offences and total duration of suspensions as both skewed 
recode y8_off1 y8_off2 y8_off3 y8_off4 y8_off5 y8_off6 y8_off7 y8_off8 y8_off9 y8_off10 y8_off11 y8_off12 (2/30=2)
recode y8_off13 y8_off14 y8_off15 y8_off16 y8_off17 y8_off18 y8_off19 y8_off20 y8_off21 y8_off22 (2/30=2)
recode y8_1tot y8_2tot y8_3tot y8_4tot y8_5tot y8_6tot y8_7tot y8_8tot y8_9tot y8_10tot y8_11tot (2/3=1) (4/9=2) (10/19=3) (20/500=4)
recode y8_12tot y8_13tot y8_14tot y8_15tot y8_16tot y8_17tot y8_18tot y8_19tot y8_20tot y8_21tot y8_22tot (2/3=1) (4/9=2) (10/19=3) (20/500=4)
merge 1:1 pmra using y7start
keep if _merge==3
drop _merge
replace year7=year(y7start) if year7>=.
replace fsmsch=. if fsmsch>100
xtile schfsm=fsmsch, nq(5)
xtile bwhite=whiteb, nq(5)
merge m:1 lea using lea_region
drop if _merge==2
drop _merge
*Group absence (quartiles not sensible)
gen absgp=absence
recode absgp (1/4=1) (5/9=2) (10/100=3)
egen regnum=group(region)
*Make London reference group
recode regnum (3=0)
egen y8miss=rowmiss(sex ethnic ks2q absence fsm idaciq sengp cla cin lea urn year7 fsmsch whiteb)
drop year8
compress
drop if year7==2006 | year>=2016
save final_formatching8, replace

use final_formatching9
merge 1:1 pmra using covars_fixed
keep if _merge==3
drop _merge
merge 1:1 pmra using absence_derived
keep if _merge==3
rename y8punauth absence
replace absence=y7punauth if absence>=. & y7punauth<.
replace absence=y6punauth if absence>=. & y6punauth<.
drop _merge y6punauth y7punauth y9punauth y10punauth
merge 1:1 pmra using fsmsenidaci_clean
keep if _merge==3
rename fsm8 fsm 
rename idaci8 idaci
rename sengp8 sengp
replace idaci=idaci7 if idaci>=.
replace sengp=sengp7 if sengp>=.
replace fsm=fsm7 if fsm>=.
replace idaci=idaci9 if idaci>=.
replace sengp=sengp9 if sengp>=.
replace fsm=fsm9 if fsm>=.
drop _merge fsm6-idaci7 fsm9-sengp10
xtile idaciq=idaci, nq(5)
merge 1:1 pmra using cla_derived
drop if _merge==2
rename cla8 cla
replace cla=0 if cla>=.
drop _merge cla6 clab6 cla7 cla9-cla10 agefirstcla
merge 1:1 pmra using cin_derived
drop if _merge==2
drop cin6 cinb6 cin7 cin9 cin10 _merge
rename cin8 cin
replace cin=0 if cin>=.
merge 1:1 pmra using schoolautumn1
drop if _merge==2
rename lea9 lea 
rename urn9 urn
rename fsmsch9 fsmsch
rename whiteb9 whiteb
replace lea=lea8 if lea>=.
replace urn=urn8 if urn>=.
replace fsmsch=fsmsch8 if fsmsch>=.
replace whiteb=whiteb8 if whiteb>=.
drop _merge lea7-whiteb8 lea10-whiteb11 
*Recode number of previous offences and total duration of suspensions as both skewed 
recode y9_off1 y9_off2 y9_off3 y9_off4 y9_off5 y9_off6 y9_off7 y9_off8 y9_off9 y9_off10 (3/60=3)
recode y9_off11 y9_off12 y9_off13 y9_off14 y9_off15 y9_off16 y9_off17 y9_off18 y9_off19 y9_off20 y9_off21 y9_off22 (3/60=3)
recode y9_1tot y9_2tot y9_3tot y9_4tot y9_5tot y9_6tot y9_7tot y9_8tot y9_9tot y9_10tot y9_11tot (2/9=1) (10/19=2) (20/39=3) (40/500=4) 
recode y9_12tot y9_13tot y9_14tot y9_15tot y9_16tot y9_17tot y9_18tot y9_19tot y9_20tot y9_21tot y9_22tot (2/9=1) (10/19=2) (20/39=3) (40/500=4)
merge 1:1 pmra using y7start
keep if _merge==3
drop _merge
gen year7=year9-2
replace year7=year(y7start) if year7>=.
drop year9
replace fsmsch=. if fsmsch>100
xtile schfsm=fsmsch, nq(5)
xtile bwhite=whiteb, nq(5)
merge m:1 lea using lea_region
drop if _merge==2
drop _merge
*Group absence (quartiles not sensible)
gen absgp=absence
recode absgp (1/4=1) (5/9=2) (10/100=3)
egen regnum=group(region)
*Make London reference group
recode regnum (3=0)
egen y9miss=rowmiss(sex ethnic ks2q absence fsm idaciq sengp cla cin lea urn year7 fsmsch whiteb)
compress
drop if year7<=2006 | year7>=2015
save final_formatching9, replace

use final_formatching10
merge 1:1 pmra using covars_fixed
keep if _merge==3
drop _merge
merge 1:1 pmra using absence_derived
keep if _merge==3
rename y9punauth absence
replace absence=y8punauth if absence>=. & y8punauth<.
replace absence=y7punauth if absence>=. & y7punauth<.
drop _merge y6punauth y7punauth y8punauth y10punauth
merge 1:1 pmra using fsmsenidaci_clean
keep if _merge==3
rename fsm9 fsm 
rename idaci9 idaci
rename sengp9 sengp
replace idaci=idaci8 if idaci>=.
replace sengp=sengp8 if sengp>=.
replace fsm=fsm8 if fsm>=.
replace idaci=idaci10 if idaci>=.
replace sengp=sengp10 if sengp>=.
replace fsm=fsm10 if fsm>=.
drop _merge fsm6-idaci8 fsm10-sengp10
xtile idaciq=idaci, nq(5)
merge 1:1 pmra using cla_derived
drop if _merge==2
rename cla9 cla
replace cla=0 if cla>=.
drop _merge cla6 clab6 cla7 cla8 cla10 agefirstcla
merge 1:1 pmra using cin_derived
drop if _merge==2
drop cin6 cinb6 cin7 cin8 cin10 _merge
rename cin9 cin
replace cin=0 if cin>=.
merge 1:1 pmra using schoolautumn1
drop if _merge==2
rename lea10 lea 
rename urn10 urn
rename fsmsch10 fsmsch
rename whiteb10 whiteb
replace lea=lea9 if lea>=.
replace urn=urn9 if urn>=.
replace fsmsch=fsmsch9 if fsmsch>=.
replace whiteb=whiteb9 if whiteb>=.
drop _merge lea7-whiteb9 lea11-whiteb11 
*Recode number of previous offences and total duration of suspensions as both skewed 
recode y10_off1 y10_off2 y10_off3 y10_off4 y10_off5 y10_off6 y10_off7 y10_off8 y10_off9 y10_off10 y10_off11 (3/90=3)
recode y10_off12 y10_off13 y10_off14 y10_off15 y10_off16 y10_off17 y10_off18 y10_off19 y10_off20 y10_off21 y10_off22 (3/90=3)
recode y10_1tot y10_2tot y10_3tot y10_4tot y10_5tot y10_6tot y10_7tot y10_8tot y10_9tot y10_10tot (2/9=1) (10/19=2) (20/39=3) (40/500=4)
recode y10_11tot y10_12tot y10_13tot y10_14tot y10_15tot y10_16tot y10_17tot y10_18tot y10_19tot y10_20tot y10_21tot y10_22tot (2/9=1) (10/19=2) (20/39=3) (40/500=4)
merge 1:1 pmra using y7start
keep if _merge==3
drop _merge
gen year7=year10-3
replace year7=year(y7start) if year7>=.
drop year10
replace fsmsch=. if fsmsch>100
xtile schfsm=fsmsch, nq(5)
xtile bwhite=whiteb, nq(5)
merge m:1 lea using lea_region
drop if _merge==2
drop _merge
*Group absence (quartiles not sensible)
gen absgp=absence
recode absgp (1/4=1) (5/9=2) (10/100=3)
egen regnum=group(region)
*Make London reference group
recode regnum (3=0)
egen y10miss=rowmiss(sex ethnic ks2q absence fsm idaciq sengp cla cin lea urn year7 fsmsch whiteb)
compress
drop if year7<=2006 | year7>=2014
save final_formatching10, replace

use final_formatching11
merge 1:1 pmra using covars_fixed
keep if _merge==3
drop _merge
merge 1:1 pmra using absence_derived
keep if _merge==3
rename y10punauth absence
replace absence=y9punauth if absence>=. & y9punauth<.
replace absence=y8punauth if absence>=. & y8punauth<.
drop _merge y6punauth y7punauth y8punauth y9punauth
merge 1:1 pmra using fsmsenidaci_clean
keep if _merge==3
rename fsm10 fsm 
rename idaci10 idaci
rename sengp10 sengp
replace idaci=idaci9 if idaci>=.
replace sengp=sengp9 if sengp>=.
replace fsm=fsm9 if fsm>=.
drop _merge fsm6-sengp9
xtile idaciq=idaci, nq(5)
merge 1:1 pmra using cla_derived
drop if _merge==2
rename cla10 cla
replace cla=0 if cla>=.
drop _merge cla6 clab6 cla7 cla8 cla9 agefirstcla
merge 1:1 pmra using cin_derived
drop if _merge==2
drop cin6 cinb6 cin7 cin8 cin9 _merge
rename cin10 cin
replace cin=0 if cin>=.
merge 1:1 pmra using schoolautumn1
drop if _merge==2
rename lea11 lea 
rename urn11 urn
rename fsmsch11 fsmsch
rename whiteb11 whiteb
replace lea=lea10 if lea>=.
replace urn=urn10 if urn>=.
replace fsmsch=fsmsch10 if fsmsch>=.
replace whiteb=whiteb10 if whiteb>=.
drop _merge lea7-whiteb10 
*Recode number of previous offences and total duration of suspensions as both skewed 
recode y11_off1 y11_off2 y11_off3 y11_off4 y11_off5 y11_off6 y11_off7 y11_off8 y11_off9 y11_off10 y11_off11 (3/90=3)
recode y11_off12 y11_off13 y11_off14 y11_off15 y11_off16 y11_off17 y11_off18 y11_off19 y11_off20 y11_off21 y11_off22 (3/90=3)
recode y11_1tot y11_2tot y11_3tot y11_4tot y11_5tot y11_6tot y11_7tot y11_8tot y11_9tot y11_10tot (2/9=1) (10/19=2) (20/39=3) (40/500=4)
recode y11_11tot y11_12tot y11_13tot y11_14tot y11_15tot y11_16tot y11_17tot y11_18tot y11_19tot y11_20tot y11_21tot y11_22tot (2/9=1) (10/19=2) (20/39=3) (40/500=4)
merge 1:1 pmra using y7start
keep if _merge==3
drop _merge
gen year7=year11-4
replace year7=year(y7start) if year7>=.
drop year11
replace fsmsch=. if fsmsch>100
xtile schfsm=fsmsch, nq(5)
xtile bwhite=whiteb, nq(5)
merge m:1 lea using lea_region
drop if _merge==2
drop _merge
*Group absence (quartiles not sensible)
gen absgp=absence
recode absgp (1/4=1) (5/9=2) (10/100=3)
egen regnum=group(region)
*Make London reference group
recode regnum (3=0)
egen y11miss=rowmiss(sex ethnic ks2q absence fsm idaciq sengp cla cin lea urn year7 fsmsch whiteb)
compress
drop if year7<=2006 | year7>=2013
save final_formatching11, replace

**Select those eligibile with no missing covariate data for each school year and two-week period
local k=7
while `k'<12 {
local i=1
while `i'<23 {
use final_formatching`k'
keep if y`k'elig`i'==1 & y`k'miss==0
rename y`k'pex`i' exclude
rename y`k'_`i'tot totsusp
rename y`k'_off`i' totoff
rename y`k'elig`i' eligible
drop y`k'elig* y`k'_*tot y`k'_off* y`k'pex*
gen byte period=`i'
save y`k'tomatch`i'.dta, replace
clear
local i=`i'+1
}
local k=`k'+1
}

sysdir set PLUS "P:\Working\Stata_ado"

**Do (1:1) matching and save matched and unmatched individuals for each school year and two-week period
**Uses stata package cem.ado (coarsened exact matching, but here variables have been categorised so no coarsening needed)
**Saves matched and unmatched data for each school year from 7 to 11 and for each two week period with each of these

log using matchingrates.log, replace
local k=7
while `k'<11 {
local i=1
while `i'<23 {
clear
use y`k'tomatch`i'
gen london=1 if regnum==0
replace london=0 if london~=1 & regnum<.
recode sengp (2=1)
cem sex ethnic totoff (#0) totsusp (#0) absgp sengp london year7 (#0), treatment(exclude) k2k
save temp`k', replace
keep if cem_matched==0 & exclude==1
save y`k'unmatched`i'.dta, replace
use temp`k'
keep if cem_matched==1
save y`k'matched`i'.dta, replace
clear
local i=`i'+1
}
local k=`k'+1
}
local i=1
while `i'<20 {
clear
use y11tomatch`i'
gen london=1 if regnum==0
replace london=0 if london~=1 & regnum<.
recode sengp (2=1)
cem sex ethnic totoff (#0) totsusp (#0) absgp sengp london year7 (#0), treatment(exclude) k2k
save temp11, replace
keep if cem_matched==0 & exclude==1
save y11unmatched`i'.dta, replace
use temp11
keep if cem_matched==1
save y11matched`i'.dta, replace
clear
local i=`i'+1
}
log close

*Get exclusion data 
local k=7
while `k'<12 {
use pexclusions_working_file
keep if ncyear==`k'
sort pmra startp
bysort pmra: gen recno=_n
keep if recno==1
save pexclusions`k', replace
local k=`k'+1
}

**Generate final file for analysis by merging matched individuals to exclusion data (to get start date) and outcome data
local k=7
while `k'<11 {
local i=1
while `i'<23 {
clear
use y`k'matched`i'
merge 1:1 pmra using pexclusions`k'
drop if _merge==2
drop recno eligible ks2read ks2maths

*Censoring data for any controls later excluded
gen censor=startp if exclude==0 & _merge==3 
**This will only work if strata contain two individuals. 
bysort cem_strata: gen size=_N
sort cem_strata exclude

*Start of follow-up=date of exclusion
gen start=startp if _merge==3 & exclude==1
format start censor %d
*Control start date = same as matched control
replace start=startp[_n+1] if cem_strata==cem_strata[_n+1] & exclude==0 & size==2
gen score=idaci+(100-ks2attain)+fsmsch
sort cem_strata exclude score
replace start=startp[_n+2] if cem_strata==cem_strata[_n+2] & exclude==0 & size==4
replace start=startp[_n+3] if cem_strata==cem_strata[_n+3] & exclude==0 & size==6
replace start=startp[_n+4] if cem_strata==cem_strata[_n+4] & exclude==0 & size==8
replace start=startp[_n+5] if cem_strata==cem_strata[_n+5] & exclude==0 & size==10
replace start=startp[_n+6] if cem_strata==cem_strata[_n+6] & exclude==0 & size==12
replace start=startp[_n+7] if cem_strata==cem_strata[_n+7] & exclude==0 & size==14
replace start=startp[_n+8] if cem_strata==cem_strata[_n+8] & exclude==0 & size==16
replace start=startp[_n+9] if cem_strata==cem_strata[_n+9] & exclude==0 & size==18
replace start=startp[_n+10] if cem_strata==cem_strata[_n+10] & exclude==0 & size==20
drop _merge startp
merge 1:m pmra using pexclusions_working_file
drop if _merge==2
bysort pmra: gen recnum=_N
drop if _merge==3 & startp==start & recnum>1
drop recnum
bysort pmra: gen recnum=_N
replace startp=. if _merge==3 & start==startp
replace startp=. if startp<start

*Censor pairs if control is excluded
replace censor=startp if startp<. & startp-start<365 & exclude==0 & censor>=.
replace startp=. if startp-start>365 & startp<.
replace startp=. if startp==censor & censor<.
sort pmra start censor
gen drop=1 if pmra==pmra[_n-1] & exclude==exclude[_n-1] & start==start[_n-1] & censor==censor[_n-1]
drop if drop==1
drop recnum drop
bysort pmra: gen recnum=_N
sort pmra start censor
gen drop=1 if pmra==pmra[_n-1] & exclude==exclude[_n-1] & start==start[_n-1] & censor>=. & censor[_n-1]<.
drop if drop==1
drop drop recnum
bysort pmra: gen recnum=_N
sort pmra start censor
gen drop=1 if pmra==pmra[_n-1] & exclude==exclude[_n-1] & start==start[_n-1] & censor<. & censor[_n-1]<. & censor>censor[_n-1]
drop if drop==1
drop startp recnum _merge drop score
replace censor=. if censor<start & censor<. & start<.
bysort cem_strata start: gen sizesame=_N
sort cem_strata start exclude censor
replace censor=censor[_n-1] if cem_strata==cem_strata[_n-1] & exclude==1 & start==start[_n-1] & censor[_n-1]<. & sizesame==2
replace censor=censor[_n-2] if cem_strata==cem_strata[_n-2] & exclude==1 & start==start[_n-2] & censor[_n-2]<. & sizesame==4
replace censor=censor[_n-3] if cem_strata==cem_strata[_n-3] & exclude==1 & start==start[_n-3] & censor[_n-3]<. & sizesame==6
replace censor=censor[_n-4] if cem_strata==cem_strata[_n-4] & exclude==1 & start==start[_n-4] & censor[_n-4]<. & sizesame==8
drop size sizesame
merge 1:m pmra using outcomes_temp
drop if _merge==2

*Relevant outcomes are those occurring up to a year after start of follow-up 
replace SV=0 if SV==1 & offdate<start & _merge==3
replace homnmiss=0 if homnmiss==1 & offdate<start & _merge==3
replace SV=0 if SV==1 & offdate-start>365 & _merge==3
replace homnmiss=0 if homnmiss==1 & offdate-start>365 & _merge==3
replace SV=0 if _merge==1
replace homnmiss=0 if _merge==1
replace offdate=. if SV==0 & homnmiss==0
duplicates drop
sort pmra start offdate
drop if pmra==pmra[_n-1] & start==start[_n-1] 
compress
drop _merge
save y`k'matched`i'f, replace
clear
local i=`i'+1
}
local k=`k'+1
}

*Fewer two-week periods in year 11 since pupils leave after GCSEs so can't be excluded
local i=1
while `i'<20 {
clear
use y11matched`i'
merge 1:1 pmra using pexclusions11
drop if _merge==2
drop recno eligible ks2read ks2maths
*Censoring data for any controls later excluded
gen censor=startp if exclude==0 & _merge==3 
**This will only work if strata contain two individuals. 
bysort cem_strata: gen size=_N
sort cem_strata exclude
gen start=startp if _merge==3 & exclude==1
format start censor %d
replace start=startp[_n+1] if cem_strata==cem_strata[_n+1] & exclude==0 & size==2
gen score=idaci+(100-ks2attain)+fsmsch
sort cem_strata exclude score
replace start=startp[_n+2] if cem_strata==cem_strata[_n+2] & exclude==0 & size==4
replace start=startp[_n+3] if cem_strata==cem_strata[_n+3] & exclude==0 & size==6
replace start=startp[_n+4] if cem_strata==cem_strata[_n+4] & exclude==0 & size==8
replace start=startp[_n+5] if cem_strata==cem_strata[_n+5] & exclude==0 & size==10
replace start=startp[_n+6] if cem_strata==cem_strata[_n+6] & exclude==0 & size==12
replace start=startp[_n+7] if cem_strata==cem_strata[_n+7] & exclude==0 & size==14
replace start=startp[_n+8] if cem_strata==cem_strata[_n+8] & exclude==0 & size==16
replace start=startp[_n+9] if cem_strata==cem_strata[_n+9] & exclude==0 & size==18
replace start=startp[_n+10] if cem_strata==cem_strata[_n+10] & exclude==0 & size==20
drop _merge startp
merge 1:m pmra using pexclusions_working_file
drop if _merge==2
bysort pmra: gen recnum=_N
drop if _merge==3 & startp==start & recnum>1
drop recnum
bysort pmra: gen recnum=_N
replace startp=. if _merge==3 & start==startp
replace startp=. if startp<start
replace censor=startp if startp<. & startp-start<365 & exclude==0 & censor>=.
replace startp=. if startp-start>365 & startp<.
replace startp=. if startp==censor & censor<.
sort pmra start censor
gen drop=1 if pmra==pmra[_n-1] & exclude==exclude[_n-1] & start==start[_n-1] & censor==censor[_n-1]
drop if drop==1
drop recnum drop
bysort pmra: gen recnum=_N
sort pmra start censor
gen drop=1 if pmra==pmra[_n-1] & exclude==exclude[_n-1] & start==start[_n-1] & censor>=. & censor[_n-1]<.
drop if drop==1
drop drop recnum
bysort pmra: gen recnum=_N
sort pmra start censor
gen drop=1 if pmra==pmra[_n-1] & exclude==exclude[_n-1] & start==start[_n-1] & censor<. & censor[_n-1]<. & censor>censor[_n-1]
drop if drop==1
drop startp recnum _merge drop score
bysort cem_strata start: gen sizesame=_N
sort cem_strata start exclude censor
replace censor=censor[_n-1] if cem_strata==cem_strata[_n-1] & exclude==1 & start==start[_n-1] & censor[_n-1]<. & sizesame==2
replace censor=censor[_n-2] if cem_strata==cem_strata[_n-2] & exclude==1 & start==start[_n-2] & censor[_n-2]<. & sizesame==4
replace censor=censor[_n-3] if cem_strata==cem_strata[_n-3] & exclude==1 & start==start[_n-3] & censor[_n-3]<. & sizesame==6
replace censor=censor[_n-4] if cem_strata==cem_strata[_n-4] & exclude==1 & start==start[_n-4] & censor[_n-4]<. & sizesame==8
drop size sizesame
merge 1:m pmra using outcomes_temp
drop if _merge==2
replace SV=0 if SV==1 & offdate<start & _merge==3
replace homnmiss=0 if homnmiss==1 & offdate<start & _merge==3
replace SV=0 if SV==1 & offdate-start>365 & _merge==3
replace homnmiss=0 if homnmiss==1 & offdate-start>365 & _merge==3
replace SV=0 if _merge==1
replace homnmiss=0 if _merge==1
replace offdate=. if SV==0 & homnmiss==0
drop tew_io
duplicates drop
sort pmra start offdate
drop if pmra==pmra[_n-1] & start==start[_n-1] 
compress
drop _merge
save y11matched`i'f, replace
clear
local i=`i'+1
}

*Put all matched files together for analysis
clear all
local k=7
while `k'<11 {
clear
use y`k'matched1f
local i=2
while `i'<23 {
append using y`k'matched`i'f
local i=`i'+1
}
gen endsv=censor if censor<. 
gen endh=censor if censor<.
gen sv=SV
gen homn=homnmiss
replace sv=0 if sv==1 & offdate>censor & offdate<. & censor<.
replace homn=0 if homnmiss==1 & offdate>censor & offdate<. & censor<.
replace endsv=offdate if sv==1
replace endh=offdate if homn==1
replace endsv=start+365 if sv==0 & endsv>=.
replace endh=start+365 if homn==0 & endh>=.
format endsv endh %d
tab sv exclude, col
tab homn exclude, col
save y`k'matchedall, replace
local k=`k'+1
}

clear
clear all
use y11matched1f
local i=2
while `i'<20 {
append using y11matched`i'f
local i=`i'+1
}
gen endsv=censor if censor<. 
gen endh=censor if censor<.
gen sv=SV
gen homn=homnmiss
replace sv=0 if sv==1 & offdate>censor & offdate<. & censor<.
replace homn=0 if homnmiss==1 & offdate>censor & offdate<. & censor<.
replace endsv=offdate if sv==1
replace endh=offdate if homn==1
replace endsv=start+365 if sv==0 & endsv>=.
replace endh=start+365 if homn==0 & endh>=.
replace endsv=start+365 if endsv-start>365
replace endh=start+365 if endh-start>365
format endsv endh %d
tab sv exclude, col
tab homn exclude, col
save y11matchedall, replace
clear


