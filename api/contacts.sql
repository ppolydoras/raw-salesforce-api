-- @param account_name the name of the Salesforce Account. Substring search is supported.
-- @type account_name varchar
-- @default account_name null
-- @param contact_name the name of the Salesforce Contact. Substring search is supported.
-- @type contact_name varchar
-- @default contact_name null
-- @param contact_email the email of the Salesforce Contact. Substring search is supported.
-- @type contact_email varchar
-- @default contact_email null
-- @param contact_title the title of the Salesforce Contact. Substring search is supported.
-- @type contact_title varchar
-- @default contact_title null
-- @param contact_lead_source comma-separated list of lead source/origin - permissible values can be found in endpoint `/salesforce_gpt/enumeration/lead_sources`. If null the all sources are included.
-- @type contact_lead_source varchar
-- @default contact_lead_source null
-- @param contact_owner_name the name of the Salesforce user who owns the contact. Substring search is supported.
-- @type contact_owner_name varchar
-- @default contact_owner_name null
-- @param contact_created_date_range_start contact creation date is greater than or equal to contact_created_date_range_start. Format YYYY-MM-DD.
-- @type contact_created_date_range_start date
-- @default contact_created_date_range_start null
-- @param contact_created_date_range_end contact creation date is lower than or equal to contact_created_date_range_end. Format YYYY-MM-DD.
-- @type contact_created_date_range_end date
-- @default contact_created_date_range_end null
-- @param contact_birthdate_range_start contact birthdate is greater than or equal to contact_birthdate_range_start. Format YYYY-MM-DD.
-- @type contact_birthdate_range_start date
-- @default contact_birthdate_range_start null
-- @param contact_birthdate_range_end contact birthdate is lower than or equal to contact_birthdate_range_end. Format YYYY-MM-DD.
-- @type contact_birthdate_range_end date
-- @default contact_birthdate_range_end null
-- @param contact_last_activity_date_range_start contacts's last activity date is greater than or equal to contact_last_activity_date_range_start. Format YYYY-MM-DD.
-- @type contact_last_activity_date_range_start date
-- @default contact_last_activity_date_range_start null
-- @param contact_last_activity_date_range_end contact's last activity date is lower than or equal to contact_last_activity_date_range_end. Format YYYY-MM-DD.
-- @type contact_last_activity_date_range_end date
-- @default contact_last_activity_date_range_end null
-- @param contact_mailing_country the mailing address country of the contact
-- @type contact_mailing_country varchar
-- @default contact_mailing_country null
-- @param contact_mailing_state the mailing address state of the contact
-- @type contact_mailing_state varchar
-- @default contact_mailing_state null
-- @param contact_mailing_postal_code the mailing address postal code of the contact
-- @type contact_mailing_postal_code integer
-- @default contact_mailing_postal_code null
-- @param contact_mailing_street the mailing address street of the contact
-- @type contact_mailing_street varchar
-- @default contact_mailing_street null
-- @param contact_mailing_city the mailing address city of the contact
-- @type contact_mailing_city varchar
-- @default contact_mailing_city null
-- @param has_email_bounced filter Salesforce contacts where email has bounced (true/false).
-- @type has_email_bounced boolean
-- @default has_email_bounced null
-- @param is_priority_record filter Salesforce contacts that are marked as priority (true/false).
-- @type is_priority_record boolean
-- @default is_priority_record null
-- @param contact_level the level associated with the Salesforce Contact.
-- @type contact_level varchar
-- @default contact_level null
-- @param contact_languages the languages spoken by the Salesforce Contact.
-- @type contact_languages varchar
-- @default contact_languages null
-- @param page the current page number to retrieve
-- @type page integer
-- @default page null
-- @param page_size the number of records per page
-- @type page_size integer
-- @default page_size null
-- @return Salesforce contacts with pagination and various filters such as account name, contact name, contact email, and contact title.

WITH filtered_contacts AS (
    SELECT c."id" as "contact_id",
           c."name" as "contact_name",
           c."account_id" as "contact_account_id",
           c."email" as "contact_email",
           c."lead_source" as "contact_lead_source",
           c."owner_id" as "contact_owner_id",
           c."title" as "contact_title",
           c."assistant_name" as "contact_assistant_name",
           c."assistant_phone" as "contact_assistant_phone",
           c."birthdate" as "contact_birthdate",
           c."clean_status" as "contact_clean_status",
           c."created_by_id" as "contact_created_by_id",
           c."created_date" as "contact_created_date",
           c."department" as "contact_department",
           c."description" as "contact_description",
           c."email_bounced_date" as "contact_email_bounced_date",
           c."email_bounced_reason" as "contact_email_bounced_reason",
           c."fax" as "contact_fax",
           c."home_phone" as "contact_home_phone",
           c."individual_id" as "contact_individual_id",
           c."is_deleted" as "contact_is_deleted",
           c."is_email_bounced" as "contact_is_email_bounced",
           c."jigsaw" as "contact_jigsaw",
           c."jigsaw_contact_id" as "contact_jigsaw_contact_id",
           c."last_activity_date" as "contact_last_activity_date",
           c."last_c_u_request_date" as "contact_last_c_u_request_date",
           c."last_c_u_update_date" as "contact_last_c_u_update_date",
           c."last_modified_by_id" as "contact_last_modified_by_id",
           c."last_modified_date" as "contact_last_modified_date",
           c."last_referenced_date" as "contact_last_referenced_date",
           c."last_viewed_date" as "contact_last_viewed_date",
           c."master_record_id" as "contact_master_record_id",
           c."mobile_phone" as "contact_mobile_phone",
           c."other_phone" as "contact_other_phone",
           c."phone" as "contact_phone",
           c."photo_url" as "contact_photo_url",
           c."reports_to_id" as "contact_reports_to_id",
           c."system_modstamp" as "contact_system_modstamp",
           c."last_name" as "contact_last_name",
           c."first_name" as "contact_first_name",
           c."salutation" as "contact_salutation",
           c."other_street" as "contact_other_street",
           c."other_city" as "contact_other_city",
           c."other_state" as "contact_other_state",
           c."other_postal_code" as "contact_other_postal_code",
           c."other_country" as "contact_other_country",
           c."other_latitude" as "contact_other_latitude",
           c."other_longitude" as "contact_other_longitude",
           c."other_geocode_accuracy" as "contact_other_geocode_accuracy",
           c."mailing_street" as "contact_mailing_street",
           c."mailing_city" as "contact_mailing_city",
           c."mailing_state" as "contact_mailing_state",
           c."mailing_postal_code" as "contact_mailing_postal_code",
           c."mailing_country" as "contact_mailing_country",
           c."mailing_latitude" as "contact_mailing_latitude",
           c."mailing_longitude" as "contact_mailing_longitude",
           c."mailing_geocode_accuracy" as "contact_mailing_geocode_accuracy",
           c."is_priority_record" as "contact_is_priority_record",
           c."Level__c" as "contact_Level__c",
           c."Languages__c" as "contact_Languages__c",
           a.name AS account_name
    FROM salesforce.salesforce_contact c
             JOIN salesforce.salesforce_account a ON c.account_id = a.id
    WHERE (a.name ILIKE CONCAT('%',:account_name,'%') OR :account_name IS NULL)
      AND (c.name ILIKE CONCAT('%',:contact_name,'%') OR :contact_name IS NULL)
      AND (c.title ILIKE CONCAT('%',:contact_title,'%') OR :contact_title IS NULL)
      AND (c.email ILIKE CONCAT('%',:contact_email,'%') OR :contact_email IS NULL)
      AND (c.lead_source ILIKE ANY (string_to_array(:contact_lead_source, ',')) OR :contact_lead_source IS NULL)
      AND ((c.created_date >= :contact_created_date_range_start::timestamp) OR (:contact_created_date_range_start IS NULL))
      AND ((c.created_date <= :contact_created_date_range_end::timestamp) OR (:contact_created_date_range_end IS NULL))
      AND ((c.last_activity_date >= :contact_last_activity_date_range_start::date) OR (:contact_last_activity_date_range_start IS NULL))
      AND ((c.last_activity_date <= :contact_last_activity_date_range_end::date) OR (:contact_last_activity_date_range_end IS NULL))
      AND (c.mailing_country ILIKE CONCAT('%',:contact_mailing_country,'%') OR :contact_mailing_country IS NULL)
      AND (c.mailing_state ILIKE CONCAT('%',:contact_mailing_state,'%') OR :contact_mailing_state IS NULL)
      AND (c.mailing_postal_code ILIKE CONCAT('%',:contact_mailing_postal_code,'%') OR :contact_mailing_postal_code IS NULL)
      AND (c.mailing_street ILIKE CONCAT('%',:contact_mailing_street,'%') OR :contact_mailing_street IS NULL)
      AND (c.mailing_city ILIKE CONCAT('%',:contact_mailing_city,'%') OR :contact_mailing_city IS NULL)
      AND (c.is_email_bounced = :has_email_bounced OR :has_email_bounced IS NULL)
      AND (c.is_priority_record = :is_priority_record OR :is_priority_record IS NULL)
      AND (c."Level__c" ILIKE CONCAT('%', :contact_level, '%') OR :contact_level IS NULL)
      AND (c."Languages__c" ILIKE CONCAT('%', :contact_languages, '%') OR :contact_languages IS NULL)
)
SELECT *
FROM filtered_contacts
ORDER BY contact_name
    LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
