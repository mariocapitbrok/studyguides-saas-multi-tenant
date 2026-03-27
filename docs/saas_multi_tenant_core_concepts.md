# Core Concepts

This is the center of the guide. Most certification questions will be derived from these concepts and their tradeoffs.

## 1. Isolation Models

### Shared Database, Shared Schema

All tenants share the same tables, usually partitioned with a `tenant_id`.

Advantages:

- cheapest to operate
- simplest onboarding
- easy to roll out schema changes

Risks:

- query bugs can expose cross-tenant data
- large tenants can distort indexing and performance
- backup and restore at tenant granularity is harder

### Shared Database, Separate Schemas

Tenants share database infrastructure but get distinct schemas.

Advantages:

- stronger logical separation
- easier tenant-specific maintenance and archival

Risks:

- operational complexity grows with tenant count
- schema migration tooling becomes more complex

### Database Per Tenant

Each tenant has a dedicated database while the app layer may remain shared.

Advantages:

- stronger isolation
- easier per-tenant backup and restore
- better fit for premium tenants or regional placement

Risks:

- fleet management overhead
- connection management complexity
- cost grows quickly

### Hybrid

Some tenants remain pooled while premium or regulated tenants get stronger isolation.

This is common in real products and frequently appears in architecture scenarios because it balances cost and enterprise requirements.

## 2. Isolation Must Exist At Multiple Layers

Many teams think only about the database. That is insufficient.

You must evaluate isolation in:

- request routing
- session handling
- authorization policies
- caches
- queues and events
- object storage paths
- search indexes
- analytics exports
- background jobs
- support tooling

An exam trick is to present a secure primary database design while hiding a leak in caches, exports, or async workers.

## 3. Tenant Context Propagation

Tenant identity must survive every hop in the system.

A safe propagation model usually includes:

- tenant context established at the edge
- authentication and membership validation
- explicit propagation through service boundaries
- tenant-scoped logging and tracing
- tenant-aware job payloads and retry handling

Avoid designs that rely on implicit global state or optional tenant parameters that developers can forget to pass.

## 4. Authorization And Scope

Multi-tenant auth is more than user roles.

You typically need to reason about:

- platform administrator
- tenant administrator
- standard tenant user
- service account
- support operator
- automation or provisioning process

Questions to answer:

- Who can switch tenant context?
- Who can impersonate users?
- Who can access tenant-wide exports?
- Which operations cross tenant boundaries?

## 5. Control Plane vs Data Plane

This distinction is foundational.

### Control Plane

Handles platform-level operations such as:

- tenant registry
- provisioning workflows
- billing plans
- feature entitlements
- region placement
- lifecycle status

### Data Plane

Handles tenant application traffic and tenant-owned data operations.

Why it matters:

- different scaling profiles
- different failure blast radii
- clearer security boundaries
- cleaner migration patterns

## 6. Configuration And Entitlements

Each tenant may have:

- enabled features
- plan limits
- branding
- region assignment
- integrations
- retention policies
- audit requirements

The challenge is keeping configuration flexible without scattering entitlement logic across the codebase.

Common good pattern:

- central entitlement service or policy layer
- explicit feature gates
- auditable plan change workflow

## 7. Provisioning And Lifecycle

Tenant provisioning is rarely just "insert one row."

It often includes:

- tenant record creation
- admin user invitation
- default role assignment
- storage or schema initialization
- billing linkage
- integration setup
- sample data or onboarding state

This should be idempotent, observable, and recoverable.

## 8. Metering, Quotas, And Billing

Certification questions often mix architecture and monetization.

You should understand:

- event-based usage metering
- storage and seat limits
- soft versus hard quotas
- feature entitlements by plan
- overage handling
- billing event correctness

Key risk:

retries or duplicate events can produce billing inaccuracies unless the system is idempotent and auditable.

## 9. Tenant-Aware Observability

The platform must answer:

- Which tenant is impacted?
- Is the problem isolated or platform-wide?
- What changed for this tenant recently?
- Is one tenant driving unusual resource consumption?

Useful patterns:

- tenant tag in logs, traces, and metrics
- tenant-level dashboards
- tenant-scoped rate and error views
- support-safe inspection tools

## 10. Migration Paths

A strong answer often includes the next-step architecture, not only the initial one.

Examples:

- pooled tenants moved to dedicated databases when they exceed load thresholds
- enterprise tenants isolated by region or compliance class
- background workloads partitioned by tenant tier

## Review Questions

1. Why is tenant isolation a cross-layer concern rather than a database-only concern?
2. When is database-per-tenant worth the cost?
3. What is the difference between control-plane metadata and tenant-owned business data?
4. Why are retries and async jobs dangerous in tenant-aware billing systems?
