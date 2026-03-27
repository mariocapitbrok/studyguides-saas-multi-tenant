# Setup and Foundations

This section covers the design setup decisions that determine whether a multi-tenant platform remains manageable at scale.

## 1. Define The Tenant Model

Before selecting a database pattern or deployment model, define the business boundary precisely.

Questions to answer:

- What object is a tenant in this product?
- Can one user belong to multiple tenants?
- Can one tenant contain multiple workspaces, environments, or projects?
- Does billing attach to tenant, subscription, workspace, or organization?
- Who can administer the tenant?

If these answers are vague, the platform will accumulate authorization and billing defects quickly.

## 2. Resolve Tenant Identity Consistently

Every request and background action must be tenant-aware.

Common resolution mechanisms:

- subdomain, such as `tenant.example.com`
- URL path segment, such as `/t/acme/...`
- token claims
- signed session state
- internal service headers populated by a trusted gateway

What matters is consistency and trust boundaries. Never trust client-controlled tenant hints without validating them against the authenticated principal.

## 3. Choose An Isolation Model Early

Typical choices:

- shared app and shared database with tenant discriminator
- shared app with schema-per-tenant
- shared app with database-per-tenant
- dedicated app and data stack per tenant
- hybrid model for standard versus enterprise tenants

Selection criteria:

- compliance obligations
- expected tenant count
- data volume and workload skew
- supportability
- disaster recovery goals
- cost per tenant

## 4. Establish Identity And Access Foundations

You need clear rules for:

- authentication:
  who is the user and how are they verified?
- authorization:
  what can the user do within the tenant?
- tenant membership:
  which tenant does this user belong to right now?
- privileged operations:
  which actions belong only to platform admins?

Enterprise-oriented SaaS platforms should plan for:

- SSO
- SCIM
- role mapping
- audit trails
- break-glass admin workflows

## 5. Model Tenant Metadata

Most SaaS systems need a control-plane view of the tenant containing:

- tenant identifier
- status: trial, active, suspended, archived
- billing plan
- enabled features
- region or data residency assignment
- provisioning state
- support tier

This metadata should be authoritative, queryable, and safe to use in automation.

## 6. Prepare Environments And Delivery

Do not treat local development as an afterthought. Multi-tenancy bugs often come from environment mismatches.

You should define:

- how developers switch tenants locally
- how test data represents multiple tenants
- how staging simulates plan tiers and quotas
- how migrations are rolled out safely across all tenants
- how feature flags are tested for partial rollout

## 7. Plan For Lifecycle Events

Certification questions often center on lifecycle complexity rather than CRUD.

Be ready to design:

- tenant signup
- verification and activation
- trial-to-paid conversion
- tenant suspension
- downgrade or upgrade
- offboarding and retention windows
- deletion with compliance controls
- restore or recovery flows

## 8. Define Non-Functional Requirements

Architecture choices must map to business constraints.

Critical categories:

- latency targets
- availability targets
- tenant-level reporting and observability
- data isolation guarantees
- backup and recovery expectations
- cost ceilings
- data residency
- compliance and audit requirements

## Exam Tips

If a scenario mentions regulated customers, customer-managed keys, private networking, or residency constraints, the expected answer often shifts away from pure shared-everything designs.

If a scenario emphasizes rapid onboarding, low cost, and many small tenants, the expected answer often favors pooled infrastructure with stronger logical isolation controls.

## Review Questions

1. What is the safest place to establish tenant identity in a request flow?
2. What changes when users can belong to multiple tenants at once?
3. Why should tenant metadata be treated as control-plane data?
4. Which non-functional requirements most strongly affect isolation design?
