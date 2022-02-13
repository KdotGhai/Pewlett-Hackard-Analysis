
--Do count of mentorship(Compare to count of those retiring)
SELECT COUNT(me.emp_no),me.title
INTO mentor_count
FROM mentorship_eligibilty as me
GROUP BY me.title
ORDER BY COUNT DESC;
-- View Table
SELECT * FROM mentor_count;
