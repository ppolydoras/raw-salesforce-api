-- @param account_name the name of the Salesforce Account. Substring search is supported.
-- @type account_name varchar
-- @default account_name null
-- @param contact_mailing_country the mailing address country of the contact.
-- @type contact_mailing_country varchar
-- @default contact_mailing_country null
-- @param contact_created_date_range_start contact creation date is greater than or equal to contact_created_date_range_start. Format YYYY-MM-DD.
-- @type contact_created_date_range_start date
-- @default contact_created_date_range_start null
-- @param contact_created_date_range_end contact creation date is lower than or equal to contact_created_date_range_end. Format YYYY-MM-DD.
-- @type contact_created_date_range_end date
-- @default contact_created_date_range_end null
-- @param group_by_field the field to group the summary by (e.g., 'account_name', 'mailing_country', 'contact_title', 'contact_lead_source', 'contact_owner_name').
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of the total number of contacts in Salesforce, grouped by specified fields like account name, mailing country, or contact title. Supports filtering by account name, mailing country, contact creation date range.

WITH base_summary AS (
    SELECT
        c.id AS contact_id,
        c.is_deleted,
        c.created_date,
        a.name AS account_name,
        c.mailing_country,
        c.title AS contact_title,
        c.lead_source AS contact_lead_source,
        u.name AS contact_owner_name
    FROM salesforce.salesforce_contact c
             JOIN salesforce.salesforce_account a ON c.account_id = a.id
             JOIN salesforce.salesforce_user u ON c.owner_id = u.id
    WHERE (a.name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)
      AND (c.mailing_country ILIKE CONCAT('%', :contact_mailing_country, '%') OR :contact_mailing_country IS NULL)
      AND ((c.created_date >= :contact_created_date_range_start::timestamp) OR :contact_created_date_range_start IS NULL)
      AND ((c.created_date <= :contact_created_date_range_end::timestamp) OR :contact_created_date_range_end IS NULL)
)
SELECT
    -- Dynamically group by the specified field
    CASE
        WHEN :group_by_field = 'account_name' THEN account_name
        WHEN :group_by_field = 'mailing_country' THEN mailing_country
        WHEN :group_by_field = 'contact_title' THEN contact_title
        WHEN :group_by_field = 'contact_lead_source' THEN contact_lead_source
        WHEN :group_by_field = 'contact_owner_name' THEN contact_owner_name
        ELSE 'All'
        END AS group_by_value,

    COUNT(contact_id) AS total_contacts,
    COUNT(CASE WHEN is_deleted = false THEN 1 END) AS active_contacts,
    COUNT(CASE WHEN is_deleted = true THEN 1 END) AS deleted_contacts,
    COUNT(CASE WHEN created_date >= :contact_created_date_range_start::timestamp
          AND created_date <= :contact_created_date_range_end::timestamp
          THEN 1 END) AS contacts_created_in_date_range
FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
