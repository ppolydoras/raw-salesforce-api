-- @param username the username of the Salesforce User. Substring search is supported.
-- @type username varchar
-- @default username null

-- @param user_email the email of the Salesforce User. Substring search is supported.
-- @type user_email varchar
-- @default user_email null

-- @param user_is_active filter users based on their active status (true/false)
-- @type user_is_active boolean
-- @default user_is_active null

-- @param user_department the department of the Salesforce User. Substring search is supported.
-- @type user_department varchar
-- @default user_department null

-- @param user_role_id filter users by Role ID
-- @type user_role_id varchar
-- @default user_role_id null

-- @param user_created_date_period_start filter users created after this date. Format YYYY-MM-DD.
-- @type user_created_date_period_start date
-- @default user_created_date_period_start null

-- @param user_created_date_period_end filter users created before this date. Format YYYY-MM-DD.
-- @type user_created_date_period_end date
-- @default user_created_date_period_end null

-- @param group_by_field the field to group the summary by (e.g., 'user_department', 'user_is_active', 'user_role_id').
-- @type group_by_field varchar
-- @default group_by_field null

-- @return summary of the total, active, and recently created users based on various filters and grouping options.

WITH base_summary AS (
    SELECT
        u.id AS user_id,
        u.username AS username,
        u.name AS user_name,
        u.email AS user_email,
        u.is_active AS user_is_active,
        u.department AS user_department,
        u.created_date AS user_created_date,
        u.user_role_id AS user_role_id
    FROM salesforce.salesforce_user u
    WHERE (u.username ILIKE CONCAT('%', :username, '%') OR :username IS NULL)
      AND (u.email ILIKE CONCAT('%', :user_email, '%') OR :user_email IS NULL)
      AND (u.is_active = :user_is_active OR :user_is_active IS NULL)
      AND (u.department ILIKE CONCAT('%', :user_department, '%') OR :user_department IS NULL)
      AND (u.user_role_id = :user_role_id OR :user_role_id IS NULL)
      AND (u.created_date >= :user_created_date_period_start::timestamp OR :user_created_date_period_start IS NULL)
      AND (u.created_date <= :user_created_date_period_end::timestamp OR :user_created_date_period_end IS NULL)
)

SELECT
    CASE
        WHEN :group_by_field = 'user_department' THEN user_department
        WHEN :group_by_field = 'user_is_active' THEN CAST(user_is_active AS varchar)
        WHEN :group_by_field = 'user_role_id' THEN user_role_id
        ELSE 'All'
        END AS group_by_value,

    COUNT(user_id) AS total_users,
    COUNT(CASE WHEN user_is_active = true THEN 1 END) AS active_users,
    COUNT(CASE WHEN user_created_date >= :user_created_date_period_start::timestamp
          AND user_created_date <= :user_created_date_period_end::timestamp
          THEN 1 END) AS users_created_in_date_range

FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
