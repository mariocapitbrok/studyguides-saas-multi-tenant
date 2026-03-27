# Additional Resources

Use these resource categories to deepen the guide and support exam preparation with vendor-neutral and platform-specific references.

## Recommended Resource Types

### SaaS Architecture References

Look for:

- cloud provider SaaS reference architectures
- control plane and data plane design guidance
- tenancy isolation strategy papers

These help you compare pooled, partitioned, and dedicated models under realistic operating constraints.

### Database And Isolation References

Prioritize material on:

- row-level security
- tenant-aware indexing
- partitioning strategies
- schema migration patterns
- backup and tenant-level restore considerations

### Identity And Access References

Study:

- SSO and federation basics
- SCIM provisioning flows
- role-based and policy-based access control
- service-to-service trust boundaries

### Platform Operations References

Useful topics include:

- tenant-aware observability
- rate limiting and fairness
- workload isolation
- incident response for shared platforms
- resilience and disaster recovery

### Business And Product References

Strong certification answers often link technical design to product constraints.

Review material on:

- SaaS pricing models
- feature entitlements
- usage metering
- enterprise onboarding
- FinOps and cost attribution

## How To Use These Resources

Do not read passively. For each resource, extract:

- the problem it is trying to solve
- the tradeoffs it introduces
- when the pattern breaks down
- what assumptions it makes about scale or compliance

## Self-Study Exercises

1. Compare three isolation models for a startup SaaS product serving many small tenants.
2. Redesign the same product for regulated enterprise tenants with strict residency needs.
3. Create a migration plan from pooled tenancy to hybrid isolation without customer downtime.
