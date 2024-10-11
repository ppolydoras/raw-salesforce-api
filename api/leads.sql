-- @param lead_rating comma-separated list of lead ratings - permissible values can be found in endpoint `/salesforce_gpt/enumeration/ratings`. If null then all ratings are included.
-- @type lead_rating varchar
-- @default lead_rating null
-- @param lead_status comma-separated list of lead statuses - permissible values can be found in endpoint `/salesforce_gpt/enumeration/lead_statuses`. If null then all statuses are included.
-- @type lead_status varchar
-- @default lead_status null
-- @param lead_industry comma-separated list of lead industries - permissible values can be found in endpoint `/salesforce_gpt/enumeration/industries`. If null then all statuses are included.
-- @type lead_industry varchar
-- @default lead_industry null
-- @param lead_source comma-separated list of lead source/origin - permissible values can be found in endpoint `/salesforce_gpt/enumeration/lead_sources`. If null the all sources are included.
-- @type lead_source varchar
-- @default lead_source null
-- @param lead_email the email of the Salesforce Lead
-- @type lead_email varchar
-- @default lead_email null
-- @param lead_name the full name of the Salesforce Lead
-- @type lead_name varchar
-- @default lead_name null
-- @param lead_description the description of the Salesforce Lead
-- @type lead_description varchar
-- @default lead_description null
-- @param lead_is_converted Salesforce Lead is converted
-- @type lead_is_converted boolean
-- @default lead_is_converted null
-- @param lead_created_date_range_start lead creation date is greater than or equal to lead_created_date_range_start. Format YYYY-MM-DD.
-- @type lead_created_date_range_start date
-- @default lead_created_date_range_start null
-- @param lead_created_date_range_end lead creation date is lower than or equal to lead_created_date_range_end. Format YYYY-MM-DD.
-- @type lead_created_date_range_end date
-- @default lead_created_date_range_end null
-- @param lead_last_activity_date_range_start lead's last activity date is greater than or equal to lead_last_activity_date_range_start. Format YYYY-MM-DD.
-- @type lead_last_activity_date_range_start date
-- @default lead_last_activity_date_range_start null
-- @param lead_last_activity_date_range_end lead's last activity date is lower than or equal to lead_last_activity_date_range_end. Format YYYY-MM-DD.
-- @type lead_last_activity_date_range_end date
-- @default lead_last_activity_date_range_end null
-- @param lead_country the billing address country of the contract
-- @type lead_country varchar
-- @default lead_country null
-- @param lead_state the billing address state of the contract
-- @type lead_state varchar
-- @default lead_state null
-- @param lead_postal_code the billing address postal code of the contract
-- @type lead_postal_code integer
-- @default lead_postal_code null
-- @param lead_street the billing address street of the contract
-- @type lead_street varchar
-- @default lead_street null
-- @param lead_city the billing address city of the contract
-- @type lead_city varchar
-- @default lead_city null
-- @param lead_is_deleted contract deleted
-- @type lead_is_deleted boolean
-- @default lead_is_deleted null
-- @param lead_owner_id the Salesforce Owner ID of the Lead. This is the Salesforce User ID for the owner.
-- @type lead_owner_id varchar
-- @default lead_owner_id null
-- @param lead_converted_date_range_start lead converted date is greater than or equal to this date. Format YYYY-MM-DD.
-- @type lead_converted_date_range_start date
-- @default lead_converted_date_range_start null
-- @param lead_converted_date_range_end lead converted date is lower than or equal to this date. Format YYYY-MM-DD.
-- @type lead_converted_date_range_end date
-- @default lead_converted_date_range_end null
-- @param has_email_bounced filter leads where email has bounced (true/false).
-- @type has_email_bounced boolean
-- @default has_email_bounced null
-- @param is_priority_record filter Salesforce leads that are marked as priority (true/false).
-- @type is_priority_record boolean
-- @default is_priority_record null
-- @param min_employees minimum number of employees in the company associated with the lead.
-- @type min_employees integer
-- @default min_employees null
-- @param max_employees maximum number of employees in the company associated with the lead.
-- @type max_employees integer
-- @default max_employees null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page
-- @type page_size integer
-- @default page_size null
-- @return Salesforce Leads by rating, status, and other filters, with pagination support.

WITH filtered_leads AS (
    SELECT "id" as "lead_id",
           "email" as "lead_email",
           "is_converted" as "lead_is_converted",
           "name" as "lead_name",
           "phone" as "lead_phone",
           "status" as "lead_status",
           "annual_revenue" as "lead_annual_revenue",
           "company" as "lead_company",
           "converted_date" as "lead_converted_date",
           "created_by_id" as "lead_created_by_id",
           "created_date" as "lead_created_date",
           "industry" as "lead_industry",
           "last_modified_by_id" as "lead_last_modified_by_id",
           "last_modified_date" as "lead_last_modified_date",
           "lead_source" as "lead_source",
           "number_of_employees" as "lead_number_of_employees",
           "owner_id" as "lead_owner_id",
           "rating" as "lead_rating",
           "website" as "lead_website",
           "is_deleted" as "lead_is_deleted",
           "master_record_id" as "lead_master_record_id",
           "last_name" as "lead_last_name",
           "first_name" as "lead_first_name",
           "salutation" as "lead_salutation",
           "title" as "lead_title",
           "street" as "lead_street",
           "city" as "lead_city",
           "state" as "lead_state",
           "postal_code" as "lead_postal_code",
           "country" as "lead_country",
           "latitude" as "lead_latitude",
           "longitude" as "lead_longitude",
           "geocode_accuracy" as "lead_geocode_accuracy",
           "mobile_phone" as "lead_mobile_phone",
           "fax" as "lead_fax",
           "photo_url" as "lead_photo_url",
           "description" as "lead_description",
           "converted_account_id" as "lead_converted_account_id",
           "converted_contact_id" as "lead_converted_contact_id",
           "converted_opportunity_id" as "lead_converted_opportunity_id",
           "is_unread_by_owner" as "lead_is_unread_by_owner",
           "system_modstamp" as "lead_system_modstamp",
           "last_activity_date" as "lead_last_activity_date",
           "last_viewed_date" as "lead_last_viewed_date",
           "last_referenced_date" as "lead_last_referenced_date",
           "jigsaw" as "lead_jigsaw",
           "jigsaw_contact_id" as "lead_jigsaw_contact_id",
           "clean_status" as "lead_clean_status",
           "company_duns_number" as "lead_company_duns_number",
           "dandb_company_id" as "lead_dandb_company_id",
           "email_bounced_reason" as "lead_email_bounced_reason",
           "email_bounced_date" as "lead_email_bounced_date",
           "individual_id" as "lead_individual_id",
           "is_priority_record" as "lead_is_priority_record",
           "SICCode__c" as "lead_SICCode__c",
           "ProductInterest__c" as "lead_ProductInterest__c",
           "Primary__c" as "lead_Primary__c",
           "CurrentGenerators__c" as "lead_CurrentGenerators__c",
           "NumberofLocations__c" as "lead_NumberofLocations__c"
    FROM salesforce.salesforce_lead
    WHERE (rating ILIKE ANY (string_to_array(:lead_rating, ',')) OR :lead_rating IS NULL)
      AND (status ILIKE ANY (string_to_array(:lead_status, ',')) OR :lead_status IS NULL)
      AND (industry ILIKE ANY (string_to_array(:lead_industry, ',')) OR :lead_industry IS NULL)
      AND (lead_source ILIKE ANY (string_to_array(:lead_source, ',')) OR :lead_source IS NULL)
      AND (email ILIKE CONCAT('%', :lead_email, '%') OR :lead_email IS NULL)
      AND (description ILIKE CONCAT('%', :lead_description, '%') OR :lead_description IS NULL)
      AND (is_converted=:lead_is_converted OR :lead_is_converted IS NULL)
      AND (name ILIKE CONCAT('%',:lead_name,'%') OR :lead_name IS NULL)
      AND ((created_date >= :lead_created_date_range_start::timestamp) OR (:lead_created_date_range_start IS NULL))
      AND ((created_date <= :lead_created_date_range_end::timestamp) OR (:lead_created_date_range_end IS NULL))
      AND ((last_activity_date >= :lead_last_activity_date_range_start::date) OR (:lead_last_activity_date_range_start IS NULL))
      AND ((last_activity_date <= :lead_last_activity_date_range_end::date) OR (:lead_last_activity_date_range_end IS NULL))
      AND (country ILIKE CONCAT('%',:lead_country,'%') OR :lead_country IS NULL)
      AND (state ILIKE CONCAT('%',:lead_state,'%') OR :lead_state IS NULL)
      AND (postal_code ILIKE CONCAT('%',:lead_postal_code,'%') OR :lead_postal_code IS NULL)
      AND (street ILIKE CONCAT('%',:lead_street,'%') OR :lead_street IS NULL)
      AND (city ILIKE CONCAT('%',:lead_city,'%') OR :lead_city IS NULL)
      AND (is_deleted=:lead_is_deleted OR :lead_is_deleted IS NULL)
      AND (owner_id = :lead_owner_id OR :lead_owner_id IS NULL)
      AND ((converted_date >= :lead_converted_date_range_start::date) OR (:lead_converted_date_range_start IS NULL))
      AND ((converted_date <= :lead_converted_date_range_end::date) OR (:lead_converted_date_range_end IS NULL))
      AND (email_bounced_reason IS NOT NULL OR :has_email_bounced IS NULL)
      AND (is_priority_record = :is_priority_record OR :is_priority_record IS NULL)
      AND (number_of_employees >= :min_employees OR :min_employees IS NULL)
      AND (number_of_employees <= :max_employees OR :max_employees IS NULL)
)
SELECT *
FROM filtered_leads
ORDER BY lead_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);