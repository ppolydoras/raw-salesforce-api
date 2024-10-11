-- @param opportunity_name the name of the Salesforce Opportunity. Substring search is supported.
-- @type opportunity_name varchar
-- @default opportunity_name null
-- @param opportunity_id Salesforce Opportunity ID
-- @type opportunity_id varchar
-- @default opportunity_id null
-- @param event_subject the subject of the event related with a given opportunity. Substring search is supported.
-- @type event_subject varchar
-- @default event_subject null
-- @param event_id the ID of the event related with a given opportunity.
-- @type event_id varchar
-- @default event_id null
-- @param event_start_date_range_start Filter events with start dates greater than or equal to this value. Format YYYY-MM-DD.
-- @type event_start_date_range_start date
-- @default event_start_date_range_start null
-- @param event_start_date_range_end Filter events with start dates lower than or equal to this value. Format YYYY-MM-DD.
-- @type event_start_date_range_end date
-- @default event_start_date_range_end null
-- @param event_end_date_range_start Filter events with end dates greater than or equal to this value. Format YYYY-MM-DD.
-- @type event_end_date_range_start date
-- @default event_end_date_range_start null
-- @param event_end_date_range_end Filter events with end dates lower than or equal to this value. Format YYYY-MM-DD.
-- @type event_end_date_range_end date
-- @default event_end_date_range_end null
-- @param event_location Filter events by location. Substring search is supported.
-- @type event_location varchar
-- @default event_location null
-- @param event_is_private Filter events by privacy status (private or public).
-- @type event_is_private boolean
-- @default event_is_private null
-- @param event_is_group_event Filter events by group event status (true if it's a group event).
-- @type event_is_group_event boolean
-- @default event_is_group_event null
-- @param event_is_recurrence Filter events based on recurrence status (true if it's a recurring event).
-- @type event_is_recurrence boolean
-- @default event_is_recurrence null
-- @param owner_id Filter events by the ID of the event owner.
-- @type owner_id varchar
-- @default owner_id null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page. Default value is 25.
-- @type page_size integer
-- @default page_size null
-- @return Events related to opportunities based on filters like opportunity name, opportunity id, and event subject.

WITH filtered_opportunity_events AS (
    SELECT e."id" as "event_id",
           e."who_id" as "event_who_id",
           e."what_id" as "event_what_id",
           e."subject" as "event_subject",
           e."location" as "event_location",
           e."is_all_day_event" as "event_is_all_day_event",
           e."activity_date_time" as "event_activity_date_time",
           e."activity_date" as "event_activity_date",
           e."duration_in_minutes" as "event_duration_in_minutes",
           e."start_date_time" as "event_start_date_time",
           e."end_date_time" as "event_end_date_time",
           e."description" as "event_description",
           e."account_id" as "event_account_id",
           e."owner_id" as "event_owner_id",
           e."is_private" as "event_is_private",
           e."show_as" as "event_show_as",
           e."is_deleted" as "event_is_deleted",
           e."created_date" as "event_created_date",
           e."created_by_id" as "event_created_by_id",
           e."last_modified_date" as "event_last_modified_date",
           e."last_modified_by_id" as "event_last_modified_by_id",
           e."system_modstamp" as "event_system_modstamp",
           e."end_date" as "event_end_date",
           e."is_child" as "event_is_child",
           e."is_group_event" as "event_is_group_event",
           e."group_event_type" as "event_group_event_type",
           e."is_archived" as "event_is_archived",
           e."recurrence_activity_id" as "event_recurrence_activity_id",
           e."is_recurrence" as "event_is_recurrence",
           e."recurrence_start_date_time" as "event_recurrence_start_date_time",
           e."recurrence_end_date_only" as "event_recurrence_end_date_only",
           e."recurrence_time_zone_sid_key" as "event_recurrence_time_zone_sid_key",
           e."recurrence_type" as "event_recurrence_type",
           e."recurrence_interval" as "event_recurrence_interval",
           e."recurrence_day_of_week_mask" as "event_recurrence_day_of_week_mask",
           e."recurrence_day_of_month" as "event_recurrence_day_of_month",
           e."recurrence_instance" as "event_recurrence_instance",
           e."recurrence_month_of_year" as "event_recurrence_month_of_year",
           e."reminder_date_time" as "event_reminder_date_time",
           e."is_reminder_set" as "event_is_reminder_set",
           e."event_subtype" as "event_event_subtype",
           e."is_recurrence_2_exclusion" as "event_is_recurrence_2_exclusion",
           e."recurrence_2_pattern_text" as "event_recurrence_2_pattern_text",
           e."recurrence_2_pattern_version" as "event_recurrence_2_pattern_version",
           e."is_recurrence_2" as "event_is_recurrence_2",
           e."is_recurrence_2_exception" as "event_is_recurrence_2_exception",
           e."recurrence_2_pattern_start_date" as "event_recurrence_2_pattern_start_date",
           e."recurrence_2_pattern_time_zone" as "event_recurrence_2_pattern_time_zone",
           e."service_appointment_id" as "event_service_appointment_id",
           o.id as opportunity_id,
           o.name as opportunity_name
    FROM  salesforce.salesforce_event e
              INNER JOIN salesforce.salesforce_opportunity o ON o.id = e.what_id
    WHERE (o.name ILIKE CONCAT('%', :opportunity_name, '%') OR :opportunity_name IS NULL)
      AND (o.id = :opportunity_id OR :opportunity_id IS NULL)
      AND (e.subject ILIKE CONCAT('%', :event_subject, '%') OR :event_subject IS NULL)
      AND ((e.id = :event_id) OR (:event_id IS NULL))
      AND ((e.start_date_time >= :event_start_date_range_start::timestamp) OR (:event_start_date_range_start IS NULL))
      AND ((e.start_date_time <= :event_start_date_range_end::timestamp) OR (:event_start_date_range_end IS NULL))
      AND ((e.end_date_time >= :event_end_date_range_start::timestamp) OR (:event_end_date_range_start IS NULL))
      AND ((e.end_date_time <= :event_end_date_range_end::timestamp) OR (:event_end_date_range_end IS NULL))
      AND (e.location ILIKE CONCAT('%', :event_location, '%') OR :event_location IS NULL)
      AND (e.owner_id = :owner_id OR :owner_id IS NULL)
      AND (e.is_private = :event_is_private OR :event_is_private IS NULL)
      AND (e.is_group_event = :event_is_group_event OR :event_is_group_event IS NULL)
      AND (e.is_recurrence = :event_is_recurrence OR :event_is_recurrence IS NULL)
)
SELECT *
FROM filtered_opportunity_events
ORDER BY event_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
