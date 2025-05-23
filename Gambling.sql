SELECT Title, FirstName, LastName, DateOfBirth FROM Customer;

SELECT CustomerGroup, COUNT(*) AS "Total customers" FROM Customer
GROUP BY CustomerGroup;

SELECT customer.*, CurrencyCode FROM Customer
JOIN Account on Customer.CustId = account.CustId;

SELECT product.`product`, betting.BetDate, Betting.Bet_Amt
FROM product
JOIN Betting ON product.CategoryId = Betting.CategoryId
GROUP by product.`product`, BetDate;

SELECT product.`product`, betting.BetDate, Betting.Bet_Amt
FROM product
JOIN Betting ON product.CategoryId = Betting.CategoryId
WHERE Betting.BetDate > '2012-11-01' AND product.`product` like '%Sportsbook%'
GROUP by product.`product`, BetDate;

SELECT product.`product`, CustomerGroup, CurrencyCode,
FROM product
JOIN Betting ON product.CategoryId = Betting.CategoryId
JOIN Account on Betting. = Account.
JOIN Account On Customer.CustId = account.CustId;
WHERE Betting.BetDate > '2023-12-01'
GROUP BY ProductID, CurrencyCode, CustomerGroup
ORDER BY ProductID, CurrencyCode, CustomerGroup;

---7 
SELECT Title, FirstName, LastName, DateOfBirth, SUM(Betting.Bet_Amt) AS "Total bet"
FROM Customer
JOIN Account ON Customer.CustId = Account.CustId
JOIN `Betting` ON Account.AccountNo = Betting.AccountNo 
WHERE Betting.BetDate BETWEEN '2012-11-01' AND '2012-11-30'
GROUP BY Title, FirstName, LastName, DateOfBirth 
ORDER BY "Total bet" DESC;

---8
SELECT Betting.AccountNo AS Player_Account_Number, count(DISTINCT Betting.`product`) AS Total_products
FROM Betting
GROUP BY Betting.AccountNo;

SELECT Betting.AccountNo AS Player_Account_Number
FROM Betting
WHERE Betting.`product` LIKE '%Vegas%' AND Betting.AccountNo IN (SELECT B2.AccountNo FROM Betting AS B2 WHERE B2.`product` LIKE '%Sportsbook%')
GROUP BY Betting.AccountNo;

--Q9
SELECT Betting.AccountNo AS Player_Account_Number, count(DISTINCT Betting.`product`) AS Total_products, Betting.`product`, SUM(Betting.Bet_Amt) AS Total_betting
FROM Betting
GROUP BY Betting.AccountNo
HAVING Betting.`product` LIKE '%Sportsbook%'
AND Total_products = 1;

--Q10
SELECT
    Player_Account_Number,
    `product`,
    Total_betting
FROM (	
	SELECT Betting.AccountNo AS Player_Account_Number, Betting.`product`, SUM(Betting.Bet_Amt) AS Total_betting,
	ROW_NUMBER() OVER (
            PARTITION BY Betting.AccountNo        -- Restart ranking for each unique AccountNo
            ORDER BY SUM(Betting.Bet_Amt) DESC    -- Order by Total_betting in descending order
    ) as rn
	FROM Betting
	GROUP BY Betting.AccountNo, Betting.`product`
	ORDER BY Betting.AccountNo, Total_betting DESC
	) AS RankedProducts
WHERE rn = 1;

---11
SELECT student_name AS "Student name", GPA
FROM Student_School
ORDER BY GPA DESC
LIMIT 5;

----12
SELECT school_name AS "University name", COUNT(student_id) AS "Number of Students"
FROM Student_School
GROUP BY school_name;

---13
SELECT student_name AS "Student name", school_name AS "University name", GPA
FROM Student_School
WHERE school_name IS NOT NULL
ORDER BY GPA DESC
LIMIT 3;