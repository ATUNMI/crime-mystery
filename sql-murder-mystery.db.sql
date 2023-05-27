--checking crime-scene report
SELECT *
FROM crime_scene_report
WHERE type = 'murder'
	AND city LIKE '%SQL%'
    AND date = 20180115;
    
--Finding Annabel
SELECT *
FROM person
WHERE name LIKE '%Annabel%'
	AND address_street_name = 'Franklin Ave';
    
-- Finding Anonymous Witness of 'Northwestern Dr'crime_scene_report
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_street_name DESC
LIMIT 1;

---Finding the suspect
SELECT P.id,
	   name
FROM person AS P
JOIN drivers_license AS D
	ON P.license_id = D.id
WHERE plate_number LIKE '%H42W%'
INTERSECT
SELECT person_id,
	   name
FROM get_fit_now_check_in AS C
JOIN get_fit_now_member AS M
	 ON C.membership_id = M.id
WHERE check_in_date = 20180109
	  AND membership_status = 'gold'
      AND membership_id LIKE '48Z%';
      
-- Suspect statement
SELECT *
FROM interview
WHERE person_id = 67318;

--Hunting for the mastermind
SELECT p.id AS person_id,
	   p.name,
       p.address_number,
       p.address_street_name,
       d.id AS license_id,
       d.age,
       d.height,
       d.hair_color,
       d.plate_number,
       d.gender,
       i.annual_income,
       i.ssn
FROM person p
	LEFT JOIN drivers_license d
    ON d.id = p.license_id
    LEFT JOIN income i
    ON i.ssn = p.ssn
WHERE d.height IN (65, 66, 67) AND
	  d.hair_color = 'red' AND
      d.car_make = 'Tesla'AND
      d.car_model = 'Model S' AND
      d.gender = 'female' AND
      p.id IN (
        	SELECT person_id
        	FROM facebook_event_checkin
        	WHERE date BETWEEN 20171201 AND 20171231
        	AND event_name LIKE '%SQL%'
        	GROUP BY person_id
        	HAVING COUNT(person_id) = 3
        );