-- @param account_name the name of the Salesforce Account. Substring search is supported.
-- @type account_name varchar
-- @default account_name null
-- @param owner_name the name of the owner (Salesforce user). Substring search is supported.
-- @type owner_name varchar
-- @default owner_name 'Pavlos Polydoras'
-- @param opportunity_name the name of the opportunity. Substring search is supported.
-- @type opportunity_name varchar
-- @default opportunity_name null
-- @param opportunity_stage comma-separated list of opportunity stages - permissible values can be found in endpoint '/salesforce_gpt/enumeration/opportunity_stages'. If null, all stages are included.
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
-- @param opportunity_type the type of the opportunity.
-- @type opportunity_type varchar
-- @default opportunity_type null
-- @param is_closed Filter by whether the opportunity is closed (true or false).
-- @type is_closed boolean
-- @default is_closed null
-- @param is_won Filter by whether the opportunity is won (true or false).
-- @type is_won boolean
-- @default is_won null
-- @param lead_source the lead source of the opportunity.
-- @type lead_source varchar
-- @default lead_source null
-- @param fiscal_year Filter by fiscal year.
-- @type fiscal_year integer
-- @default fiscal_year null
-- @param page the current page number to retrieve.
-- @type page integer
-- @default page null
-- @param page_size the number of records per page.
-- @type page_size integer
-- @default page_size null
-- @return opportunities with additional fields and filters based on the user input criteria, including pagination support.

WITH filtered_opportunities AS (
    SELECT
        o.id as opportunity_id,
        o.name as opportunity_name,
        o.amount as opportunity_amount,
        o.close_date as opportunity_close_date,
        o.stage_name as opportunity_stage_name,
        o.probability as opportunity_probability,
        o.expected_revenue as opportunity_expected_revenue,
        o.fiscal_quarter as opportunity_fiscal_quarter,
        o.fiscal_year as opportunity_fiscal_year,
        o.forecast_category as opportunity_forecast_category,
        o.forecast_category_name as opportunity_forecast_category_name,
        o.has_open_activity as opportunity_has_open_activity,
        o.has_opportunity_line_item as opportunity_has_opportunity_line_item,
        o.has_overdue_task as opportunity_has_overdue_task,
        o.is_closed as opportunity_is_closed,
        o.is_deleted as opportunity_is_deleted,
        o.is_private as opportunity_is_private,
        o.is_won as opportunity_is_won,
        o.last_activity_date as opportunity_last_activity_date,
        o.lead_source as opportunity_lead_source,
        o.next_step as opportunity_next_step,
        o.total_opportunity_quantity as opportunity_total_opportunity_quantity,
        o.type as opportunity_type,
        o.last_stage_change_date as opportunity_last_stage_change_date,
        o.push_count as opportunity_push_count,
        o.system_modstamp as opportunity_system_modstamp,
        o.created_date as opportunity_created_date,
        o.created_by_id as opportunity_created_by_id,
        o.last_modified_date as opportunity_last_modified_date,
        o.last_modified_by_id as opportunity_last_modified_by_id,
        o.description as opportunity_description,
        o.pricebook_2_id as opportunity_pricebook_2_id,
        o.contact_id as opportunity_contact_id,
        o."DeliveryInstallationStatus__c" as "opportunity_DeliveryInstallationStatus__c",
        o."TrackingNumber__c" as "opportunity_TrackingNumber__c",
        o."OrderNumber__c" as "opportunity_OrderNumber__c",
        o."CurrentGenerators__c" as "opportunity_CurrentGenerators__c",
        o."MainCompetitors__c" as "opportunity_MainCompetitors__c",
        a.name AS account_name,
        a.id as account_id,
        u.name AS owner_name,
        u.id as owner_id,
        a.billing_address as account_billing_address
    FROM salesforce.salesforce_opportunity o
             INNER JOIN salesforce.salesforce_account a ON o.account_id = a.id
             INNER JOIN salesforce.salesforce_user u ON o.owner_id = u.id
    WHERE (a.name ILIKE CONCAT('%',:account_name,'%') OR :account_name IS NULL)
      AND (u.name ILIKE CONCAT('%',:owner_name,'%') OR :owner_name IS NULL)
      AND (o.name ILIKE CONCAT('%',:opportunity_name,'%') OR :opportunity_name IS NULL)
      AND (o.stage_name ILIKE ANY (string_to_array(:opportunity_stage, ',')) OR :opportunity_stage IS NULL)
      AND ((o.created_date >= :opportunity_created_date_range_start::timestamp) OR (:opportunity_created_date_range_start IS NULL))
      AND ((o.created_date <= :opportunity_created_date_range_end::timestamp) OR (:opportunity_created_date_range_end IS NULL))
      AND ((o.last_activity_date >= :opportunity_last_activity_date_range_start::timestamp) OR (:opportunity_last_activity_date_range_start IS NULL))
      AND ((o.last_activity_date <= :opportunity_last_activity_date_range_end::timestamp) OR (:opportunity_last_activity_date_range_end IS NULL))
      AND (a.billing_address->'country' ILIKE CONCAT('%',:country,'%') OR :country IS NULL)
      AND (a.billing_address->'state' ILIKE CONCAT('%',:state,'%') OR :state IS NULL)
      AND (a.billing_address->'postalCode' ILIKE CONCAT('%',:postal_code,'%') OR :postal_code IS NULL)
      AND (a.billing_address->'street' ILIKE CONCAT('%',:street,'%') OR :street IS NULL)
      AND (o.type ILIKE :opportunity_type OR :opportunity_type IS NULL)
      AND (o.is_closed = :is_closed OR :is_closed IS NULL)
      AND (o.is_won = :is_won OR :is_won IS NULL)
      AND (o.lead_source ILIKE :lead_source OR :lead_source IS NULL)
      AND (o.fiscal_year = :fiscal_year OR :fiscal_year IS NULL)
)
SELECT *
FROM filtered_opportunities
ORDER BY opportunity_id
    LIMIT COALESCE(:page_size, 250) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 250);
