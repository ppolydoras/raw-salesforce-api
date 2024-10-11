-- @param opportunity_name the name of the opportunity. Substring search is supported.
-- @type opportunity_name varchar
-- @default opportunity_name null
-- @param opportunity_id Salesforce Opportunity ID
-- @type opportunity_id varchar
-- @default opportunity_id null
-- @param task_subject the subject of the task related with a given opportunity. Substring search is supported.
-- @type task_subject varchar
-- @default task_subject null
-- @param task_subtype comma-separated list of the subtypes of the task related with a given opportunity. Permissible values can be found in endpoint '/salesforce_gpt/enumeration/task_subtypes'. If null, all subtypes are included.
-- @type task_subtype varchar
-- @default task_subtype null
-- @param task_id the ID of the task related with a given opportunity.
-- @type task_id varchar
-- @default task_id null
-- @param account_name the name of the Salesforce Account.
-- @type account_name varchar
-- @default account_name null
-- @param account_id Salesforce Account ID.
-- @type account_id varchar
-- @default account_id null
-- @param task_status comma-separated list of task statuses. Permissible values can be found in endpoint '/salesforce_gpt/enumeration/task_statuses'. If null, all statuses are included.
-- @type task_status varchar
-- @default task_status null
-- @param task_priority comma-separated list of task priorities. Permissible values can be found in endpoint '/salesforce_gpt/enumeration/task_priorities'. If null, all priorities are included.
-- @type task_priority varchar
-- @default task_priority null
-- @param task_created_date_range_start Filter tasks with creation dates greater than or equal to this value. Format YYYY-MM-DD.
-- @type task_created_date_range_start date
-- @default task_created_date_range_start null
-- @param task_created_date_range_end Filter tasks with creation dates lower than or equal to this value. Format YYYY-MM-DD.
-- @type task_created_date_range_end date
-- @default task_created_date_range_end null
-- @param task_last_modified_date_range_start Filter tasks with last modified dates greater than or equal to this value. Format YYYY-MM-DD.
-- @type task_last_modified_date_range_start date
-- @default task_last_modified_date_range_start null
-- @param task_last_modified_date_range_end Filter tasks with last modified dates lower than or equal to this value. Format YYYY-MM-DD.
-- @type task_last_modified_date_range_end date
-- @default task_last_modified_date_range_end null
-- @param task_completed_date_range_start Filter tasks with completion dates greater than or equal to this value. Format YYYY-MM-DD.
-- @type task_completed_date_range_start date
-- @default task_completed_date_range_start null
-- @param task_completed_date_range_end Filter tasks with completion dates lower than or equal to this value. Format YYYY-MM-DD.
-- @type task_completed_date_range_end date
-- @default task_completed_date_range_end null
-- @param owner_id Filter tasks by owner ID.
-- @type owner_id varchar
-- @default owner_id null
-- @param is_reminder_set Filter tasks that have reminders set.
-- @type is_reminder_set boolean
-- @default is_reminder_set null
-- @param page the current page number to retrieve.
-- @type page integer
-- @default page null
-- @param page_size the number of records per page. Default value is 25.
-- @type page_size integer
-- @default page_size null
-- @return tasks related to opportunities based on filters like opportunity name, opportunity id, task subject, and status.

WITH filtered_tasks AS (
    SELECT t."id" as "task_id",
           t."subject" as "task_subject",
           t."status" as "task_status",
           t."priority" as "task_priority",
           t."activity_date" as "task_activity_date",
           t."description" as "task_description",
           t."owner_id" as "task_owner_id",
           t."what_id" as "opportunity_id",
           t."who_id" as "task_who_id",
           t."created_by_id" as "task_created_by_id",
           t."created_date" as "task_created_date",
           t."last_modified_by_id" as "task_last_modified_by_id",
           t."last_modified_date" as "task_last_modified_date",
           t."is_closed" as "task_is_closed",
           t."is_deleted" as "task_is_deleted",
           t."is_high_priority" as "task_is_high_priority",
           t."reminder_date_time" as "task_reminder_date_time",
           t."is_reminder_set" as "task_is_reminder_set",
           t."account_id" as "task_account_id",
           t."call_type" as "task_call_type",
           t."call_duration_in_seconds" as "task_call_duration_in_seconds",
           t."call_disposition" as "task_call_disposition",
           t."is_recurrence" as "task_is_recurrence",
           t."recurrence_interval" as "task_recurrence_interval",
           t."recurrence_end_date_only" as "task_recurrence_end_date_only",
           t."recurrence_day_of_week_mask" as "task_recurrence_day_of_week_mask",
           t."recurrence_type" as "task_recurrence_type",
           t."system_modstamp" as "task_system_modstamp",
           t."is_archived" as "task_is_archived",
           t."call_object" as "task_call_object",
           t."recurrence_activity_id" as "task_recurrence_activity_id",
           t."recurrence_start_date_only" as "task_recurrence_start_date_only",
           t."recurrence_time_zone_sid_key" as "task_recurrence_time_zone_sid_key",
           t."recurrence_day_of_month" as "task_recurrence_day_of_month",
           t."recurrence_instance" as "task_recurrence_instance",
           t."recurrence_month_of_year" as "task_recurrence_month_of_year",
           t."recurrence_regenerated_type" as "task_recurrence_regenerated_type",
           t."task_subtype" as "task_subtype",
           t."completed_date_time" as "task_completed_date_time"
    FROM  salesforce.salesforce_task t
              INNER JOIN salesforce.salesforce_opportunity o on o.id=t.what_id
              INNER JOIN salesforce.salesforce_account a on a.id=o.account_id
    WHERE (o.name ILIKE CONCAT('%',:opportunity_name,'%') OR :opportunity_name IS NULL)
      AND (o.id = :opportunity_id OR :opportunity_id IS NULL)
      AND (t.subject ILIKE CONCAT('%',:task_subject,'%') OR :task_subject IS NULL)
      AND (t.id = :task_id OR :task_id IS NULL)
      AND (t.task_subtype ILIKE ANY (string_to_array(:task_subtype, ',')) OR :task_subtype IS NULL)
      AND (a.name ILIKE CONCAT('%',:account_name,'%') OR :account_name IS NULL)
      AND (a.id = :account_id OR :account_id IS NULL)
      AND (t.status ILIKE ANY (string_to_array(:task_status, ',')) OR :task_status IS NULL)
      AND (t.priority ILIKE ANY (string_to_array(:task_priority, ',')) OR :task_priority IS NULL)
      AND ((t.created_date >= :task_created_date_range_start::timestamp) OR (:task_created_date_range_start IS NULL))
      AND ((t.created_date <= :task_created_date_range_end::timestamp) OR (:task_created_date_range_end IS NULL))
      AND ((t.last_modified_date >= :task_last_modified_date_range_start::timestamp) OR (:task_last_modified_date_range_start IS NULL))
      AND ((t.last_modified_date <= :task_last_modified_date_range_end::timestamp) OR (:task_last_modified_date_range_end IS NULL))
      AND ((t.completed_date_time >= :task_completed_date_range_start::timestamp) OR (:task_completed_date_range_start IS NULL))
      AND ((t.completed_date_time <= :task_completed_date_range_end::timestamp) OR (:task_completed_date_range_end IS NULL))
      AND (t.owner_id = :owner_id OR :owner_id IS NULL)
      AND (t.is_reminder_set = :is_reminder_set OR :is_reminder_set IS NULL)
)
SELECT *
FROM filtered_tasks
ORDER BY task_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
