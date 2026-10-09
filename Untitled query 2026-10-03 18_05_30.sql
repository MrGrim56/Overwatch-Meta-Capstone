SELECT
    gm.Hero,
    gm.Role,
    b.Win_Rate AS bronze_win_rate,
    gm.Win_Rate AS gm_win_rate,
    ROUND(gm.Win_Rate - b.Win_Rate, 2) AS win_rate_delta,
    b.Pick_Rate AS bronze_pick_rate,
    gm.Pick_Rate AS gm_pick_rate,
    ROUND(gm.Pick_Rate - b.Pick_Rate, 2) AS pick_rate_delta,
    CASE 
        WHEN (gm.Win_Rate - b.Win_Rate) >= 3.0 THEN 'High Skill Scaler (Ceiling Beneficiary)'
        WHEN (gm.Win_Rate - b.Win_Rate) <= -3.0 THEN 'Low Rank Dependent (Punished at High Elo)'
        ELSE 'Skill Stable'
    END AS tier_scaling_category
FROM `andy-503516.Capstone.hero_rates_tidy` gm
JOIN `andy-503516.Capstone.hero_rates_tidy` b
    ON gm.Hero = b.Hero
WHERE gm.Rank = 'Grandmaster / Top 500'
  AND b.Rank = 'Bronze'
ORDER BY win_rate_delta DESC;