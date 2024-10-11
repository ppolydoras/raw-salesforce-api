-- @param account_name the name of the Salesforce Account
-- @type account_name varchar
-- @default account_name null
-- @param account_industry comma-separated list of account industries - permissible values can be found in endpoint '/salesforce_gpt/enumeration/industries'. If null, all industries are included.
-- @type account_industry varchar
-- @default account_industry null
-- @param account_type comma-separated list of account types - permissible values can be found in endpoint '/salesforce_gpt/enumeration/account_types'. If null, all account types are included.
-- @type account_type varchar
-- @default account_type null
-- @param account_created_date_range_start account creation date is greater than or equal to account_created_date_range_start. Format YYYY-MM-DD.
-- @type account_created_date_range_start date
-- @default account_created_date_range_start null
-- @param account_created_date_range_end account creation date is lower than or equal to account_created_date_range_end. Format YYYY-MM-DD.
-- @type account_created_date_range_end date
-- @default account_created_date_range_end null
-- @param account_last_activity_date_range_start account's last activity date is greater than or equal to account_last_activity_date_range_start. Format YYYY-MM-DD.
-- @type account_last_activity_date_range_start date
-- @default account_last_activity_date_range_start null
-- @param account_last_activity_date_range_end account's last activity date is lower than or equal to account_last_activity_date_range_end. Format YYYY-MM-DD.
-- @type account_last_activity_date_range_end date
-- @default account_last_activity_date_range_end null
-- @param account_billing_country the billing address country of the account
-- @type account_billing_country varchar
-- @default account_billing_country null
-- @param account_billing_state the billing address state of the account
-- @type account_billing_state varchar
-- @default account_billing_state null
-- @param account_billing_postal_code the billing address postal code of the account
-- @type account_billing_postal_code integer
-- @default account_billing_postal_code null
-- @param account_billing_street the billing address street of the account
-- @type account_billing_street varchar
-- @default account_billing_street null
-- @param account_billing_city the billing address city of the account
-- @type account_billing_city varchar
-- @default account_billing_city null
-- @param account_is_deleted account deleted
-- @type account_is_deleted boolean
-- @default account_is_deleted null
-- @param annual_revenue_range_start Filter accounts with annual revenue greater than or equal to this value.
-- @type annual_revenue_range_start bigint
-- @default annual_revenue_range_start null
-- @param annual_revenue_range_end Filter accounts with annual revenue less than or equal to this value.
-- @type annual_revenue_range_end bigint
-- @default annual_revenue_range_end null
-- @param number_of_employees_range_start Filter accounts with number of employees greater than or equal to this value.
-- @type number_of_employees_range_start integer
-- @default number_of_employees_range_start null
-- @param number_of_employees_range_end Filter accounts with number of employees less than or equal to this value.
-- @type number_of_employees_range_end integer
-- @default number_of_employees_range_end null
-- @param account_rating Filter by account rating - permissible values can be found in endpoint '/salesforce_gpt/enumeration/ratings'. If null, all account ratings are included.
-- @type account_rating varchar
-- @default account_rating null
-- @param owner_id Filter by Salesforce User ID of the account owner.
-- @type owner_id varchar
-- @default owner_id null
-- @param clean_status Filter by clean status of the account. Permissible values are 'Clean', 'Pending'.
-- @type clean_status varchar
-- @default clean_status null
-- @param account_source Filter by the source of the account.
-- @type account_source varchar
-- @default account_source null
-- @param operating_hours_id Filter by operating hours ID of the account.
-- @type operating_hours_id varchar
-- @default operating_hours_id null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page. Default value is 25.
-- @type page_size integer
-- @default page_size null
-- @return Salesforce accounts with pagination and supports various filters like account industry, account type, and account billing country.

WITH filtered_accounts AS (
    SELECT "id" as "account_id",
           "is_deleted" as "account_is_deleted",
           "master_record_id" as "account_master_record_id",
           "name" as "account_name",
           "type" as "account_type",
           "parent_id" as "account_parent_id",
           "billing_street" as "account_billing_street",
           "billing_city" as "account_billing_city",
           "billing_state" as "account_billing_state",
           "billing_postal_code" as "account_billing_postal_code",
           "billing_country" as "account_billing_country",
           "billing_latitude" as "account_billing_latitude",
           "billing_longitude" as "account_billing_longitude",
           "billing_geocode_accuracy" as "account_billing_geocode_accuracy",
           "billing_address" as "account_billing_address",
           "shipping_street" as "account_shipping_street",
           "shipping_city" as "account_shipping_city",
           "shipping_state" as "account_shipping_state",
           "shipping_postal_code" as "account_shipping_postal_code",
           "shipping_country" as "account_shipping_country",
           "shipping_latitude" as "account_shipping_latitude",
           "shipping_longitude" as "account_shipping_longitude",
           "shipping_geocode_accuracy" as "account_shipping_geocode_accuracy",
           "shipping_address" as "account_shipping_address",
           "phone" as "account_phone",
           "fax" as "account_fax",
           "account_number" as "account_account_number",
           "website" as "account_website",
           "photo_url" as "account_photo_url",
           "sic" as "account_sic",
           "industry" as "account_industry",
           "annual_revenue" as "account_annual_revenue",
           "number_of_employees" as "account_number_of_employees",
           "ownership" as "account_ownership",
           "ticker_symbol" as "account_ticker_symbol",
           "description" as "account_description",
           "rating" as "account_rating",
           "site" as "account_site",
           "owner_id" as "account_owner_id",
           "created_date" as "account_created_date",
           "created_by_id" as "account_created_by_id",
           "last_modified_date" as "account_last_modified_date",
           "last_modified_by_id" as "account_last_modified_by_id",
           "system_modstamp" as "account_system_modstamp",
           "last_activity_date" as "account_last_activity_date",
           "last_viewed_date" as "account_last_viewed_date",
           "last_referenced_date" as "account_last_referenced_date",
           "jigsaw" as "account_jigsaw",
           "jigsaw_company_id" as "account_jigsaw_company_id",
           "clean_status" as "account_clean_status",
           "account_source" as "account_account_source",
           "duns_number" as "account_duns_number",
           "tradestyle" as "account_tradestyle",
           "naics_code" as "account_naics_code",
           "naics_desc" as "account_naics_desc",
           "year_started" as "account_year_started",
           "sic_desc" as "account_sic_desc",
           "dandb_company_id" as "account_dandb_company_id",
           "operating_hours_id" as "account_operating_hours_id"
    FROM salesforce.salesforce_account
    WHERE (industry ILIKE ANY (string_to_array(:account_industry, ','))
           OR :account_industry IS NULL)
      AND (type ILIKE ANY (string_to_array(:account_type, ','))
           OR :account_type IS NULL)
      AND (name ILIKE CONCAT('%',:account_name,'%') OR :account_name IS NULL)
      AND ((created_date >= :account_created_date_range_start::timestamp) OR (:account_created_date_range_start IS NULL))
      AND ((created_date <= :account_created_date_range_end::timestamp) OR (:account_created_date_range_end IS NULL))
      AND ((last_activity_date >= :account_last_activity_date_range_start::date) OR (:account_last_activity_date_range_start IS NULL))
      AND ((last_activity_date <= :account_last_activity_date_range_end::date) OR (:account_last_activity_date_range_end IS NULL))
      AND (billing_country ILIKE CONCAT('%',:account_billing_country,'%') OR :account_billing_country IS NULL)
      AND (billing_state ILIKE CONCAT('%',:account_billing_state,'%') OR :account_billing_state IS NULL)
      AND (billing_postal_code ILIKE CONCAT('%',:account_billing_postal_code,'%') OR :account_billing_postal_code IS NULL)
      AND (billing_street ILIKE CONCAT('%',:account_billing_street,'%') OR :account_billing_street IS NULL)
      AND (billing_city ILIKE CONCAT('%',:account_billing_city,'%') OR :account_billing_city IS NULL)
      AND (is_deleted=:account_is_deleted OR :account_is_deleted IS NULL)
      AND (annual_revenue >= :annual_revenue_range_start OR :annual_revenue_range_start IS NULL)
      AND (annual_revenue <= :annual_revenue_range_end OR :annual_revenue_range_end IS NULL)
      AND (number_of_employees >= :number_of_employees_range_start OR :number_of_employees_range_start IS NULL)
      AND (number_of_employees <= :number_of_employees_range_end OR :number_of_employees_range_end IS NULL)
      AND (rating ILIKE :account_rating OR :account_rating IS NULL)
      AND (owner_id = :owner_id OR :owner_id IS NULL)
      AND (clean_status ILIKE :clean_status OR :clean_status IS NULL)
      AND (account_source ILIKE :account_source OR :account_source IS NULL)
      AND (operating_hours_id = :operating_hours_id OR :operating_hours_id IS NULL)
)
SELECT *
FROM filtered_accounts
ORDER BY account_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
