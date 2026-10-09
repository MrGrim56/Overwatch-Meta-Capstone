# Overwatch-Meta-Capstone
Capstone project for Google Certification 
# Overwatch 2: Competitive Meta Viability Analysis
**Google Data Analytics Professional Certificate — Capstone Project (Track B)**

[![Looker Studio](https://img.shields.io/badge/Looker_Studio-Interactive_Dashboard-blue)]
([LOOKER_STUDIO_SHARE_LINK_HERE](https://datastudio.google.com/reporting/d11c3ea2-c522-43e9-8805-13d97880524d))
[![BigQuery](https://img.shields.io/badge/Google_Cloud-BigQuery-orange)](#)

---

## Executive Summary
This project analyzes competitive telemetry across 53 heroes and 8 competitive ranks (Bronze through Grandmaster / Top 500) to examine how hero selection, mechanical ceilings, and ban prioritization drive match victory in *Overwatch*. 

Key findings show that **Pick Rate correlates neutrally to negatively with Win Rate across lower and mid tiers ($r = -0.100$ overall)**, revealing that player perception and "meta hype" regularly prioritize inefficient picks over high-converting specialists.

---

## 1. Ask
* **Business Task:** Identify how character pick rates, rank brackets, and ban friction influence competitive success.
* **Key Stakeholders:** Solo-queue climbers, esports team captains, and match analysts.
* **Core Questions:**
  1. Does higher hero popularity guarantee higher win rates?
  2. How does hero viability scale from low mechanical tiers (Bronze) to high tiers (Grandmaster)?
  3. Are competitive bans aligned with true statistical efficacy or driven by perceived frustration?

---

## 2. Prepare
* **Data Source:** Official Blizzard Entertainment Overwatch Hero Statistics (Rates) first-party match telemetry.
* **Parameters:** PC platform, Americas region, Role Queue (`rq=1`) covering 424 observations across 8 competitive divisions.
* **ROCCC Evaluation:** High reliability and originality due to first-party server telemetry; free from public-profile scraper sampling biases.

---

## 3. Process
* **Integrity Audit:** Corrected reversed `Pick Rate` and `Win Rate` columns identified during initial exploratory data checks.
* **Normalization:** Repaired character string truncations (`CIO` -> `LUCIO`, `Torb` -> `Torbjörn`).
* **Reshaping:** Unpivoted the wide 48-column matrix into a relational, tidy schema (`overwatch_competitive_clean_tidy.csv`).
* **Database Ingestion:** Loaded into Google Cloud Platform BigQuery (`andy-503516.Capstone.hero_rates_tidy`).

---

## 4. Analyze

### 4-Quadrant Meta Matrix (Grandmaster / Top 500)
Segmented using a 50.0% win rate benchmark and tier median pick rate (7.0%):
* **Q1: Meta Dominant (High Pick, High Win):** Ana, Tracer, Cassidy, D.Mon (57.9% WR), Jetpack Cat (53.7% WR).
* **Q2: Sleeper Specialists (Low Pick, High Win):** Pharah (53.4% WR), Domina (53.4% WR), Junkrat (52.5% WR), Echo (51.7% WR).
* **Q3: Fringe / Off-Meta (Low Pick, Low Win):** Sierra (43.5% WR), Mauga (44.1% WR), Ramattra (45.7% WR).
* **Q4: Meta Traps (High Pick, Low Win):** Kiriko (41.4% PR, 45.7% WR), Sojourn (19.8% PR, 47.8% WR).

### Mechanical Ceiling vs. Low-Floor Falloff ($\Delta$ WR: Bronze to GM)
* **Top Mechanical Gainers:** Echo (+4.8%), Baptiste (+4.4%), Pharah (+4.1%), Sojourn (+4.1%).
* **Top Tier Fallers:** Sierra (-6.9%), Torbjörn (-5.1%), Mei (-5.0%), Ramattra (-4.7%).

---

## 5. Share
* **Interactive Dashboard:** Built in **Google Looker Studio** connected directly to BigQuery view `vw_hero_viability_master`.
* **Features:**
  * Interactive rank division filter (Bronze through GM).
  * 4-Quadrant scatter plot with dynamic role color-coding and ban-weighted bubbles.
  * Companion cross-filtering table to enable seamless selection of tightly clustered data points.

![Dashboard Preview](assets/looker_dashboard_preview.png)

---

## 6. Act (Strategic Recommendations)
1. **For Solo-Queue Climbers:** Stop emulating pro-tier hero picks in uncoordinated ranks. High-maintenance heroes like Kiriko and Sojourn generate negative win equity without high-tier team synergy. Exploit Quadrant 2 sleeper specialists like Pharah and Junkrat.
2. **For Team Captains & Coaches:** Reallocate ban capital. Stop burning bans on low-conversion nuisance heroes like Mauga (44.1% WR) and direct bans strictly toward actual statistical anomalies like D.Mon (57.9% WR) and Jetpack Cat (53.7% WR).
