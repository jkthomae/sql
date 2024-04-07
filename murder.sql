-- https://mystery.knightlab.com
-- https://github.com/NUKnightLab/sql-mysteries/blob/master/sql-murder-mystery.db
-- sqlite3 sql-murder-mystery.db

-- PART 1

SELECT *
  FROM crime_scene_report
  WHERE date = 20180115 AND city is "SQL City" AND type is "murder";

-- Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT *
FROM interview
WHERE person_id in (
    SELECT id
    FROM person
    WHERE address_street_name is "Northwestern Dr" ORDER BY address_number DESC LIMIT 1
);
-- I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".

SELECT *
FROM interview
WHERE person_id in
(SELECT id
FROM person
WHERE address_street_name is "Franklin Ave" AND name LIKE "Annabel%");
--address_street_name is "Franklin Ave"


SELECT * 
FROM get_fit_now_member
WHERE person_id in (
  SELECT id
  FROM person
  WHERE license_id in ( SELECT id FROM drivers_license WHERE plate_number LIKE "%H42W%")
  );
-- 48Z55	67318	Jeremy Bowers	20160101	gold
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        SELECT value FROM solution;
-- Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.


-- PART II

SELECT *
FROM interview
WHERE person_id in (
  SELECT person_id 
  FROM get_fit_now_member
  WHERE person_id in (
    SELECT id
    FROM person
    WHERE license_id in ( SELECT id FROM drivers_license WHERE plate_number LIKE "%H42W%"
    )
  )
);

-- I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. 

SELECT name, event_name, gender
FROM drivers_license, person, facebook_event_checkin
WHERE hair_color is 'red'
and gender is 'female'
and height > 65
and height < 67
and car_model is "Model S"
and person.license_id = drivers_license.id
and facebook_event_checkin.person_id = person.id
LIMIT 1;

-- Miranda Priestly|SQL Symphony Concert|female
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        SELECT value FROM solution;
-- Congrats, you found the brains behind the murder!
-- Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!

.quit
