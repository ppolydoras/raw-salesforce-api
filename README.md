
# Salesforce API Template for RAW Labs

## Table of Contents

1. [Introduction](#introduction)
   - [Description](#description)
   - [How It Works](#how-it-works)
   - [Features](#features)
2. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Setup Instructions](#setup-instructions)
3. [Domain Entities](#domain-entities)
   - [Entities Overview](#entities-overview)
   - [Entity Relationships](#entity-relationships)
4. [Query Structure](#query-structure)
   - [Basic Structure of SQL Files](#basic-structure-of-sql-files)
   - [Types of Queries](#types-of-queries)
5. [Filters and Pagination](#filters-and-pagination)
   - [Filters](#filters)
   - [Pagination](#pagination)
6. [Customization](#customization)
7. [Contributing](#contributing)
8. [Support and Troubleshooting](#support-and-troubleshooting)
9. [License](#license)
10. [Acknowledgements](#acknowledgements)
11. [Contact](#contact)

---

## Introduction

### Description

This repository provides a **Salesforce API template** for integrating Salesforce data into the RAW Labs platform. It demonstrates how to retrieve and manipulate Salesforce data using SQL queries on a logical Salesforce database within RAW Labs. The template focuses on main Salesforce entities and serves as a starting point for users to build custom APIs tailored to their needs. Since Salesforce schemas can be highly dynamic, this template offers a flexible approach to data retrieval and integration.

### How It Works

The RAW Labs platform allows you to create APIs by writing SQL queries that can access data from various data sources, including Salesforce. Under the hood, RAW Labs uses a Data Access Service (DAS) architecture to connect to numerous origin servers and/or data sources, including your Salesforce instance. The **DAS Architecture** acts as a bridge between RAW Labs and Salesforce, enabling seamless, real-time data retrieval without the need for data replication. Please note that detailed documentation on the DAS Architecture is currently a work in progress and will be provided soon.


### Features

- **Real-time Data Access**: Query Salesforce data in real-time without the need for data replication.
- **Predefined Templates**: Utilize templates for common data access patterns to speed up development.
- **Data Integration**: Combine Salesforce data with other data sources supported by RAW Labs.
- **Customizable Queries**: Adjust queries to fit your specific Salesforce schema and business logic.

## Getting Started

### Prerequisites

- **Salesforce Account**:
  - An active Salesforce account with API access enabled.
  - Necessary permissions to access desired objects and fields.
- **RAW Labs Account**:
  - An active RAW Labs account. [Sign up here](https://app.raw-labs.com/register) if you don't have one.
- **Permissions**:
  - **Salesforce**:
    - API Enabled
    - Access to connected apps
  - **RAW Labs**:
    - Admin role to your RAW Labs account.
- **Dependencies**:
  - Web browser to access RAW Labs and Salesforce.
  - Internet connectivity.

### Setup Instructions

1. **Configure Salesforce Credentials in RAW Labs**:
   - Follow the instructions in the [RAW Labs Salesforce Data Source documentation](https://docs.raw-labs.com/sql/data-sources/salesforce) to set up your Salesforce credentials.

2. **Clone the Repository**:
   - Clone this repository into your RAW Labs workspace.

3. **Explore and Customize SQL Files**:
   - Review the provided `.sql` files.
   - Customize the queries to suit your data needs.

4. **Create APIs in RAW Labs**:
   - Use RAW Labs to publish the SQL queries as APIs.
   - Refer to the [Building APIs documentation](https://docs.raw-labs.com/docs/building-api-in-raw/) for guidance.

5. **Test Your APIs**:
   - Use RAW Labs' testing tools or tools like Postman to test your APIs.

## Domain Entities

### Entities Overview


The template focuses on key Salesforce entities:

- **Account**: Represents an individual customer account, organization, or partner involved with your business.
- **Contact**: An individual associated with an Account.
- **Opportunity**: A potential sales deal that you want to track.
- **Task**: Represents a to-do item or action that needs to be completed, associated with accounts or opportunities.
- **Event**: Scheduled meetings or events for accounts or opportunities.
- **File**: Documents or files attached to accounts or products.
- **Business_Case**: Custom object representing a business case (specific to your organization).
- **Business_Case_Expert**: Custom object representing experts associated with a business case.
- **Lead**: Prospective customers or sales opportunities.
- **Product**: Items or services that your company sells.
- **Contract**: Agreements between your company and an Account.
- **User**: Individuals who have access to your Salesforce organization.

### Entity Relationships

![Class Diagram of Logical Entities Exposed by the API Layer](salesforce.png)

*Alt text: Class diagram showing relationships between Account, Contact, Opportunity, and Task entities.*

## Query Structure

### Basic Structure of SQL Files

Each SQL file contains a query that retrieves data from Salesforce. The queries are written in standard SQL and are designed for flexibility, supporting dynamic filtering and pagination.

- **Parameters**: Defined at the top of each file using comments.
- **Filters**: Applied in the `WHERE` clause based on parameters.
- **Pagination**: Implemented using `LIMIT` and `OFFSET`.

### Types of Queries

#### Basic & Hierarchical Queries

These queries retrieve data from a single table or joined tables with potential parent-child relationships. They support dynamic filtering and pagination.

**Example:**

```sql
-- Retrieves Salesforce accounts with various filters
SELECT *
FROM salesforce.salesforce_account
WHERE (name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)
  AND (industry ILIKE ANY (string_to_array(:account_industry, ',')) OR :account_industry IS NULL)
  -- Additional filters...
ORDER BY id
LIMIT COALESCE(:page_size, 25) OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
```

#### Summary Queries

These queries aggregate data using functions like `SUM`, `COUNT`, `AVG`, etc.

**Example:**

```sql
-- Summarizes tasks grouped by a specified field
SELECT
    CASE
        WHEN :group_by_field = 'task_status' THEN task_status
        WHEN :group_by_field = 'task_priority' THEN task_priority
        WHEN :group_by_field = 'task_subtype' THEN task_subtype
        ELSE 'All'
    END AS group_by_value,
    COUNT(task_id) AS total_tasks,
    COUNT(CASE WHEN task_is_closed = true THEN 1 END) AS closed_tasks,
    COUNT(CASE WHEN task_is_high_priority = true THEN 1 END) AS high_priority_tasks
FROM base_summary
GROUP BY group_by_value
ORDER BY group_by_value;
```

## Filters and Pagination

### Filters

The template supports various types of filters for flexible querying:

| Filter Type                               | Description                                                         | Example                                                         |
|-------------------------------------------|---------------------------------------------------------------------|-----------------------------------------------------------------|
| **Basic Equality Filters**                | Checks if a column's value equals the specified parameter or is NULL | `AND (is_deleted = :account_is_deleted OR :account_is_deleted IS NULL)` |
| **Substring Search**                      | Searches for a substring within a column                            | `AND (name ILIKE CONCAT('%', :account_name, '%') OR :account_name IS NULL)` |
| **Equality Search with Comma-Separated List** | Matches any value from a comma-separated list                       | `AND (industry ILIKE ANY (string_to_array(:account_industry, ',')) OR :account_industry IS NULL)` |
| **Date Comparison**                       | Compares date columns with specified date ranges                    | `AND (created_date >= :account_created_date_range_start OR :account_created_date_range_start IS NULL)` |

### Pagination

The queries support pagination through `LIMIT` and `OFFSET`.

- **Parameters**:
  - `:page` (integer): The current page number (default is 1).
  - `:page_size` (integer): The number of records per page (default is 25).

**Example:**

```sql
LIMIT COALESCE(:page_size, 25)
OFFSET (COALESCE(:page, 1) - 1) * COALESCE(:page_size, 25);
```

## Customization

Salesforce schemas can vary significantly between organizations. This template is designed to be adaptable:

- **Modify SQL Queries**: Adjust the provided SQL queries to include additional fields or entities specific to your Salesforce instance.
- **Add New Endpoints**: Create new SQL files to define additional API endpoints as needed.

## Contributing

We welcome contributions!

- **Reporting Issues**:
  - Submit issues via [GitHub Issues](https://github.com/raw-labs/raw-salesforce-api/issues).

- **Contributing Code**:
  1. Fork the repository.
  2. Create a feature branch: `git checkout -b feature/YourFeature`.
  3. Commit your changes: `git commit -m 'Add YourFeature'`.
  4. Push to the branch: `git push origin feature/YourFeature`.
  5. Open a Pull Request with a detailed description of your changes.

- **Code Guidelines**:
  - Follow the [RAW Labs Coding Standards](https://docs.raw-labs.com/coding-standards).
  - Write clear commit messages.
  - Include documentation for new features.

## Support and Troubleshooting

- **Documentation**:
  - Refer to the [RAW Labs Documentation](https://docs.raw-labs.com/docs/) for detailed guides.
    - [Using Data Sources](https://docs.raw-labs.com/docs/sql/data-sources/overview)
    - [Salesforce Data Source](https://docs.raw-labs.com/sql/data-sources/salesforce)
    - [Creating APIs with RAW Labs](https://docs.raw-labs.com/docs/publishing-api/overview)

- **Community Forum**:
  - Join the discussion on our [Community Forum](https://www.raw-labs.com/community).

- **Contact Support**:
  - Email us at [support@raw-labs.com](mailto:support@raw-labs.com) for assistance.

## License

This project is licensed under the **Apache License 2.0**. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- **Contributors**: Thanks to all our contributors for their efforts.
- **Third-Party Libraries**: This template utilizes Salesforce APIs in compliance with their [API Terms of Use](https://developer.salesforce.com/files/tos/Developerforce_TOU_20101119.pdf).

## Contact

- **Email**: [support@raw-labs.com](mailto:support@raw-labs.com)
- **Website**: [https://raw-labs.com](https://raw-labs.com)
- **Twitter**: [@RAWLabs](https://twitter.com/raw_labs)
- **Community Forum**: [Forum](https://www.raw-labs.com/community)

---

## Additional Resources

- **RAW Labs Documentation**: Comprehensive guides and references are available at [docs.raw-labs.com](https://docs.raw-labs.com/).
- **Salesforce Data Source**: Detailed instructions on connecting Salesforce with RAW Labs can be found [here](https://docs.raw-labs.com/sql/data-sources/salesforce).
- **Publishing APIs**: Learn how to publish your SQL queries as APIs [here](https://docs.raw-labs.com/docs/building-api-in-raw/).
- **Snapi Language**: Explore RAW Labs' custom language for data manipulation [here](https://docs.raw-labs.com/snapi/overview).
- **SQL Language**: Explore RAW Labs' SQL language for data manipulation [here](https://docs.raw-labs.com/sql/overview).

