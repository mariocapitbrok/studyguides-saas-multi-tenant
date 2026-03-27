# Syntax Cheat Sheet

This topic is architecture-focused, but there are a few recurring implementation patterns worth recognizing.

## Tenant-Aware Request Context

```text
request -> authenticate principal
        -> resolve tenant membership
        -> validate tenant access
        -> attach tenant context
        -> execute tenant-scoped business logic
```

## Safe Query Shape

```sql
SELECT *
FROM invoices
WHERE tenant_id = :tenant_id
  AND status = 'open';
```

Certification note:
The key lesson is not SQL syntax. It is that tenant scoping must be mandatory, not optional.

## Cache Key Pattern

```text
tenant:{tenant_id}:dashboard:{resource_id}
tenant:{tenant_id}:settings
tenant:{tenant_id}:report:{report_id}
```

If `tenant_id` is missing from cache keys, cross-tenant leaks become likely.

## Event Payload Pattern

```json
{
  "event_id": "evt_123",
  "tenant_id": "tenant_456",
  "actor_id": "user_789",
  "event_type": "subscription.upgraded",
  "occurred_at": "2026-03-27T00:00:00Z"
}
```

Key rule:
async systems must propagate tenant identity explicitly.

## Quota Enforcement Pattern

```text
if tenant_usage >= tenant_plan_limit:
    reject_or_throttle()
else:
    process_request()
```

In production, this usually requires:

- atomic counters or reconciled metering
- idempotent usage events
- clear distinction between soft and hard limits

## Row-Level Security Pattern

```text
allow access only when row.tenant_id == current_session.tenant_id
```

This is powerful, but it does not replace secure auth, cache scoping, and admin-tool controls.
