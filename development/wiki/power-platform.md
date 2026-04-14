# Power Platform & Dynamics 365

A reference for Power Automate filter queries, Power Platform development, and the Level Up productivity extension for Dynamics 365.

## Power Automate — OData Filter Queries

OData filter queries let you filter data retrieved by Power Automate connectors (List rows, Get items, etc.). These are the most commonly needed filter patterns for Dataverse, SharePoint, and other connectors.

**Basic syntax:**
```
column eq 'value'
column ne 'value'
column gt 123
column lt 123
column ge 123
column le 123
```

**Logical operators:**
```
(status eq 'active') and (amount gt 1000)
(type eq 'A') or (type eq 'B')
not (status eq 'inactive')
```

**String operations:**
```
startswith(name, 'Smith')
endswith(email, '@company.com')
contains(description, 'urgent')
```

**Date filtering:**
```
createdon ge '2024-01-01T00:00:00Z'
modifiedon le '2024-12-31T23:59:59Z'
```

**Null checks:**
```
field eq null
field ne null
```

**Lookup columns (Dataverse):**
```
_ownerid_value eq 'user-guid-here'
```

See `development/raw/Every Power Automate (MS Flow) Filter Query You Ever Wanted To Know...md` for the comprehensive reference.

---

## Level Up for Dynamics 365 — God Mode

[Level Up for Dynamics 365](https://chrome.google.com/webstore/detail/level-up-for-dynamics-365/bjnkkhimoaclnddigpphpgkfgeggokam) is a Chrome extension for working with Power Platform model-driven apps.

**God Mode** capabilities:
- Makes all mandatory fields **optional**
- Makes **hidden fields/tabs/sections visible**
- Makes **read-only fields editable**

### Does God Mode Break Security?

**No.** It runs entirely client-side — it does not call the API with elevated privileges.

| What God Mode CAN do | What God Mode CANNOT do |
|---|---|
| See hidden form attributes | See records outside your security role |
| Update read-only form attributes | Read fields protected by Field Level Security |
| Anything a browser DevTools console can do | Bypass server-side plugin validation |
| | Skip auditing (edits are still tracked) |

### Running God Mode via DevTools (No Extension Required)

Open Chrome DevTools (F12) → Console → run:
```js
// Equivalent to God Mode — makes hidden fields visible, read-only fields editable
Xrm.Page.ui.tabs.forEach(t => t.setVisible(true));
Xrm.Page.ui.tabs.forEach(t => 
  t.sections.forEach(s => s.setVisible(true))
);
Xrm.Page.getAttribute().forEach(a => {
  a.controls.forEach(c => c.setDisabled(false));
});
```

### Security Considerations
- Use God Mode only in development/testing — not as a workaround for production data integrity
- Edits made via God Mode are still audited in the Dynamics 365 audit log
- Does not bypass server-side plugins or business rules

---

## Sources
- `development/raw/Every Power Automate (MS Flow) Filter Query You Ever Wanted To Know As A Functional Consultant.md`
- `development/raw/Level Up God Mode.md`

## Related
- [[optimizely-cms]] — CMS platform development (separate from Power Platform)
- [[INDEX]] — Development wiki home
