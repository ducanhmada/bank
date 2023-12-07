**A.Key Performance Indicators (KPIs) Requirements:**
#### KPIs include Total Loan Applications , Total Funded Amount,Total Amount Received,Average Interest Rate , Average Debt-to-Income Ratio and I calculate according to the 3 cases below:

- Current
 ````sql
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
FROM  kpi
````

#### Answer:
| Total_Loan_Applications | Total_Funded_Amount | Total_Amount_Collected | Avg_Int_Rate | Avg_DTI | 
| ----------- | ---------- |------------  | ---------------| ---------- |
| 38576       | 435757075  |  473070933   |  12.04          |    13.32 |


- MTD
 ````sql
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
WHERE MONTH(issue_date) = 12
````

#### Answer:
| Total_Loan_Applications | Total_Funded_Amount | Total_Amount_Collected | Avg_Int_Rate | Avg_DTI | 
| ----------- | ---------- |------------  | ---------------| ---------- |
| 4314     | 53981425|  58074380   |  12.35     |   13.66 |

- PMTD
 ````sql
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
WHERE MONTH(issue_date) = 11
````

#### Answer:
| Total_Loan_Applications | Total_Funded_Amount | Total_Amount_Collected | Avg_Int_Rate | Avg_DTI | 
| ----------- | ---------- |------------  | ---------------| ---------- |
| 4035    | 47754825|  50132030  |  11.94    |   13.30|

***


**B.Good Loan Issued vs Bad Loan Issued**

#### Good Loan Issued is WHEN loan_status = 'Fully Paid' or loan_status = 'Current'

- Good_Loan_Percengte
 ````sql
SELECT
	COUNT(CASE	WHEN loan_status = 'Fully Paid' or loan_status = 'Current'  THEN id END) * 100 /
		COUNT(id) AS Good_Loan_Percengte
FROM bank_loan
````

#### Answer:
| Good_Loan_Percengte| 
| ----------- | 
| 86    | 


- Good Loan Applications,Good Loan Funded Amount,Good Loan Total Received Amount
 ````sql
SELECT	
	COUNT(id) AS Good_Loan_Applications,
	SUM(loan_amount) AS Good_Loan_Funded_Amount,
	SUM(total_payment) AS Good_Loan_Amount_Received
FROM bank_loan
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'
````

#### Answer:
| Good_Loan_Applications| Good_Loan_Funded_Amount | Good_Loan_Amount_Received|
| ----------- | ---------- |------------  |
| 33243  | 370224850|  435786170  |

*** 
#### Bad Loan Issued is WHEN loan_status = 'Charged off' 
- Bad_Loan_Percengte
 ````sql
SELECT
	COUNT(CASE	WHEN loan_status = 'Charged off' THEN id END) * 100 /
		COUNT(id) AS Bad_Loan_Percengte
FROM bank_loan
````

#### Answer:
| Good_Loan_Percengte| 
| ----------- | 
| 14    | 


- Bad Loan Applications,Bad  Loan Funded Amount,Bad  Loan Total Received Amount
 ````sql
SELECT
	COUNT(id) AS Bad_Loan_Applications,
	SUM(loan_amount) AS Bad_Loan_Funded_Amount,
	SUM(total_payment) AS Bad_Loan_Amount_Received
FROM bank_loan
WHERE loan_status = 'Charged off'
````

#### Answer:
| Bad_Loan_Applications| Bad_Loan_Funded_Amount | Bad_Loan_Amount_Received|
| ----------- | ---------- |------------  |
| 5333  | 65532225|  37284763  |

***  

#### In order to gain a comprehensive overview of our lending operations and monitor the performance of loans, I aim to create a grid view report categorized by 'Loan Status.'
- Loan status
 ````sql
SELECT
	loan_status,
	COUNT(id) AS Total_Loan,	
	SUM(total_payment) AS Total_Amount_Received,
	AVG(int_rate) * 100 AS Int_Rate,
	AVG(dti) * 100 AS DTI
FROM bank_loan
GROUP BY loan_status
````
#### Answer:

| Loan_status | Total_Loan | Total_Amount_Received | Int_Rate | DTI | 
| ----------- | ---------- |------------  | ---------------| ---------- |
| Fully Paid   | 32145|  411586256  |  11.641  |   13.16|
| Charged Off   | 5333 | 37284763 |  13.87   |   14|
| Current   | 1098| 24199914|  15.09   |   14.72|

***
**C.Bank Loan Overview:**

#### After calculating the bank_loan indicators as above, I proceed to overview the main indicators in the report:

- Month
 ````sql
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
````

#### Answer:

![ảnh](https://lh3.googleusercontent.com/pw/ADCreHcZ727Q09s2FHDJhp6WdvVoC1yl-9Mwgwd-f4BGR3q4I1psEbKtBEJU_evZQWfz3w0oswDMGw8J1Z02k8aRqpFh-LmKnQrwVMuMqI3-4DMm2OGzWmNhYqQzULmTF5MPtBorL4GcJ-zp1-edX0ZvC1MR_JpJPxzAIX_bD4xcGImXlm025QuHaX-LsXfAkkQ5ax4mpPqetzlhXGllMpuujKGhgh4UQu2Av18SAnXmFgX8YAmNDS7AhaVvaQC6LASp47GcmjTUWXJNUpFRhMs7weHFQeldoi24nJ0A1r0WIfmd8d6UBxLSGWC9gy_RULFHlwYeE1tl8_Itvvi4riEakIWoR3x8wT2EGQCbEOLC5Ap4F_GhC9U8K8inGMeE2MB6y6SdeoQvOZJaKlGAytjEbRgqEk6DVeJdNKkUXAeVYmjXJw7iw9HuRR6dFHoYH3vFKYXWGCYzGax46VcKEyboELbCocPnZhxIgMmWmq60ADYyZMk2WT1L3jjOqFJr8EtUn1jYzFebkGeyz1wzjJnKN8Zb0cfcdwGab2b8epMRIhhyiV1K5_OK-SdE4dlv5WATXJgmWvqhmbfvMyRTXKwfauFbbr0LDoA1p5Owr2-h5agGhuAjvTrwpQQh0wTFceBph3IQIT_eMUi7OvbQ6OcyXlVZkg5mHbpNZXpwlzAS4RvyKPTp-fDF9FJyUbdD-PPDygEuPMc322GczWOtAv-fK2G2O5Djf4tS8XVYhCJjh4fzUd90MSlyAX1iF2YywKvoQQCJZWAIFLdeBMogJZIhVhcaSVuhYSXtND6779LiwkrcLyaCQw01OdNE7f1SDP3psaeUwf9ndbQn9skJmqCPhvLDhdXPzCuQVcOJMKTlkq8Sv1ZBxtXhyUDQNvC1ttukV2zxmO4vBrdaxOjFtCXQdfDTq2NXMc6BJxDFAG_1SwXVRc9qkOzVTU8gmYlTfITcSFnj-4uiGcK8DQ=w482-h281-s-no-gm?authuser=0)

- State
 ````sql
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
````

#### Answer:
![ảnh](https://lh3.googleusercontent.com/pw/ADCreHefTBF9yCjU63oGp-BJGg04srvSiwwVhdQvRnFtFZnVohnPwtdzVkWZvZQmbvXVL24WwVfZPQXw-iHIKy3qR01yFtll6UcSNyYmuj5tca70lO1liNaYeqc9ixuuHnmq2N0sdNj4fTn4vR1s-D7C4OrMBEg3y_EZJOk2vb4bin2lbVECXFi5I4EP25MMMHX2zdslrgH5-uWyFszv6Puuei54dcGr6lDoeS6AmrG_3g86WvAvwL4rIOqBQQJchQ8K2QWYb-SblQfnfexNYmvFz0vP1HAFoRue-e2RaM4zBcVehgNoN_7NiUnHQ9aa6sggSJ2MIVj6VQSigs6BQa9f-Z9lnOM10GEOFsjdxquabl2A3Tas6Hkgohe2EaKV4FBBUM9hwQRREzOEUk1Ut_YghaUgZyCdVVJyYX8rymnIB6aJWQQCHHi5A-X7q0iShKnVJ3l_AGd_As7H4oroJ-IVzJlO_16e9eNZV3EvpWMc95lpyTC6tl7gtVKfmoX2imfSJ6r7aknwHTkz7p6rqgF5PzUCzZ9mQoGedFYvdmVQO5ipV7zxIdY_QOL80K9DkeYWyMUi3Qv8ImfiRB6dgaUlISXJsBQ2_8AKwixxkZ8xzB9oKhSZ0MzTmPnYq02Qb-vMyHnXySK7_0oxIBL_kYWhLDkD-3lvSG-1IMqbFiWkV_FzahWOZesm9ls-Mj-patd4dpwOi4jkNAEWtGzqXGpaFGVop39hUoFgn5c7jTQ8x2rh6eI8_l83k-6Lzuu050DW8zpmgAHuFgsWST_s_41bUCSmeKHHGOdBLcxZmm3WTqtV5oAPw38ROxcqZMETJzF6Kj0K8V6tB-vmBri1RjUd1Z06h3AYfdc_STCTJnHDnWXQmYn7ukmDWOx67mIYIhIMOQDiqK7b_vUihhg6oiqn2GLeMYBmo4trk_EUUcASL-K-XFGpqSwRlz7M54lU-Lxq_cV0LFShvyfy3A=w1199-h559-s-no-gm?authuser=0)

- Term
 ````sql
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
````
#### Answer:
| Term | Total_Loan_Applications | Total_Funded_Amount | Total_Amount_Recvied | 
| ----------- | ---------- |------------  | ---------------| 
| 36 months   | 28237|  273041225 |  294709458  | 
| 60 months  | 10339 | 162715850|  178361475  |  

- Employee Length
````sql
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
````
#### Answer:
![ảnh](https://lh3.googleusercontent.com/pw/ADCreHfqbcZFu_Vha_aBDnJB8cMy-eAhyxkkSHLttC--fyEURVzmnDC39M6biJGlO2fUquDJn2Wmyjg9Ru_Te9ZeHKfUmpQ2uTVeqS9IvUDSVsiLIGLLnJLk2S2yYQFj1mwoxuQqmEgN2Gs9Zst_0r_8kGzqc4w25bwKWNRRNEqBEmZ6oPbBhTp5tbP3TqTgxrqkRxCoYg7RfEgeMbAWZr-iZoMLpGFROWdACC38vmC6nx0ycRvYRFqRUg1VMN1-4XqJ9NxZwzPdWs51vh8AXno4VyQ2oVxXlo5SdzHsCTm8gQkw3hEB0BwNVL-ABuFQdZjxvDnHU-GtnyescvHDj36aoFYd-gWJbs5BJkO4pwo4bJJo_2FDcQndq32oZBaQepWfvgi6cm-tuPMGH7IARZBj4VDhwuXk8Yp_yC_m8gvwomKXkipwgSbN_d4RHiTCC6rqunHUyZl_u6h1DFyqxakSOIgND2fwU2bFotzQuWgxs1DA1J-EtMFPbN9hfAzRmcCtcOgPcsWGEGvPL_aV8AHh_m04pSBDXt-cfN7KRkjqJ-bO4W-LLOBmFrT0if-W7Wu1pvTs3ztOFNxo7XlUrEObl_oa7hVbzkf-3wtJCIocsY3hF_1mdJvliYhk2vl5Ob18o68tGFL0i6cEEPO9nHWqvc8J_tToxFAbXq1t03w6Xl3DDNkmPoXxnWKNR5HiIr-bmoEQ0fMqwv1-zG7SO-xAfl-3sZGwcoz6XzooT9pJxqU1NmV5liAJZr0-DevxnPq9u6H16bx_dPFMYIdEfYJc5vVITHT5xHflGqRSlcyWRmkDns2HS2ScEG-f9tFObHe71LTzd2GCeWj0m4bRBLWLbxKuWIUx0GR4AAlxnakx3gleAqmcet9mwlnxYmGvWHCF58bgxpcIEP2AiK-SkvYClsDWCdKMPF7u3zW5Agrle6xikhlf_wkS95vZ6_J5VIjgx3-Weln-mg9aLA=w1195-h327-s-no-gm?authuser=0)

- Purpose
````sql
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
````
#### Answer:
![ảnh](https://lh3.googleusercontent.com/pw/ADCreHfARkx-WDn7wT3Ti4lyNPD8mlNvXx2tr09YDCyKZJyVSOTfj_2-JwPPjz9wpilWJWTPkzPsTay_sD0-w84M7JOsWoTE0oJIm8A8JkGSK58C64TVrJVA1HhXxVcfMo_I6rjhCTcAbY3aTThZUBqPR06v_o7d26-VTxL6YOyCPWf5wkC2PxfjbZN9ghoZbRMrmInCIb3R7ZiE14Rkre_0cHs6dz27AIi2soSO9_rmcsP1go4CVV-nJZZWZhzegkS-N3lkybd7kTvtmgYjvrJrJgelJimZ1LaWsZYXz8MvvQaSSF8MXsf38n16RiIoLnsb6gn7GJX9sOZ_RPiuxBn-MBJmVS0zuFgZi503u3HJWzMQPZsoI_tfPNY1fxVvBrLiJD9lyiPo4skKDTcVxW6CRKC3-rpXnXE0JXfM_oP-1osICa5TL3FB5ax5DO9_x5JvyF34bu2XTOcn3d8dOuGlze6s8GuAOPgpBAa03xlotQCbCGvxLUsItpXbWjnqEFOPVb8mEya020ddb_NhlkkoJEdBn0sxz_Wx9OLQNEvlU5mNbbD6GFJ8YYSVtfox4dwEK5s7AoTta-PPbsRBMiq1Cy4wW7Q3DCznKSyXjCYV8YH6DPjome6BwxOa3zgyjvxKy3o2VW9xvrbvY26bNFVHONIthWda7p1kiuotB6oDCTM5W8rL3nVinZqIiqBotSUnsoNYwA5KlVPcaHqb-g3ufpPjYQL8rdSMr7VOFTlNDHBdzmK4DqpwErUvvk-DGRAiPB1EQB5g_yCnSwyGxbfiDF-rv9gvLVP-83cXatxE2t6UxGQmLXkwz0DAhFd5JliF6fb5Y97SjhRWsZf5kKjttEV3HnrMh3EK_2OjcStGuuLzZlZdfje97rZxgD5890S9ACz2ASxvHCny4OfkZMAtiyA8AlzEqGnT2OtRTO3j3P7F8zGL6r044JFBvPef0LVzI8V3T783n9FHYA=w529-h297-s-no-gm?authuser=0)

- HOME OWNERSHIP
````sql
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
````
#### Answer:
|  Home_ownership | Total_Loan_Applications | Total_Funded_Amount | Total_Amount_Recvied | 
| ----------- | ---------- |------------  | ---------------| 
|MORTGAGE  | 17198| 219329150 |  238474438  | 
|NONE  |3 | 16800 | 19053 |  
|OTHER | 98|  1044975 |  1025257 | 
|OWN  | 2838 | 29597675|  31729129  |  
|RENT | 18439|  185768475 |  201823056 | 
 