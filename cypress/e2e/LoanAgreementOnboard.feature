Feature: Loan Agreement Onboarding Process

  Background:
    Given Financial Fortune loan providers submit approved loan applications in XML format
    And upload them to the Loan Management System through SFTP
    And the file processor picks up XML files for processing every 5 minutes

  Scenario: Successful Onboarding of Loan Agreement
    Given a unique XML file named 'accountId_date_time.xml' is transferred to SFTP
    And the file is picked up by the file processor
    When the file is processed and found to be XSD compliant
    And there are no duplicate files
    Then the agreement is successfully onboarded
    And the necessary information is stored in the AGREEMENTS table
    And the payment schedule is recorded in the PROFILES table
    And customer details are stored in the CUSTOMERS table
    And payment details are saved in the PAYMENTS table
    And the XML file content is logged in the XML_LOG table
    And a welcome email is sent to the customer, logged in the EMAIL_LOG table

  Scenario: Handling Duplicate AccountId
    Given a unique XML file with an existing AccountId is uploaded to SFTP
      | AccountId | StartDate  | EndDate    | Term | AmountAdvanced |
      | 123456    | 2024-05-15 | 2025-05-15 | 12   | 10000          |
    When the file processor picks up the XML file for processing
    Then the file is rejected due to duplicate AccountId

  Scenario: Verification of Information from XML
    Given the XML file content is processed and onboarded successfully
    Then the information from the XML file is correctly loaded into the appropriate tables in the database
    And no duplicates are accepted

  Example:
      | AccountId | StartDate  | EndDate    | Term | AmountAdvanced | Duplicate |
      | 123456    | 2024-05-15 | 2025-05-15 | 12   | 10000          | No        |
      | 789012    | 2024-06-01 | 2025-06-01 | 24   | 15000          | No        |
      | 123456    | 2024-05-15 | 2025-05-15 | 12   | 10000          | Yes       |


  Scenario: Handling Duplicate Files
    Given a unique XML file named 'accountId_date_time.xml' is transferred to SFTP
      | AccountId | StartDate  | EndDate    | Term | AmountAdvanced |
      | 123456    | 2024-05-15 | 2025-05-15 | 12   | 10000          |
    And the file is picked up by the file processor
    And there is already a file with the same AccountId onboarded
      | AccountId | StartDate  | EndDate    | Term | AmountAdvanced |
      | 123456    | 2024-05-15 | 2025-05-15 | 12   | 10000          |
    Then the file is rejected
    And the rejection reason is logged in the XML_LOG table

  Scenario: Handling Errors
    Given an error occurs during the onboarding process
      | ErrorType        | ErrorMessage                      |
      | Validation Error | Missing required field: AccountId |
    Then the error details are logged in the ERROR_LOG table

  Scenario: Handling Database Connection Error
    Given the system attempts to connect to the database
    When a database connection error occurs
      | ErrorCode | ErrorMessage                   |
      | 1001      | Unable to establish connection |
    Then the error details are logged in the ERROR_LOG table

  Scenario: Handling Unexpected System Error
    Given the system is in the process of executing an operation
    When an unexpected system error occurs
      | ErrorCode | ErrorMessage          |
      | 500       | Internal server error |
    Then the error details are logged in the ERROR_LOG table

  Scenario: Verification of Onboarded Agreements
    Given multiple unique XML files are transferred to SFTP
      | FileName        | AccountId | StartDate  | EndDate    | Term | AmountAdvanced |
      | agreement_1.xml | 123456    | 2024-05-15 | 2025-05-15 | 12   | 10000          |
      | agreement_2.xml | 789012    | 2024-06-01 | 2025-06-01 | 24   | 15000          |
      | agreement_3.xml | 345678    | 2024-07-01 | 2025-07-01 | 36   | 20000          |
    When the file processor picks up the XML files for processing
    Then the total number of agreements received should match the total number of agreements onboarded or rejected
      | TotalReceived | Onboarded | Rejected |
      | 3             | 2         | 1        |
    And the count of successfully onboarded agreements is accurate
      | ExpectedOnboardedCount |
      | 2                      |
    And the count of rejected agreements is accurate
      | ExpectedRejectedCount |
      | 1                     |