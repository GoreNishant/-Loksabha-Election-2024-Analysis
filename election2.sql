
--Q 1] Total seats ?
select count(distinct "Constituency ID") as total_seats from  constituency_wise_results;

alter table constituencywise_details
rename to constituency_wise_results;

-- Q2] what are the total no of seats available for election in each state;

SELECT 
    "States"."State" AS statename,
    COUNT(distinct "statewise_results"."Parliament Constituency") AS total_constituencies
FROM 
    "States"
JOIN 
    "statewise_results"
ON 
    "States"."State ID" = "statewise_results"."State ID"
GROUP BY 
    "States"."State"
ORDER BY 
    total_constituencies DESC;

ALTER TABLE "partywise_results"
ADD COLUMN "alliance" VARCHAR(40);



UPDATE "partywise_results"
SET "alliance" = 'NDA'
WHERE "Party" IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);


--Q3] Total seats won by NDA Alliance?

SELECT DISTINCT ON ("Party") *
FROM "partywise_results"
WHERE "alliance" = 'NDA'
ORDER BY "Party", "Party ID";

UPDATE "partywise_results"
SET "alliance" = 'NDA'
WHERE "Party ID" IN (804, 805);





DELETE FROM "partywise_results"
WHERE "Party ID" = 1998;

INSERT INTO "partywise_results" ("Party", "Won", "Party ID", "alliance")
VALUES ('United Peoples Party, Liberal - UPPL', 1, 1998, 'NDA');

UPDATE "partywise_results"
SET "alliance" = 'NDA'
WHERE "Party" = 'Janata Dal (Secular) - JD(S)';



SELECT "alliance", SUM("Won") AS "seats_won"
FROM (
    SELECT DISTINCT "Party", "Won", "alliance"
    FROM "partywise_results"
    WHERE "alliance" = 'NDA'
) AS distinct_parties
GROUP BY "alliance";



UPDATE "partywise_results"
SET "alliance" = 'INDIA'
WHERE "Party" IN (
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Samajwadi Party - SP',
    'Dravida Munnetra Kazhagam - DMK',
    'Communist Party of India (Marxist) - CPI(M)',
    'Communist Party of India (Marxist-Leninist) (Liberation) - CPI(ML)(L)',
    'Rashtriya Janata Dal - RJD',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Communist Party of India (Marxist) - CPI(M)',
    'Jharkhand Mukti Morcha - JMM',
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Viduthalai Chiruthaigal Katchi - VCK',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP'
);

SELECT DISTINCT ON ("Party") *
FROM "partywise_results"
WHERE "alliance" = 'INDIA'
ORDER BY "Party", "Party ID";

 -- Q4] Total seats won by INDIA Alliance?

SELECT "alliance", SUM("Won") AS "seats_won"
FROM (
    SELECT DISTINCT "Party", "Won", "alliance"
    FROM "partywise_results"
    WHERE "alliance" = 'INDIA'
) AS distinct_parties
GROUP BY "alliance";

UPDATE "partywise_results"
SET "alliance" = 'INDIA'
WHERE "Party ID" IN (742, 544, 545, 547);

SELECT DISTINCT "alliance" FROM "partywise_results" WHERE "alliance" NOT IN ('INDIA', 'NDA');

 -- Q5] Total seats won by Independent/others?

SELECT "alliance", SUM("Won") AS "seats_won"
FROM (
    SELECT DISTINCT "Party", "Won", "alliance"
    FROM "partywise_results"
    WHERE "alliance" NOT IN ('INDIA', 'NDA')
) AS distinct_parties
GROUP BY "alliance";


select * from  "partywise_results"


































SELECT "Party", "Won" 
FROM "partywise_results" 
ORDER BY "Won" DESC 
LIMIT 1;





SELECT "alliance", SUM("Won") AS total_seats
FROM (
    SELECT DISTINCT "Party", "Won", "alliance"
    FROM "partywise_results"
    WHERE "Party" IS NOT NULL AND "Won" IS NOT NULL AND "alliance" IS NOT NULL
) AS distinct_parties
GROUP BY "alliance"
ORDER BY total_seats DESC;





SELECT DISTINCT
    "constituencywise_results"."Constituency Name", 
    "constituencywise_results"."Winning Candidate", 
    "partywise_results"."Party", 
    "constituencywise_results"."Margin", 
    "States"."State"
FROM 
    "constituencywise_results"
JOIN 
    "partywise_results" 
    ON "constituencywise_results"."Party ID" = "partywise_results"."Party ID"
JOIN 
    "statewise_results" 
    ON "constituencywise_results"."Parliament Constituency" = "statewise_results"."Parliament Constituency"
JOIN 
    "States" 
    ON "statewise_results"."State ID" = "States"."State ID"
WHERE 
    "States"."State" = 'Maharashtra'
    AND "constituencywise_results"."Constituency Name" = 'BARAMATI';




SELECT DISTINCT 
    "constituencywise_results"."Constituency Name",
    "constituencywise_details"."Candidate",
    "constituencywise_details"."EVM Votes",
    "constituencywise_details"."Postal Votes",
    "constituencywise_details"."Total Votes"
FROM 
    "constituencywise_results"
JOIN 
    "constituencywise_details" 
    ON "constituencywise_details"."Constituency ID" = "constituencywise_results"."Constituency ID"
WHERE 
    "constituencywise_results"."Constituency Name" = 'BARAMATI'
ORDER BY 
    "constituencywise_details"."Total Votes" DESC;



SELECT 
    "partywise_results"."Party",
    COUNT(distinct"constituencywise_results"."Constituency ID") AS "won_seats"
FROM 
    "partywise_results"
JOIN 
    "constituencywise_results" 
    ON "partywise_results"."Party ID" = "constituencywise_results"."Party ID"
JOIN 
    "statewise_results" 
    ON "constituencywise_results"."Parliament Constituency" = "statewise_results"."Parliament Constituency"
JOIN 
    "States" 
    ON "statewise_results"."State ID" = "States"."State ID"
WHERE 
    "States"."State" = 'Maharashtra'
GROUP BY 
    "partywise_results"."Party"
ORDER BY 
    "won_seats" DESC;






SELECT
    "States"."State",
    "partywise_results"."alliance",
    COUNT(DISTINCT "constituencywise_results"."Constituency ID") AS "won_seats"
FROM
    "partywise_results"
JOIN
    "constituencywise_results" 
    ON "partywise_results"."Party ID" = "constituencywise_results"."Party ID"
JOIN
    "statewise_results" 
    ON "constituencywise_results"."Parliament Constituency" = "statewise_results"."Parliament Constituency"
JOIN
    "States" 
    ON "statewise_results"."State ID" = "States"."State ID"
WHERE
    "States"."State" = 'Maharashtra'
GROUP BY
    "partywise_results"."alliance"
ORDER BY
    "won_seats" DESC;






SELECT
    "States"."State",
    "partywise_results"."alliance",
    COUNT(DISTINCT "constituencywise_results"."Constituency ID") AS "won_seats"
FROM
    "partywise_results"
JOIN
    "constituencywise_results" 
    ON "partywise_results"."Party ID" = "constituencywise_results"."Party ID"
JOIN
    "statewise_results" 
    ON "constituencywise_results"."Parliament Constituency" = "statewise_results"."Parliament Constituency"
JOIN
    "States" 
    ON "statewise_results"."State ID" = "States"."State ID"
WHERE
    "States"."State" = 'Maharashtra'
    AND "partywise_results"."alliance" IS NOT NULL
GROUP BY
    "States"."State", "partywise_results"."alliance"
ORDER BY
    "won_seats" DESC;



SELECT 
    "constituencywise_details"."Candidate", 
    MAX("constituencywise_details"."EVM Votes") AS "EVM Votes"
FROM 
    "constituencywise_details"
GROUP BY 
    "constituencywise_details"."Candidate"
ORDER BY 
    "EVM Votes" DESC
LIMIT 5;





SELECT 
    "statewise_results"."Constituency", 
    "statewise_results"."Leading Candidate" AS "winning_candidate", 
    "statewise_results"."Trailing Candidate" AS "runnerup_candidate"
FROM 
    "statewise_results"
LIMIT 10;


SELECT 
    "States"."State" AS "state_name",
    COUNT(DISTINCT "statewise_results"."Constituency") AS "total_constituencies",
    COUNT(DISTINCT "constituencywise_details"."Candidate") AS "total_candidates",
    COUNT(DISTINCT "constituencywise_details"."Party") AS "total_parties",
    SUM("constituencywise_details"."Total Votes") AS "total_votes",
    SUM("constituencywise_details"."EVM Votes") AS "total_evm_votes",
    SUM("constituencywise_details"."Postal Votes") AS "total_postal_votes"
FROM 
    "States"
JOIN 
    "statewise_results" ON "States"."State ID" = "statewise_results"."State ID"
JOIN 
    "constituencywise_results" ON "statewise_results"."Parliament Constituency" = "constituencywise_results"."Parliament Constituency"
JOIN 
    "constituencywise_details" ON "constituencywise_results"."Constituency ID" = "constituencywise_details"."Constituency ID"
WHERE 
    "States"."State" = 'Maharashtra'
GROUP BY 
    "States"."State";
