# solo-health

The Health cell: its own API (Railway, serverless) and its own Neon
database, made from `cell.yaml` with [solo-cell-kit](../solo-cell-kit). It
reuses empire-platform for identity, authorization, executions and audit over
HTTP with the caller's token.

| | |
|---|---|
| API | Railway project `solo-health`, service `health-api` (Serverless) |
| Data | Neon project `solo-health`, database `health` |
| Registry | solo-empire `repository-catalog/registries/online-systems.yaml` (`health`) |

## API

Every resource has list, stats, get, get-by-legacy-id, create, patch and delete
(see `cellkit/app.py`). Permissions are `health.<resource>:read|write|delete`.

| Path | Resource | Filters |
|---|---|---|
| `/v1/health-metrics` | health-metric | — |

## Develop and operate

```bash
uv venv .venv && uv pip install --python .venv/bin/python -e ".[dev]"
.venv/bin/pytest -q
NEON_API_KEY=... .venv/bin/health-db provision
npm install && railway config apply && railway up --ci --service health-api
railway scale --service health-api asia-southeast1-eqsg3a=1 us-east4-eqdc4a=0   # next to Neon and the platform
```

Railway variables: `HEALTH_DB_MODE=hosted`, `HEALTH_DB_URL_API`,
`HEALTH_JWT_PUBLIC_KEY_PEM`, `HEALTH_JWT_ISSUER`, `EMPIRE_PLATFORM_URL`.
