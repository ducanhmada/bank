-- A.Key Performance Indicators (KPIs) Requirements:
--Total Loan Applications , Total Funded Amount,Total Amount Received,Average Interest Rate , Average Debt-to-Income Ratio

WITH kpi AS(
SELECT
	issue_date,id,loan_amount,total_payment,int_rate,dti
FROM bank_loan
)
SELECT 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Collected,
	AVG(int_rate) * 100 AS Avg_Int_Rate,
	AVG(dti) * 100 AS Avg_DTI
from kpi


--Total Loan Applications , Total Funded Amount,Total Amount Received,Average Interest Rate , Average Debt-to-Income Ratio MTD

WITH mtd_kpi AS(
SELECT
	issue_date,id,loan_amount,total_payment,int_rate,dti
FROM bank_loan
)
SELECT 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Collected,
	AVG(int_rate) * 100 AS Avg_Int_Rate,
	AVG(dti) * 100 AS Avg_DTI
from mtd_kpi
WHERE MONTH(issue_date) =12


--Total Loan Applications , Total Funded Amount,Total Amount Received,Average Interest Rate , Average Debt-to-Income Ratio PMTD

WITH pmtd_kpi AS(
SELECT
	issue_date,id,loan_amount,total_payment,int_rate,dti
FROM bank_loan
)
SELECT 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Collected,
	AVG(int_rate) * 100 AS Avg_Int_Rate,
	AVG(dti) * 100 AS Avg_DTI
from pmtd_kpi
WHERE MONTH(issue_date) =11


--B. GOOD LOAN ISSUED vs Bad Loan ISSUED
-- Good Loan KPIs:Good Loan Application Percentage,Good Loan Applications,Good Loan Funded Amount,Good Loan Total Received Amount

SELECT
	COUNT(CASE	WHEN loan_status = 'Fully Paid' or loan_status = 'Current'  THEN id END) * 100 /
		COUNT(id) AS Good_Loan_Percengte
FROM bank_loan

SELECT	
	COUNT(id) AS Good_Loan_Applications,
	SUM(loan_amount) AS Good_Loan_Funded_Amount,
	SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Bad Loan KPIs: Bad Loan Application Percentage, Bad Loan Applications , Bad Loan Funded Amount , Bad Loan Total Received Amount

SELECT
	COUNT(CASE	WHEN loan_status = 'Charged off' THEN id END) * 100 /
		COUNT(id) AS Bad_Loan_Percengte
FROM bank_loan

SELECT
	COUNT(id) AS Bad_Loan_Applications,
	SUM(loan_amount) AS Bad_Loan_Funded_Amount,
	SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan
WHERE loan_status = 'Charged off'

-- Loan Status
SELECT
	loan_status,
	COUNT(id) AS Total_Loan,	
	SUM(total_payment) AS Total_Amount_Received,
	AVG(int_rate) * 100 AS Int_Rate,
	AVG(dti) * 100 AS DTI
FROM bank_loan
GROUP BY loan_status

SELECT
	loan_status,
	SUM(total_payment) AS MTD_Total_Amount_Received,
	SUM(loan_amount) AS MTD_Total_Funded_Recvied	
FROM bank_loan
WHERE MONTH(issue_date)= 12
GROUP BY loan_status

--C.BANK LOAN REPORT OVERVIEW
-- MONTH
SELECT
	MONTH(issue_date) AS Month,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Recvied	
FROM bank_loan
GROUP BY
	MONTH(issue_date)
ORDER BY
	MONTH(issue_date)

-- STATE
SELECT
	address_state AS State,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Recvied	
FROM bank_loan
GROUP BY
	address_state
ORDER BY
	address_state

-- TERM
SELECT
	term AS Term,	
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Recvied	
FROM bank_loan
GROUP BY
	term
ORDER BY
	term

-- Employee Length
SELECT
	emp_length AS Employee_Length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Recvied	
FROM bank_loan
GROUP BY
	emp_length
ORDER BY
	emp_length

-- PURPOSE
SELECT
	purpose AS Purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Recvied	
FROM bank_loan
GROUP BY
	purpose
ORDER BY
	purpose

-- HOME OWNERSHIP
SELECT
	home_ownership AS Home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Recvied	
FROM bank_loan
GROUP BY
	home_ownership
ORDER BY
	home_ownership





