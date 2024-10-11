-- @param account_id the ID of the account
-- @type account_id varchar
-- @default account_id null
-- @return all files associated with a specific account ID.

WITH cids AS (
    SELECT distinct content_document_id
    FROM salesforce.salesforce_content_document_link
    WHERE linked_entity_id = :account_id)
SELECT *
FROM salesforce.salesforce_content_version
WHERE salesforce_content_version.content_document_id IN
      (SELECT content_document_id FROM cids)