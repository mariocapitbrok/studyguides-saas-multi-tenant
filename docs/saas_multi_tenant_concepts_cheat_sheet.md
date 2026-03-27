# Concepts Cheat Sheet

## Core Definitions

- SaaS: Software delivered as a managed service with centralized operations and recurring value delivery
- Tenant: A customer boundary within the platform
- Multi-tenant: A design where multiple tenants share some platform resources with enforced isolation
- Single-tenant: A design where a customer gets dedicated app or data resources
- Control plane: Platform-level systems that manage tenants, plans, provisioning, and policies
- Data plane: Systems that process tenant traffic and tenant-owned application data

## Isolation Models

- Shared app + shared database: Lowest cost, highest logical-isolation risk
- Shared app + separate schemas: Better separation, more operational overhead
- Shared app + database per tenant: Stronger recovery and isolation, higher fleet complexity
- Dedicated environment per tenant: Strongest isolation, highest cost
- Hybrid: Mix of pooled and dedicated approaches based on tier or compliance needs

## Identity And Access

- Authentication answers: Who is the caller?
- Tenant resolution answers: Which tenant is active?
- Authorization answers: What can the caller do in that tenant?
- Membership answers: Does this principal belong to this tenant?
- Least privilege: Grant only the minimum required access

## High-Risk Failure Modes

- Missing tenant filter in queries
- Cache keys without tenant scope
- Search or analytics exports crossing tenant boundaries
- Background jobs that lose tenant context
- Support tooling with unrestricted cross-tenant access
- Metering systems that double-count retries

## Operational Terms

- Noisy neighbor: One tenant degrades shared resources for others
- Entitlements: Features or limits granted by plan or contract
- Provisioning: Creating and configuring tenant resources
- Offboarding: Suspending, archiving, deleting, or exporting tenant data
- Residency: Geographic constraints on where tenant data can live
- Tenant migration: Moving a tenant to a different data or infrastructure boundary

## Exam Heuristics

- If cost and speed dominate, pooled models become more attractive
- If compliance and isolation dominate, stronger separation becomes more attractive
- If tenant load is uneven, plan for quotas, partitions, or dedicated tiers
- If restore granularity matters, pooled data models become less attractive
