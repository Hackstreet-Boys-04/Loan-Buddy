CREATE DATABASE banks;
USE banks;
CREATE TABLE bank(
bank_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
min_age INT,
max_age INT,
min_income DECIMAL(10,2),
work_experience VARCHAR(100),
type ENUM('Public','Private','NBFC') DEFAULT 'Private'
);
CREATE TABLE loan_details(
loan_id INT PRIMARY KEY,
bank_id INT,
min_amount DECIMAL(12,2),
max_amount DECIMAL(12,2),
interest_rate_min DECIMAL(5,2),
interest_rate_max DECIMAL(5,2),
processing_fee VARCHAR(50),
foreclosure_charges VARCHAR(50),
FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
CREATE TABLE eligibility_criteria(
criteria_id INT PRIMARY KEY,
bank_id INT,
min_age INT,
max_age INT,
min_income DECIMAL(10,2),
credit_score_required INT,
employment_type ENUM('Salaried','Self-employed'),
FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
CREATE TABLE documents_required(
doc_id INT PRIMARY KEY,
bank_id INT,
document_name VARCHAR(100),
FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
CREATE TABLE applicants(
applicant_id INT PRIMARY KEY,
name VARCHAR(100),
age INT,
monthly_income DECIMAL(10,2),
credit_score INT,
employment_type ENUM('Salaried','Self-employed'),
existing_emi DECIMAL(10,2) DEFAULT 0
);
CREATE TABLE applications(
app_id INT PRIMARY KEY,
user_id INT,
loan_id INT,
status ENUM('Pending','Approved','Rejected') DEFAULT 'Pending',
applied_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES applicants(applicant_id),
FOREIGN KEY (loan_id) REFERENCES loan_details(loan_id)
);
ALTER TABLE loan_details ADD loan_type ENUM('Personal','Education') DEFAULT 'Personal';
CREATE TABLE education_loan_details(
edu_loan_id INT PRIMARY KEY,
bank_id INT,
max_amount_india DECIMAL(12,2),
max_amount_abroad DECIMAL(12,2),
margin_india DECIMAL(5,2),
margin_abroad DECIMAL(5,2),
security_required VARCHAR(255),
repayment_period_years INT,
moratorium_period VARCHAR(50),
FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
ALTER TABLE eligibility_criteria
ADD COLUMN nationality ENUM('Indian','NRI','POI','OCI') DEFAULT 'Indian',
ADD COLUMN admission_type ENUM('Merit','Entrance','Other') DEFAULT 'Merit';
CREATE TABLE expenses_covered(
expense_id INT PRIMARY KEY,
edu_loan_id INT,
expense_name VARCHAR(100),
FOREIGN KEY (edu_loan_id) REFERENCES education_loan_details(edu_loan_id)
);
INSERT INTO bank (bank_id, name, min_age, max_age, min_income, work_experience, type)
VALUES
(1, 'State Bank of India', 21, 76, 15000, 'Flexible eligibility, public sector', 'Public'),
(2, 'HDFC Bank', 21, 60, 125000, '2 yrs total, 1 yr current job', 'Private'),
(3, 'ICICI Bank', 23, 58, 30000, '1-2 yrs experience', 'Private'),
(4, 'Axis Bank', 21, 60, 15000, 'Salaried professionals', 'Private'),
(5, 'Kotak Mahindra Bank', 21, 60, 25000, 'Higher income for non-salary accounts', 'Private'),
(6, 'IndusInd Bank', 21, 60, 25000, '2-5 yrs work experience', 'Private'),
(7, 'Punjab National Bank', 21, 58, 15000, 'Doctors & professionals preferred', 'Public'),
(8, 'Bank of Baroda', 21, 65, 20000, 'Public sector bank', 'Public'),
(9, 'IDFC FIRST Bank', 21, 60, 20000, 'Flexible criteria', 'Private'),
(10, 'Federal Bank', 21, 55, 25000, 'Minimum 3 yrs experience', 'Private'),
(11, 'Standard Chartered Bank', 22, 58, 22000, 'Urban salaried customers', 'Private'),
(12, 'IDBI Bank', 21, 75, 15000, 'Includes pensioners', 'Public'),
(13, 'Indian Overseas Bank', 21, 55, 5000, 'Lower income threshold', 'Public');
INSERT INTO loan_details (loan_id, bank_id, min_amount, max_amount, interest_rate_min, interest_rate_max, processing_fee, foreclosure_charges, loan_type)
VALUES
(1, 1, 125000, 4000000, 9.00, 25.00, '1-3% + GST', 'Applicable', 'Personal'),
(2, 2, 125000, 4000000, 9.00, 25.00, '1-3% + GST', 'Applicable', 'Personal'),
(3, 3, 125000, 4000000, 9.00, 25.00, '1-3% + GST', 'Applicable', 'Personal');
INSERT INTO education_loan_details 
(edu_loan_id, bank_id, max_amount_india, max_amount_abroad, margin_india, margin_abroad, security_required, repayment_period_years, moratorium_period)
VALUES
(1, 1, 5000000, 750000, 5.00, 15.00, 'Up to 7.5L: Parent co-obligation; Above 7.5L: Collateral + co-obligation', 15, 'Course period + 1 year'),
(2, 2, 2000000, 2000000, 5.00, 15.00, 'Up to 7.5L: Parent co-obligation; Above 7.5L: Collateral + co-obligation', 15, 'Course period + 1 year');
INSERT INTO eligibility_criteria 
(criteria_id, bank_id, min_age, max_age, min_income, credit_score_required, employment_type, nationality, admission_type)
VALUES
(1, 1, 21, 76, 15000, 700, 'Salaried', 'Indian', 'Merit'),
(2, 2, 21, 60, 125000, 700, 'Salaried', 'Indian', 'Merit'),
(3, 3, 23, 58, 30000, 700, 'Salaried', 'Indian', 'Merit'),
(4, 13, 21, 55, 5000, 650, 'Salaried', 'Indian', 'Merit');
INSERT INTO expenses_covered (expense_id, edu_loan_id, expense_name)
VALUES
(1, 1, 'Tuition Fees'),
(2, 1, 'Hostel Fees'),
(3, 1, 'Books & Equipment'),
(4, 1, 'Travel Expenses Abroad'),
(5, 1, 'Insurance Premium'),
(6, 2, 'Tuition Fees'),
(7, 2, 'Hostel Fees'),
(8, 2, 'Books & Equipment'),
(9, 2, 'Travel Expenses Abroad'),
(10, 2, 'Insurance Premium');
INSERT INTO documents_required (doc_id, bank_id, document_name)
VALUES
(1, 1, 'PAN Card'),
(2, 1, 'Aadhaar'),
(3, 1, 'Admission Letter'),
(4, 1, 'Academic Records'),
(5, 1, 'Bank Statements'),
(6, 2, 'PAN Card'),
(7, 2, 'Aadhaar'),
(8, 2, 'Admission Letter'),
(9, 2, 'Academic Records'),
(10, 2, 'Income Certificate (for subsidy)');
SELECT b.name, l.min_amount, l.max_amount, l.interest_rate_min, l.interest_rate_max
FROM bank b
JOIN loan_details l ON b.bank_id = l.bank_id
JOIN eligibility_criteria e ON b.bank_id = e.bank_id
WHERE 25 BETWEEN e.min_age AND e.max_age
  AND 30000 >= e.min_income
  AND 720 >= e.credit_score_required
  AND l.loan_type = 'Personal';
SELECT b.name, e.min_income, ed.max_amount_india, ed.max_amount_abroad, ed.margin_india, ed.margin_abroad
FROM bank b
JOIN eligibility_criteria e ON b.bank_id = e.bank_id
JOIN education_loan_details ed ON b.bank_id = ed.bank_id
WHERE 22 BETWEEN e.min_age AND e.max_age
  AND 25000 >= e.min_income
  AND e.nationality = 'Indian'
  AND e.admission_type = 'Merit';
SELECT a.name, (a.monthly_income * 15) AS approx_eligible_amount
FROM applicants a;
SELECT d.document_name
FROM documents_required d
JOIN bank b ON d.bank_id = b.bank_id
WHERE b.name = 'State Bank of India';
SELECT e.expense_name
FROM expenses_covered e
JOIN education_loan_details ed ON e.edu_loan_id = ed.edu_loan_id
JOIN bank b ON ed.bank_id = b.bank_id
WHERE b.name = 'State Bank of India';
DELIMITER //
CREATE PROCEDURE CheckPersonalLoanEligibility(IN user_age INT, IN user_income DECIMAL(10,2), IN user_score INT)
BEGIN
  SELECT b.name, l.min_amount, l.max_amount, l.interest_rate_min, l.interest_rate_max
  FROM banks b
  JOIN loan_details l ON b.bank_id = l.bank_id
  JOIN eligibility_criteria e ON b.bank_id = e.bank_id
  WHERE user_age BETWEEN e.min_age AND e.max_age
    AND user_income >= e.min_income
    AND user_score >= e.credit_score_required
    AND l.loan_type = 'Personal';
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE CheckEducationLoanEligibility(IN user_age INT, IN user_income DECIMAL(10,2), IN nationality VARCHAR(20), IN admission VARCHAR(20))
BEGIN
  SELECT b.name, ed.max_amount_india, ed.max_amount_abroad, ed.margin_india, ed.margin_abroad, ed.security_required
  FROM banks b
  JOIN eligibility_criteria e ON b.bank_id = e.bank_id
  JOIN education_loan_details ed ON b.bank_id = ed.bank_id
  WHERE user_age BETWEEN e.min_age AND e.max_age
    AND user_income >= e.min_income
    AND e.nationality = nationality
    AND e.admission_type = admission;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE GetDocuments(IN bankName VARCHAR(100))
BEGIN
  SELECT d.document_name
  FROM documents_required d
  JOIN banks b ON d.bank_id = b.bank_id
  WHERE b.name = bankName;
END //
DELIMITER ;
DELIMITER //
CREATE PROCEDURE GetExpenses(IN bankName VARCHAR(100))
BEGIN
  SELECT e.expense_name
  FROM expenses_covered e
  JOIN education_loan_details ed ON e.edu_loan_id = ed.edu_loan_id
  JOIN banks b ON ed.bank_id = b.bank_id
  WHERE b.name = bankName;
END //
DELIMITER ;
ALTER TABLE loan_details DROP FOREIGN KEY loan_details_ibfk_1;
ALTER TABLE eligibility_criteria DROP FOREIGN KEY eligibility_criteria_ibfk_1;
ALTER TABLE documents_required DROP FOREIGN KEY documents_required_ibfk_1;
ALTER TABLE education_loan_details DROP FOREIGN KEY education_loan_details_ibfk_1;
ALTER TABLE bank MODIFY bank_id INT AUTO_INCREMENT;
ALTER TABLE loan_details 
  ADD CONSTRAINT fk_loan_bank FOREIGN KEY (bank_id) REFERENCES bank(bank_id);
ALTER TABLE eligibility_criteria 
  ADD CONSTRAINT fk_elig_bank FOREIGN KEY (bank_id) REFERENCES bank(bank_id);
ALTER TABLE documents_required 
  ADD CONSTRAINT fk_docs_bank FOREIGN KEY (bank_id) REFERENCES bank(bank_id);
ALTER TABLE education_loan_details 
  ADD CONSTRAINT fk_edu_bank FOREIGN KEY (bank_id) REFERENCES bank(bank_id);
ALTER TABLE eligibility_criteria
MODIFY COLUMN nationality ENUM('Indian','NRI','PIO','OCI') DEFAULT 'Indian';
ALTER TABLE eligibility_criteria ADD COLUMN max_emi_ratio DECIMAL(5,4) DEFAULT 0.40;
CREATE INDEX idx_bank_name ON bank(name);
CREATE INDEX idx_elig_bank ON eligibility_criteria(bank_id);
CREATE INDEX idx_loan_bank ON loan_details(bank_id);
CREATE INDEX idx_loan_type ON loan_details(loan_type);
CREATE INDEX idx_docs_bank ON documents_required(bank_id);
CREATE INDEX idx_edu_bank ON education_loan_details(bank_id);
CREATE TABLE IF NOT EXISTS college_tiers (
  tier_id TINYINT PRIMARY KEY,
  tier_name VARCHAR(20) NOT NULL,      
  chance_label VARCHAR(20) NOT NULL    
);

CREATE TABLE IF NOT EXISTS colleges (
  college_id INT AUTO_INCREMENT PRIMARY KEY,
  college_name VARCHAR(200) NOT NULL,
  tier_id TINYINT NOT NULL,
  city VARCHAR(100),
  FOREIGN KEY (tier_id) REFERENCES college_tiers(tier_id)
);
INSERT IGNORE INTO college_tiers (tier_id, tier_name, chance_label)
VALUES (1,'Tier 1','High'),(2,'Tier 2','Moderate'),(3,'Tier 3','Low');
ALTER TABLE colleges 
DROP COLUMN college_name,
DROP COLUMN city;
CREATE TABLE IF NOT EXISTS colleges (
  college_id INT AUTO_INCREMENT PRIMARY KEY,
  tier_id TINYINT NOT NULL,
  FOREIGN KEY (tier_id) REFERENCES college_tiers(tier_id)
);
RENAME TABLE colleges TO college_tier_mapping;
INSERT INTO college_tier_mapping (tier_id) VALUES 
(1), (2), (3);
SELECT b.name, l.min_amount, l.max_amount, l.interest_rate_min, l.interest_rate_max
FROM bank b
JOIN loan_details l ON b.bank_id = l.bank_id
JOIN eligibility_criteria e ON b.bank_id = e.bank_id
WHERE 25 BETWEEN e.min_age AND e.max_age
  AND 30000 >= e.min_income
  AND 720 >= e.credit_score_required
  AND l.loan_type = 'Personal';
  SELECT b.name, ed.max_amount_india, ed.max_amount_abroad, ed.margin_india, ed.margin_abroad, ed.security_required
FROM bank b
JOIN eligibility_criteria e ON b.bank_id = e.bank_id
JOIN education_loan_details ed ON b.bank_id = ed.bank_id
WHERE 22 BETWEEN e.min_age AND e.max_age
  AND 25000 >= e.min_income
  AND e.nationality = 'Indian'
  AND e.admission_type = 'Merit';
  CREATE TABLE home_loan_details (
  home_loan_id INT PRIMARY KEY AUTO_INCREMENT,
  bank_id INT,
  max_amount DECIMAL(12,2),
  tenure_years INT,
  ltv_ratio DECIMAL(5,2), -- Loan-to-Value ratio
  property_type VARCHAR(100),
  FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
DROP TABLE home_loan_details;
CREATE TABLE home_loan_details (
  home_loan_id INT PRIMARY KEY AUTO_INCREMENT,
  bank_id INT,
  loan_type ENUM('Purchase','Construction','Improvement','Extension','BalanceTransfer'),
  max_tenure_years INT,
  min_age INT,
  max_age INT,
  min_credit_score INT,
  collateral_required VARCHAR(255),
  FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
INSERT INTO home_loan_details 
(bank_id, loan_type, max_tenure_years, min_age, max_age, min_credit_score, collateral_required)
VALUES
(1, 'Purchase', 30, 21, 65, 700, 'Property acts as collateral'),
(1, 'Construction', 25, 21, 65, 700, 'Property acts as collateral'),
(1, 'Improvement', 20, 21, 65, 700, 'Property acts as collateral'),
(1, 'Extension', 20, 21, 65, 700, 'Property acts as collateral'),
(1, 'BalanceTransfer', 30, 21, 65, 700, 'Property acts as collateral');
CREATE TABLE home_loan_documents (
  doc_id INT PRIMARY KEY AUTO_INCREMENT,
  home_loan_id INT,
  document_name VARCHAR(200),
  FOREIGN KEY (home_loan_id) REFERENCES home_loan_details(home_loan_id)
);

INSERT INTO home_loan_documents (home_loan_id, document_name)
VALUES
(1, 'Identity Proof (Aadhaar, PAN, Passport, Voter ID)'),
(1, 'Address Proof (Aadhaar, Utility Bill, Passport)'),
(1, 'Income Proof (Salary Slips or IT Returns)'),
(1, 'Bank Statements (Last 6 months)'),
(1, 'Property Documents (Sale Agreement, Building Plan)'),
(1, 'Passport-size Photographs'),
(1, 'Employment/Business Proof');
SELECT b.name, h.loan_type, h.max_tenure_years, h.collateral_required
FROM bank b
JOIN home_loan_details h ON b.bank_id = h.bank_id
WHERE 30 BETWEEN h.min_age AND h.max_age
  AND 750 >= h.min_credit_score;
  DELIMITER //
CREATE PROCEDURE CheckHomeLoanEligibility(
    IN user_age INT,
    IN user_score INT
)
BEGIN
  SELECT b.name, h.loan_type, h.max_tenure_years, h.collateral_required
  FROM bank b
  JOIN home_loan_details h ON b.bank_id = h.bank_id
  WHERE user_age BETWEEN h.min_age AND h.max_age
    AND user_score >= h.min_credit_score;
END //
DELIMITER ;
CREATE TABLE business_loan_details (
  business_loan_id INT PRIMARY KEY AUTO_INCREMENT,
  bank_id INT,
  loan_type ENUM('Term','WorkingCapital','MSME','Equipment','LineOfCredit','Startup'),
  max_amount DECIMAL(12,2),
  tenure_years INT,
  min_age INT,
  min_credit_score INT,
  business_vintage_required INT, -- years of business existence
  collateral_required VARCHAR(255),
  FOREIGN KEY (bank_id) REFERENCES bank(bank_id)
);
INSERT INTO business_loan_details 
(bank_id, loan_type, max_amount, tenure_years, min_age, min_credit_score, business_vintage_required, collateral_required)
VALUES
(1, 'Term', 10000000, 10, 21, 650, 3, 'Collateral may be required'),
(1, 'WorkingCapital', 5000000, 5, 21, 650, 2, 'Collateral optional'),
(1, 'MSME', 2000000, 7, 21, 650, 1, 'Collateral optional'),
(1, 'Equipment', 3000000, 8, 21, 650, 2, 'Collateral required'),
(1, 'LineOfCredit', 5000000, 5, 21, 650, 2, 'Collateral optional'),
(1, 'Startup', 1000000, 5, 21, 650, 0, 'Collateral depends on lender');
CREATE TABLE business_loan_documents (
  doc_id INT PRIMARY KEY AUTO_INCREMENT,
  business_loan_id INT,
  document_name VARCHAR(200),
  FOREIGN KEY (business_loan_id) REFERENCES business_loan_details(business_loan_id)
);

INSERT INTO business_loan_documents (business_loan_id, document_name)
VALUES
(1, 'Identity Proof (Aadhaar, PAN, Passport, Voter ID)'),
(1, 'Address Proof (Utility Bills, Rental Agreement)'),
(1, 'Business Proof (GST Registration, Shop Act License, Partnership Deed)'),
(1, 'Income Proof (IT Returns for last 2-3 years)'),
(1, 'Bank Statements (Last 6-12 months)'),
(1, 'Financial Statements (Profit & Loss, Balance Sheet)'),
(1, 'Passport-size Photographs');
SELECT b.name, bl.loan_type, bl.max_amount, bl.tenure_years, bl.collateral_required
FROM bank b
JOIN business_loan_details bl ON b.bank_id = bl.bank_id
WHERE 30 >= bl.min_age
  AND 720 >= bl.min_credit_score
  AND 3 >= bl.business_vintage_required;
  DELIMITER //
CREATE PROCEDURE CheckBusinessLoanEligibility(
    IN user_age INT, 
    IN user_score INT, 
    IN business_vintage INT
)
BEGIN
  SELECT b.name, bl.loan_type, bl.max_amount, bl.tenure_years, bl.collateral_required
  FROM bank b
  JOIN business_loan_details bl ON b.bank_id = bl.bank_id
  WHERE user_age >= bl.min_age
    AND user_score >= bl.min_credit_score
    AND business_vintage >= bl.business_vintage_required;
END //
DELIMITER ;
ALTER TABLE eligibility_criteria 
ADD COLUMN tier_id TINYINT,
ADD CONSTRAINT fk_elig_tier FOREIGN KEY (tier_id) REFERENCES college_tiers(tier_id);
DROP PROCEDURE IF EXISTS CheckEducationLoanEligibility;
DELIMITER //
CREATE PROCEDURE CheckEducationLoanEligibility(
    IN user_age INT, 
    IN user_income DECIMAL(10,2), 
    IN nationality VARCHAR(20), 
    IN admission VARCHAR(20),
    IN tier_input TINYINT
)
BEGIN
  SELECT b.name, ed.max_amount_india, ed.max_amount_abroad, 
         ed.margin_india, ed.margin_abroad, ed.security_required,
         t.tier_name, t.chance_label
  FROM bank b
  JOIN eligibility_criteria e ON b.bank_id = e.bank_id
  JOIN education_loan_details ed ON b.bank_id = ed.bank_id
  JOIN college_tiers t ON e.tier_id = t.tier_id
  WHERE user_age BETWEEN e.min_age AND e.max_age
    AND user_income >= e.min_income
    AND e.nationality = nationality
    AND e.admission_type = admission
    AND e.tier_id = tier_input;
END //
DELIMITER ;





