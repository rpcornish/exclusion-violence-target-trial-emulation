**Preparing dataset for analysis

set more off
version 17 
clear

**********************************************************************************************************************************************************************
*Steps:
*1. Generate eligibility indicator for having been suspended for at least 1 day previously
*2. Generate total sessions missed up to the start of each two week period from the start of year 7 to the end of year 11
*3. Merge with previously generated other eligibility criteria datasets (no previous serious violence, no permanent exclusion in past year
*4. Generate files (one each for years 7 to 11) containing information needed to carry out matching=exclusion indicators, eligibility indicators + matching variables

**********************************************************************************************************************************************************************

use fexclusions_all
merge m:1 pmra using pmra_denom_fixed
keep if _merge==3
drop _merge
keep pmra sessions ncyear startf
sort pmra startf
merge m:1 pmra using y7start
keep if _merge==3
drop _merge
gen year7=year(y7start)
gen day=1
gen month=9
gen y8start=mdy(month,day,year7+1)
gen y9start=mdy(month,day,year7+2)
gen y10start=mdy(month,day,year7+3)
gen y11start=mdy(month,day,year7+4)
format y8start y9start y10start y11start %d
drop year7 day month
replace sessions=0 if sessions>=.

***For each school year and two-week period, generate indicator for eligibility = pupil has had at least 1 day of suspension
***up to that point, starting 1st September each year
gen totalsess=sessions
replace totalsess=sessions+totalsess[_n-1] if pmra==pmra[_n-1]
gen bef7=1 if ncyear<7
local i=7
while `i'<12 {
replace bef`i'=1 if ncyear<`i'
replace bef`i'=0 if bef`i'~=1
replace bef`i'=0 if bef`i'==1 & startf>y`i'start
gen y`i'_1s=1 if bef`i'==1 & sessions>=2
*before 15th Sept
gen y`i'_2s=1 if y`i'_1s==1
replace y`i'_2s=1 if bef`i'~=1 & startf+(sessions/2)<y`i'start+14 & sessions>=2
*before 1st Oct
gen y`i'_3s=1 if y`i'_2s==1
replace y`i'_3s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+30 & sessions>=2
*before 15th Oct
gen y`i'_4s=1 if y`i'_3s==1
replace y`i'_4s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+44 & sessions>=2
*before 1st Nov
gen y`i'_5s=1 if y`i'_4s==1
replace y`i'_5s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+61 & sessions>=2
*before 15th Nov
gen y`i'_6s=1 if y`i'_5s==1
replace y`i'_6s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+75 & sessions>=2
*before 1st Dec
gen y`i'_7s=1 if y`i'_6s==1
replace y`i'_7s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+91 & sessions>=2
*before 15th Dec
gen y`i'_8s=1 if y`i'_7s==1
replace y`i'_8s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+105 & sessions>=2
*before 1st Jan
gen y`i'_9s=1 if y`i'_8s==1
replace y`i'_9s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+122 & sessions>=2
*before 15th Jan
gen y`i'_10s=1 if y`i'_9s==1
replace y`i'_10s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+136 & sessions>=2
*before 1st Feb
gen y`i'_11s=1 if y`i'_10s==1
replace y`i'_11s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+153 & sessions>=2
*before 14th Feb
gen y`i'_12s=1 if y`i'_11s==1
replace y`i'_12s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+166 & sessions>=2
*before 1st March
gen y`i'_13s=1 if y`i'_12s==1
replace y`i'_13s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+181 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_13s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+182 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 15th March
gen y`i'_14s=1 if y`i'_13s==1
replace y`i'_14s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+195 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_14s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+196 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 1st April
gen y`i'_15s=1 if y`i'_14s==1
replace y`i'_15s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+212 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_15s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+213 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 15th April
gen y`i'_16s=1 if y`i'_15s==1
replace y`i'_16s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+226 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_16s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+227 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 1st May
gen y`i'_17s=1 if y`i'_16s==1
replace y`i'_17s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+242 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_17s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+243 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 15th May
gen y`i'_18s=1 if y`i'_17s==1
replace y`i'_18s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+256 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_18s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+257 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 1st June
gen y`i'_19s=1 if y`i'_18s==1
replace y`i'_19s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+273 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_19s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+274 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 15th June
gen y`i'_20s=1 if y`i'_19s==1
replace y`i'_20s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+287 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_20s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+288 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 1st July
gen y`i'_21s=1 if y`i'_20s==1
replace y`i'_21s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+303 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_21s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+304 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
*before 15th July
gen y`i'_22s=1 if y`i'_21s==1
replace y`i'_22s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+317 & sessions>=2 & year(startf)/4~=trunc(year(startf)/4)
replace y`i'_22s=1 if startf>y`i'start & startf+(sessions/2)<y`i'start+318 & sessions>=2 & year(startf)/4==trunc(year(startf)/4)
local j=`i'+1
gen bef`j'=1 if y`i'_22s==1
local i=`i'+1
}
drop bef*

**Also generate total number of sessions of suspension up to start of each two-week period (for matching purposes)
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace y`k'_`i's=0 if y`k'_`i's~=1
gen y`k'_tot`i'=totalsess if y`k'_`i's==1
replace y`k'_tot`i'=0 if y`k'_tot`i'>=.
local i=`i'+1
}
local k=`k'+1
}

*Tried doing this with nested loops but was making stata crash so have split up
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e1=max(y`k'_1s)
bysort pmra: egen y`k'_1tot=max(y`k'_tot1)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e2=max(y`k'_2s)
bysort pmra: egen y`k'_2tot=max(y`k'_tot2)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e3=max(y`k'_3s)
bysort pmra: egen y`k'_3tot=max(y`k'_tot3)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e4=max(y`k'_4s)
bysort pmra: egen y`k'_4tot=max(y`k'_tot4)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e5=max(y`k'_5s)
bysort pmra: egen y`k'_5tot=max(y`k'_tot5)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e6=max(y`k'_6s)
bysort pmra: egen y`k'_6tot=max(y`k'_tot6)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e7=max(y`k'_7s)
bysort pmra: egen y`k'_7tot=max(y`k'_tot7)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e8=max(y`k'_8s)
bysort pmra: egen y`k'_8tot=max(y`k'_tot8)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e9=max(y`k'_9s)
bysort pmra: egen y`k'_9tot=max(y`k'_tot9)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e10=max(y`k'_10s)
bysort pmra: egen y`k'_10tot=max(y`k'_tot10)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e11=max(y`k'_11s)
bysort pmra: egen y`k'_11tot=max(y`k'_tot11)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e12=max(y`k'_12s)
bysort pmra: egen y`k'_12tot=max(y`k'_tot12)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e13=max(y`k'_13s)
bysort pmra: egen y`k'_13tot=max(y`k'_tot13)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e14=max(y`k'_14s)
bysort pmra: egen y`k'_14tot=max(y`k'_tot14)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e15=max(y`k'_15s)
bysort pmra: egen y`k'_15tot=max(y`k'_tot15)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e16=max(y`k'_16s)
bysort pmra: egen y`k'_16tot=max(y`k'_tot16)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e17=max(y`k'_17s)
bysort pmra: egen y`k'_17tot=max(y`k'_tot17)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e18=max(y`k'_18s)
bysort pmra: egen y`k'_18tot=max(y`k'_tot18)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e19=max(y`k'_19s)
bysort pmra: egen y`k'_19tot=max(y`k'_tot19)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e20=max(y`k'_20s)
bysort pmra: egen y`k'_20tot=max(y`k'_tot20)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e21=max(y`k'_21s)
bysort pmra: egen y`k'_21tot=max(y`k'_tot21)
local k=`k'+1
}
local k=7
while `k'<12 {
bysort pmra: egen y`k'_e22=max(y`k'_22s)
bysort pmra: egen y`k'_22tot=max(y`k'_tot22)
local k=`k'+1
}
keep pmra y7_e1-y11_22tot
duplicates drop
order pmra y7* y8* y9* y10* y11*
compress
save eligible_all

*Merge with other eligibility indicators (no previous serious violence and no exclusion in past year)
*Eligibility based on no previous serious violence
merge 1:1 pmra using eligible_all_sv
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace y`k'_sve`i'=0 if _merge==1
replace y`k'_off`i'=0 if _merge==1
replace y`k'_tewio`i'=0 if _merge==1
replace y`k'_sum`i'=0 if _merge==1
local i=`i'+1
}
local k=`k'+1
}
drop _merge

**Eligibility based on no exclusion in past year
merge 1:1 pmra using pex_elig
drop if _merge==2
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace pexy`k'e`i'=0 if _merge==1
local i=`i'+1
}
local k=`k'+1
}
drop _merge

*THEN FOR EACH PERIOD GENERATE OVERALL ELIGIBILITY INDICATOR (variables: y7elig1 to y11elig3)
local k=7
while `k'<12 {
local i=1
while `i'<23 {
gen y`k'elig`i'=1 if y`k'_e`i'==1 & y`k'_sve`i'==0 & pexy`k'e`i'==0
replace y`k'elig`i'=0 if y`k'elig`i'~=1
local i=`i'+1
}
local k=`k'+1
}
keep pmra y*elig* y*_off* y*_*tot y*_sve* pexy*
compress
order pmra y*elig* y*_*tot y*off* 
save eligible, replace

**Generate file containing information needed to carry out matching=exclusion indicators, eligibility indicators + matching variables
merge 1:1 pmra using pexclusions_foranalysis
drop if _merge==2
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace y`k'pex`i'=0 if _merge==1
local i=`i'+1
}
local k=`k'+1
}
drop _merge
keep pmra y*elig* y*_off* y*_*tot y*pex*
order pmra y*elig* y*_*tot y*off* y*pex*  
save final_formatching, replace

*Separate by school year since will match within school year
local k=7
while `k'<12 {
use final_formatching, clear
keep pmra y`k'*
save final_formatching`k', replace
clear
local k=`k'+1
}

