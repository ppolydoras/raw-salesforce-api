-- @param opportunity_name the name of the opportunity. Substring search is supported.
-- @type opportunity_name varchar
-- @default opportunity_name null
-- @param opportunity_id Salesforce Opportunity ID
-- @type opportunity_id varchar
-- @default opportunity_id null
-- @param product_name the name of the product related with a given opportunity. Substring search is supported.
-- @type product_name varchar
-- @default product_name null
-- @param product_id the ID of the product related with a given opportunity.
-- @type product_id varchar
-- @default product_id null
-- @return products related to opportunities based on filters like opportunity name, opportunity id and product name.

SELECT li.quantity, li.unit_price, li.total_price, p.name as product_name, p.id as product_id,
       o.name as opportunity_name, o.id as opportunity_id
FROM salesforce.salesforce_opportunity o
         INNER JOIN salesforce.salesforce_opportunity_line_item li ON o.id=li.opportunity_id
         INNER JOIN salesforce.salesforce_product p ON p.id=li.product_2_id
WHERE (o.name ILIKE CONCAT('%',:opportunity_name,'%') OR :opportunity_name IS NULL)
  AND (o.id = :opportunity_id OR :opportunity_id IS NULL)
  AND (p.name ILIKE CONCAT('%',:product_name,'%') OR :product_name IS NULL)
  AND (p.id = :product_id OR :product_id IS NULL)