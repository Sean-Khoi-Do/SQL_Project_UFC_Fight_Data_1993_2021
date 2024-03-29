--How does Reach relate to the outcome?

SELECT
    winner AS who_won,
    COUNT(*) AS count_of_winners
FROM
    (SELECT
        (CASE
            WHEN
                (CASE -- Determines which fighter has the longer reach advantage
                    WHEN R_Reach_cms > B_Reach_cms THEN r_fighter
                    WHEN B_Reach_cms > R_Reach_cms THEN b_fighter
                    ELSE NULL
                END
                ) =
                (CASE
                    WHEN winner = 'Red' THEN r_fighter
                    WHEN winner = 'Blue' THEN b_fighter
                    WHEN winner = 'Draw' THEN 'Draw'
                END
                ) THEN 'Longer reach won' ELSE 'Shorter reach won'
        END
        ) AS winner
    FROM
        ufc_data
    WHERE
        (CASE
            WHEN R_Reach_cms > B_Reach_cms THEN r_fighter
            WHEN B_Reach_cms > R_Reach_cms THEN b_fighter
            WHEN R_Reach_cms = B_Reach_cms THEN NULL
        END
        ) IS NOT NULL AND
        (CASE
            WHEN winner = 'Red' THEN r_fighter
            WHEN winner = 'Blue' THEN b_fighter
            WHEN winner = 'Draw' THEN 'Draw'
        END
        ) <> 'Draw'
    ) AS did_longer_win
GROUP BY
    did_longer_win.winner