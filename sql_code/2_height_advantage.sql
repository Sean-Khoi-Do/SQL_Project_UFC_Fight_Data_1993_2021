--How does Height relate to the outcome?

SELECT
    winner AS who_won,
    COUNT(*) AS count_of_winners
FROM
    (SELECT
        (CASE
            WHEN
                (CASE -- Determines the taller fighter
                    WHEN R_Height_cms > B_Height_cms THEN r_fighter
                    WHEN B_Height_cms > R_Height_cms THEN b_fighter
                    ELSE NULL
                END
                ) =
                (CASE
                    WHEN winner = 'Red' THEN r_fighter
                    WHEN winner = 'Blue' THEN b_fighter
                    WHEN winner = 'Draw' THEN 'Draw'
                END
                ) THEN 'Taller fighter won' ELSE 'Shorter fighter won'
        END
        ) AS winner
    FROM
        ufc_data
    WHERE
        (CASE
            WHEN R_Height_cms > B_Height_cms THEN r_fighter
            WHEN B_Height_cms > R_Height_cms THEN b_fighter
            WHEN R_Height_cms = B_Height_cms THEN NULL
        END
        ) IS NOT NULL AND
        (CASE
            WHEN winner = 'Red' THEN r_fighter
            WHEN winner = 'Blue' THEN b_fighter
            WHEN winner = 'Draw' THEN 'Draw'
        END
        ) <> 'Draw'
    ) AS did_taller_win
GROUP BY
    did_taller_win.winner