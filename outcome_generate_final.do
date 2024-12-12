*Generate file of outcomes - all offences, SV and homicide for all individuals born 1993/94 to 2003/04

clear all
clear
capture log close
cd "P:\XXXXXXX\XXXXXXXXXX\XXXXXXXXXX"

*************************************************************************************************
** PNC_WITHPMRA = offence file from previous work with PMRA included


*FOR HOMICIDE
use "P:\XXXXXXX\XXXXXXXXXXXX\pnc_withpmra"
merge m:1 pmra using "pmra_denom_fixed"
keep if _merge==3
drop _merge recno country yearoff cdate
*Drop if offence is unknown
drop if offtype>=.
duplicates drop
**Generate indicator for homicide or near-miss
gen homnmiss=1 if substr(Offence,1,4)=="1 Mu" | substr(Offence,1,5)=="4.1 M" | substr(Offence,1,3)=="4.3" | substr(Offence,1,3)=="4.7" | substr(Offence,1,4)=="4.11" 
replace homnmiss=1 if substr(Offence,1,3)=="2 A" | substr(Offence,1,2)=="5A" | substr(Offence,1,4)=="5.1"
replace homnmiss=0 if homnmiss~=1

*Drop offences aged 19+ since won't be required
drop if offenceage>=19 & offenceage<.
gsort pmra Offence offdate -SV
drop if pmra==pmra[_n-1] & Offence==Offence[_n-1] & offdate==offdate[_n-1] 
merge 1:1 pmra offdate Offence using pnc_outcomes
keep if _merge==3
drop _merge
save alloffences, replace

*Generate file that gives eligibility (no SV by each school year and two-week period) + offence totals by each date (for matching)
gen svage=offenceage if SV==1 & conviction~=0
bysort pmra: egen minsv=min(svage)
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
gen off=1
sort pmra offdate
gen totaloff=off
replace totaloff=off+totaloff[_n-1] if pmra==pmra[_n-1]
replace SV=1 if SV==0 & pmra==pmra[_n-1] & offdate==offdate[_n-1] & SV[_n-1]==1
drop if pmra==pmra[_n+1] & offdate==offdate[_n+1]
gen totsv=SV
replace totsv=SV+totsv[_n-1] if pmra==pmra[_n-1]

local i=7
while `i'<12 {
gen svbef`i'=1 if offdate<y`i'start & SV==1
replace svbef`i'=0 if svbef`i'~=1
gen svy`i'_1s=1 if SV==1 & offdate<y`i'start
gen off`i'_1s=totaloff if offdate<y`i'start
gen tewio`i'_1s=tottewio if offdate<y`i'start
gen sum`i'_1s=totsum if offdate<y`i'start
*before 15th Sept
gen svy`i'_2s=1 if SV==1 & offdate<y`i'start+14
gen off`i'_2s=totaloff if offdate<y`i'start+14
gen tewio`i'_2s=tottewio if offdate<y`i'start+14
gen sum`i'_2s=totsum if offdate<y`i'start+14
*before 1st Oct
gen svy`i'_3s=1 if SV==1 & offdate<y`i'start+30
gen off`i'_3s=totaloff if offdate<y`i'start+30
gen tewio`i'_3s=tottewio if offdate<y`i'start+30
gen sum`i'_3s=totsum if offdate<y`i'start+30
*before 15th Oct
gen svy`i'_4s=1 if SV==1 & offdate<y`i'start+44
gen off`i'_4s=totaloff if offdate<y`i'start+44
gen tewio`i'_4s=tottewio if offdate<y`i'start+44
gen sum`i'_4s=totsum if offdate<y`i'start+44
*before 1st Nov
gen svy`i'_5s=1 if SV==1 & offdate<y`i'start+61
gen off`i'_5s=totaloff if offdate<y`i'start+61
gen tewio`i'_5s=tottewio if offdate<y`i'start+61
gen sum`i'_5s=totsum if offdate<y`i'start+61
*before 15th Nov
gen svy`i'_6s=1 if SV==1 & offdate<y`i'start+75
gen off`i'_6s=totaloff if offdate<y`i'start+75
gen tewio`i'_6s=tottewio if offdate<y`i'start+75
gen sum`i'_6s=totsum if offdate<y`i'start+75
*before 1st Dec
gen svy`i'_7s=1 if SV==1 & offdate<y`i'start+91
gen off`i'_7s=totaloff if offdate<y`i'start+91
gen tewio`i'_7s=tottewio if offdate<y`i'start+91
gen sum`i'_7s=totsum if offdate<y`i'start+91
*before 15th Dec
gen svy`i'_8s=1 if SV==1 & offdate<y`i'start+105
gen off`i'_8s=totaloff if offdate<y`i'start+105
gen tewio`i'_8s=tottewio if offdate<y`i'start+105
gen sum`i'_8s=totsum if offdate<y`i'start+105
*before 1st Jan
gen svy`i'_9s=1 if SV==1 & offdate<y`i'start+122
gen off`i'_9s=totaloff if offdate<y`i'start+122
gen tewio`i'_9s=tottewio if offdate<y`i'start+122
gen sum`i'_9s=totsum if offdate<y`i'start+122
*before 15th Jan
gen svy`i'_10s=1 if SV==1 & offdate<y`i'start+136
gen off`i'_10s=totaloff if offdate<y`i'start+136
gen tewio`i'_10s=tottewio if offdate<y`i'start+136
gen sum`i'_10s=totsum if offdate<y`i'start+136
*before 1st Feb
gen svy`i'_11s=1 if SV==1 & offdate<y`i'start+153
gen off`i'_11s=totaloff if offdate<y`i'start+153
gen tewio`i'_11s=tottewio if offdate<y`i'start+153
gen sum`i'_11s=totsum if offdate<y`i'start+153
*before 14th Feb
gen svy`i'_12s=1 if SV==1 & offdate<y`i'start+166
gen off`i'_12s=totaloff if offdate<y`i'start+166
gen tewio`i'_12s=tottewio if offdate<y`i'start+166
gen sum`i'_12s=totsum if offdate<y`i'start+166
*before 1st March
gen svy`i'_13s=1 if SV==1 & offdate<y`i'start+181 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_13s=totaloff if offdate<y`i'start+181 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_13s=tottewio if offdate<y`i'start+181 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_13s=totsum if offdate<y`i'start+181 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_13s=1 if SV==1 & offdate<y`i'start+182 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_13s=totaloff if offdate<y`i'start+182 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_13s=tottewio if offdate<y`i'start+182 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_13s=totsum if offdate<y`i'start+182 & year(offdate)/4==trunc(year(offdate)/4)
*before 15th March
gen svy`i'_14s=1 if SV==1 & offdate<y`i'start+195 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_14s=totaloff if offdate<y`i'start+195 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_14s=tottewio if offdate<y`i'start+195 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_14s=totsum if offdate<y`i'start+195 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_14s=1 if SV==1 & offdate<y`i'start+196 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_14s=totaloff if offdate<y`i'start+196 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_14s=tottewio if offdate<y`i'start+196 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_14s=totsum if offdate<y`i'start+196 & year(offdate)/4==trunc(year(offdate)/4)
*before 1st April
gen svy`i'_15s=1 if SV==1 & offdate<y`i'start+212 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_15s=totaloff if offdate<y`i'start+212 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_15s=tottewio if offdate<y`i'start+212 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_15s=totsum if offdate<y`i'start+212 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_15s=1 if SV==1 & offdate<y`i'start+213 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_15s=totaloff if offdate<y`i'start+213 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_15s=tottewio if offdate<y`i'start+213 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_15s=totsum if offdate<y`i'start+213 & year(offdate)/4==trunc(year(offdate)/4)
*before 15th April
gen svy`i'_16s=1 if SV==1 & offdate<y`i'start+226 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_16s=totaloff if offdate<y`i'start+226 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_16s=tottewio if offdate<y`i'start+226 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_16s=totsum if offdate<y`i'start+226 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_16s=1 if SV==1 & offdate<y`i'start+227 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_16s=totaloff if offdate<y`i'start+227 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_16s=tottewio if offdate<y`i'start+227 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_16s=totsum if offdate<y`i'start+227 & year(offdate)/4==trunc(year(offdate)/4)
*before 1st May
gen svy`i'_17s=1 if SV==1 & offdate<y`i'start+242 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_17s=totaloff if offdate<y`i'start+242 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_17s=tottewio if offdate<y`i'start+242 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_17s=totsum if offdate<y`i'start+242 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_17s=1 if SV==1 & offdate<y`i'start+243 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_17s=totaloff if offdate<y`i'start+243 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_17s=tottewio if offdate<y`i'start+243 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_17s=totsum if offdate<y`i'start+243 & year(offdate)/4==trunc(year(offdate)/4)
*before 15th May
gen svy`i'_18s=1 if SV==1 & offdate<y`i'start+256 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_18s=totaloff if offdate<y`i'start+256 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_18s=tottewio if offdate<y`i'start+256 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_18s=totsum if offdate<y`i'start+256 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_18s=1 if SV==1 & offdate<y`i'start+257 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_18s=totaloff if offdate<y`i'start+257 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_18s=tottewio if offdate<y`i'start+257 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_18s=totsum if offdate<y`i'start+257 & year(offdate)/4==trunc(year(offdate)/4)
*before 1st June
gen svy`i'_19s=1 if SV==1 & offdate<y`i'start+273 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_19s=totaloff if offdate<y`i'start+273 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_19s=tottewio if offdate<y`i'start+273 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_19s=totsum if offdate<y`i'start+273 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_19s=1 if SV==1 & offdate<y`i'start+274 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_19s=totaloff if offdate<y`i'start+274 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_19s=tottewio if offdate<y`i'start+274 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_19s=totsum if offdate<y`i'start+274 & year(offdate)/4==trunc(year(offdate)/4)
*before 15th June
gen svy`i'_20s=1 if SV==1 & offdate<y`i'start+287 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_20s=totaloff if offdate<y`i'start+287 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_20s=tottewio if offdate<y`i'start+287 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_20s=totsum if offdate<y`i'start+287 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_20s=1 if SV==1 & offdate<y`i'start+288 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_20s=totaloff if offdate<y`i'start+288 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_20s=tottewio if offdate<y`i'start+288 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_20s=totsum if offdate<y`i'start+288 & year(offdate)/4==trunc(year(offdate)/4)
*before 1st July
gen svy`i'_21s=1 if SV==1 & offdate<y`i'start+303 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_21s=totaloff if offdate<y`i'start+303 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_21s=tottewio if offdate<y`i'start+303 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_21s=totsum if offdate<y`i'start+303 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_21s=1 if SV==1 & offdate<y`i'start+304 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_21s=totaloff if offdate<y`i'start+304 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_21s=tottewio if offdate<y`i'start+304 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_21s=totsum if offdate<y`i'start+304 & year(offdate)/4==trunc(year(offdate)/4)
*before 15th July
gen svy`i'_22s=1 if SV==1 & offdate<y`i'start+317 & year(offdate)/4~=trunc(year(offdate)/4)
gen off`i'_22s=totaloff if offdate<y`i'start+317 & year(offdate)/4~=trunc(year(offdate)/4)
gen tewio`i'_22s=tottewio if offdate<y`i'start+317 & year(offdate)/4~=trunc(year(offdate)/4)
gen sum`i'_22s=totsum if offdate<y`i'start+317 & year(offdate)/4~=trunc(year(offdate)/4)
replace svy`i'_22s=1 if SV==1 & offdate<y`i'start+318 & year(offdate)/4==trunc(year(offdate)/4)
replace off`i'_22s=totaloff if offdate<y`i'start+318 & year(offdate)/4==trunc(year(offdate)/4)
replace tewio`i'_22s=tottewio if offdate<y`i'start+318 & year(offdate)/4==trunc(year(offdate)/4)
replace sum`i'_22s=totsum if offdate<y`i'start+318 & year(offdate)/4==trunc(year(offdate)/4)
local i=`i'+1
}
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace svy`k'_`i's=0 if svy`k'_`i's~=1
replace off`k'_`i's=0 if off`k'_`i's>=.
replace tewio`k'_`i's=0 if tewio`k'_`i's>=.
replace sum`k'_`i's=0 if sum`k'_`i's>=.
local i=`i'+1
}
local k=`k'+1
}
local i=1
while `i'<23 {
bysort pmra: egen y7_sve`i'=max(svy7_`i's)
bysort pmra: egen y7_off`i'=max(off7_`i's)
local i=`i'+1
}
local i=1
while `i'<23 {
bysort pmra: egen y8_sve`i'=max(svy8_`i's)
bysort pmra: egen y8_off`i'=max(off8_`i's)
local i=`i'+1
}
local i=1
while `i'<23 {
bysort pmra: egen y9_sve`i'=max(svy9_`i's)
bysort pmra: egen y9_off`i'=max(off9_`i's)
local i=`i'+1
}
local i=1
while `i'<23 {
bysort pmra: egen y10_sve`i'=max(svy10_`i's)
bysort pmra: egen y10_off`i'=max(off10_`i's)
local i=`i'+1
}
local i=1
while `i'<23 {
bysort pmra: egen y11_sve`i'=max(svy11_`i's)
bysort pmra: egen y11_off`i'=max(off11_`i's)
local i=`i'+1
}
keep pmra y7_sve1-y11_sum22
duplicates drop
compress
*File containing eligibility indicators for each two week period based on no previous serious violence
save eligible_all_sv, replace

**Get outcome data in format ready to merge with exposure/confounder files
use alloffences
order pmra 
drop mojuid offnum conviction Offence offenceage offtype
duplicates drop

**Create SV outcome file + near-miss outcome file 
*Will need to merge with exposure file; then keep only offences occurring from date of exclusion to 12 months later, can then generate outcome 0/1, plus will
*have date of outcome
keep if SV==1 | homnmiss==1
save outcomes_temp, replace



