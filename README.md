# Pewlett-Hackard-Analysis

## Overview:
In this Module we will be using SQL to extract multiple csv’s, merge data based upon commonalities, then create new data tables with the intent of performing data-analysis. We will be helping Pewlett-Hackard do as such while exporting the data to create tangible and easily digestible data tables to break down their needs. The task is to find consolidate all employees that will be retring soon while excluding those who have already. From there, we will break down the data further by which departments and most-recent title to better grasp which positions are becoming vacant. Lastly, to deal with the vacancy of positions we will compile a list of mentors from the retirees to work in a part-time role.
## Results:
- In the first table,Retirement-Titles([retirement_titles.csv](Data/retirement_titles.csv)), we notice that the list of those retiring is larger than it need be since certain employeess have worked multiple postions in their years of employment. This gives usa  good impression that postions are highly flexible within the company however we want to focus on their most recent work before retiring
- The deliverable of unique titles shows us that roughly 70,000 employees will be retiring(excluding those who have retired beforehand). From this list, roughly 41,000 will be eligible for a retirement package based upon the criteria of their birth date and hire date being between (1952 and 1955) and (1985 and 1988) in respective order.
- The [retirement-titles-count](Resources/retirement_titles_count.png) table breaks down the employees retiring based upon the employees most recent/highest title position earned.  There’s a transparent display of disparity in titles held by those retiring as only 2 Managers are retiring in comparison to the rest, all of which are quadruple digits and higher in count which is also cause for concern for the company
- In regard to mentorship program, the notion of “Understaffed” is an understatement to the clear difference in # of mentors compared to vacant positions. When we carry out a count of mentors there’s roughly 1,500 mentors for 70k plus soon-to-be vacant positions of various titles. 

## Summary:
The number of roles that need be filled are 7 with 70,000 plus vacancies:<br />
![retirement-titles-count](Resources/retirement_titles_count.png)

<br />If we compare this to the criteria set for # of mentors available,([mentors_count.sql](https://github.com/KdotGhai/Pewlett-Hackard-Analysis/blob/7c1192342fa760b5021b32561b67886607afb922/Queries/mentor_count.sql)):[Mentors_Table](Data/mentor_count.csv)
