# Troubleshooting

Certification questions often describe a symptom and expect you to identify the likely design failure. This section focuses on those failure patterns.

## 1. Cross-Tenant Data Exposure

### Common Causes

- missing tenant filter in a query
- cache keys that omit tenant context
- object storage paths not segmented per tenant
- admin tooling bypassing policy checks
- search indexes shared without tenant scoping

### What To Check

- request logs with tenant and user context
- ORM or query builder filters
- row-level security or policy enforcement
- cache key format
- background job payloads and replays

### Typical Fix

Move tenant enforcement closer to system boundaries and reduce reliance on developer discipline.

## 2. Wrong Tenant Resolved At Login Or Request Time

### Common Causes

- multiple memberships with ambiguous default tenant selection
- stale session context
- subdomain mismatch
- untrusted client header used as tenant selector

### Typical Fix

Require explicit tenant selection when needed, bind tenant context to authenticated membership, and validate it at the gateway or auth layer.

## 3. Noisy-Neighbor Performance Incidents

### Symptoms

- one tenant creates spikes for everyone
- queue backlog grows but only for certain workloads
- a few reports or exports saturate shared infrastructure

### Root Causes

- shared worker pools with no fairness
- hot partitions in pooled databases
- expensive tenant-specific queries
- missing quotas or concurrency controls

### Fix Direction

- rate limiting
- queue partitioning
- workload isolation
- tier-based resource assignment
- targeted indexing or data partitioning

## 4. Provisioning Drift

This happens when one system thinks the tenant exists and another does not.

Examples:

- tenant created in the app but not in billing
- billing upgraded but entitlements not updated
- SSO enabled but role mapping missing
- schema created but seed roles absent

### Fix Direction

Use idempotent workflows with explicit state transitions and compensating actions rather than one-shot scripts.

## 5. Billing And Metering Mismatches

### Typical Causes

- duplicate usage events
- retries counted as new billable activity
- stale plan configuration
- delayed event processing
- feature gates not aligned with billing state

### Fix Direction

Implement idempotency keys, reconciliation processes, and auditable event ledgers.

## 6. Authorization Gaps

### High-Risk Cases

- platform admins acting as tenant admins without audit logs
- support agents using hidden impersonation
- service accounts with broad read access across all tenants

### Fix Direction

Separate roles clearly and make privileged access explicit, time-bound, and audited.

## 7. Backup, Restore, And Recovery Problems

Multi-tenant recovery is harder than standard backup strategy.

Common issue:

You can restore the full database but not a single tenant cleanly.

This matters on exams because it exposes a tradeoff:

- pooled storage is cost-efficient
- tenant-granular recovery is harder

### Fix Direction

Choose storage boundaries and backup patterns that match required recovery granularity.

## 8. Region And Residency Issues

### Symptoms

- tenant data stored in the wrong region
- analytics pipelines export data across boundaries
- backups violate residency expectations

### Fix Direction

Treat region assignment and residency as enforceable tenant metadata, not documentation-only intent.

## Scenario Practice

1. A premium customer reports seeing another customer's cached dashboard data.
   Likely issue: cache keys missing tenant scoping or shared edge caching rules.
2. A support engineer can inspect all tenant exports without approval.
   Likely issue: admin tooling violates least-privilege and audit requirements.
3. Billing says a tenant exceeded API quotas, but logs show duplicate retry traffic.
   Likely issue: metering logic is not idempotent.

## Review Questions

1. Why are cache layers a common cross-tenant leak source?
2. What makes tenant restore harder in pooled database models?
3. How does provisioning drift happen even when each individual service is working correctly?
4. Why should tenant region assignment be machine-enforced rather than manually tracked?
