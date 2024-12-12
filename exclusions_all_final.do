*Code to extract exclusions from all years
*January 2023

***********************************************************************************************************************************************
**Takes raw exclusions data and separates into suspensions and permanent exclusions. Keeps variables of interest. Appends files for all years**
***********************************************************************************************************************************************

version 16
clear
clear all
cd "P:\XXXXXXXXXXX\XXXXXXXXXXXXX\XXXXXXXXXXXXX"
************************************************************************************

*Extract fixed-term exclusions (suspensions)

insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2006.txt", tab names
rename pupilmatchingref pmra
drop academicyear_ex06 connexions_ex06 enrolstatus_ex06 source_characteristics_ex06 numberofenrolments_ex06 permanentexclusionindicator_ex06 gender_ex06
drop term*
local i=1
while `i'<27 {
rename category_`i'_ex06 category`i'
rename reason_`i'_ex06 reason`i'
rename startdate_`i'_ex06 startdate`i'
rename sessions_`i'_ex06 sessions`i'
local i=`i'+1
}
reshape long category reason startdate sessions, i(pmra) j(exclno)
drop if category==""
*Drop permanent exclusions
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=6
save fexclusions05_06
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2007.txt", tab names
drop academicyear connexions enrolstatus source_char numberofenrol permanentexclusionindicator gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex07 category`i'
rename reason_`i'_ex07 reason`i'
rename startdate_`i'_ex07 startdate`i'
rename sessions_`i'_ex07 sessions`i'
local i=`i'+1
}
reshape long category reason startdate sessions, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=7
save fexclusions06_07
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2008.txt", tab names
drop academicyear connexions enrolstatus source_char numberofenrol permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex08 category`i'
rename reason_`i'_ex08 reason`i'
rename startdate_`i'_ex08 startdate`i'
rename sessions_`i'_ex08 sessions`i'
local i=`i'+1
}
reshape long category reason startdate sessions, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=8
save fexclusions07_08
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2009.txt", tab names
drop academicyear connexions enrolstatus source_char numberofenrol permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex09 category`i'
rename reason_`i'_ex09 reason`i'
rename startdate_`i'_ex09 startdate`i'
rename sessions_`i'_ex09 sessions`i'
local i=`i'+1
}
reshape long category reason startdate sessions, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=9
save fexclusions08_09
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2010.txt", tab names
drop academicyear connexions enrolstatus source_char numberofenrol permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<40 {
rename category_`i'_ex10 category`i'
rename reason_`i'_ex10 reason`i'
rename startdate_`i'_ex10 startdate`i'
rename sessions_`i'_ex10 sessions`i'
rename ncyear_`i'_ex10 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=10
save fexclusions09_10
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2011.txt", tab names
drop academicyear connexions enrolstatus source_char numberofenrol permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex11 category`i'
rename reason_`i'_ex11 reason`i'
rename startdate_`i'_ex11 startdate`i'
rename sessions_`i'_ex11 sessions`i'
rename ncyear_`i'_ex11 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=11
save fexclusions10_11
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2012.txt", tab names
drop academicyear connexions enrolstatus source_char numberofenrol permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex12 category`i'
rename reason_`i'_ex12 reason`i'
rename startdate_`i'_ex12 startdate`i'
rename sessions_`i'_ex12 sessions`i'
rename ncyear_`i'_ex12 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=12
save fexclusions11_12
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2013.txt", tab names
drop academicyear yssa enrolstatus source_char numberofenrol permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex13 category`i'
rename reason_`i'_ex13 reason`i'
rename startdate_`i'_ex13 startdate`i'
rename sessions_`i'_ex13 sessions`i'
rename ncyear_`i'_ex13 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=13
save fexclusions12_13
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2014.txt", tab names
drop academicyear yssa enrolstatus source_char numberofenrol permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex14 category`i'
rename reason_`i'_ex14 reason`i'
rename startdate_`i'_ex14 startdate`i'
rename sessions_`i'_ex14 sessions`i'
rename ncyear_`i'_ex14 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=14
save fexclusions13_14
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2015.txt", tab names
drop academicyear yssa enrolstatus source_char numberofenrol permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex15 category`i'
rename reason_`i'_ex15 reason`i'
rename startdate_`i'_ex15 startdate`i'
rename sessions_`i'_ex15 sessions`i'
rename ncyear_`i'_ex15 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=15
save fexclusions14_15
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2016.txt", tab names
drop academicyear yssa enrolstatus source_char numberofenrol permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* 
local i=1
while `i'<41 {
rename category_`i'_ex16 category`i'
rename reason_`i'_ex16 reason`i'
rename startdate_`i'_ex16 startdate`i'
rename sessions_`i'_ex16 sessions`i'
rename ncyear_`i'_ex16 ncyear`i'
local i=`i'+1
}
tostring ncyear*, replace
reshape long category reason startdate sessions ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="P"
drop exclno category
rename startdate sdate
gen acadyr=16
save fexclusions15_16

use fexclusions05_06
append using fexclusions06_07
append using fexclusions07_08
append using fexclusions08_09
append using fexclusions09_10
append using fexclusions10_11
append using fexclusions11_12
append using fexclusions12_13
append using fexclusions13_14
append using fexclusions14_15
append using fexclusions15_16
**Keep data for those born in the years of interest only (pmra_list_final is dataset containing pmra for these individuals)
merge m:1 pmra using pmra_list_final
keep if _merge==3
drop _merge
*Calculate total number of suspensions and total sessions suspended per individual per academic year 
gen totalfixed= totalfixedexclusions_ex06 if acadyr==6
gen totalsessions= totalfixedsessions_ex06 if acadyr==6
local i=7
while `i'<10 {
replace totalfixed= totalfixedexclusions_ex0`i' if acadyr==`i'
replace totalsessions= totalfixedsessions_ex0`i' if acadyr==`i'
local i=`i'+1
}
local i=10
while `i'<17 {
replace totalfixed= totalfixedexclusions_ex`i' if acadyr==`i'
replace totalsessions= totalfixedsessions_ex`i' if acadyr==`i'
local i=`i'+1
}
drop totalfixedexclusions* totalfixedsessions*

*These are fixed-term exclusions among those born 1993/04-2003/04 with sufficient data during secondary school
*Link to dataset containing cleaned information on school year attended per academic year. Fill in missing school years from this.
merge m:1 pmra using ncyears_1993_2003
keep if _merge==3
drop _merge
*Drop exclusions after year 11
gen drop=1 if ncyear=="12" | ncyear=="13" | ncyear=="14"
replace drop=1 if ncyear=="" & acadyr+2000>year11
replace ncyear="" if ncyear=="X"
replace ncyear="0" if ncyear=="R"
replace ncyear="" if ncyear=="X"
replace ncyear="-1" if substr(ncyear,1,1)=="N"
destring ncyear, replace
replace ncyear=11 if ncyear>=. & acadyr+2000==year11
replace ncyear=10 if ncyear>=. & acadyr+2001==year11
replace ncyear=9 if ncyear>=. & acadyr+2002==year11
replace ncyear=8 if ncyear>=. & acadyr+2003==year11
replace ncyear=7 if ncyear>=. & acadyr+2004==year11
replace ncyear=6 if ncyear>=. & acadyr+2000==year6
replace ncyear=5 if ncyear>=. & acadyr+2001==year6
replace ncyear=4 if ncyear>=. & acadyr+2002==year6
replace ncyear=3 if ncyear>=. & acadyr+2003==year6
replace ncyear=2 if ncyear>=. & acadyr+2004==year6
replace ncyear=1 if ncyear>=. & acadyr+2005==year6
replace ncyear=0 if ncyear>=. & acadyr+2000==ks0
replace ncyear=0 if ncyear>=. & acadyr+2000<ks0
replace ncyear=12 if ncyear>=. & acadyr+1999==year11
replace ncyear=13 if ncyear>=. & acadyr+1998==year11
drop byear-ncy16
replace drop=1 if ncyear>11
drop if drop==1
drop drop
compress
gen startf=date(sdate,"YMD")
format startf %d
sort pmra startf
bysort pmra: gen fexclnum=_N
bysort pmra: gen fexclno=_n
**Calculated total suspensions and total sessions suspended for per pupil (for eligibility criteria)
bysort pmra: egen totalexsess=total(totalsessions)
bysort pmra: egen maxsess=max(totalsessions)
compress
save fexclusions_all, replace

*THOSE ELIGIBLE FOR EXCLUSIONS ANALYSIS HAVE TO HAVE BEEN SUSPENSED FOR AT LEAST 2 SESSIONS 
keep pmra fexclnum totalexsess maxsess
duplicates drop
drop if totalexsess<2
drop if maxsess<2 
compress
drop fexclnum totalexsess
save pmra_denom_fixed, replace

***********************************************************************************************************
***Extract permanent exclusions from all years

insheet censusdt pmra mojuid gender sdate exclind using "P:\XXXXXX\XXXXXXXX\Exclusions_2002.txt", tab names
drop censusdt 
keep if exclind=="P"
drop exclind gender
gen acadyr=2
save pexclusions01_02
clear
insheet censusdt pmra mojuid gender sdate exclind using "P:\XXXXXX\XXXXXXXX\Exclusions_2003.txt", tab names
drop censusdt 
keep if exclind=="P"
drop exclind gender
gen acadyr=3
save pexclusions02_03
clear
insheet pmra mojuid gender sdate exclind using "P:\XXXXXX\XXXXXXXX\Exclusions_2004.txt", tab names
keep if exclind=="P"
drop exclind gender
gen acadyr=4
save pexclusions03_04
*Some fixed exclusions appear to be in this file but no details
clear
insheet collect pmra mojuid gender sdate exclind using "P:\XXXXXX\XXXXXXXX\Exclusions_2005.txt", tab names
drop collect gender
keep if substr(exclind,1,1)=="P"
drop exclind
gen acadyr=5
save pexclusions04_05

**This is where details come in - reasons for exclusions etc + fixed exclusions
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2006.txt", tab names
keep if permanentexclusionindicator_ex06==1
drop academicyear_ex06 connexions_ex06 enrolstatus_ex06 source_characteristics_ex06 numberofenrolments_ex06 totalfixedexclusions_ex06 totalfixedsessions_ex06 ///
    permanentexclusionindicator_ex06 gender_ex06
*This line will need editing for each year:
drop category_19_ex06-sessions_26_ex06
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<19 {
rename category_`i'_ex06 category`i'
rename reason_`i'_ex06 reason`i'
rename startdate_`i'_ex06 startdate`i'
local i=`i'+1
}
reshape long category reason startdate, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=6
save pexclusions05_06
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2007.txt", tab names
keep if permanentexclusionindicator==1
drop academicyear connexions enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusionindicator gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex07 category`i'
rename reason_`i'_ex07 reason`i'
rename startdate_`i'_ex07 startdate`i'
local i=`i'+1
}
reshape long category reason startdate, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=7
save pexclusions06_07
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2008.txt", tab names
drop if permanentexclusioncount==0
drop academicyear connexions enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex08 category`i'
rename reason_`i'_ex08 reason`i'
rename startdate_`i'_ex08 startdate`i'
local i=`i'+1
}
reshape long category reason startdate, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=8
save pexclusions07_08
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2009.txt", tab names
drop if permanentexclusioncount==0
drop academicyear connexions enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex09 category`i'
rename reason_`i'_ex09 reason`i'
rename startdate_`i'_ex09 startdate`i'
local i=`i'+1
}
reshape long category reason startdate, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=9
save pexclusions08_09
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2010.txt", tab names
drop if permanentexclusioncount==0
drop academicyear connexions enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<40 {
rename category_`i'_ex10 category`i'
rename reason_`i'_ex10 reason`i'
rename startdate_`i'_ex10 startdate`i'
rename ncyear_`i'_ex10 ncyear`i'
local i=`i'+1
}
tostring ncyear22-ncyear39, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=10
save pexclusions09_10
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2011.txt", tab names
drop if permanentexclusioncount==0
drop academicyear connexions enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex modeoftrav
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex11 category`i'
rename reason_`i'_ex11 reason`i'
rename startdate_`i'_ex11 startdate`i'
rename ncyear_`i'_ex11 ncyear`i'
local i=`i'+1
}
tostring ncyear16-ncyear40, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=11
save pexclusions10_11
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2012.txt", tab names
drop if permanentexclusioncount==0
drop academicyear connexions enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex12 category`i'
rename reason_`i'_ex12 reason`i'
rename startdate_`i'_ex12 startdate`i'
rename ncyear_`i'_ex12 ncyear`i'
local i=`i'+1
}
tostring ncyear18-ncyear40, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=12
save pexclusions11_12
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2013.txt", tab names
drop if permanentexclusioncount==0
drop academicyear yssa enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex13 category`i'
rename reason_`i'_ex13 reason`i'
rename startdate_`i'_ex13 startdate`i'
rename ncyear_`i'_ex13 ncyear`i'
local i=`i'+1
}
tostring ncyear32-ncyear40, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=13
save pexclusions12_13
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2014.txt", tab names
drop if permanentexclusioncount==0
drop academicyear yssa enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex14 category`i'
rename reason_`i'_ex14 reason`i'
rename startdate_`i'_ex14 startdate`i'
rename ncyear_`i'_ex14 ncyear`i'
local i=`i'+1
}
tostring ncyear17-ncyear40, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=14
save pexclusions13_14
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2015.txt", tab names
drop if permanentexclusioncount==0
drop academicyear yssa enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex15 category`i'
rename reason_`i'_ex15 reason`i'
rename startdate_`i'_ex15 startdate`i'
rename ncyear_`i'_ex15 ncyear`i'
local i=`i'+1
}
tostring ncyear22-ncyear40, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=15
save pexclusions14_15
clear
insheet using "P:\XXXXXX\XXXXXXXX\Exclusions_2016.txt", tab names
drop if permanentexclusioncount==0
drop academicyear yssa enrolstatus source_char numberofenrol totalfixedexcl totalfixedsess permanentexclusioncount gender_ex 
rename pupilmatchingre pmra
drop term* sessions*
local i=1
while `i'<41 {
rename category_`i'_ex16 category`i'
rename reason_`i'_ex16 reason`i'
rename startdate_`i'_ex16 startdate`i'
rename ncyear_`i'_ex16 ncyear`i'
local i=`i'+1
}
tostring ncyear18-ncyear40, replace
reshape long category reason startdate ncyear, i(pmra) j(exclno)
drop if category==""
drop if substr(category,1,1)=="F"
drop exclno category
rename startdate sdate
gen acadyr=16
save pexclusions15_16

use pexclusions01_02
append using pexclusions02_03
append using pexclusions03_04
append using pexclusions04_05
append using pexclusions05_06
append using pexclusions06_07
append using pexclusions07_08
append using pexclusions08_09
append using pexclusions09_10
append using pexclusions10_11
append using pexclusions11_12
append using pexclusions12_13
append using pexclusions13_14
append using pexclusions14_15
append using pexclusions15_16

*Keep only those in our sample of interest
merge m:1 pmra using pmra_list_final
keep if _merge==3
drop _merge
*These will be permanent exclusions among those born 1993/04-2003/04 with sufficient data during secondary school who had 
*ever been suspended for more than a day 
merge m:1 pmra using pmra_denom_fixed
keep if _merge==3
drop _merge
save pexclusions_all, replace

*Link exclusions to clean version of school year data 
use urnleancyear
bysort pmra: gen recno=_n
keep if recno==1
drop recno
rename ncyear ncyr
save temp, replace
use pexclusions_all
merge m:1 pmra using temp
drop if _merge==2
drop _merge
replace acadyr=2000+acadyr
replace ncyear="" if ncyear=="X"
destring ncyear, replace
replace ncyear=ncyr+(acadyr-year) if ncyear>=.
drop ncyr year

*Drop exclusions after year 11
drop if ncyear>12
save pexclusions_working_file, replace

*Save details on exclusions in primary school
keep if ncyear<7
keep pmra mojuid ncyear
duplicates drop
save pexclusions_primary, replace

*Now drop primary school exclusions before year 6 from main file
use pexclusions_working_file
drop if ncyear<6
duplicates drop
gen startp=date(sdate,"YMD")
format startp %d
drop sdate
compress
save pexclusions_working_file, replace

*Get information on when started year 7 - will take 1st September as starting date for all
merge m:1 pmra using y7start
gen year7=year(y7start)
gen day=1
gen month=9
replace year7=acadyr-(ncyear-6) if _merge==1 
drop _merge
**Use year 7 starting date to generate start dates for years 8 to 11 (also take as 1st September)
replace y7start=mdy(month,day,year7) if y7start>=.
gen y8start=mdy(month,day,year7+1)
gen y9start=mdy(month,day,year7+2)
gen y10start=mdy(month,day,year7+3)
gen y11start=mdy(month,day,year7+4)
format y8start y9start y10start y11start %d
drop year7 day month 
sort pmra startp

**For each two week period in the school year, generate indicator for whether pupil was excluded in previous year
**variable names = pexy7e1-pexy11e22 (this goes from 1st September to 15th July = 22 two-week periods)
local i=7
while `i'<12 {
gen pexy`i'_1s=1 if startp>y`i'start-366 & startp<y`i'start
*before 15th Sept
gen pexy`i'_2s=1 if startp>y`i'start-366+14 & startp<y`i'start+14
*before 1st Oct
gen pexy`i'_3s=1 if startp>y`i'start-366+30 & startp<y`i'start+30
*before 15th Oct 
gen pexy`i'_4s=1 if startp>y`i'start-366+44 & startp<y`i'start+44
*before 1st Nov
gen pexy`i'_5s=1 if startp>y`i'start-366+61 & startp<y`i'start+61
*before 15th Nov
gen pexy`i'_6s=1 if startp>y`i'start-366+75 & startp<y`i'start+75
*before 1st Dec
gen pexy`i'_7s=1 if startp>y`i'start-366+91 & startp<y`i'start+91
*before 15th Dec
gen pexy`i'_8s=1 if startp>y`i'start-366+105 & startp<y`i'start+105
*before 1st Jan
gen pexy`i'_9s=1 if startp>y`i'start-366+122 & startp<y`i'start+122
*before 15th Jan
gen pexy`i'_10s=1 if startp>y`i'start-366+136 & startp<y`i'start+136
*before 1st Feb
gen pexy`i'_11s=1 if startp>y`i'start-366+153 & startp<y`i'start+153
*before 14th Feb
gen pexy`i'_12s=1 if startp>y`i'start-366+166 & startp<y`i'start+166
*before 1st March
gen pexy`i'_13s=1 if startp>y`i'start-366+181 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+181
replace pexy`i'_13s=1 if startp>y`i'start-366+182 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+182
*before 15th March
gen pexy`i'_14s=1 if startp>y`i'start-366+195 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+195
replace pexy`i'_14s=1 if startp>y`i'start-366+196 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+196
*before 1st April
gen pexy`i'_15s=1 if startp>y`i'start-366+212 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+212
replace pexy`i'_15s=1 if startp>y`i'start-366+213 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+213
*before 15th April
gen pexy`i'_16s=1 if startp>y`i'start-366+226 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+226
replace pexy`i'_16s=1 if startp>y`i'start-366+227 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+227
*before 1st May
gen pexy`i'_17s=1 if startp>y`i'start-366+242 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+242
replace pexy`i'_17s=1 if startp>y`i'start-366+243 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+243
*before 15th May
gen pexy`i'_18s=1 if startp>y`i'start-366+256 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+256
replace pexy`i'_18s=1 if startp>y`i'start-366+257 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+257
*before 1st June
gen pexy`i'_19s=1 if startp>y`i'start-366+273 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+273
replace pexy`i'_19s=1 if startp>y`i'start-366+274 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+274
*before 15th June
gen pexy`i'_20s=1 if startp>y`i'start-366+287 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+287
replace pexy`i'_20s=1 if startp>y`i'start-366+288 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+288
*before 1st July
gen pexy`i'_21s=1 if startp>y`i'start-366+303 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+303
replace pexy`i'_21s=1 if startp>y`i'start-366+304 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+304
*before 15th July
gen pexy`i'_22s=1 if startp>y`i'start-366+317 & year(startp)/4~=trunc(year(startp)/4) & startp<y`i'start+317
replace pexy`i'_22s=1 if startp>y`i'start-366+318 & year(startp)/4==trunc(year(startp)/4) & startp<y`i'start+318
local i=`i'+1
}
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace pexy`k'_`i's=0 if pexy`k'_`i's~=1
bysort pmra: egen pexy`k'e`i'=max(pexy`k'_`i's)
local i=`i'+1
}
local k=`k'+1
}
keep pmra pexy7e1-pexy11e22
duplicates drop
compress
*File = eligibility indicators for each two week period from start of year 7 to end of year 11
save pex_elig, replace

**Now generate file containing indicator for exclusion in each two week period of each school year from 7 to 11 
**(variable names = y7pex1-y11pex22)
use pexclusions_working_file
*Up to December
local i=7
while `i'<12 {
local k=1
while `k'<8 {
gen y`i'p`k'=1 if ncyear==`i' & month(startp)==trunc(`k'/2)+9 & day(startp)<15
local k=`k'+2
}
local i=`i'+1
}
*January-July
local i=7
while `i'<12 {
local k=9
while `k'<22 {
gen y`i'p`k'=1 if ncyear==`i' & month(startp)==trunc(`k'/2)-3 & day(startp)<15
local k=`k'+2
}
local i=`i'+1
}
*Up to December
local i=7
while `i'<12 {
local k=2
while `k'<9 {
gen y`i'p`k'=1 if ncyear==`i' & month(startp)==(`k'/2)+8 & day(startp)>=15
local k=`k'+2
}
local i=`i'+1
}
*January to July
local i=7
while `i'<12 {
local k=10
while `k'<23 {
gen y`i'p`k'=1 if ncyear==`i' & month(startp)==(`k'/2)-4 & day(startp)>=15
local k=`k'+2
}
local i=`i'+1
}
local k=7
while `k'<12 {
local i=1
while `i'<23 {
replace y`k'p`i'=0 if y`k'p`i'~=1
local i=`i'+1
}
local k=`k'+1
}
local k=7
while `k'<12 {
local i=1
while `i'<23 {
bysort pmra: egen y`k'pex`i'=max(y`k'p`i')
local i=`i'+1
}
local k=`k'+1
}
**
keep pmra y7pex1-y11pex22
duplicates drop
compress
save pexclusions_foranalysis, replace
