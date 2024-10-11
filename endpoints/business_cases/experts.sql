-- @param user_email the email of the Salesforce User
-- @type user_email varchar
-- @default user_email null
-- @param user_id the ID of the Salesforce User
-- @type user_id varchar
-- @default user_id null
-- @param username the username of the Salesforce User
-- @type username varchar
-- @default username null
-- @param business_case_id the id of the Salesforce Business Case
-- @type business_case_id varchar
-- @default business_case_id null
-- @param business_case_expert_expertise the expertise of Salesforce Business Case Expert. Substring search is enabled.
-- @type business_case_expert_expertise varchar
-- @default business_case_expert_expertise null
-- @param business_case_expert_reason_for_assignment the reason for assigning this Salesforce Business Case Expert to this Salesforce Business Case. Substring search is enabled.
-- @type business_case_expert_reason_for_assignment varchar
-- @default business_case_expert_reason_for_assignment null
-- @param expert_assignment_date_range_start assignment date of the expert should be greater than or equal to create_date_range_start. Format YYYY-MM-DD
-- @type expert_assignment_date_range_start date
-- @default expert_assignment_date_range_start null
-- @param expert_assignment_date_range_end assignment date of the expert should be lower than or equal to create_date_range_end. Format YYYY-MM-DD
-- @type expert_assignment_date_range_end date
-- @default expert_assignment_date_range_end null
-- @param user_created_date_range_start creation date of the user should be greater than or equal to create_date_range_start. Format YYYY-MM-DD
-- @type user_created_date_range_start date
-- @default user_created_date_range_start null
-- @param user_created_date_range_end creation date of the user should be lower than or equal to create_date_range_end. Format YYYY-MM-DD
-- @type user_created_date_range_end date
-- @default user_created_date_range_end null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page. Default value is 25.
-- @type page_size integer
-- @default page_size null
-- @return Salesforce Business Case Experts based on specified filters.

WITH filtered_business_case_experts AS (
    SELECT u.id as expert_user_id,
           u.username as expert_username,
           u.email as expert_email,
           u.is_active as expert_is_active,
           bc.id as business_case_id,
           e."Expertise__c" as expertise,
           e."Reason_For_Assignment__c" as reason_for_assignment,
           e.created_date as expert_assignment_date,
           u.created_date as expert_user_created_date
    FROM salesforce."salesforce_BusinessCaseExpert__c" e
             INNER JOIN salesforce."salesforce_BusinessCase__c" bc ON bc.id=e."Business_Case__c"
             INNER JOIN salesforce.salesforce_user u ON u.id=e."User__c"
    WHERE (u.email = :user_email OR :user_email IS NULL)
      AND (u.username = :username OR :username IS NULL)
      AND (u.id = :user_id OR :user_id IS NULL)
      AND (bc.id = :business_case_id OR :business_case_id IS NULL)
      AND (e."Expertise__c" ILIKE CONCAT('%',:business_case_expert_expertise,'%') OR :business_case_expert_expertise IS NULL)
      AND (e."Reason_For_Assignment__c" ILIKE CONCAT('%',:business_case_expert_reason_for_assignment,'%') OR :business_case_expert_reason_for_assignment IS NULL)
      AND ((e.created_date >= :expert_assignment_date_range_start::timestamp) OR (:expert_assignment_date_range_start IS NULL))
      AND ((e.created_date <= :expert_assignment_date_range_end::timestamp) OR (:expert_assignment_date_range_end IS NULL))
      AND ((u.created_date >= :user_created_date_range_start::timestamp) OR (:user_created_date_range_start IS NULL))
      AND ((u.created_date <= :user_created_date_range_end::timestamp) OR (:user_created_date_range_end IS NULL))
)
SELECT *
FROM filtered_business_case_experts
ORDER BY business_case_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
