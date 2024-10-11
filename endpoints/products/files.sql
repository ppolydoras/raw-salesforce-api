-- @param product_id the ID of the product
-- @type product_id varchar
-- @default product_id null
-- @return all files associated with a specific product ID.

WITH cids AS (
    SELECT distinct content_document_id
    FROM salesforce.salesforce_content_document_link
    WHERE linked_entity_id = :product_id)
SELECT *
FROM salesforce.salesforce_content_version
WHERE salesforce_content_version.content_document_id IN
      (SELECT content_document_id FROM cids)