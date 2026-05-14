---
type: concept
domains: [work]
status: evolving
source-confidence: high
updated: 2026-05-14
---

# Power Platform (D365 & Power Automate)

Reference for Microsoft Dynamics 365 and Power Automate development.

## Power Automate — OData Filter Queries

Filter syntax: `fieldname operator fieldvalue`

| Operator | Meaning |
|----------|---------|
| `eq` | Equal to |
| `ne` | Not equal to |
| `gt` / `lt` | Greater than / less than |
| `ge` / `le` | Greater than or equal / less than or equal |
| `contains(field,'value')` | Contains — note reversed operand order |
| `not contains(field,'value')` | Does not contain |

> `contains` and `not contains` use function syntax, not infix: `contains(fieldname,'value')`

### Two Filter Types in Flows

1. **ODATA filter query** — server-side filtering applied in connector actions (e.g., "Get items" from SharePoint/Dataverse). Reduces data returned before it reaches the flow.
2. **Filter array** — client-side filtering on a collection already in memory. Useful when OData filtering isn't supported by the connector.

### Common Pattern
```
Field Name   Operator   Value
status       eq         1
name         contains   "Acme"
createdon    gt         2024-01-01T00:00:00Z
```

→ Source: [Every Power Automate (MS Flow) Filter Query You Ever Wanted To Know](/raw/Every%20Power%20Automate%20%28MS%20Flow%29%20Filter%20Query%20You%20Ever%20Wanted%20To%20Know%20As%20A%20Functional%20Consultant%20%E2%80%93%20....md)

---

## Dynamics 365 — Level Up Extension

**[Level Up for Dynamics 365](https://chrome.google.com/webstore/detail/level-up-for-dynamics-365/bjnkkhimoaclnddigpphpgkfgeggokam)** — Chrome extension for Power Platform / model-driven app productivity.

### God Mode

Makes required fields optional, reveals hidden fields/tabs/sections, and makes read-only fields editable — all **client-side only**.

**Security implications (what God Mode does NOT do):**
- Does not bypass server-side security roles
- Does not bypass field-level security profiles
- Does not bypass server-side plugins or pre-validation
- Does not skip auditing — changes are still tracked
- Does not grant access to records beyond your security role

**Equivalent without the extension (F12 → Console):**
```js
Xrm.Page.data.entity.attributes.forEach(attr => attr.setRequiredLevel('none'));

Xrm.Page.ui.controls.forEach(c => {
    c.setVisible(true);
    if (c.setDisabled) c.setDisabled(false);
    if (c.clearNotification) c.clearNotification();
});
```

→ Source: [Level Up God Mode](/raw/Level%20Up%20God%20Mode.md)
