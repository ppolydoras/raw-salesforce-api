-- @param account_name the name of the Salesforce Account. Substring search is supported.
-- @type account_name varchar
-- @default account_name null
-- @param account_id the id of the Salesforce Account
-- @type account_id varchar
-- @default account_id null
-- @param start_date_range_start contract start date is greater than or equal to start_date_range_start. Format YYYY-MM-DD.
-- @type start_date_range_start date
-- @default start_date_range_start null
-- @param start_date_range_end contract start date is lower than or equal to start_date_range_end. Format YYYY-MM-DD.
-- @type start_date_range_end date
-- @default start_date_range_end null
-- @param end_date_range_start contract end date (renewal date) is greater than or equal to end_date_range_start. Format YYYY-MM-DD.
-- @type end_date_range_start date
-- @default end_date_range_start null
-- @param end_date_range_end contract end date (renewal date) is lower than or equal to end_date_range_end. Format YYYY-MM-DD.
-- @type end_date_range_end date
-- @default end_date_range_end null
-- @param contract_status the status of the contract. Permissible values can be found in endpoint '/salesforce_gpt/enumeration/contract_statuses'. If null, then all statuses are included.
-- @type contract_status varchar
-- @default contract_status null
-- @param owner_id the Salesforce User ID who owns the contract
-- @type owner_id varchar
-- @default owner_id null
-- @param activated_by_id the Salesforce User ID who activated the contract
-- @type activated_by_id varchar
-- @default activated_by_id null
-- @param contract_term the length of the contract in months
-- @type contract_term integer
-- @default contract_term null
-- @param special_terms filter contracts based on special terms. Substring search is supported.
-- @type special_terms varchar
-- @default special_terms null
-- @param pricebook_2_id the Salesforce Pricebook ID associated with the contract
-- @type pricebook_2_id varchar
-- @default pricebook_2_id null
-- @param group_by_field the field to group the summary by (e.g., 'account_name', 'contract_status', 'owner_id').
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of the total number of contracts, grouped by the specified field.

WITH filtered_contracts AS (
    SELECT c."id" as "contract_id",
           c."account_id",
           c."contract_term",
           c."end_date" as "contract_end_date",
           c."start_date" as "contract_start_date",
           c."status_code" as "contract_status",
           c."owner_id",
           c."activated_by_id",
           c."special_terms",
           c."pricebook_2_id",
           a.name AS account_name
    FROM salesforce.salesforce_contract c
             INNER JOIN salesforce.salesforce_account a ON c.account_id = a.id
    WHERE (a.name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)
      AND (a.id ILIKE CONCAT('%', :account_id, '%') OR :account_id IS NULL)
      AND ((c.start_date >= :start_date_range_start) OR (:start_date_range_start IS NULL))
      AND ((c.start_date <= :start_date_range_end) OR (:start_date_range_end IS NULL))
      AND ((c.end_date >= :end_date_range_start) OR (:end_date_range_start IS NULL))
      AND ((c.end_date <= :end_date_range_end) OR (:end_date_range_end IS NULL))
      AND (c.status_code ILIKE :contract_status OR :contract_status IS NULL)
      AND (c.owner_id = :owner_id OR :owner_id IS NULL)
      AND (c.activated_by_id = :activated_by_id OR :activated_by_id IS NULL)
      AND (c.contract_term = :contract_term OR :contract_term IS NULL)
      AND (c.special_terms ILIKE CONCAT('%', :special_terms, '%') OR :special_terms IS NULL)
      AND (c.pricebook_2_id = :pricebook_2_id OR :pricebook_2_id IS NULL)
)
SELECT
    -- Dynamically group by the specified field
    CASE
        WHEN :group_by_field = 'account_name' THEN account_name
        WHEN :group_by_field = 'contract_status' THEN contract_status
        WHEN :group_by_field = 'owner_id' THEN owner_id
        ELSE 'All'
        END AS group_by_value,

    COUNT(contract_id) AS total_contracts,

    -- Active Contracts
    COUNT(*) FILTER (WHERE contract_status = 'Active') AS active_contracts,

    -- Expired Contracts
        COUNT(*) FILTER (WHERE contract_status = 'Expired' OR contract_end_date < NOW()) AS expired_contracts,

    -- Upcoming Renewals (contracts expiring in the next 30 days)
        COUNT(*) FILTER (WHERE contract_end_date BETWEEN NOW() AND NOW() + INTERVAL '30 days') AS upcoming_renewals_30_days,

    -- Average Contract Term (in months)
        AVG(contract_term) AS avg_contract_term,

    -- Breakdown by Status
    COUNT(*) FILTER (WHERE contract_status = 'Draft') AS draft_contracts,
        COUNT(*) FILTER (WHERE contract_status = 'Pending') AS pending_contracts,

    -- Breakdown by Owner
        COUNT(*) FILTER (WHERE owner_id IS NOT NULL) AS contracts_with_owner,
        COUNT(*) FILTER (WHERE owner_id IS NULL) AS contracts_without_owner

FROM filtered_contracts
GROUP BY group_by_value
ORDER BY group_by_value;
