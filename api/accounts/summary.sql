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
-- @param group_by_field the field to group the summary by (e.g., 'account_industry', 'account_type', 'account_billing_country').
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of the total number of accounts, grouped by the specified field.

WITH base_summary AS (
    SELECT
        a.id AS account_id,
        a.is_deleted AS account_is_deleted,
        a.created_date AS account_created_date,
        a.last_activity_date AS account_last_activity_date,
        a.name AS account_name,
        a.industry AS account_industry,
        a.type AS account_type,
        a.billing_country AS account_billing_country,
        a.annual_revenue AS account_annual_revenue,
        a.number_of_employees AS account_number_of_employees,
        a.rating AS account_rating,
        a.owner_id AS account_owner_id,
        a.clean_status AS account_clean_status,
        a.account_source AS account_account_source,
        a.operating_hours_id AS account_operating_hours_id
    FROM salesforce.salesforce_account a
    WHERE (industry ILIKE ANY (string_to_array(:account_industry, ',')) OR :account_industry IS NULL)
      AND (type ILIKE ANY (string_to_array(:account_type, ',')) OR :account_type IS NULL)
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
SELECT
    -- Dynamic grouping based on the group_by_field parameter
    CASE
        WHEN :group_by_field = 'account_industry' THEN account_industry
        WHEN :group_by_field = 'account_type' THEN account_type
        WHEN :group_by_field = 'account_billing_country' THEN account_billing_country
        WHEN :group_by_field = 'account_rating' THEN account_rating
        WHEN :group_by_field = 'account_source' THEN account_account_source
        ELSE 'All'
        END AS group_by_value,

    COUNT(account_id) AS total_accounts,
    COUNT(CASE WHEN account_is_deleted = false THEN 1 END) AS active_accounts,
    COUNT(CASE WHEN account_is_deleted = true THEN 1 END) AS deleted_accounts,
    COUNT(CASE WHEN account_created_date >= :account_created_date_range_start::timestamp
          AND account_created_date <= :account_created_date_range_end::timestamp
          THEN 1 END) AS accounts_created_in_date_range
FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
