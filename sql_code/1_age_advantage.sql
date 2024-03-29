/*
MMA is a highly unpredictable sport. The goal of this project is to identify trends that I will help predict fight outcomes.

A few questions I hope to answer:
    - How does Age relate to the outcome?
    - How does Height relate to the outcome?
    - How does Reach relate to the outcome?
*/

--How does Age relate to the outcome?

SELECT
    winner AS who_won,
    COUNT(*) AS count_of_winners
FROM
    (SELECT
        (CASE
            WHEN
                (CASE -- Determines the older fighter
                    WHEN r_age > b_age THEN r_fighter
                    WHEN b_age > r_age THEN b_fighter
                    ELSE NULL
                END
                ) =
                (CASE
                    WHEN winner = 'Red' THEN r_fighter
                    WHEN winner = 'Blue' THEN b_fighter
                    WHEN winner = 'Draw' THEN 'Draw'
                END
                ) THEN 'Older fighter won' ELSE 'Younger fighter won'
        END
        ) AS winner
    FROM
        ufc_data
    WHERE
        (CASE
            WHEN r_age > b_age THEN r_fighter
            WHEN b_age > r_age THEN b_fighter
            WHEN r_age = b_age THEN NULL
        END
        ) IS NOT NULL AND
        (CASE
            WHEN winner = 'Red' THEN r_fighter
            WHEN winner = 'Blue' THEN b_fighter
            WHEN winner = 'Draw' THEN 'Draw'
        END
        ) <> 'Draw'
    ) AS did_older_win
GROUP BY
    did_older_win.winner


SELECT
    r_age,
    b_age
FROM ufc_data



SELECT
    winner AS who_won,
    r_age,
    b_age
FROM
    (SELECT
        r_age,
        b_age,
        (CASE
            WHEN
                (CASE -- Determines the older fighter
                    WHEN r_age > b_age THEN r_fighter
                    WHEN b_age > r_age THEN b_fighter
                    ELSE NULL
                END
                ) =
                (CASE
                    WHEN winner = 'Red' THEN r_fighter
                    WHEN winner = 'Blue' THEN b_fighter
                    WHEN winner = 'Draw' THEN 'Draw'
                END
                ) THEN 'Older fighter won' ELSE 'Younger fighter won'
        END
        ) AS winner
    FROM
        ufc_data
    WHERE
        (CASE
            WHEN r_age > b_age THEN r_fighter
            WHEN b_age > r_age THEN b_fighter
            WHEN r_age = b_age THEN NULL
        END
        ) IS NOT NULL AND
        (CASE
            WHEN winner = 'Red' THEN r_fighter
            WHEN winner = 'Blue' THEN b_fighter
            WHEN winner = 'Draw' THEN 'Draw'
        END
        ) <> 'Draw'
    ) AS did_older_win