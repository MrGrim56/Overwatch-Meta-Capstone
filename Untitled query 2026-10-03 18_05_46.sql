SELECT 
    Rank,
    COUNT(Hero) AS hero_count,
    ROUND(AVG(Win_Rate), 2) AS avg_win_rate,
    ROUND(AVG(Pick_Rate), 2) AS avg_pick_rate,
    ROUND(AVG(Ban_Rate), 2) AS avg_ban_rate
FROM `andy-503516.Capstone.hero_rates_tidy`
GROUP BY Rank
ORDER BY 
    CASE Rank
        WHEN 'Bronze' THEN 1
        WHEN 'Silver' THEN 2
        WHEN 'Gold' THEN 3
        WHEN 'Platinum' THEN 4
        WHEN 'Emerald' THEN 5
        WHEN 'Diamond' THEN 6
        WHEN 'Masters' THEN 7
        WHEN 'Grandmaster / Top 500' THEN 8
    END;