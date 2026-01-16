************************************************************
*  Beliefs about Gender & Task Performance – Analysis Do-file
*  Project: Bordalo et al. replication (Ashoka)
*  Author:   Shashvathi Hariharan, Madhumitha GI, Neha Maniar, Elizabeth Jose, Akriti Verma
*IMPORTANT:
*This repository uses SYNTHETIC DATA generated to pilot the experimental design, validate power calculations, and stress-test the analysis pipeline prior to field deployment.

*Results are illustrative only and do not reflect real participant data.

*Randomization and treatment assignment were implemented via Qualtrics.
************************************************************

version 18
clear all
set more off

*-----------------------------------------------------------*
* 0. IMPORT DATA & BASIC OVERVIEW
*-----------------------------------------------------------*


global data_path "../data/synthetic"
use "$data_path/experimental_synthetic.csv", clear

describe
summarize

*-----------------------------------------------------------*
* 1. BASIC DESCRIPTIVE GRAPHS: SAMPLE COMPOSITION
*-----------------------------------------------------------*

* Gender composition
graph pie, over(gender) ///
    plabel(_all percent, format(%4.1f)) ///
    title("Gender Composition of Sample")

* Major composition
graph pie, over(major) ///
    plabel(_all percent, format(%4.1f)) ///
    title("Major Composition of Sample")

* Age composition
graph pie, over(age_cat) ///
    plabel(_all percent, format(%4.1f)) ///
    title("Age Composition of Sample")

* Year of study composition
graph pie, over(year_of_study) ///
    plabel(_all percent, format(%4.1f)) ///
    title("Year of Study Composition of Sample")


*-----------------------------------------------------------*
* 2. PERFORMANCE & SELF-BELIEFS BY GENDER
*-----------------------------------------------------------*

* Actual performance in Cars vs Beauty by gender
graph bar cars_correct beauty_correct, ///
    over(gender) blabel(bar) ///
    title("Actual Performance by Gender") ///
    ytitle("Correct Answers") ///
    legend(order(1 "Cars" 2 "Beauty & Skincare"))

* Self-beliefs in Cars vs Beauty by gender
graph bar selfbelief_cars selfbelief_beauty, ///
    over(gender) blabel(bar) ///
    title("Self-Beliefs by Gender") ///
    ytitle("Believed Score") ///
    legend(order(1 "Cars" 2 "Beauty & Skincare"))


*-----------------------------------------------------------*
* 3. KERNEL DENSITIES: SELF-DISTORTION BY GENDER
*-----------------------------------------------------------*

* Self distortion in Beauty
twoway ///
    (kdensity distort_self_beauty if gender == "Female", ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity distort_self_beauty if gender == "Male", ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "Women" 2 "Men") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Self Distortion in Beauty") ///
    title("Kernel Density of Self Distortion in Beauty, by Gender")

* Self distortion in Cars
twoway ///
    (kdensity distort_self_cars if gender == "Female", ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity distort_self_cars if gender == "Male", ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "Women" 2 "Men") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Self Distortion in Cars") ///
    title("Kernel Density of Self Distortion in Cars, by Gender")


*-----------------------------------------------------------*
* 4. DYAD CONSTRUCTION (TREATMENT ONLY)
*-----------------------------------------------------------*
* dyad_type:
*   1 = F_F  (Female subject – Female partner)
*   2 = M_M  (Male subject – Male partner)
*   3 = M_F  (Male subject – Female partner)
*   4 = F_M  (Female subject – Male partner)
* Note: defined only when treatment_pronoun == 1

gen dyad_type = . 
replace dyad_type = 1 if treatment_pronoun == 1 & gender == "Female" & partner_gender == 2   // F_F
replace dyad_type = 2 if treatment_pronoun == 1 & gender == "Male"   & partner_gender == 1   // M_M
replace dyad_type = 3 if treatment_pronoun == 1 & gender == "Male"   & partner_gender == 2   // M_F
replace dyad_type = 4 if treatment_pronoun == 1 & gender == "Female" & partner_gender == 1   // F_M

label define dyad_lbl 1 "F_F" 2 "M_M" 3 "M_F" 4 "F_M"
label values dyad_type dyad_lbl


*-----------------------------------------------------------*
* 5. KERNEL DENSITIES: PARTNER SCORE BELIEFS BY DYAD TYPE
*-----------------------------------------------------------*

* Partner score belief: F_F vs M_M
twoway ///
    (kdensity partner_score_belief if dyad_type == 1, ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity partner_score_belief if dyad_type == 2, ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "F_F" 2 "M_M") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Partner Score Belief") ///
    title("Partner Score Belief: F_F vs M_M (Treatment Only)")

* Partner score belief: F_M vs M_F
twoway ///
    (kdensity partner_score_belief if dyad_type == 4, ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity partner_score_belief if dyad_type == 3, ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "F_M" 2 "M_F") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Partner Score Belief") ///
    title("Partner Score Belief: F_M vs M_F (Treatment Only)")


* Partner cars belief: F_M vs M_F
twoway ///
    (kdensity partner_cars_belief if dyad_type == 4, ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity partner_cars_belief if dyad_type == 3, ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "F_M" 2 "M_F") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Partner Cars Belief") ///
    title("Partner Cars Belief: F_M vs M_F (Treatment Only)")

* Partner cars belief: F_F vs M_M
twoway ///
    (kdensity partner_cars_belief if dyad_type == 1, ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity partner_cars_belief if dyad_type == 2, ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "F_F" 2 "M_M") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Partner Cars Belief") ///
    title("Partner Cars Belief: F_F vs M_M (Treatment Only)")


* Partner beauty belief: F_M vs M_F
twoway ///
    (kdensity partner_beauty_belief if dyad_type == 4, ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity partner_beauty_belief if dyad_type == 3, ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "F_M" 2 "M_F") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Partner Beauty Belief") ///
    title("Partner Beauty Belief: F_M vs M_F (Treatment Only)")

* Partner beauty belief: F_F vs M_M
twoway ///
    (kdensity partner_beauty_belief if dyad_type == 1, ///
        lcolor(blue) lwidth(medthick)) ///
    (kdensity partner_beauty_belief if dyad_type == 2, ///
        lcolor("255 105 180") lwidth(medthick)) ///
    , ///
    legend(order(1 "F_F" 2 "M_M") pos(11) ring(0)) ///
    ytitle("Density") ///
    xtitle("Partner Beauty Belief") ///
    title("Partner Beauty Belief: F_F vs M_M (Treatment Only)")


*-----------------------------------------------------------*
* 6. TESTS: SELF-DISTORTION BY GENDER
*-----------------------------------------------------------*


ttest distort_self_cars,    by(gender)
ttest distort_self_beauty,  by(gender)


*-----------------------------------------------------------*
* 7. TESTS: PARTNER BELIEFS BY DYAD TYPE (TREATMENT SAMPLE)
*-----------------------------------------------------------*

* Male participants: M_F vs M_M
gen dyad_MF_MM = . 
replace dyad_MF_MM = 1 if dyad_type == 3   // M_F
replace dyad_MF_MM = 0 if dyad_type == 2   // M_M

ttest partner_cars_belief,    by(dyad_MF_MM)
ttest partner_beauty_belief,  by(dyad_MF_MM)

* Female participants: F_M vs F_F
gen dyad_FM_FF = .
replace dyad_FM_FF = 1 if dyad_type == 4   // F_M
replace dyad_FM_FF = 0 if dyad_type == 1   // F_F

ttest partner_cars_belief,    by(dyad_FM_FF)
ttest partner_beauty_belief,  by(dyad_FM_FF)


*-----------------------------------------------------------*
* 8. REGRESSIONS: GENDER MATCHING & PARTNER BELIEFS
*-----------------------------------------------------------*
* Variables:
*   - female:           1 = female, 0 = male (numeric)
*   - gender_matching:  1 = subject and partner same gender, 0 = control, 2= gender mismatched
*   - agenumeric:       numeric age category (encoded from age_cat)
*   - major_num:        numeric major category (encoded from major)
*   - year_of_study:    numeric year (if still string, encode first)

encode gender, gen(gender_num)
label list gender_num

encode age, gen(age_num)
label list age_num

encode major, gen(major_num)
label list major_num


* Baseline regressions (no controls)
reg partner_confidence     i.gender_matching, robust
reg partner_score_belief   i.gender_matching, robust
reg partner_cars_belief i.gender_matching gender_num, robust
reg partner_cars_belief  gender_num, robust

* Interaction of gender and matching (no controls)
reg partner_confidence gender_num##i.gender_matching, robust

* Interaction with controls
reg partner_confidence     gender_num##i.gender_matching age_num i.major_num i.year_of_study, robust
reg partner_beauty_belief  gender_num##i.gender_matching age_num i.major_num i.year_of_study, robust
reg partner_cars_belief    gender_num##i.gender_matching age_num i.major_num i.year_of_study, robust


************************************************************
* POWER ANALYSIS USING PARAMETERS FROM BORdALO ET AL. (2019)
* Table 4: Bank-level beliefs about others (0–1 scale)
************************************************************

* Strong stereotype effect: beliefs about men
* θσ = 0.45 (Table 4, col. 3) – probability points
* Assume sd of belief ≈ 0.23 (since we do not know the s.e. of the belief we can assume it to be 0.23. We use this value by estimating the pooled sd from our sample)

power twomeans 0 0.45, sd(0.23) power(0.8)

* This asks: how many observations do we need to detect
* a 0.45 difference in mean beliefs with sd = 0.25 at 80% power?

* Smaller stereotype effect: beliefs about women
* θσ = 0.14 (Table 4, col. 4)

power twomeans 0 0.14, sd(0.23) power(0.8)

* This asks: how many observations do we need to detect
* a 0.14 difference in mean beliefs with sd = 0.25 at 80% power?


************************************************************
*  END OF DO-FILE
************************************************************
