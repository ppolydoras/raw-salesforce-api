-- @param account_name the name of the Salesforce Account
-- @type account_name varchar
-- @default account_name null
-- @param account_id the id of the Salesforce Account
-- @type account_id varchar
-- @default account_id null
-- @param contract_description the description of the Salesforce Contract
-- @type contract_description varchar
-- @default contract_description null
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
-- @param contract_status the status of the contract - permissible values can be found in endpoint '/salesforce_gpt/enumeration/contract_statuses'. If null then all statuses are included.
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
-- @param pricebook_2_id the Salesforce Pricebook ID associated with the contract
-- @type pricebook_2_id varchar
-- @default pricebook_2_id null
-- @param special_terms filter contracts based on special terms. Substring search is supported.
-- @type special_terms varchar
-- @default special_terms null
-- @param country the billing address country of the contract
-- @type country varchar
-- @default country null
-- @param state the billing address state of the contract
-- @type state varchar
-- @default state null
-- @param postal_code the billing address postal code of the contract
-- @type postal_code integer
-- @default postal_code null
-- @param street the billing address street of the contract
-- @type street varchar
-- @default street null
-- @param city the billing address city of the contract
-- @type city varchar
-- @default city null
-- @param contract_is_deleted contract deleted
-- @type contract_is_deleted boolean
-- @default contract_is_deleted null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page
-- @type page_size integer
-- @default page_size null
-- @return contracts by account name, contract description, status, contract terms, pricebook id, owner, start date, end date (renewal date) and billing address. Permissible values for status can be found in endpoint `/salesforce_gpt/enumeration/contract_statuses`

WITH filtered_contracts AS (
    SELECT c."id" as "contract_id",
           c."account_id",
           c."contract_number",
           c."contract_term",
           c."end_date" as "contract_end_date",
           c."owner_id",
           c."start_date",
           c."activated_by_id",
           c."activated_date",
           c."billing_address",
           c."company_signed_date",
           c."company_signed_id",
           c."created_by_id",
           c."created_date",
           c."customer_signed_date",
           c."customer_signed_id",
           c."customer_signed_title",
           c."description",
           c."is_deleted",
           c."last_activity_date",
           c."last_approved_date",
           c."last_modified_by_id",
           c."last_modified_date",
           c."last_referenced_date",
           c."last_viewed_date",
           c."owner_expiration_notice",
           c."pricebook_2_id",
           c."special_terms",
           c."system_modstamp",
           c."billing_street",
           c."billing_city",
           c."billing_state",
           c."billing_postal_code",
           c."billing_country",
           c."billing_latitude",
           c."billing_longitude",
           c."billing_geocode_accuracy",
           c."status_code",
           a.name AS account_name
    FROM salesforce.salesforce_contract c
             INNER JOIN salesforce.salesforce_account a ON c.account_id = a.id
    WHERE (a.name ILIKE CONCAT('%',:account_name,'%') OR :account_name IS NULL)
      AND (a.id ILIKE CONCAT('%', :account_id, '%') OR :account_id IS NULL)
      AND (c.description ILIKE CONCAT('%', :contract_description, '%') OR :contract_description IS NULL)
      AND (((c.start_date >= :start_date_range_start) OR (:start_date_range_start IS NULL))
        AND ((c.start_date <= :start_date_range_end) OR (:start_date_range_end IS NULL)))
      AND (((c.end_date >= :end_date_range_start) OR (:end_date_range_start IS NULL))
        AND ((c.end_date <= :end_date_range_end) OR (:end_date_range_end IS NULL)))
      AND (c.status_code ILIKE :contract_status OR :contract_status IS NULL)
      AND (c.owner_id = :owner_id OR :owner_id IS NULL)
      AND (c.activated_by_id = :activated_by_id OR :activated_by_id IS NULL)
      AND (c.contract_term = :contract_term OR :contract_term IS NULL)
      AND (c.pricebook_2_id = :pricebook_2_id OR :pricebook_2_id IS NULL)
      AND (c.special_terms ILIKE CONCAT('%',:special_terms,'%') OR :special_terms IS NULL)
      AND (c.billing_country ILIKE CONCAT('%',:country,'%') OR :country IS NULL)
      AND (c.billing_state ILIKE CONCAT('%',:state,'%') OR :state IS NULL)
      AND (c.billing_postal_code ILIKE CONCAT('%',:postal_code,'%') OR :postal_code IS NULL)
      AND (c.billing_street ILIKE CONCAT('%',:street,'%') OR :street IS NULL)
      AND (c.billing_city ILIKE CONCAT('%',:city,'%') OR :city IS NULL)
      AND (c.is_deleted=:contract_is_deleted OR :contract_is_deleted IS NULL)
)
SELECT *
FROM filtered_contracts
ORDER BY account_name
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
