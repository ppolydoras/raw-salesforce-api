-- @param account_name the name of the Salesforce Account. Substring search is supported.
-- @type account_name varchar
-- @default account_name null
-- @param owner_name the name of the owner (Salesforce user). Substring search is supported.
-- @type owner_name varchar
-- @default owner_name 'Pavlos Polydoras'
-- @param opportunity_name the name of the opportunity. Substring search is supported.
-- @type opportunity_name varchar
-- @default opportunity_name null
-- @param opportunity_stage comma-separated list of opportunity stages - permissible values can be found in endpoint '/salesforce_gpt/enumeration/opportunity_stages'. If null then all stages are included.
-- @type opportunity_stage varchar
-- @default opportunity_stage null
-- @param opportunity_created_date_range_start opportunity creation date is greater than or equal to opportunity_created_date_range_start. Format YYYY-MM-DD.
-- @type opportunity_created_date_range_start date
-- @default opportunity_created_date_range_start null
-- @param opportunity_created_date_range_end opportunity creation date is lower than or equal to opportunity_created_date_range_end. Format YYYY-MM-DD.
-- @type opportunity_created_date_range_end date
-- @default opportunity_created_date_range_end null
-- @param opportunity_last_activity_date_range_start opportunity's last activity date is greater than or equal to opportunity_last_activity_date_range_start. Format YYYY-MM-DD.
-- @type opportunity_last_activity_date_range_start date
-- @default opportunity_last_activity_date_range_start null
-- @param opportunity_last_activity_date_range_end opportunity's last activity date is lower than or equal to opportunity_last_activity_date_range_end. Format YYYY-MM-DD.
-- @type opportunity_last_activity_date_range_end date
-- @default opportunity_last_activity_date_range_end null
-- @param country the country of the opportunity account
-- @type country varchar
-- @default country null
-- @param state the state of the opportunity account
-- @type state varchar
-- @default state null
-- @param postal_code the postal code of the opportunity account
-- @type postal_code integer
-- @default postal_code null
-- @param street the street of the opportunity account.
-- @type street varchar
-- @default street null
-- @param group_by_field the field to group the summary by (e.g., 'account_name', 'opportunity_stage', 'country').
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of the total number of opportunities, grouped by the specified field.

WITH base_summary AS (
    SELECT
        o.id AS opportunity_id,
        o.amount AS opportunity_amount,
        o.close_date AS opportunity_close_date,
        o.stage_name AS opportunity_stage,
        o.created_date AS opportunity_created_date,
        o.last_activity_date AS opportunity_last_activity_date,
        o.probability AS opportunity_probability,
        a.name AS account_name,
        u.name AS owner_name,
        a.billing_address->'country' AS country
    FROM salesforce.salesforce_opportunity o
             INNER JOIN salesforce.salesforce_account a ON o.account_id = a.id
             INNER JOIN salesforce.salesforce_user u ON o.owner_id = u.id
    WHERE (a.name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)
      AND (u.name ILIKE CONCAT('%', :owner_name, '%') OR :owner_name IS NULL)
      AND (o.name ILIKE CONCAT('%', :opportunity_name, '%') OR :opportunity_name IS NULL)
      AND (o.stage_name ILIKE ANY (string_to_array(:opportunity_stage, ',')) OR :opportunity_stage IS NULL)
      AND ((o.created_date >= :opportunity_created_date_range_start::timestamp) OR :opportunity_created_date_range_start IS NULL)
      AND ((o.created_date <= :opportunity_created_date_range_end::timestamp) OR :opportunity_created_date_range_end IS NULL)
      AND ((o.last_activity_date >= :opportunity_last_activity_date_range_start::date) OR :opportunity_last_activity_date_range_start IS NULL)
      AND ((o.last_activity_date <= :opportunity_last_activity_date_range_end::date) OR :opportunity_last_activity_date_range_end IS NULL)
      AND (a.billing_address->'country' ILIKE CONCAT('%', :country, '%') OR :country IS NULL)
      AND (a.billing_address->'state' ILIKE CONCAT('%', :state, '%') OR :state IS NULL)
      AND (a.billing_address->'postalCode' ILIKE CONCAT('%', :postal_code, '%') OR :postal_code IS NULL)
)
SELECT
    CASE
        WHEN :group_by_field = 'account_name' THEN account_name
        WHEN :group_by_field = 'opportunity_stage' THEN opportunity_stage
        WHEN :group_by_field = 'country' THEN country
        ELSE 'All'
        END AS group_by_value,

    COUNT(opportunity_id) AS total_opportunities,
    SUM(opportunity_amount) AS total_amount,
    AVG(opportunity_probability) AS avg_probability,
    COUNT(CASE WHEN opportunity_stage = 'closed' THEN 1 END) AS closed_opportunities,
    COUNT(CASE WHEN opportunity_created_date >= :opportunity_created_date_range_start::date
          AND opportunity_created_date <= :opportunity_created_date_range_end::date
          THEN 1 END) AS opportunities_created_in_date_range
FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
