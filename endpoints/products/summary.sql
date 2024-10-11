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
-- @param group_by_field the field to group the summary by (e.g., 'product_family', 'product_type', 'product_is_active').
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of the total, active, deleted and archived products based on various filters and grouping options.

WITH base_summary AS (
    SELECT
        p.id AS product_id,
        p.name AS product_name,
        p.family AS product_family,
        p.product_code AS product_code,
        p.type AS product_type,
        p.is_active AS product_is_active,
        p.is_deleted AS product_is_deleted,
        p.is_archived AS product_is_archived,
        p.created_date AS product_created_date
    FROM salesforce.salesforce_product p
    WHERE (p.name ILIKE CONCAT('%', :product_name, '%') OR :product_name IS NULL)
      AND (p.description ILIKE CONCAT('%', :product_description, '%') OR :product_description IS NULL)
      AND (p.family ILIKE CONCAT('%', :product_family, '%') OR :product_family IS NULL)
      AND (p.id = :product_id OR :product_id IS NULL)
      AND (p.product_code = :product_code OR :product_code IS NULL)
      AND (p.type = :product_type OR :product_type IS NULL)
      AND (p.quantity_unit_of_measure ILIKE CONCAT('%', :product_quantity_unit_of_measure, '%') OR :product_quantity_unit_of_measure IS NULL)
      AND (p.stock_keeping_unit = :product_stock_keeping_unit OR :product_stock_keeping_unit IS NULL)
      AND (p.is_active = :product_is_active OR :product_is_active IS NULL)
      AND (p.is_deleted = :product_is_deleted OR :product_is_deleted IS NULL)
      AND (p.is_archived = :product_is_archived OR :product_is_archived IS NULL)
      AND (p.created_date >= :product_created_date_period_start::timestamp OR :product_created_date_period_start IS NULL)
      AND (p.created_date <= :product_created_date_period_end::timestamp OR :product_created_date_period_end IS NULL)
)
SELECT
    CASE
        WHEN :group_by_field = 'product_family' THEN product_family
        WHEN :group_by_field = 'product_type' THEN product_type
        WHEN :group_by_field = 'product_is_active' THEN CAST(product_is_active AS varchar)
        ELSE 'All'
        END AS group_by_value,

    COUNT(product_id) AS total_products,
    COUNT(CASE WHEN product_is_active = true THEN 1 END) AS active_products,
    COUNT(CASE WHEN product_is_deleted = true THEN 1 END) AS deleted_products,
    COUNT(CASE WHEN product_is_archived = true THEN 1 END) AS archived_products,
    COUNT(CASE WHEN product_created_date >= :product_created_date_period_start::timestamp
          AND product_created_date <= :product_created_date_period_end::timestamp
          THEN 1 END) AS products_created_in_date_range
FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
