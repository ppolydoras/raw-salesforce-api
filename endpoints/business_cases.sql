-- @param account_name the name of the Salesforce Account
-- @type account_name varchar
-- @default account_name null
-- @param account_id the id of the Salesforce Account
-- @type account_id varchar
-- @default account_id null
-- @param create_date_range_start creation date of the business case should be greater than or equal to create_date_range_start. Format YYYY-MM-DD
-- @type create_date_range_start date
-- @default create_date_range_start null
-- @param create_date_range_end creation date of the business case should be lower than or equal to create_date_range_end. Format YYYY-MM-DD
-- @type create_date_range_end date
-- @default create_date_range_end null
-- @param business_case_description the description of the business case. Substring search is supported.
-- @type business_case_description varchar
-- @default business_case_description null
-- @param business_case_pain_points the pain points of the business case. Substring search is supported.
-- @type business_case_pain_points varchar
-- @default business_case_pain_points null
-- @param business_case_proposed_solution the proposed solution of the business case. Substring search is supported.
-- @type business_case_proposed_solution varchar
-- @default business_case_proposed_solution null
-- @param business_case_expected_outcomes the expected outcomes of the business case. Substring search is supported.
-- @type business_case_expected_outcomes varchar
-- @default business_case_expected_outcomes null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page. Default value is 25.
-- @type page_size integer
-- @default page_size null
-- @return Salesforce business cases based on various search parameters.

WITH filtered_business_cases AS (
    SELECT bc.id as business_case_id,
           bc.name as business_case_name,
           bc."Description__c" as business_case_description,
           bc."Pain_Points__c" as business_case_pain_points,
           bc."Proposed_Solution__c" as business_case_proposed_solution,
           bc."Expected_Outcomes__c" as business_case_expected_outcomes,
           bc.created_date as business_case_created_date
    FROM salesforce."salesforce_BusinessCase__c" bc
             INNER JOIN salesforce.salesforce_account a ON bc."Account__c"=a.id
             JOIN salesforce."salesforce_BusinessCaseExpert__c" e ON e."Business_Case__c"=bc.id
    WHERE (a.name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)
      AND (a.id ILIKE CONCAT('%', :account_id, '%') OR :account_id IS NULL)
      AND ((bc.created_date::timestamp >= :create_date_range_start::timestamp) OR (:create_date_range_start IS NULL))
      AND ((bc.created_date::timestamp <= :create_date_range_end::timestamp) OR (:create_date_range_end IS NULL))
      AND (bc."Description__c" ILIKE CONCAT('%', :business_case_description, '%') OR :business_case_description IS NULL)
      AND (bc."Pain_Points__c" ILIKE CONCAT('%', :business_case_pain_points, '%') OR :business_case_pain_points IS NULL)
      AND (bc."Proposed_Solution__c" ILIKE CONCAT('%', :business_case_proposed_solution, '%') OR :business_case_proposed_solution IS NULL)
      AND (bc."Expected_Outcomes__c" ILIKE CONCAT('%', :business_case_expected_outcomes, '%') OR :business_case_expected_outcomes IS NULL)
)
SELECT *
FROM filtered_business_cases
ORDER BY business_case_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
