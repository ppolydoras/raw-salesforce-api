# OpenApi spec of organization: dev-mlmsul7huphxehi

### Table of Contents

- [/salesforce_gpt/accounts](#salesforce_gptaccounts)
- [/salesforce_gpt/accounts/events](#salesforce_gptaccountsevents)
- [/salesforce_gpt/accounts/files](#salesforce_gptaccountsfiles)
- [/salesforce_gpt/accounts/summary](#salesforce_gptaccountssummary)
- [/salesforce_gpt/accounts/tasks](#salesforce_gptaccountstasks)
- [/salesforce_gpt/accounts/tasks/summary](#salesforce_gptaccountstaskssummary)
- [/salesforce_gpt/business_cases](#salesforce_gptbusiness_cases)
- [/salesforce_gpt/business_cases/experts](#salesforce_gptbusiness_casesexperts)
- [/salesforce_gpt/contacts](#salesforce_gptcontacts)
- [/salesforce_gpt/contacts/summary](#salesforce_gptcontactssummary)
- [/salesforce_gpt/contracts](#salesforce_gptcontracts)
- [/salesforce_gpt/contracts/summary](#salesforce_gptcontractssummary)
- [/salesforce_gpt/enumeration/account_types](#salesforce_gptenumerationaccount_types)
- [/salesforce_gpt/enumeration/contract_statuses](#salesforce_gptenumerationcontract_statuses)
- [/salesforce_gpt/enumeration/industries](#salesforce_gptenumerationindustries)
- [/salesforce_gpt/enumeration/lead_sources](#salesforce_gptenumerationlead_sources)
- [/salesforce_gpt/enumeration/lead_statuses](#salesforce_gptenumerationlead_statuses)
- [/salesforce_gpt/enumeration/opportunity_stages](#salesforce_gptenumerationopportunity_stages)
- [/salesforce_gpt/enumeration/ratings](#salesforce_gptenumerationratings)
- [/salesforce_gpt/enumeration/task_subtypes](#salesforce_gptenumerationtask_subtypes)
- [/salesforce_gpt/leads](#salesforce_gptleads)
- [/salesforce_gpt/leads/summary](#salesforce_gptleadssummary)
- [/salesforce_gpt/opportunities](#salesforce_gptopportunities)
- [/salesforce_gpt/opportunities/events](#salesforce_gptopportunitiesevents)
- [/salesforce_gpt/opportunities/products](#salesforce_gptopportunitiesproducts)
- [/salesforce_gpt/opportunities/summary](#salesforce_gptopportunitiessummary)
- [/salesforce_gpt/opportunities/tasks](#salesforce_gptopportunitiestasks)
- [/salesforce_gpt/opportunities/tasks/summary](#salesforce_gptopportunitiestaskssummary)
- [/salesforce_gpt/products](#salesforce_gptproducts)
- [/salesforce_gpt/products/files](#salesforce_gptproductsfiles)
- [/salesforce_gpt/products/summary](#salesforce_gptproductssummary)
- [/salesforce_gpt/users](#salesforce_gptusers)
- [/salesforce_gpt/users/summary](#salesforce_gptuserssummary)
- [/salesforce_gpt/utilities/currentdatetime](#salesforce_gptutilitiescurrentdatetime)


## Version: 1.0.0

### /salesforce_gpt/users/summary

#### GET
##### Summary:

Salesforce User Summary.

##### Description:

Returns a summary of Salesforce users based on various filters and grouping options, including total users, active users, and users created within a specified date range.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| username | query |  | No | string |
| group_by_field | query |  | No | string |
| user_role_id | query |  | No | string |
| user_created_date_period_start | query |  | No | date |
| user_email | query |  | No | string |
| user_created_date_period_end | query |  | No | date |
| user_is_active | query |  | No | boolean |
| user_department | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/contracts

#### GET
##### Summary:

Get contracts by account name, end date (renewal date) and billing address

##### Description:

Retrieve contracts by account name, contract description, status, contract terms, pricebook id, owner, start date, end date (renewal date) and billing address. Permissible values for status can be found in endpoint `/salesforce_gpt/enumeration/contract_statuses`

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| start_date_range_start | query |  | No | date |
| special_terms | query |  | No | string |
| contract_is_deleted | query |  | No | boolean |
| city | query |  | No | string |
| pricebook_2_id | query |  | No | string |
| state | query |  | No | string |
| page | query |  | No | integer |
| owner_id | query |  | No | string |
| start_date_range_end | query |  | No | date |
| page_size | query |  | No | integer |
| country | query |  | No | string |
| end_date_range_start | query |  | No | date |
| account_id | query |  | No | string |
| activated_by_id | query |  | No | string |
| account_name | query |  | No | string |
| end_date_range_end | query |  | No | date |
| postal_code | query |  | No | integer |
| street | query |  | No | string |
| contract_status | query |  | No | string |
| contract_term | query |  | No | integer |
| contract_description | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/products/files

#### GET
##### Summary:

Get Product attached files.

##### Description:

Retrieves all files associated with a specific product ID.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| product_id | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/contacts

#### GET
##### Summary:

Retrieve Salesforce Contacts.

##### Description:

Retrieves Salesforce contacts with pagination and various filters such as account name, contact name, contact email, and contact title.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| is_priority_record | query |  | No | boolean |
| contact_created_date_range_end | query |  | No | date |
| contact_mailing_country | query |  | No | string |
| contact_mailing_state | query |  | No | string |
| contact_owner_name | query |  | No | string |
| contact_mailing_street | query |  | No | string |
| has_email_bounced | query |  | No | boolean |
| page | query |  | No | integer |
| contact_last_activity_date_range_start | query |  | No | date |
| page_size | query |  | No | integer |
| contact_mailing_postal_code | query |  | No | integer |
| contact_birthdate_range_end | query |  | No | date |
| contact_created_date_range_start | query |  | No | date |
| contact_last_activity_date_range_end | query |  | No | date |
| contact_lead_source | query |  | No | string |
| account_name | query |  | No | string |
| contact_birthdate_range_start | query |  | No | date |
| contact_mailing_city | query |  | No | string |
| contact_title | query |  | No | string |
| contact_level | query |  | No | string |
| contact_languages | query |  | No | string |
| contact_name | query |  | No | string |
| contact_email | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/task_subtypes

#### GET
##### Summary:

List of Task Subtypes.

##### Description:

Returns a list of Task Subtypes, such as "Email", "Call", and "Task".

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/industries

#### GET
##### Summary:

List of Salesforce Account or Lead Industries.

##### Description:

This endpoint returns a list of industry names for Salesforce Accounts or Leads.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/accounts/summary

#### GET
##### Summary:

Summarize Salesforce Accounts.

##### Description:

Summarizes the total number of Salesforce accounts based on various filters and groups them by a specified field. Permissible group by fields are these - 'account_industry', 'account_type', 'account_billing_country', 'account_rating', 'account_source'

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| account_is_deleted | query |  | No | boolean |
| account_billing_postal_code | query |  | No | integer |
| number_of_employees_range_start | query |  | No | integer |
| account_created_date_range_start | query |  | No | date |
| group_by_field | query |  | No | string |
| clean_status | query |  | No | string |
| owner_id | query |  | No | string |
| annual_revenue_range_end | query |  | No | long |
| account_billing_street | query |  | No | string |
| number_of_employees_range_end | query |  | No | integer |
| account_type | query |  | No | string |
| account_industry | query |  | No | string |
| operating_hours_id | query |  | No | string |
| account_last_activity_date_range_end | query |  | No | date |
| account_created_date_range_end | query |  | No | date |
| annual_revenue_range_start | query |  | No | long |
| account_billing_state | query |  | No | string |
| account_name | query |  | No | string |
| account_billing_country | query |  | No | string |
| account_source | query |  | No | string |
| account_rating | query |  | No | string |
| account_last_activity_date_range_start | query |  | No | date |
| account_billing_city | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/opportunities

#### GET
##### Summary:

Retrieve Salesforce Opportunities.

##### Description:

Retrieve opportunities based on optional filters like account name, owner name, and stage from the Salesforce database. The list of permissible values for opportunity_stage can be found in this endpoint `/salesforce_gpt/enumeration/opportunity_stages`

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| is_won | query |  | No | boolean |
| state | query |  | No | string |
| opportunity_last_activity_date_range_end | query |  | No | date |
| opportunity_type | query |  | No | string |
| opportunity_stage | query |  | No | string |
| page | query |  | No | integer |
| opportunity_created_date_range_end | query |  | No | date |
| opportunity_name | query |  | No | string |
| opportunity_created_date_range_start | query |  | No | date |
| page_size | query |  | No | integer |
| country | query |  | No | string |
| owner_name | query |  | No | string |
| is_closed | query |  | No | boolean |
| lead_source | query |  | No | string |
| opportunity_last_activity_date_range_start | query |  | No | date |
| account_name | query |  | No | string |
| postal_code | query |  | No | integer |
| street | query |  | No | string |
| fiscal_year | query |  | No | integer |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/utilities/currentdatetime

#### GET
##### Summary:

Get current Date & Time.

##### Description:

Retrieve current Date & Time along with timezone

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/account_types

#### GET
##### Summary:

Get List of Account Types

##### Description:

Returns the closed list of account types, used in Salesforce Account table.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/opportunities/summary

#### GET
##### Summary:

Opportunity Summary by Field.

##### Description:

Summarizes the total number of opportunities based on various filters and grouping options.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| state | query |  | No | string |
| opportunity_last_activity_date_range_end | query |  | No | date |
| group_by_field | query |  | No | string |
| opportunity_stage | query |  | No | string |
| opportunity_created_date_range_end | query |  | No | date |
| opportunity_name | query |  | No | string |
| opportunity_created_date_range_start | query |  | No | date |
| country | query |  | No | string |
| owner_name | query |  | No | string |
| opportunity_last_activity_date_range_start | query |  | No | date |
| account_name | query |  | No | string |
| postal_code | query |  | No | integer |
| street | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/accounts

#### GET
##### Summary:

Retrieve Salesforce Accounts.

##### Description:

Retrieves Salesforce accounts with pagination and supports various filters like account industry, account type, and account billing country.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| account_is_deleted | query |  | No | boolean |
| account_billing_postal_code | query |  | No | integer |
| number_of_employees_range_start | query |  | No | integer |
| account_created_date_range_start | query |  | No | date |
| clean_status | query |  | No | string |
| page | query |  | No | integer |
| owner_id | query |  | No | string |
| annual_revenue_range_end | query |  | No | long |
| account_billing_street | query |  | No | string |
| page_size | query |  | No | integer |
| number_of_employees_range_end | query |  | No | integer |
| account_type | query |  | No | string |
| account_industry | query |  | No | string |
| operating_hours_id | query |  | No | string |
| account_last_activity_date_range_end | query |  | No | date |
| account_created_date_range_end | query |  | No | date |
| annual_revenue_range_start | query |  | No | long |
| account_billing_state | query |  | No | string |
| account_name | query |  | No | string |
| account_billing_country | query |  | No | string |
| account_source | query |  | No | string |
| account_rating | query |  | No | string |
| account_last_activity_date_range_start | query |  | No | date |
| account_billing_city | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/ratings

#### GET
##### Summary:

Get List of Ratings for Salesforce Leads or Accounts.

##### Description:

Returns a list of different ratings for Salesforce Leads or Accounts.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/accounts/events

#### GET
##### Summary:

Retrieve Account Events.

##### Description:

Retrieves events related to accounts based on filters like account name, account id, and event subject.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| event_subject | query |  | No | string |
| page | query |  | No | integer |
| owner_id | query |  | No | string |
| event_is_recurrence | query |  | No | boolean |
| event_is_private | query |  | No | boolean |
| page_size | query |  | No | integer |
| account_id | query |  | No | string |
| event_is_group_event | query |  | No | boolean |
| account_name | query |  | No | string |
| event_end_date_range_end | query |  | No | date |
| event_id | query |  | No | string |
| event_start_date_range_start | query |  | No | date |
| event_start_date_range_end | query |  | No | date |
| event_end_date_range_start | query |  | No | date |
| event_location | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/products

#### GET
##### Summary:

Get Salesforce Products.

##### Description:

Retrieves products based on various filters such as product name, description, family, ID, code, type, unit of measure, SKU, and more.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| product_description | query |  | No | string |
| product_created_date_period_start | query |  | No | date |
| page | query |  | No | integer |
| product_is_deleted | query |  | No | boolean |
| page_size | query |  | No | integer |
| product_type | query |  | No | string |
| product_family | query |  | No | string |
| product_is_archived | query |  | No | boolean |
| product_code | query |  | No | string |
| product_name | query |  | No | string |
| product_is_active | query |  | No | boolean |
| product_created_date_period_end | query |  | No | date |
| product_id | query |  | No | string |
| product_stock_keeping_unit | query |  | No | string |
| product_quantity_unit_of_measure | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/accounts/tasks/summary

#### GET
##### Summary:

Salesforce Account Task Summary.

##### Description:

Summarizes the total number of tasks related to a Salesforce Account, with various filtering and grouping options.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| task_status | query |  | No | string |
| group_by_field | query |  | No | string |
| task_created_date_range_start | query |  | No | date |
| task_subtype | query |  | No | string |
| account_id | query |  | No | string |
| task_priority | query |  | No | string |
| account_name | query |  | No | string |
| task_subject | query |  | No | string |
| task_created_date_range_end | query |  | No | date |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/products/summary

#### GET
##### Summary:

Product Summary by Field.

##### Description:

Summarizes the total, active, deleted and archived products based on various filters and grouping options.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| product_description | query |  | No | string |
| group_by_field | query |  | No | string |
| product_created_date_period_start | query |  | No | date |
| product_is_deleted | query |  | No | boolean |
| product_type | query |  | No | string |
| product_family | query |  | No | string |
| product_is_archived | query |  | No | boolean |
| product_code | query |  | No | string |
| product_name | query |  | No | string |
| product_is_active | query |  | No | boolean |
| product_created_date_period_end | query |  | No | date |
| product_id | query |  | No | string |
| product_stock_keeping_unit | query |  | No | string |
| product_quantity_unit_of_measure | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/leads/summary

#### GET
##### Summary:

Lead Summary by Field.

##### Description:

This endpoint retrieves a summary of leads based on various filters and groups them by a specified field. The summary includes total leads, converted and unconverted leads, average time to conversion, and breakdowns by status, rating, source, and industry.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| lead_is_converted | query |  | No | boolean |
| lead_created_date_range_end | query |  | No | date |
| group_by_field | query |  | No | string |
| lead_country | query |  | No | string |
| lead_last_activity_date_range_end | query |  | No | date |
| lead_source | query |  | No | string |
| lead_status | query |  | No | string |
| lead_rating | query |  | No | string |
| lead_industry | query |  | No | string |
| lead_is_deleted | query |  | No | boolean |
| lead_created_date_range_start | query |  | No | date |
| lead_last_activity_date_range_start | query |  | No | date |
| lead_state | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/business_cases/experts

#### GET
##### Summary:

Get Salesforce Business Case Experts.

##### Description:

Retrieves Salesforce Business Case Experts based on specified filters.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| business_case_id | query |  | No | string |
| username | query |  | No | string |
| page | query |  | No | integer |
| expert_assignment_date_range_end | query |  | No | date |
| page_size | query |  | No | integer |
| user_created_date_range_end | query |  | No | date |
| user_id | query |  | No | string |
| user_email | query |  | No | string |
| business_case_expert_reason_for_assignment | query |  | No | string |
| user_created_date_range_start | query |  | No | date |
| business_case_expert_expertise | query |  | No | string |
| expert_assignment_date_range_start | query |  | No | date |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/contacts/summary

#### GET
##### Summary:

Summarize Contacts by Field.

##### Description:

Summarizes the total number of contacts in Salesforce, grouped by specified fields like account name, mailing country, or contact title. Supports filtering by account name, mailing country, contact creation date range.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| contact_created_date_range_end | query |  | No | date |
| contact_mailing_country | query |  | No | string |
| group_by_field | query |  | No | string |
| contact_created_date_range_start | query |  | No | date |
| account_name | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/opportunity_stages

#### GET
##### Summary:

Get List of Salesforce Opportunity Stages.

##### Description:

Returns a list of stages in Salesforce Opportunities.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/leads

#### GET
##### Summary:

Get leads by rating and status

##### Description:

Retrieves accounts from Salesforce Lead based on filters like rating and status. In order to retrieve permissible values for ratings, statuses, sources and industries, consult `/salesforce_gpt/enumeration/ratings`, `/salesforce_gpt/enumeration/lead_statuses`, `/salesforce_gpt/enumeration/lead_sources`, `/salesforce_gpt/enumeration/industries` respectively

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| max_employees | query |  | No | integer |
| is_priority_record | query |  | No | boolean |
| lead_converted_date_range_end | query |  | No | date |
| lead_city | query |  | No | string |
| min_employees | query |  | No | integer |
| lead_is_converted | query |  | No | boolean |
| lead_created_date_range_end | query |  | No | date |
| lead_country | query |  | No | string |
| lead_email | query |  | No | string |
| has_email_bounced | query |  | No | boolean |
| page | query |  | No | integer |
| page_size | query |  | No | integer |
| lead_name | query |  | No | string |
| lead_last_activity_date_range_end | query |  | No | date |
| lead_postal_code | query |  | No | integer |
| lead_street | query |  | No | string |
| lead_source | query |  | No | string |
| lead_owner_id | query |  | No | string |
| lead_status | query |  | No | string |
| lead_rating | query |  | No | string |
| lead_description | query |  | No | string |
| lead_converted_date_range_start | query |  | No | date |
| lead_industry | query |  | No | string |
| lead_is_deleted | query |  | No | boolean |
| lead_created_date_range_start | query |  | No | date |
| lead_last_activity_date_range_start | query |  | No | date |
| lead_state | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/lead_statuses

#### GET
##### Summary:

Get List of Status Options for Salesforce Leads.

##### Description:

Returns a list of different statuses for Salesforce Leads.

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/lead_sources

#### GET
##### Summary:

Get List of Salesforce Lead Sources

##### Description:

Retrieve the List of Salesforce Lead Sources

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/opportunities/products

#### GET
##### Summary:

Filter products by opportunity.

##### Description:

Retrieves products related to opportunities based on filters like opportunity name, opportunity id, and product name.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| product_id | query |  | No | string |
| product_name | query |  | No | string |
| opportunity_name | query |  | No | string |
| opportunity_id | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/contracts/summary

#### GET
##### Summary:

Summarize Contracts by Field.

##### Description:

Summarizes the total number of contracts based on various filters and groups them by a specified field.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| start_date_range_start | query |  | No | date |
| special_terms | query |  | No | string |
| pricebook_2_id | query |  | No | string |
| group_by_field | query |  | No | string |
| owner_id | query |  | No | string |
| start_date_range_end | query |  | No | date |
| end_date_range_start | query |  | No | date |
| account_id | query |  | No | string |
| activated_by_id | query |  | No | string |
| account_name | query |  | No | string |
| end_date_range_end | query |  | No | date |
| contract_status | query |  | No | string |
| contract_term | query |  | No | integer |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/accounts/files

#### GET
##### Summary:

Get Account attached files.

##### Description:

Retrieves all files associated with a specific account ID.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| account_id | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/enumeration/contract_statuses

#### GET
##### Summary:

Get contract status codes.

##### Description:

Returns a list of contract status codes, such as "Draft", "InApproval", and "Activated".

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/users

#### GET
##### Summary:

Get Salesforce Users.

##### Description:

Returns Salesforce users based on various filters such as username, email, active status, and date ranges. Pagination is supported. All Salesforce entities are created by (created_by_id) and owned by (owner_id) a Salesforce User.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| username | query |  | No | string |
| user_last_login_date_range_start | query |  | No | date |
| page | query |  | No | integer |
| user_last_modified_date_range_start | query |  | No | date |
| user_role_id | query |  | No | string |
| page_size | query |  | No | integer |
| user_created_date_range_end | query |  | No | date |
| user_id | query |  | No | string |
| user_email | query |  | No | string |
| user_is_active | query |  | No | boolean |
| user_department | query |  | No | string |
| user_created_date_range_start | query |  | No | date |
| user_last_login_date_range_end | query |  | No | date |
| user_name | query |  | No | string |
| user_last_modified_date_range_end | query |  | No | date |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/opportunities/tasks

#### GET
##### Summary:

Retrieve Opportunity Tasks.

##### Description:

Retrieves tasks related to opportunities based on filters like opportunity name, opportunity id, task id, task subject and task subtype. Permissible values for task sabtypes can be found in endpoint '/salesforce_gpt/enumeration/task_subtypes'

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| task_last_modified_date_range_end | query |  | No | date |
| task_status | query |  | No | string |
| task_last_modified_date_range_start | query |  | No | date |
| page | query |  | No | integer |
| owner_id | query |  | No | string |
| opportunity_name | query |  | No | string |
| task_created_date_range_start | query |  | No | date |
| page_size | query |  | No | integer |
| task_subtype | query |  | No | string |
| account_id | query |  | No | string |
| task_priority | query |  | No | string |
| account_name | query |  | No | string |
| task_subject | query |  | No | string |
| task_completed_date_range_end | query |  | No | date |
| is_reminder_set | query |  | No | boolean |
| opportunity_id | query |  | No | string |
| task_id | query |  | No | string |
| task_completed_date_range_start | query |  | No | date |
| task_created_date_range_end | query |  | No | date |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/business_cases

#### GET
##### Summary:

Get Business Cases.

##### Description:

Retrieves Salesforce business cases based on various search parameters.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| business_case_proposed_solution | query |  | No | string |
| create_date_range_start | query |  | No | date |
| page | query |  | No | integer |
| page_size | query |  | No | integer |
| account_id | query |  | No | string |
| create_date_range_end | query |  | No | date |
| business_case_description | query |  | No | string |
| account_name | query |  | No | string |
| business_case_pain_points | query |  | No | string |
| business_case_expected_outcomes | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/accounts/tasks

#### GET
##### Summary:

Retrieve Account Tasks.

##### Description:

Retrieves tasks and related account information from Salesforce based on filters like account name, account ID, and task subject. Permissible values for task sabtypes can be found in endpoint '/salesforce_gpt/enumeration/task_subtypes'

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| task_last_modified_date_range_end | query |  | No | date |
| task_status | query |  | No | string |
| task_last_modified_date_range_start | query |  | No | date |
| page | query |  | No | integer |
| owner_id | query |  | No | string |
| task_created_date_range_start | query |  | No | date |
| page_size | query |  | No | integer |
| task_subtype | query |  | No | string |
| account_id | query |  | No | string |
| task_priority | query |  | No | string |
| account_name | query |  | No | string |
| task_subject | query |  | No | string |
| task_completed_date_range_end | query |  | No | date |
| is_reminder_set | query |  | No | boolean |
| task_id | query |  | No | string |
| task_completed_date_range_start | query |  | No | date |
| task_created_date_range_end | query |  | No | date |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/opportunities/tasks/summary

#### GET
##### Summary:

Salesforce Opportunity Task Summary.

##### Description:

Summarizes the total number of tasks related to a given opportunity, with various filtering and grouping options.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| task_status | query |  | No | string |
| group_by_field | query |  | No | string |
| opportunity_name | query |  | No | string |
| task_created_date_range_start | query |  | No | date |
| task_subtype | query |  | No | string |
| task_priority | query |  | No | string |
| task_subject | query |  | No | string |
| opportunity_id | query |  | No | string |
| task_created_date_range_end | query |  | No | date |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |

### /salesforce_gpt/opportunities/events

#### GET
##### Summary:

Retrieve Opportunity Events.

##### Description:

Retrieve events related to opportunities based on filters like opportunity name, opportunity id, and event subject.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| event_subject | query |  | No | string |
| page | query |  | No | integer |
| owner_id | query |  | No | string |
| event_is_recurrence | query |  | No | boolean |
| event_is_private | query |  | No | boolean |
| opportunity_name | query |  | No | string |
| page_size | query |  | No | integer |
| event_is_group_event | query |  | No | boolean |
| opportunity_id | query |  | No | string |
| event_end_date_range_end | query |  | No | date |
| event_id | query |  | No | string |
| event_start_date_range_start | query |  | No | date |
| event_start_date_range_end | query |  | No | date |
| event_end_date_range_start | query |  | No | date |
| event_location | query |  | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Successful response |
| 202 | Results not ready yet |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not found |
| 500 | Internal server error |

##### Security

| Security Schema | Scopes |
| --- | --- |
| api_key | |
