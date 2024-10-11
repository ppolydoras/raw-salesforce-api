-- @param product_name the name of the product. Substring search is supported.
-- @type product_name varchar
-- @default product_name null
-- @param product_id the ID of the product
-- @type product_id varchar
-- @default product_id null
-- @param product_type the type of the product
-- @type product_type varchar
-- @default product_type null
-- @param product_code the code of the product
-- @type product_code varchar
-- @default product_code null
-- @param product_description the description of the product. Substring search is supported.
-- @type product_description varchar
-- @default product_description null
-- @param product_family the family of the product. Substring search is supported.
-- @type product_family varchar
-- @default product_family null
-- @param product_quantity_unit_of_measure unit of the product—for example, kilograms, liters, or cases.
-- @type product_quantity_unit_of_measure varchar
-- @default product_quantity_unit_of_measure null
-- @param product_stock_keeping_unit the product's SKU, which can be used with or in place of the Product Code field.
-- @type product_stock_keeping_unit varchar
-- @default product_stock_keeping_unit null
-- @param product_is_deleted show deleted or non-deleted products. Boolean.
-- @type product_is_deleted boolean
-- @default product_is_deleted null
-- @param product_is_active show active or inactive products. Boolean.
-- @type product_is_active boolean
-- @default product_is_active null
-- @param product_is_archived show archived or non-archived products. Boolean.
-- @type product_is_archived boolean
-- @default product_is_archived null
-- @param product_created_date_period_start filter products created after a date.
-- @type product_created_date_period_start date
-- @default product_created_date_period_start null
-- @param product_created_date_period_end filter products created before a date.
-- @type product_created_date_period_end date
-- @default product_created_date_period_end null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page
-- @type page_size integer
-- @default page_size null
-- @return products based on filters like product id, name, description, family, is_active, is_deleted, is_archived, quantity_unit_of_measure, stock_keeping_unit.

WITH filtered_products AS (
    SELECT
        "id" as product_id,
        "name" as product_name,
        "family" as product_family,
        "product_code",
        "is_active" as product_is_active,
        "created_by_id" as product_created_by_id,
        "created_date" as product_created_date,
        "description" as product_description,
        "display_url" as product_display_url,
        "external_data_source_id" as product_external_data_source_id,
        "external_id" as product_external_id,
        "is_archived" as product_is_archived,
        "is_deleted" as product_is_deleted,
        "last_modified_by_id" as product_last_modified_by_id,
        "last_modified_date" as product_last_modified_date,
        "last_referenced_date" as product_last_referenced_date,
        "last_viewed_date" as product_last_viewed_date,
        "quantity_unit_of_measure" as product_quantity_unit_of_measure,
        "stock_keeping_unit" as product_stock_keeping_unit,
        "system_modstamp" as product_system_modstamp,
        "type" as product_type,
        "product_class"
    FROM salesforce.salesforce_product
    WHERE (name ILIKE CONCAT('%',:product_name,'%') OR :product_name IS NULL)
      AND (description ILIKE CONCAT('%',:product_description,'%') OR :product_description IS NULL)
      AND (family ILIKE CONCAT('%',:product_family,'%') OR :product_family IS NULL)
      AND (id = :product_id OR :product_id IS NULL)
      AND (product_code = :product_code OR :product_code IS NULL)
      AND (type = :product_type OR :product_type IS NULL)
      AND (quantity_unit_of_measure ILIKE CONCAT('%',:product_quantity_unit_of_measure,'%') OR :product_quantity_unit_of_measure IS NULL)
      AND (stock_keeping_unit = :product_stock_keeping_unit OR :product_stock_keeping_unit IS NULL)
      AND (is_active = :product_is_active OR :product_is_active IS NULL)
      AND (is_deleted = :product_is_deleted OR :product_is_deleted IS NULL)
      AND (is_archived = :product_is_archived OR :product_is_archived IS NULL)
      AND (created_date >= :product_created_date_period_start::timestamp OR :product_created_date_period_start IS NULL)
      AND (created_date <= :product_created_date_period_end::timestamp OR :product_created_date_period_end IS NULL)
)
SELECT *
FROM filtered_products
ORDER BY product_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);