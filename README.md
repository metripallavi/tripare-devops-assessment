# Terraform + Database Reliability

## Project Information

## Project Information

**Repository:** https://github.com/metripallavi/tripare-devops-assessment


**Technology Stack**

-   Terraform
-   AWS
-   Docker Compose
-   PostgreSQL
-   GitHub Actions
-   Bash Shell Scripting

------------------------------------------------------------------------

# Overview

This repository contains a production-oriented solution for the Tripare
Terraform + Database Reliability assessment.

The project demonstrates Infrastructure as Code (IaC) using Terraform
together with database reliability practices including Docker Compose,
PostgreSQL schema migrations, seed data generation, query optimization,
backup and restore automation, and Continuous Integration (CI).

AWS deployment is intentionally not performed, as required by the
assessment. The Terraform configuration is designed and validated
locally, while the database components are fully runnable using Docker
Compose.

------------------------------------------------------------------------

# Features

-   Modular Terraform architecture
-   Separate Development and Production environments
-   AWS VPC, ALB, ECS/Fargate and private RDS design
-   PostgreSQL running locally with Docker Compose
-   SQL migration scripts
-   Seed data generation
-   Query optimization using indexes
-   Automated backup and restore scripts
-   GitHub Actions CI workflow

------------------------------------------------------------------------

# Solution Architecture

``` text
                    Internet
                        │
                        ▼
         Application Load Balancer (ALB)
                        │
                        ▼
              Amazon ECS / Fargate
                        │
                        ▼
             Amazon RDS PostgreSQL
                (Private Subnets)

             Amazon Virtual Private Cloud

┌──────────────────────────────────────────────┐
│ Public Subnets                               │
│   • Application Load Balancer                │
│                                              │
│ Private Subnets                              │
│   • ECS/Fargate Tasks                        │
│   • PostgreSQL RDS                           │
└──────────────────────────────────────────────┘
```

------------------------------------------------------------------------

# Repository Structure

``` text
tripare-devops-assessment/
├── .github/workflows/
├── infra/
│   ├── modules/
│   │   ├── network/
│   │   ├── ecs/
│   │   └── rds/
│   └── envs/
│       ├── dev/
│       └── prod/
├── database/
│   ├── migrations/
│   ├── seeds/
│   ├── indexes/
│   └── backups/
├── scripts/
│   ├── backup.sh
│   └── restore.sh
├── docker-compose.yml
└── README.md
```

------------------------------------------------------------------------

# Implemented Components

  Component                    Status
  ---------------------------- ----------
  Terraform Infrastructure     Complete
  Modular Terraform            Complete
  Dev & Prod Environments      Complete
  Docker Compose               Complete
  PostgreSQL                   Complete
  SQL Migrations               Complete
  Seed Data                    Complete
  Database Indexing            Complete
  Backup & Restore             Complete
  GitHub Actions CI            Complete
  Setup & Verification Guide   Complete

------------------------------------------------------------------------

# Terraform Infrastructure

Infrastructure is organized into reusable modules:

-   network
-   ecs
-   rds

Resources include:

-   VPC
-   Public Subnets
-   Private Subnets
-   Application Load Balancer
-   ALB Security Group
-   ECS Security Group
-   RDS Security Group
-   ECS Cluster
-   ECS Task Definition
-   ECS Service
-   Private PostgreSQL RDS

Two environments are included:

-   **dev** -- smaller resources, shorter backup retention, deletion
    protection disabled.
-   **prod** -- larger resources, longer backup retention, deletion
    protection enabled.

## Terraform Commands

Development

``` bash
cd infra/envs/dev
terraform fmt
terraform init
terraform validate
terraform plan -refresh=false
```

Production

``` bash
cd infra/envs/prod
terraform fmt
terraform init
terraform validate
terraform plan -refresh=false
```

------------------------------------------------------------------------

# Continuous Integration

GitHub Actions workflow:

    .github/workflows/terraform.yml

The workflow automatically performs:

-   terraform fmt
-   terraform init
-   terraform validate

When AWS credentials are configured using GitHub Secrets, it
additionally executes:

-   terraform plan -refresh=false

If credentials are unavailable, the workflow skips the plan step and
prints an informational message while allowing the remaining validation
steps to succeed.

------------------------------------------------------------------------

# Prerequisites

-   Terraform \>= 1.5
-   Docker
-   Docker Compose
-   Git

------------------------------------------------------------------------

# Local Database Setup

Start PostgreSQL:

``` bash
docker compose up -d
```

Verify:

``` bash
docker ps
```

------------------------------------------------------------------------

# Database Migration

``` bash
docker exec -i hotel-postgres \
psql -U postgres -d hoteldb \
< database/migrations/001_create_tables.sql
```

------------------------------------------------------------------------

# Seed Data

``` bash
docker exec -i hotel-postgres \
psql -U postgres -d hoteldb \
< database/seeds/seed.sql
```

Seeded data includes:

-   100 hotel bookings
-   5 organizations
-   5 cities
-   4 booking statuses
-   51 booking events

------------------------------------------------------------------------

# Query Optimization

Target query:

``` sql
SELECT org_id, status, COUNT(*), SUM(amount)
FROM hotel_bookings
WHERE city = 'delhi'
  AND created_at >= NOW() - INTERVAL '30 days'
GROUP BY org_id, status;
```

Indexes:

``` sql
CREATE INDEX idx_hotel_bookings_city_created_at
ON hotel_bookings(city, created_at);

CREATE INDEX idx_hotel_bookings_org_status
ON hotel_bookings(org_id, status);
```

## Index Selection

The assessment requires adding indexes and explaining their purpose.

  -------------------------------------------------------------------------------
  Index                                Purpose
  ------------------------------------ ------------------------------------------
  idx_hotel_bookings_city_created_at   Speeds up filtering by `city` and
                                       `created_at`, reducing scanned rows.

  idx_hotel_bookings_org_status        Improves grouping by `org_id` and `status`
                                       during aggregation.
  -------------------------------------------------------------------------------

Together, these indexes reduce unnecessary table scans and improve
execution time for the reporting query.

------------------------------------------------------------------------

# Backup

Create a timestamped backup:

``` bash
./scripts/backup.sh
```

Backups are stored in:

    database/backups/

------------------------------------------------------------------------

# Restore

Restore from a backup:

``` bash
./scripts/restore.sh database/backups/<backup-file>.sql
```

------------------------------------------------------------------------

# Restore Verification

Verify the restore completed successfully.

Tables:

``` sql
\dt
```

Verify row counts:

``` sql
SELECT COUNT(*) FROM hotel_bookings;
SELECT COUNT(*) FROM booking_events;
```

Expected:

-   hotel_bookings = 100
-   booking_events = 51

Verify indexes:

``` sql
\d hotel_bookings
```

Expected indexes:

-   hotel_bookings_pkey
-   idx_hotel_bookings_city_created_at
-   idx_hotel_bookings_org_status

------------------------------------------------------------------------

# Setup & Verification

1.  Clone the repository.
2.  Start PostgreSQL.

``` bash
docker compose up -d
```

3.  Execute migration.

``` bash
docker exec -i hotel-postgres \
psql -U postgres -d hoteldb \
< database/migrations/001_create_tables.sql
```

4.  Seed the database.

``` bash
docker exec -i hotel-postgres \
psql -U postgres -d hoteldb \
< database/seeds/seed.sql
```

5.  Apply indexes.

``` bash
docker exec -i hotel-postgres \
psql -U postgres -d hoteldb \
< database/indexes/indexes.sql
```

6.  Verify data.

``` sql
SELECT COUNT(*) FROM hotel_bookings;
SELECT COUNT(*) FROM booking_events;
SELECT city, COUNT(*) FROM hotel_bookings GROUP BY city;
SELECT status, COUNT(*) FROM hotel_bookings GROUP BY status;
```

7.  Create a backup.

``` bash
./scripts/backup.sh
```

8.  Restore.

``` bash
./scripts/restore.sh database/backups/<backup-file>.sql
```

9.  Run the verification queries above.

------------------------------------------------------------------------

# Submission Summary

This repository includes:

-   Terraform infrastructure
-   Modular design
-   Development and Production environments
-   Docker Compose PostgreSQL
-   SQL migrations
-   Seed data
-   Query optimization with indexes
-   Backup script
-   Restore script
-   GitHub Actions workflow
-   Complete setup and verification documentation

------------------------------------------------------------------------

# License

This project is licensed under the MIT License.

------------------------------------------------------------------------

# Author

---

# Author

**Pallavi Metri**

- GitHub Profile: https://github.com/metripallavi
- Project Repository: https://github.com/metripallavi/tripare-devops-assessment
