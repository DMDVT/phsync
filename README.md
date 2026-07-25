# PhotoSync

Privacy-first, local-first gallery replacement starter implementing the Phase 1 and Phase 2 architecture from the supplied master specification.

## Included

- FastAPI backend with JWT authentication, users, devices, sync preferences, metadata sync, and health endpoints.
- PostgreSQL-ready SQLAlchemy models, Alembic scaffold, Redis/Celery cleanup worker, Docker Compose.
- Flutter application scaffold with Riverpod, Drift, `photo_manager`, gallery grid, photo viewer, albums, search, people, settings, and local-first services.
- On-device Phase 2 service interfaces for categorization, OCR, face detection, perceptual hashing, semantic embeddings, and duplicate detection.
- Seed/demo mode so the mobile UI can be explored before platform media permissions and ML model assets are configured.
- Backend tests and CI workflow.

## Important implementation boundary

This repository is a substantial runnable starter, not a store-ready release. Device gallery access, background execution, editing, and ML inference require testing on real Android/iOS hardware and adding model binaries under `mobile/assets/ml_models/`. The interfaces and data pipeline are present; model files are intentionally not bundled.

## Run the backend

```bash
cd backend
cp .env.example .env
docker compose up --build
```

API docs: `http://localhost:8000/docs`

For a lightweight local run without Docker:

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
export DATABASE_URL=sqlite+aiosqlite:///./photosync.db
uvicorn app.main:app --reload
```

## Run the Flutter app

```bash
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

The app initially uses demo data. Set `demoModeProvider` to `false` after configuring media permissions and running on a physical device.

## Phase mapping

### Phase 1
- Registration/login backend
- Device media scan service
- Album selection screen
- Gallery grid and photo viewer
- Local albums/favorites/archive/soft delete database operations
- Settings and sync preferences

### Phase 2
- AI pipeline orchestration
- Classification, OCR, face detection, embeddings interfaces
- Smart search and smart album query foundations
- Duplicate detection with dHash
- Location/date metadata storage

## Security notes

- JWT signing secret must be replaced in production.
- Password hashing uses bcrypt through Passlib.
- No media upload endpoint is included in Phase 1–2.
- Media paths and derived metadata stay in the device database.

## Phase 3–4 upgrade

This package now contains Phase 3 social/sharing foundations and Phase 4 advanced local features. See [`PHASE_3_4_IMPLEMENTATION.md`](PHASE_3_4_IMPLEMENTATION.md) for implemented modules, platform integration points, and production boundaries.

New server routes include `/friends`, `/share`, `/shared-albums`, `/notifications`, and `/share-links`. New mobile areas include Sharing, Notifications, Vault, Storage, Memories, compression services, messaging-contact assignment, and expanded local persistence.
