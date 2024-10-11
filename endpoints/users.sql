-- @param username the username of the Salesforce User
-- @type username varchar
-- @default username null

-- @param user_email the email of the Salesforce User
-- @type user_email varchar
-- @default user_email null

-- @param user_is_active filter users based on their active status (true/false)
-- @type user_is_active boolean
-- @default user_is_active null

-- @param user_name the name of the Salesforce User. Substring search is supported.
-- @type user_name varchar
-- @default user_name null

-- @param user_department the department of the Salesforce User
-- @type user_department varchar
-- @default user_department null

-- @param user_created_date_range_start filter users created after this date. Format YYYY-MM-DD.
-- @type user_created_date_range_start date
-- @default user_created_date_range_start null

-- @param user_created_date_range_end filter users created before this date. Format YYYY-MM-DD.
-- @type user_created_date_range_end date
-- @default user_created_date_range_end null

-- @param user_last_modified_date_range_start filter users last modified after this date. Format YYYY-MM-DD.
-- @type user_last_modified_date_range_start date
-- @default user_last_modified_date_range_start null

-- @param user_last_modified_date_range_end filter users last modified before this date. Format YYYY-MM-DD.
-- @type user_last_modified_date_range_end date
-- @default user_last_modified_date_range_end null

-- @param user_last_login_date_range_start filter users who last logged in after this date. Format YYYY-MM-DD.
-- @type user_last_login_date_range_start date
-- @default user_last_login_date_range_start null

-- @param user_last_login_date_range_end filter users who last logged in before this date. Format YYYY-MM-DD.
-- @type user_last_login_date_range_end date
-- @default user_last_login_date_range_end null

-- @param user_id filter users by User ID
-- @type user_id varchar
-- @default user_id null

-- @param user_role_id filter users by Role ID
-- @type user_role_id varchar
-- @default user_role_id null

-- @param page the current page number to retrieve
-- @type page integer
-- @default page 1

-- @param page_size the number of records per page. Default value is 25.
-- @type page_size integer
-- @default page_size 25

-- @return Salesforce users based on filters like username, email, active status, and date ranges.

WITH filtered_users AS (
    SELECT "id" as "user_id",
           "alias" as "user_alias",
           "username" as "username",
           "name" as "user_name",
           "email" as "user_email",
           "is_active" as "user_is_active",
           "account_id" as "user_account_id",
           "created_by_id" as "user_created_by_id",
           "department" as "user_department",
           "employee_number" as "user_employee_number",
           "forecast_enabled" as "user_forecast_enabled",
           "last_login_date" as "user_last_login_date",
           "last_modified_by_id" as "user_last_modified_by_id",
           "profile_id" as "user_profile_id",
           "state" as "user_state",
           "user_type" as "user_type",
           "last_name" as "user_last_name",
           "first_name" as "user_first_name",
           "company_name" as "user_company_name",
           "division" as "user_division",
           "title" as "user_title",
           "street" as "user_street",
           "city" as "user_city",
           "postal_code" as "user_postal_code",
           "country" as "user_country",
           "latitude" as "user_latitude",
           "longitude" as "user_longitude",
           "geocode_accuracy" as "user_geocode_accuracy",
           "email_preferences_auto_bcc" as "user_email_preferences_auto_bcc",
           "email_preferences_auto_bcc_stay_in_touch" as "user_email_preferences_auto_bcc_stay_in_touch",
           "email_preferences_stay_in_touch_reminder" as "user_email_preferences_stay_in_touch_reminder",
           "sender_email" as "user_sender_email",
           "sender_name" as "user_sender_name",
           "signature" as "user_signature",
           "stay_in_touch_subject" as "user_stay_in_touch_subject",
           "stay_in_touch_signature" as "user_stay_in_touch_signature",
           "stay_in_touch_note" as "user_stay_in_touch_note",
           "phone" as "user_phone",
           "fax" as "user_fax",
           "mobile_phone" as "user_mobile_phone",
           "community_nickname" as "user_community_nickname",
           "badge_text" as "user_badge_text",
           "time_zone_sid_key" as "user_time_zone_sid_key",
           "user_role_id" as "user_role_id",
           "locale_sid_key" as "user_locale_sid_key",
           "receives_info_emails" as "user_receives_info_emails",
           "receives_admin_info_emails" as "user_receives_admin_info_emails",
           "email_encoding_key" as "user_email_encoding_key",
           "language_locale_key" as "user_language_locale_key",
           "delegated_approver_id" as "user_delegated_approver_id",
           "manager_id" as "user_manager_id",
           "last_password_change_date" as "user_last_password_change_date",
           "created_date" as "user_created_date",
           "last_modified_date" as "user_last_modified_date",
           "system_modstamp" as "user_system_modstamp",
           "number_of_failed_logins" as "user_number_of_failed_logins",
           "offline_trial_expiration_date" as "user_offline_trial_expiration_date",
           "offline_pda_trial_expiration_date" as "user_offline_pda_trial_expiration_date",
           "user_permissions_marketing_user" as "user_permissions_marketing_user",
           "user_permissions_offline_user" as "user_permissions_offline_user",
           "user_permissions_call_center_auto_login" as "user_permissions_call_center_auto_login",
           "user_permissions_s_f_content_user" as "user_permissions_s_f_content_user",
           "user_permissions_knowledge_user" as "user_permissions_knowledge_user",
           "user_permissions_interaction_user" as "user_permissions_interaction_user",
           "user_permissions_support_user" as "user_permissions_support_user",
           "user_permissions_jigsaw_prospecting_user" as "user_permissions_jigsaw_prospecting_user",
           "user_permissions_siteforce_contributor_user" as "user_permissions_siteforce_contributor_user",
           "user_permissions_siteforce_publisher_user" as "user_permissions_siteforce_publisher_user",
           "user_permissions_work_dot_com_user_feature" as "user_permissions_work_dot_com_user_feature",
           "user_preferences_activity_reminders_popup" as "user_preferences_activity_reminders_popup",
           "user_preferences_event_reminders_checkbox_default" as "user_preferences_event_reminders_checkbox_default",
           "user_preferences_task_reminders_checkbox_default" as "user_preferences_task_reminders_checkbox_default",
           "user_preferences_reminder_sound_off" as "user_preferences_reminder_sound_off",
           "user_preferences_disable_all_feeds_email" as "user_preferences_disable_all_feeds_email",
           "user_preferences_disable_followers_email" as "user_preferences_disable_followers_email",
           "user_preferences_disable_profile_post_email" as "user_preferences_disable_profile_post_email",
           "user_preferences_disable_change_comment_email" as "user_preferences_disable_change_comment_email",
           "user_preferences_disable_later_comment_email" as "user_preferences_disable_later_comment_email",
           "user_preferences_dis_prof_post_comment_email" as "user_preferences_dis_prof_post_comment_email",
           "user_preferences_content_no_email" as "user_preferences_content_no_email",
           "user_preferences_content_email_as_and_when" as "user_preferences_content_email_as_and_when",
           "user_preferences_apex_pages_developer_mode" as "user_preferences_apex_pages_developer_mode",
           "user_preferences_receive_no_notifications_as_approver" as "user_preferences_receive_no_notifications_as_approver",
           "user_preferences_receive_notifications_as_delegated_approver" as "user_preferences_receive_notifications_as_delegated_approver",
           "user_preferences_hide_c_s_n_get_chatter_mobile_task" as "user_preferences_hide_c_s_n_get_chatter_mobile_task",
           "user_preferences_disable_mentions_post_email" as "user_preferences_disable_mentions_post_email",
           "user_preferences_dis_mentions_comment_email" as "user_preferences_dis_mentions_comment_email",
           "user_preferences_hide_c_s_n_desktop_task" as "user_preferences_hide_c_s_n_desktop_task",
           "user_preferences_hide_chatter_onboarding_splash" as "user_preferences_hide_chatter_onboarding_splash",
           "user_preferences_hide_second_chatter_onboarding_splash" as "user_preferences_hide_second_chatter_onboarding_splash",
           "user_preferences_dis_comment_after_like_email" as "user_preferences_dis_comment_after_like_email",
           "user_preferences_disable_like_email" as "user_preferences_disable_like_email",
           "user_preferences_sort_feed_by_comment" as "user_preferences_sort_feed_by_comment",
           "user_preferences_disable_message_email" as "user_preferences_disable_message_email",
           "user_preferences_jigsaw_list_user" as "user_preferences_jigsaw_list_user",
           "user_preferences_disable_bookmark_email" as "user_preferences_disable_bookmark_email",
           "user_preferences_disable_share_post_email" as "user_preferences_disable_share_post_email",
           "user_preferences_enable_auto_sub_for_feeds" as "user_preferences_enable_auto_sub_for_feeds",
           "user_preferences_disable_file_share_notifications_for_api" as "user_preferences_disable_file_share_notifications_for_api",
           "user_preferences_show_title_to_external_users" as "user_preferences_show_title_to_external_users",
           "user_preferences_show_manager_to_external_users" as "user_preferences_show_manager_to_external_users",
           "user_preferences_show_email_to_external_users" as "user_preferences_show_email_to_external_users",
           "user_preferences_show_work_phone_to_external_users" as "user_preferences_show_work_phone_to_external_users",
           "user_preferences_show_mobile_phone_to_external_users" as "user_preferences_show_mobile_phone_to_external_users",
           "user_preferences_show_fax_to_external_users" as "user_preferences_show_fax_to_external_users",
           "user_preferences_show_street_address_to_external_users" as "user_preferences_show_street_address_to_external_users",
           "user_preferences_show_city_to_external_users" as "user_preferences_show_city_to_external_users",
           "user_preferences_show_state_to_external_users" as "user_preferences_show_state_to_external_users",
           "user_preferences_show_postal_code_to_external_users" as "user_preferences_show_postal_code_to_external_users",
           "user_preferences_show_country_to_external_users" as "user_preferences_show_country_to_external_users",
           "user_preferences_show_profile_pic_to_guest_users" as "user_preferences_show_profile_pic_to_guest_users",
           "user_preferences_show_title_to_guest_users" as "user_preferences_show_title_to_guest_users",
           "user_preferences_show_city_to_guest_users" as "user_preferences_show_city_to_guest_users",
           "user_preferences_show_state_to_guest_users" as "user_preferences_show_state_to_guest_users",
           "user_preferences_show_postal_code_to_guest_users" as "user_preferences_show_postal_code_to_guest_users",
           "user_preferences_show_country_to_guest_users" as "user_preferences_show_country_to_guest_users",
           "user_preferences_show_forecasting_change_signals" as "user_preferences_show_forecasting_change_signals",
           "user_preferences_live_agent_miaw_setup_deflection" as "user_preferences_live_agent_miaw_setup_deflection",
           "user_preferences_hide_s_1_browser_u_i" as "user_preferences_hide_s_1_browser_u_i",
           "user_preferences_disable_endorsement_email" as "user_preferences_disable_endorsement_email",
           "user_preferences_path_assistant_collapsed" as "user_preferences_path_assistant_collapsed",
           "user_preferences_cache_diagnostics" as "user_preferences_cache_diagnostics",
           "user_preferences_show_email_to_guest_users" as "user_preferences_show_email_to_guest_users",
           "user_preferences_show_manager_to_guest_users" as "user_preferences_show_manager_to_guest_users",
           "user_preferences_show_work_phone_to_guest_users" as "user_preferences_show_work_phone_to_guest_users",
           "user_preferences_show_mobile_phone_to_guest_users" as "user_preferences_show_mobile_phone_to_guest_users",
           "user_preferences_show_fax_to_guest_users" as "user_preferences_show_fax_to_guest_users",
           "user_preferences_show_street_address_to_guest_users" as "user_preferences_show_street_address_to_guest_users",
           "user_preferences_lightning_experience_preferred" as "user_preferences_lightning_experience_preferred",
           "user_preferences_preview_lightning" as "user_preferences_preview_lightning",
           "user_preferences_hide_end_user_onboarding_assistant_modal" as "user_preferences_hide_end_user_onboarding_assistant_modal",
           "user_preferences_hide_lightning_migration_modal" as "user_preferences_hide_lightning_migration_modal",
           "user_preferences_hide_sfx_welcome_mat" as "user_preferences_hide_sfx_welcome_mat",
           "user_preferences_hide_bigger_photo_callout" as "user_preferences_hide_bigger_photo_callout",
           "user_preferences_global_nav_bar_w_t_shown" as "user_preferences_global_nav_bar_w_t_shown",
           "user_preferences_global_nav_grid_menu_w_t_shown" as "user_preferences_global_nav_grid_menu_w_t_shown",
           "user_preferences_create_l_e_x_apps_w_t_shown" as "user_preferences_create_l_e_x_apps_w_t_shown",
           "user_preferences_favorites_w_t_shown" as "user_preferences_favorites_w_t_shown",
           "user_preferences_record_home_section_collapse_w_t_shown" as "user_preferences_record_home_section_collapse_w_t_shown",
           "user_preferences_record_home_reserved_w_t_shown" as "user_preferences_record_home_reserved_w_t_shown",
           "user_preferences_favorites_show_top_favorites" as "user_preferences_favorites_show_top_favorites",
           "user_preferences_exclude_mail_app_attachments" as "user_preferences_exclude_mail_app_attachments",
           "user_preferences_suppress_task_s_f_x_reminders" as "user_preferences_suppress_task_s_f_x_reminders",
           "user_preferences_suppress_event_s_f_x_reminders" as "user_preferences_suppress_event_s_f_x_reminders",
           "user_preferences_preview_custom_theme" as "user_preferences_preview_custom_theme",
           "user_preferences_has_celebration_badge" as "user_preferences_has_celebration_badge",
           "user_preferences_user_debug_mode_pref" as "user_preferences_user_debug_mode_pref",
           "user_preferences_s_r_h_override_activities" as "user_preferences_s_r_h_override_activities",
           "user_preferences_new_lightning_report_run_page_enabled" as "user_preferences_new_lightning_report_run_page_enabled",
           "user_preferences_reverse_open_activities_view" as "user_preferences_reverse_open_activities_view",
           "user_preferences_show_territory_time_zone_shifts" as "user_preferences_show_territory_time_zone_shifts",
           "user_preferences_has_sent_warning_email" as "user_preferences_has_sent_warning_email",
           "user_preferences_has_sent_warning_email_2_3_8" as "user_preferences_has_sent_warning_email_2_3_8",
           "user_preferences_has_sent_warning_email_2_4_0" as "user_preferences_has_sent_warning_email_2_4_0",
           "user_preferences_native_email_client" as "user_preferences_native_email_client",
           "user_preferences_show_forecasting_rounded_amounts" as "user_preferences_show_forecasting_rounded_amounts",
           "contact_id" as "user_contact_id",
           "call_center_id" as "user_call_center_id",
           "extension" as "user_extension",
           "federation_identifier" as "user_federation_identifier",
           "about_me" as "user_about_me",
           "full_photo_url" as "user_full_photo_url",
           "small_photo_url" as "user_small_photo_url",
           "is_ext_indicator_visible" as "user_is_ext_indicator_visible",
           "out_of_office_message" as "user_out_of_office_message",
           "medium_photo_url" as "user_medium_photo_url",
           "digest_frequency" as "user_digest_frequency",
           "default_group_notification_frequency" as "user_default_group_notification_frequency",
           "jigsaw_import_limit_override" as "user_jigsaw_import_limit_override",
           "last_viewed_date" as "user_last_viewed_date",
           "last_referenced_date" as "user_last_referenced_date",
           "banner_photo_url" as "user_banner_photo_url",
           "small_banner_photo_url" as "user_small_banner_photo_url",
           "medium_banner_photo_url" as "user_medium_banner_photo_url",
           "is_profile_photo_active" as "user_is_profile_photo_active",
           "individual_id" as "user_individual_id"
    FROM salesforce.salesforce_user
    WHERE (username ILIKE CONCAT('%', :username, '%') OR :username IS NULL)
      AND (email ILIKE CONCAT('%', :user_email, '%') OR :user_email IS NULL)
      AND (name ILIKE CONCAT('%', :user_name, '%') OR :user_name IS NULL)
      AND (is_active = :user_is_active OR :user_is_active IS NULL)
      AND (department ILIKE CONCAT('%', :user_department, '%') OR :user_department IS NULL)
      AND (id = :user_id OR :user_id IS NULL)
      AND (user_role_id = :user_role_id OR :user_role_id IS NULL)
      AND ((created_date >= :user_created_date_range_start::timestamp) OR (:user_created_date_range_start IS NULL))
      AND ((created_date <= :user_created_date_range_end::timestamp) OR (:user_created_date_range_end IS NULL))
      AND ((last_modified_date >= :user_last_modified_date_range_start::timestamp) OR (:user_last_modified_date_range_start IS NULL))
      AND ((last_modified_date <= :user_last_modified_date_range_end::timestamp) OR (:user_last_modified_date_range_end IS NULL))
      AND ((last_login_date >= :user_last_login_date_range_start::timestamp) OR (:user_last_login_date_range_start IS NULL))
      AND ((last_login_date <= :user_last_login_date_range_end::timestamp) OR (:user_last_login_date_range_end IS NULL))
)
SELECT *
FROM filtered_users
ORDER BY user_id
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
