# Introduction

This guide is organized for certification-style preparation: scenario questions, architecture tradeoffs, and operational reasoning. Treat multi-tenancy as both a product strategy and a systems design problem.

## What You Need To Understand First

At a high level, SaaS means delivering software as an ongoing service rather than as a one-time installed product. Multi-tenancy means multiple customers share some part of the same application platform while still expecting isolation, security, and predictable service quality.

The exam-level challenge is not memorizing definitions. It is being able to answer questions like:

- When should a platform use shared infrastructure versus dedicated environments?
- How do you prevent one tenant from reading another tenant's data?
- How do pricing plans, enterprise requirements, and compliance rules change the architecture?
- What breaks first when a few large tenants dominate system load?

## Core Terms

### SaaS

Software delivered as a managed service with centralized operations, continuous updates, and recurring subscription or usage-based pricing.

### Tenant

A logical customer boundary inside the platform. A tenant can represent a company, workspace, department, partner, or organization depending on the product model.

### Multi-tenant

A system where multiple tenants share some combination of application runtime, infrastructure, storage, or operational tooling while preserving isolation.

### Single-tenant

A system where each customer gets dedicated application or data resources. This often simplifies isolation but increases operational and cost overhead.

### Workspace vs Account vs Organization

Certification scenarios often mix these terms. The important question is not the label but the boundary:

- Who owns the data?
- Who manages users and permissions?
- What unit maps to billing and entitlements?
- What unit maps to isolation and support operations?

## Why Multi-tenancy Exists

Multi-tenancy is usually chosen to improve one or more of the following:

- lower cost per customer
- faster onboarding
- centralized upgrades
- simpler platform operations
- easier analytics and fleet-wide observability
- faster experimentation and product rollout

Those benefits come with real risks:

- cross-tenant data exposure
- noisy-neighbor performance problems
- more complex access-control design
- harder debugging and support isolation
- migration complexity when tenants outgrow shared resources

## Common Tenancy Models

### Shared Everything

All tenants share application instances and data stores, usually separated logically by tenant identifiers and policy enforcement.

Best when:

- cost efficiency matters most
- tenants have similar compliance requirements
- product onboarding must be fast

Main risks:

- data isolation bugs
- query mistakes
- hotspots in shared infrastructure

### Shared App, Segmented Data

Tenants share application services but get stronger data separation, such as schema-per-tenant or database-per-tenant.

Best when:

- stronger isolation is needed
- operational cost still matters
- some larger tenants need more control

### Dedicated Tenant Environments

Each tenant gets separate infrastructure or deployment units.

Best when:

- strict compliance or custom networking is required
- tenants demand dedicated performance and maintenance windows
- contractual isolation is part of the product

Main drawback:

- much higher operational complexity

## Certification Lens

Expect scenario questions to force tradeoffs, for example:

- A startup wants low cost and fast onboarding.
  Likely answer direction: shared platform with strong tenant scoping and observability.
- A regulated enterprise customer needs dedicated keys, audit evidence, and data residency.
  Likely answer direction: hybrid or dedicated isolation model.
- A few large customers cause platform-wide degradation.
  Likely answer direction: workload isolation, quotas, partitions, or premium dedicated resources.

## What Good Answers Usually Include

Strong certification answers usually mention:

- tenant identity resolution
- authorization boundaries
- data partitioning strategy
- observability and auditability
- billing and entitlement implications
- migration path when the initial design no longer fits

## Review Questions

1. What is the difference between customer identity, tenant identity, and user identity?
2. Why can a product be SaaS without being strongly multi-tenant?
3. What business drivers usually push teams toward multi-tenancy?
4. Why is "tenant_id on every row" not a complete isolation strategy by itself?
