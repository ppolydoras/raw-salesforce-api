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
-- @param lead_country the billing address country of the Salesforce Lead
-- @type lead_country varchar
-- @default lead_country null
-- @param lead_state the billing address state of the Salesforce Lead
-- @type lead_state varchar
-- @default lead_state null
-- @param lead_is_deleted Salesforce Lead is deleted
-- @type lead_is_deleted boolean
-- @default lead_is_deleted null
-- @param group_by_field the field to group the summary by (e.g., 'lead_status', 'lead_rating', 'lead_source', 'lead_industry').
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of leads based on various filters and groups them by a specified field. The summary includes total leads, converted and unconverted leads, average time to conversion, and breakdowns by status, rating, source, and industry.

WITH filtered_leads AS (
    SELECT
        l.id AS lead_id,
        l.is_converted,
        l.created_date,
        l.converted_date,
        l.status AS lead_status,
        l.rating AS lead_rating,
        l.lead_source,
        l.industry AS lead_industry
    FROM salesforce.salesforce_lead l
    WHERE (rating ILIKE ANY (string_to_array(:lead_rating, ',')) OR :lead_rating IS NULL)
      AND (status ILIKE ANY (string_to_array(:lead_status, ',')) OR :lead_status IS NULL)
      AND (industry ILIKE ANY (string_to_array(:lead_industry, ',')) OR :lead_industry IS NULL)
      AND (lead_source ILIKE ANY (string_to_array(:lead_source, ',')) OR :lead_source IS NULL)
      AND (l.is_converted = :lead_is_converted OR :lead_is_converted IS NULL)
      AND ((l.created_date >= :lead_created_date_range_start::timestamp) OR :lead_created_date_range_start IS NULL)
      AND ((l.created_date <= :lead_created_date_range_end::timestamp) OR :lead_created_date_range_end IS NULL)
      AND ((l.last_activity_date >= :lead_last_activity_date_range_start::date) OR :lead_last_activity_date_range_start IS NULL)
      AND ((l.last_activity_date <= :lead_last_activity_date_range_end::date) OR :lead_last_activity_date_range_end IS NULL)
      AND (l.country ILIKE CONCAT('%', :lead_country, '%') OR :lead_country IS NULL)
      AND (l.state ILIKE CONCAT('%', :lead_state, '%') OR :lead_state IS NULL)
      AND (l.is_deleted = :lead_is_deleted OR :lead_is_deleted IS NULL)
)
SELECT
    -- Dynamically group by the specified field
    CASE
        WHEN :group_by_field = 'lead_status' THEN lead_status
        WHEN :group_by_field = 'lead_rating' THEN lead_rating
        WHEN :group_by_field = 'lead_source' THEN lead_source
        WHEN :group_by_field = 'lead_industry' THEN lead_industry
        ELSE 'All'
        END AS group_by_value,

    COUNT(lead_id) AS total_leads,

    -- Converted Lead Count
    SUM(CASE WHEN is_converted THEN 1 ELSE 0 END) AS converted_leads,

    -- Unconverted Lead Count
    SUM(CASE WHEN NOT is_converted THEN 1 ELSE 0 END) AS unconverted_leads,

    -- Average Time to Conversion
    AVG(EXTRACT(EPOCH FROM (converted_date - created_date)) / 86400) AS avg_days_to_convert,

    -- Breakdown by Status
    COUNT(*) FILTER (WHERE lead_status IN ('Open - Not Contacted', 'Working - Contacted')) AS open_leads,
    COUNT(*) FILTER (WHERE lead_status IN ('Closed - Converted','Closed - Not Converted')) AS closed_leads,

    -- Breakdown by Rating
    COUNT(*) FILTER (WHERE lead_rating = 'Hot') AS hot_leads,
    COUNT(*) FILTER (WHERE lead_rating = 'Warm') AS warm_leads,
    COUNT(*) FILTER (WHERE lead_rating = 'Cold') AS cold_leads,

    -- Leads by Source
    COUNT(*) FILTER (WHERE lead_source = 'Web') AS web_leads,
    COUNT(*) FILTER (WHERE lead_source = 'Referral') AS referral_leads,
    COUNT(*) FILTER (WHERE lead_source = 'Partner') AS partner_leads,

    -- Leads by Industry
    COUNT(*) FILTER (WHERE lead_industry = 'Technology') AS technology_leads,
    COUNT(*) FILTER (WHERE lead_industry = 'Healthcare') AS healthcare_leads

FROM filtered_leads
GROUP BY group_by_value
ORDER BY group_by_value;
