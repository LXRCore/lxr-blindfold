# 🐺 LXR Blindfold — Events Reference

> **wolves.land** — The Land of Wolves | RedM Blindfold & Restraint Script

---

## ═══════════════════════════════════════════════════════
## EVENT NAMING CONVENTION
## ═══════════════════════════════════════════════════════

All events follow the namespace format:

```
lxrblindfold:<action>
```

---

## ═══════════════════════════════════════════════════════
## SERVER EVENTS
## ═══════════════════════════════════════════════════════

### `lxrblindfold:toggleblindfold`

**Direction:** Client → Server

**Parameters:**

| Parameter | Type            | Description                              |
|-----------|-----------------|------------------------------------------|
| `player`  | `number\|'self'` | Target player server ID, or `'self'`    |
| `toggle`  | `boolean`       | `true` = apply, `false` = remove         |

**Behavior:**
- Validates the source player
- Checks rate limiting
- If `Config.blindfolditem` is true and toggling on, removes one blindfold item
- Triggers the client-side toggle event on the target player

---

## ═══════════════════════════════════════════════════════
## CLIENT EVENTS
## ═══════════════════════════════════════════════════════

### `lxrblindfold:togblindfold`

**Direction:** Server → Client

**Parameters:**

| Parameter   | Type      | Description                     |
|-------------|-----------|---------------------------------|
| `playerSex` | `string`  | `'male'` or `'female'`         |
| `comps`     | `string`  | JSON-encoded clothing components|
| `toggle`    | `boolean` | `true` = apply, `false` = remove|

---

### `lxrblindfold:blindfolditem`

**Direction:** Server → Client

Triggered when a player uses the blindfold item from inventory. Finds the closest player and applies the blindfold.

---

## ═══════════════════════════════════════════════════════
## SECURITY NOTES
## ═══════════════════════════════════════════════════════

- All events are validated server-side
- Rate limiting prevents event spam
- The server never trusts client-provided data without validation
- Source player ID is always verified

---

> © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
