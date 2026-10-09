WITH tier_benchmarks AS (
    SELECT
        Rank,
        Hero,
        Role,
        Win_Rate,
        Pick_Rate,
        Ban_Rate,
        PERCENTILE_CONT(Pick_Rate, 0.5) OVER (PARTITION BY Rank) AS median_pick_rate
    FROM `andy-503516.Capstone.hero_rates_tidy`
)
SELECT 
    Rank,
    Hero,
    Role,
    Win_Rate,
    Pick_Rate,
    Ban_Rate,
    CASE
        WHEN Pick_Rate >= median_pick_rate AND Win_Rate >= 50.0 THEN 'Q1: Meta Dominant'
        WHEN Pick_Rate <  median_pick_rate AND Win_Rate >= 50.0 THEN 'Q2: Sleeper / Specialist'
        WHEN Pick_Rate <  median_pick_rate AND Win_Rate <  50.0 THEN 'Q3: Underpowered / Fringe'
        WHEN Pick_Rate >= median_pick_rate AND Win_Rate <  50.0 THEN 'Q4: Meta Trap'
    END AS meta_quadrant
FROM tier_benchmarks
WHERE Rank = 'Grandmaster / Top 500'
ORDER BY meta_quadrant ASC, Win_Rate DESC;