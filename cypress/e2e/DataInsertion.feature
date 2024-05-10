    Scenario: Valid CUSTOMER Data Insertion
        Given a new customer is created with the following details:
            | Id | Name          | DOB        | Type | Gender | Address line1 | Address line 2 | Town/City | Postcode | County    | Telephone    | Email              | accountId | Created_date |
            | 1  | Mrs. Miya Sow | 1992-06-05 | F    | F      | 123 Main St   | Apt 2          | Cardiff   | CF11 11Y | Glamorgan | 123-456-7890 | miya.sow@email.com | 123456    | 2024-05-20   |
        When the customer data is inserted into the CUSTOMERS table
        Then the customer information is stored correctly in the database

    Scenario: Invalid CUSTOMER Data Insertion - Missing Required Fields
        Given a new customer is created with missing or invalid details:
            | Id | Name | DOB        | Type | Gender | Address line1 | Postcode | Telephone    | Email              | accountId | Created_date |
            | 1  |      | 1992-06-05 | F    | F      | 123 Main St   | CF11 11Y | 123-456-7890 | miya.sow@email.com | 123456    | 2024-05-20   |
        When the customer data is attempted to be inserted into the CUSTOMERS table
        Then an error should occur indicating missing or invalid required fields
        And the customer data should not be stored in the database

    Scenario: Valid PAYMENT Data Insertion
        Given a payment is made with the following details:
            | Id | Method       | Bank_account | Bank_name | Cust_id | Sortcode | Account_name | Created_date |
            | 1  | Direct debit | 1234567890   | Test Bank | 1       | 123456   | Miya Sow     | 2024-05-20   |
        When the payment data is inserted into the PAYMENTS table
        Then the payment information is stored correctly in the database

    Scenario: Invalid PAYMENT Data Insertion - Missing Required Fields
        Given a payment is attempted to be made with missing or invalid details:
            | Id | Method       | Bank_account | Bank_name | Cust_id | Sortcode | Account_name | Created_date |
            | 1  | Direct debit |              | Test Bank | 1       | 123456   | Miya Sow     | 2024-05-20   |
        When the payment data is attempted to be inserted into the PAYMENTS table
        Then an error should occur indicating missing or invalid required fields
        And the payment data should not be stored in the database

    Scenario: Valid PROFILE Data Insertion
        Given a payment profile is created with the following details:
            | AgreementId | Instalment_no | Payment_due_date | Instalment_amount | Created_date |
            | 0098        | 1             | 2024-05-15       | 100               | 2024-05-01   |
        When the payment profile data is inserted into the PROFILES table
        Then the payment profile information is stored correctly in the database

    Scenario: Invalid PROFILE Data Insertion - Missing Required Fields
        Given a payment profile is attempted to be created with missing or invalid details:
            | AgreementId | Instalment_no | Payment_due_date | Instalment_amount | Created_date |
            |             | 1             | 2024-05-15       | 100               | 2024-05-01   |
        When the payment profile data is attempted to be inserted into the PROFILES table
        Then an error should occur indicating missing or invalid required fields
        And the payment profile data should not be stored in the database

    Scenario: Valid AGREEMENT Data Insertion
        Given a loan agreement is created with the following details:
            | AccountId | Id | Start_date | End_date   | Term | Amount_advanced | Total_payable | Interest_amount | Interest_rate | Provider          | Frequency | Created_date |
            | 123456    | 1  | 2024-05-15 | 2025-05-15 | 12   | 10000           | 11000         | 1000            | 10%           | Financial Fortune | M         | 2024-05-15   |
        When the loan agreement data is inserted into the AGREEMENTS table
        Then the loan agreement information is stored correctly in the database

    Scenario: Invalid AGREEMENT Data Insertion - Missing Required Fields
        Given a loan agreement is attempted to be created with missing or invalid details:
            | AccountId | Id | Start_date | End_date | Term | Amount_advanced | Total_payable | Interest_amount | Interest_rate | Provider          | Frequency | Created_date |
            | 123456    | 1  | 2024-05-15 |          | 12   | 10000           | 11000         | 1000            | 10%           | Financial Fortune | M         | 2024-05-15   |
        When the loan agreement data is attempted to be inserted into the AGREEMENTS table
        Then an error should occur indicating missing or invalid required fields
        And the loan agreement data should not be stored in the database

    Scenario: Valid Email Logging
        Given an email is successfully sent to a customer
        When the email log is created with the following details:
            | email_log_id | email_id           | message                         | status | sent_date           |
            | 1            | miya.sow@gmail.com | Thank you for your application! | D      | 2024-05-15 10:00:00 |
        Then the email log is stored correctly in the EMAIL_LOG table


    Scenario: Invalid Email Logging - Missing Required Fields
        Given an attempt is made to log an email with missing or invalid details:
            | email_log_id | email_id | message | status | sent_date           |
            | 1            |          |         | D      | 2024-05-15 10:00:00 |
        When the email log is attempted to be created with the above details
        Then an error should occur indicating missing or invalid required fields
        And the email log should not be stored in the EMAIL_LOG table


    Scenario: Logging Error Details
        Given an error occurs during the processing of an application
        When the error details are logged with the following information:
            | error_id | module         | error_date          |
            | 1        | File Processor | 2024-05-15 10:30:00 |
        Then the error details are stored in the ERROR_LOG table

    Scenario: Logging XML File Information - Onboarded
        Given an XML file is received for processing
        When the XML file is successfully onboarded
        And the XML file information is logged with the following details:
            | xml_log_id | file_name          | status | Reason | sent_date           |
            | 1          | Fortune_file05.xml | O      |        | 2024-05-15 10:00:00 |
        Then the XML file information is stored correctly in the XML_LOG table

    Scenario: Logging XML File Information - Rejected
        Given an XML file is received for processing
        When the XML file is rejected due to validation errors
        And the rejection reason is specified
        And the XML file information is logged with the following details:
            | xml_log_id | file_name          | status | Reason         | sent_date           |
            | 2          | Fortune_file06.xml | R      | Invalid format | 2024-05-15 10:30:00 |
        Then the XML file information is stored correctly in the XML_LOG table
