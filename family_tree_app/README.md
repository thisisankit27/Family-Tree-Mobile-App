# 🌳 Family Tree App

A polished, privacy-first mobile application to create, manage, visualize, and preserve
your family history across multiple generations — built with Flutter, Drift ORM, and Riverpod.

---

## ✨ Features (MVP)

| Feature | Status |
|---|---|
| Add / Edit / Delete family members | ✅ |
| Profile photos (camera & gallery) | ✅ |
| Parent-child relationships (bio, adoptive, foster, step) | ✅ |
| Spouse / partner relationships with dates | ✅ |
| Auto-derived siblings & half-siblings | ✅ |
| Interactive tree visualization (pan & zoom) | ✅ |
| Ancestor + Descendant views | ✅ |
| Full-text member search | ✅ |
| Filter by living status & gender | ✅ |
| JSON export (full backup) | ✅ |
| JSON import (restore / transfer) | ✅ |
| PDF export (member report) | ✅ |
| Multiple family trees | ✅ |
| Light / Dark theme | ✅ |
| 100% offline — no account required | ✅ |

---

## 🛠️ Tech Stack

| Layer | Technology | Why |
|---|---|---|
| **Framework** | Flutter 3.x | Single codebase iOS + Android; Dart ≈ Java |
| **Database** | Drift (SQLite ORM) | Type-safe SQL; mirrors Spring Data JPA |
| **State** | Riverpod | Structured, testable, no boilerplate |
| **Navigation** | go_router | Declarative routes; deep-link ready |
| **PDF** | pdf + printing | Pure Dart; no native deps |
| **Images** | image_picker | Official plugin; camera + gallery |
| **Serialization** | json_annotation | Annotation-based; mirrors Jackson |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.2.0 — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK ≥ 3.2.0 (bundled with Flutter)
- Android Studio or VS Code with Flutter extension
- Xcode (for iOS builds, macOS only)

Verify your setup:
```bash
flutter doctor
```

---

### 1. Clone / Open the Project

```bash
cd family_tree_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Code (REQUIRED — run this once, and after any schema change)

The app uses **Drift ORM** for the database. Drift generates type-safe query code
from your table definitions. Run this command to generate the `.g.dart` files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

> ⚠️ The app will NOT compile without this step.
> Re-run whenever you modify any file in `lib/database/`.

### 4. Run the App

```bash
# Run on connected device or emulator
flutter run

# Run on specific device
flutter devices          # list devices
flutter run -d <device>
```

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── core/
│   ├── constants/app_constants.dart   # Enums, sizes, strings
│   ├── theme/app_theme.dart           # Material 3 light & dark theme
│   ├── router/app_router.dart         # go_router navigation
│   └── utils/                        # UUID, Date helpers
│
├── database/
│   ├── app_database.dart              # Drift DB entry point (+ migration)
│   ├── tables/all_tables.dart         # All Drift table definitions
│   └── daos/                         # DAO classes (queries)
│       ├── family_tree_dao.dart
│       ├── person_dao.dart
│       ├── relationship_dao.dart
│       └── media_dao.dart
│
├── features/
│   ├── tree/                          # Family tree CRUD + home screen
│   ├── member/                        # Person CRUD + list + profile
│   ├── relationship/                  # Relationship management
│   ├── visualization/                 # Tree canvas + layout algorithm
│   ├── search/                        # Full-text search
│   ├── export_import/                 # JSON / PDF export & import
│   └── settings/                      # Theme, about, danger zone
│
└── shared/
    └── widgets/                       # Reusable: Avatar, EmptyState, Shell
```

Each feature follows **Clean Architecture**:
```
feature/
  domain/entities/     ← Pure Dart models (no Flutter, no Drift)
  data/repositories/   ← Drift-backed implementations
  presentation/
    providers/         ← Riverpod providers
    screens/           ← Flutter screens
```

This mirrors a Spring Boot app: `Entity → Repository → Service → Controller`.

---

## 🗄️ Database Schema

```
family_tree       ← One per tree (name, root person)
     │
     ├── person   ← All family members (full details)
     │      │
     │      ├── relationship  ← Directed graph edges
     │      │     (PARENT_OF / CHILD_OF / SPOUSE_OF + sub-types)
     │      │
     │      └── media         ← Photos per person
     │
     └── app_settings  ← Key-value preferences
```

### Key Design Decisions

- **UUID primary keys** — safe for future cloud sync/merge
- **Bidirectional edges** — every PARENT_OF stores a matching CHILD_OF for fast single-person queries
- **Soft delete** — `is_deleted` flag keeps data for 30 days before hard delete
- **Siblings are derived** — computed from shared parent edges, never stored
- **WAL journal mode** — enabled for better write concurrency

---

## 🌳 Tree Visualization

The tree canvas uses a **generation-based BFS layout**:

1. Anchor person sits at generation `0`
2. Parents assigned to `gen - 1`, children to `gen + 1`
3. Spouses share the same generation and are placed side-by-side
4. Each generation is a horizontal row; nodes are spaced evenly
5. Bezier curves connect parent bottoms to child tops
6. A horizontal line connects spouses

Rendered with:
- `InteractiveViewer` — handles pan, zoom, boundaries
- `CustomPaint` — draws all relationship lines
- `Stack` + `Positioned` — renders tappable person node cards

---

## 📦 JSON Export Format

```json
{
  "schema_version": 1,
  "exported_at": "2026-06-07T10:30:00Z",
  "app_version": "1.0.0",
  "tree": { "id": "...", "name": "Smith Family", ... },
  "persons": [ { "id": "...", "first_name": "John", ... } ],
  "relationships": [ { "relationship_type": "PARENT_OF", ... } ]
}
```

- **Import** creates a NEW tree — existing data is never overwritten
- Schema-versioned for forward compatibility

---

## 🗺️ Roadmap

### Phase 1 — MVP (current)
- [x] Full member CRUD with photos
- [x] All relationship types (parent/child/spouse)
- [x] Interactive tree visualization
- [x] Search and filter
- [x] JSON + PDF export/import
- [x] Multiple trees
- [x] Light/Dark theme

### Phase 2 — Polish
- [ ] Life events timeline
- [ ] Media gallery per member
- [ ] Tree image export (PNG/PDF)
- [ ] Accessibility audit (TalkBack, VoiceOver)
- [ ] App Store / Play Store submission

### Phase 3 — Cloud Sync
- [ ] Spring Boot REST backend (leverage your Java knowledge!)
- [ ] JWT authentication
- [ ] Delta sync (timestamp-based)
- [ ] Family sharing (invite collaborators)

### Phase 4 — Advanced
- [ ] GEDCOM import/export (genealogy standard)
- [ ] Birthday reminders (push notifications)
- [ ] Historical records integration
- [ ] DNA platform hints

---

## 🧪 Running Tests

```bash
# Unit tests
flutter test

# With coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

---

## 🔧 Common Issues

### "Target of URI doesn't exist: ...g.dart"
Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### "No devices found"
```bash
flutter devices          # list devices
flutter emulators        # list emulators
flutter emulators --launch <emulator_id>
```

### iOS build fails — missing provisioning profile
Open `ios/Runner.xcworkspace` in Xcode → Signing & Capabilities → add your Apple ID.

### Database locked error
The app uses WAL mode. Ensure you're not opening the database file externally while the app runs.

---

## 🤝 Contributing

This project is PRD-first — check `FamilyTree_PRD.md` for the full requirements,
data model, and architecture decisions before making changes.

---

## 📄 License

MIT — free to use, extend, and share.

---

*Built with Flutter 🩵 | Architecture by PRD | Code generated by Claude Sonnet*
