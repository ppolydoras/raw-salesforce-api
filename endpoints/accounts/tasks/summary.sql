-- @param account_name the name of the Salesforce Account
-- @type account_name varchar
-- @default account_name null
-- @param account_id Salesforce Account ID
-- @type account_id varchar
-- @default account_id null
-- @param task_subject the subject of the task related with a given account. Substring search is supported.
-- @type task_subject varchar
-- @default task_subject null
-- @param task_subtype the subtype of the task related with a given account. Permissible values can be found in endpoint '/salesforce_gpt/enumeration/task_subtypes'
-- @type task_subtype varchar
-- @default task_subtype null
-- @param task_status the status of the task related with a given account. E.g., 'Not Started', 'Completed', 'In Progress'.
-- @type task_status varchar
-- @default task_status null
-- @param task_priority the priority of the task (High, Medium, Low)
-- @type task_priority varchar
-- @default task_priority null
-- @param task_created_date_range_start start date to filter tasks by creation date
-- @type task_created_date_range_start date
-- @default task_created_date_range_start null
-- @param task_created_date_range_end end date to filter tasks by creation date
-- @type task_created_date_range_end date
-- @default task_created_date_range_end null
-- @param group_by_field field to group the summary by (e.g., 'task_status', 'task_priority', 'task_subtype')
-- @type group_by_field varchar
-- @default group_by_field null
-- @return summary of the total number of tasks, grouped by the specified field.

WITH base_summary AS (
    SELECT
        t.id AS task_id,
        t.subject AS task_subject,
        t.status AS task_status,
        t.priority AS task_priority,
        t.task_subtype AS task_subtype,
        t.activity_date AS task_activity_date,
        t.is_closed AS task_is_closed,
        t.is_high_priority AS task_is_high_priority,
        t.created_date AS task_created_date,
        a.name AS account_name
    FROM salesforce.salesforce_task t
             INNER JOIN salesforce.salesforce_account a ON a.id = t.what_id
    WHERE (a.name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)
      AND (a.id = :account_id OR :account_id IS NULL)
      AND (t.subject ILIKE CONCAT('%', :task_subject, '%') OR :task_subject IS NULL)
      AND (t.task_subtype ILIKE CONCAT('%', :task_subtype, '%') OR :task_subtype IS NULL)
      AND (t.status ILIKE CONCAT('%', :task_status, '%') OR :task_status IS NULL)
      AND (t.priority ILIKE CONCAT('%', :task_priority, '%') OR :task_priority IS NULL)
      AND (t.created_date >= :task_created_date_range_start::timestamp OR :task_created_date_range_start IS NULL)
      AND (t.created_date <= :task_created_date_range_end::timestamp OR :task_created_date_range_end IS NULL)
)
SELECT
    CASE
        WHEN :group_by_field = 'task_status' THEN task_status
        WHEN :group_by_field = 'task_priority' THEN task_priority
        WHEN :group_by_field = 'task_subtype' THEN task_subtype
        ELSE 'All'
        END AS group_by_value,

    COUNT(task_id) AS total_tasks,
    COUNT(CASE WHEN task_is_closed = true THEN 1 END) AS closed_tasks,
    COUNT(CASE WHEN task_is_high_priority = true THEN 1 END) AS high_priority_tasks,
    COUNT(CASE WHEN task_created_date >= :task_created_date_range_start::timestamp
          AND task_created_date <= :task_created_date_range_end::timestamp
          THEN 1 END) AS tasks_created_in_date_range
FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
