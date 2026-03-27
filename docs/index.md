# SaaS + Multi-tenant Study Guide

Use this index as a certification-prep roadmap. The goal is not just to recognize terms, but to reason about architecture choices, tenant isolation, risk controls, scaling strategies, and operational tradeoffs under exam conditions.

## Exam Readiness Goals

By the end of this guide, you should be able to:

- Explain when multi-tenancy is the right architectural choice and when it is not
- Compare shared, pooled, siloed, and hybrid tenant isolation models
- Design tenant-aware authentication, authorization, data access, and observability flows
- Evaluate security, compliance, and cost tradeoffs in real SaaS scenarios
- Troubleshoot common cross-tenant, provisioning, and scale failures
- Answer scenario-based questions about platform design, operations, and migration strategy

## 1. [Introduction](saas_multi_tenant_intro.md)

Master the business and platform context behind SaaS systems before diving into implementation details.

- Define SaaS, multi-tenancy, tenancy boundaries, workspaces, organizations, and subscriptions
- Understand how product packaging, pricing, onboarding, and retention shape architecture
- Distinguish B2B SaaS, internal platforms, partner portals, and marketplace-like models
- Recognize the tradeoffs between speed, cost efficiency, customization, and operational simplicity
- Know the difference between multi-instance, single-tenant, and multi-tenant systems

## 2. [Setup and Foundations](saas_multi_tenant_setup_installation.md)

This section covers the decisions that usually appear early in design interviews and certification scenarios.

- Define the tenant model:
  customer account, tenant, user, role, environment, region
- Decide whether tenant identity lives in the domain, subdomain, path, token, header, or session
- Establish the source of truth for tenant metadata, entitlements, plans, and feature flags
- Choose deployment assumptions:
  single region, multi-region, shared cluster, dedicated tenant environments
- Design onboarding, tenant provisioning, seed data, default roles, and account recovery flows
- Clarify non-functional requirements:
  uptime, latency, compliance, auditability, data residency, and cost ceilings

## 3. [Core Concepts](saas_multi_tenant_core_concepts.md)

Treat this as the main exam domain. Most certification questions will be variations of these concepts.

- Compare isolation models:
  shared database with tenant discriminator, schema-per-tenant, database-per-tenant, instance-per-tenant
- Understand isolation at each layer:
  UI, API, cache, queue, object storage, search index, analytics pipeline, and background jobs
- Design tenant-aware data access patterns:
  row-level security, scoped repositories, tenant filters, and safe query composition
- Understand control plane vs data plane responsibilities in SaaS platforms
- Model tenant lifecycle events:
  signup, activation, upgrade, suspension, offboarding, deletion, and restoration
- Handle per-tenant configuration, branding, quotas, limits, and feature access cleanly
- Design usage metering and billing events without losing correctness or auditability
- Understand tenancy in asynchronous systems:
  event payloads, correlation IDs, retries, replay safety, and idempotency

## 4. [Best Practices](saas_multi_tenant_best_practices.md)

This section is where architecture maturity shows up. Focus on defensible patterns, not slogans.

- Enforce tenant context at trust boundaries, not only inside business logic
- Design for least privilege in user roles, service-to-service auth, and admin tooling
- Separate platform administration from tenant administration
- Implement defense in depth:
  auth checks, policy checks, scoped queries, auditing, and anomaly detection
- Build per-tenant observability:
  logs, traces, metrics, SLIs, cost attribution, and support diagnostics
- Prevent noisy-neighbor effects with quotas, rate limits, workload isolation, and backpressure
- Plan schema evolution and tenant migrations without downtime or cross-tenant data leaks
- Support enterprise requirements:
  SSO, SCIM, audit exports, retention policies, and compliance evidence
- Document tenant-aware incident response, rollback, and disaster recovery procedures

## 5. [Troubleshooting](saas_multi_tenant_troubleshooting.md)

Use this section to practice the failure modes that are commonly tested in scenario questions.

- Diagnose missing tenant resolution in HTTP requests, background jobs, and scheduled tasks
- Investigate cross-tenant reads or writes caused by broken filters or shared caches
- Troubleshoot authorization gaps between tenant admins, end users, and platform operators
- Detect provisioning drift:
  tenant exists in one system but not in billing, IAM, or configuration stores
- Analyze scale issues:
  hotspot tenants, skewed workloads, lock contention, and uneven partitions
- Debug metering and billing mismatches caused by retries, duplicate events, or stale plan data
- Handle region failover, backup restore, and tenant-specific recovery safely

## 6. [Additional Resources](saas_multi_tenant_additional_resources.md)

Use this section to reinforce the material with reference architectures and vendor guidance.

- Cloud SaaS architecture whitepapers and reference blueprints
- Database isolation and row-level security documentation
- IAM, SSO, SCIM, and policy-engine references
- Reliability engineering, FinOps, and compliance material relevant to SaaS platforms
- Case studies showing migrations from single-tenant to multi-tenant platforms

---

## Suggested Exam Domains

Use these domains for self-assessment or spaced repetition:

- Domain 1: SaaS business model and tenant concepts
- Domain 2: Tenant isolation and data architecture
- Domain 3: Identity, access control, and security
- Domain 4: Provisioning, lifecycle, and configuration management
- Domain 5: Scalability, performance, and noisy-neighbor control
- Domain 6: Billing, metering, and plan enforcement
- Domain 7: Observability, supportability, and tenant-aware operations
- Domain 8: Compliance, resilience, and disaster recovery

## Certification Prep Checklist

Before you consider yourself ready, make sure you can:

- Justify a tenancy model for at least three different product scenarios
- Explain how to guarantee tenant scoping from request entry to data persistence
- Compare database-per-tenant and shared-database designs beyond cost alone
- Describe how billing, quotas, and entitlements interact with product behavior
- Design logging and support workflows that help investigate one tenant without exposing another
- Identify the biggest risks in tenant migration, enterprise onboarding, and cross-region expansion

## Cheat Sheets

- [SaaS + Multi-tenant Concepts Cheat Sheet](saas_multi_tenant_concepts_cheat_sheet.md)
- [SaaS + Multi-tenant Syntax Cheat Sheet](saas_multi_tenant_syntax_cheat_sheet.md)
