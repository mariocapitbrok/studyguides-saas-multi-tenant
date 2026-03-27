# Best Practices

These are the patterns that distinguish a production-grade SaaS platform from a fragile demo implementation.

## 1. Enforce Tenant Scope At Boundaries

Do not rely on developers remembering to add filters manually in every query.

Safer patterns include:

- middleware that establishes tenant context
- repositories or data access layers that require tenant scope
- row-level security where appropriate
- policy checks before business operations

Weak pattern:

- passing `tenantId` around as an optional argument everywhere

## 2. Design For Least Privilege

Keep these roles separate:

- platform operator
- tenant administrator
- tenant member
- support engineer
- automation service

Do not give support or internal tools unrestricted cross-tenant access by default. Use auditable, time-bound, purpose-specific access paths.

## 3. Separate Operational Concerns By Tenant

Strong multi-tenant operations usually include:

- tenant-aware logging
- per-tenant rate limits
- per-tenant quota controls
- tenant-specific incident diagnostics
- tenant-level maintenance or isolation options

Without this, support teams either lack visibility or gain unsafe blanket access.

## 4. Build For Noisy-Neighbor Resistance

Shared systems fail when one tenant's behavior dominates common resources.

Useful controls:

- concurrency limits
- queue partitioning
- rate limiting
- workload prioritization
- per-tenant compute or storage caps
- dedicated tiers for heavyweight tenants

## 5. Treat Migrations As Tenant-Sensitive Operations

Schema changes, backfills, and plan migrations should be designed to avoid:

- cross-tenant corruption
- uneven rollout behavior
- long-running locks on shared tables
- support confusion during partial rollout

Good practice:

- progressive rollout
- backfill observability
- safe rollback strategy
- tenant cohorting by risk or tier

## 6. Make Observability And Auditing First-Class

You should be able to reconstruct:

- who accessed what
- under which tenant context
- what changed
- which system component performed the action

This is necessary for:

- security investigation
- customer support
- compliance evidence
- usage disputes

## 7. Plan For Enterprise Requirements Early

Even if the first release is lightweight, the architecture should not block:

- SSO and external identity providers
- SCIM provisioning
- audit exports
- data retention policies
- regional tenancy
- customer-managed encryption controls

## 8. Design Admin Tooling Carefully

Internal tooling is a common leak point.

Admin interfaces should:

- make tenant context explicit
- show when impersonation is active
- record all privileged actions
- restrict bulk exports
- require stronger controls for cross-tenant operations

## 9. Prefer Hybrid Evolution Over Premature Isolation

You do not need the most expensive isolation model on day one. You do need a path to stronger isolation later.

Good design principle:

- start pooled where it is safe
- isolate premium or regulated workloads when justified
- keep migration pathways operationally feasible

## Review Questions

1. Why is internal admin tooling often one of the highest-risk components?
2. Which controls actually reduce noisy-neighbor incidents?
3. Why is least privilege harder in multi-tenant systems than in single-tenant apps?
4. What signals indicate a tenant should move to stronger isolation?
