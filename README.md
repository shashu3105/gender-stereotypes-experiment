# gender-stereotypes-experiment
# Beliefs about Gender and Task Performance

This is a team-based experimental economics project adapting 
Bordalo et al. (2019)to study how gender stereotypes shape beliefs 
about task performance in male-typed and female-typed domains.
I designed the survey instrument and implemented partner-gender 
revelation randomization via Qualtrics.
Further, I conducted a power analysis using published effect sizes
from Bordalo et al. (2019) to confirm an adequate sample size prior to data collection
---

## Important Note on Data

This repository does **not** contain real participant data.

All data provided in `data/synthetic/` are synthetic and were generated
to pilot the experimental design, validate power calculations, and
stress-test the analysis pipeline.

Results produced using this data are illustrative only and should not be
interpreted as empirical estimates.

---

## Experimental Design Overview

- **Design:** Laboratory-style experimental economics study  
- **Treatment:** Partner gender salience via pronoun revelation  
- **Randomization:** Implemented via Qualtrics at survey runtime  
- **Outcomes:**  
  - Self-beliefs about task performance  
  - Beliefs about partner performance  
  - Belief distortion measures by task domain  

---

## Methods

The analysis workflow includes:

- Construction of treatment and dyad-type variables  
- Balance checks to verify randomized assignment  
- OLS regressions with interaction terms  
- Heterogeneity analysis by subject gender and dyad composition  
- Visualization of belief distributions  
- Power analysis using published effect sizes from Bordalo et al. (2019)  
---
## Repository Structure

code/        Stata analysis scripts
data/        Data documentation and synthetic datasets
docs/        Presentation and supporting materials
output/      Generated figures and outputs


