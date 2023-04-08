USE tlus;

-- Question a
SELECT p.ProfName, sup.ProfName AS SupProfName
	FROM Professor p JOIN Professor sup ON p.SupProfID = sup.ProfID
	WHERE p.ProfTitle = 'Visiting Professor'
    ORDER BY p.ProfName, sup.ProfName;
    
-- Question b
SELECT ProfID, ProfName 
	FROM Professor 
	WHERE ProfID NOT IN (SELECT ProfID FROM `join`);

-- Question c
SELECT ProgCode, COUNT(ProgCode) AS count 
	FROM Comprise 
    GROUP BY ProgCode 
    HAVING count >= 8;

-- Question d
SELECT t.ProfID, ProfName, CourseCode 
	FROM Teach t, Professor p 
	WHERE `Year` = "2021" AND Semester = "3" 
    AND t.ProfID = p.ProfID 
    ORDER BY ProfName;

-- Question e
SELECT c.CourseTitle AS courses, prerequisite
	FROM Course c , `Require` r, (SELECT r.PreCourseCode, c.CourseTitle AS prerequisite FROM `Require` r LEFT JOIN Course c ON r.PreCourseCode = c.CourseCode GROUP BY r.PreCourseCode) a
    WHERE c.CourseTitle LIKE "Advanced%"
    AND c.CourseCode = r.CourseCode
    AND r.PreCourseCode = a.PreCourseCode;
    
/* SELECT r.PreCourseCode, c.CourseTitle AS prerequisite FROM `Require` r LEFT JOIN Course c ON r.PreCourseCode = c.CourseCode GROUP BY r.PreCourseCode;*/

-- Question f  
SELECT CourseCode, CountNumber FROM (SELECT * FROM (SELECT CourseCode, COUNT(StuID) AS CountNumber, DENSE_RANK() OVER (ORDER BY COUNT(StuID) DESC) AS r
	FROM Take
    GROUP BY CourseCode) t
    HAVING r <= 3) a;
    
/*SELECT CourseCode, COUNT(StuID) AS CountNumber, DENSE_RANK() OVER (ORDER BY COUNT(StuID) DESC) AS r FROM Take GROUP BY CourseCode;*/

-- Question g
SELECT DISTINCT PreCourseCode
	FROM `Require`
    WHERE CourseCode NOT IN (SELECT CourseCode FROM Take t LEFT JOIN Student s ON t.StuID = s.StuID WHERE `Year` = "2021" AND YearEnrolled = "2020");

-- table of all courses taken by students in 2021 who were enrolled in 2020
/* SELECT CourseCode
	FROM Take t LEFT JOIN Student s ON t.StuID = s.StuID
    WHERE `Year` = "2021"
    AND YearEnrolled = "2020";*/

-- Question h
SELECT COUNT(StuID) AS count
	FROM take
	WHERE Grade = "F"
    AND `Year` = "2020";

-- Question i
SELECT StuName
	FROM Student 
    WHERE ProgCode IN (SELECT ProgCode FROM Program WHERE DeptID = "DP07")
	AND YearEnrolled = "2021";
 
 -- Question j
SELECT ProfName, COUNT(CourseCode) AS count
	FROM Teach t LEFT JOIN Professor p ON t.ProfID = p.ProfID
    GROUP BY t.ProfID
    HAVING count >= 4
    ORDER BY count ASC;