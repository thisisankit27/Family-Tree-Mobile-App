# 🌳 Family Tree Mobile App
## Project Requirements Document (PRD)
### Version 1.0 — June 2026
### Author: Solo Developer | Architect: AI Senior Review

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [Functional Requirements](#2-functional-requirements)
3. [Non-Functional Requirements](#3-non-functional-requirements)
4. [User Stories](#4-user-stories)
5. [Screen List & Navigation Flow](#5-screen-list--navigation-flow)
6. [Database Design](#6-database-design)
7. [API Design (Local + Future Cloud)](#7-api-design)
8. [Family Relationship Data Model](#8-family-relationship-data-model)
9. [Technology Stack Recommendation](#9-technology-stack-recommendation)
10. [Development Roadmap](#10-development-roadmap)
11. [MVP Scope vs Future Scope](#11-mvp-scope-vs-future-scope)
12. [Risk & Mitigation](#12-risk--mitigation)

---

## 1. Executive Summary

### 1.1 Project Vision

Build a polished, privacy-first mobile application that allows individuals and families to create, manage, visualize, and preserve their family history across multiple generations — designed to last decades and adapt to the complex, non-traditional structures of real-world families.

### 1.2 Problem Statement

Existing family tree tools are either web-only, require subscriptions, share your data with genealogy databases, or fail to support non-traditional family structures (adoptions, remarriages, same-sex partnerships, blended families). There is a clear market for a **beautiful, offline-first, privacy-respecting** mobile app that stores data locally and gives users full control.

### 1.3 Target Users

| Persona | Description |
|---|---|
| **The Historian** | Grandparent/parent wanting to preserve family history for children |
| **The Genealogist** | Someone actively researching ancestry and lineage |
| **The Family Curator** | Adult child managing records after a parent passes |
| **The Curious Millennial** | Young adult exploring heritage after a DNA test |

### 1.4 Key Constraints

- **Solo developer** — scope must be manageable in phases
- **Developer background** — Java/Spring Boot; limited Flutter/mobile experience
- **Budget** — minimal or zero third-party service costs for MVP
- **Timeline** — production-ready MVP in approximately 4 months

### 1.5 Success Metrics (MVP)

- App successfully adds 100+ members with complex relationships without crash
- Tree view renders 200-node tree in under 3 seconds
- JSON export/import round-trip preserves 100% of data fidelity
- Zero data loss on app crash (transactional writes)
- User can onboard and add their first family member in under 2 minutes

---

## 2. Functional Requirements

Requirements are organized by feature area and tagged with priority:
**[P0]** = MVP critical | **[P1]** = MVP preferred | **[P2]** = Post-MVP | **[P3]** = Future

---

### FR-01: Family Tree Management

| ID | Requirement | Priority |
|---|---|---|
| FR-01.1 | User can create a new family tree with a name and optional description | P0 |
| FR-01.2 | User can set a "root person" for any tree (the anchor person) | P0 |
| FR-01.3 | User can create multiple separate family trees (e.g. maternal vs paternal) | P1 |
| FR-01.4 | User can rename or delete a family tree | P1 |
| FR-01.5 | User can view a summary dashboard per tree (member count, generations, stats) | P1 |
| FR-01.6 | User can merge two trees | P3 |

### FR-02: Member (Person) Management

| ID | Requirement | Priority |
|---|---|---|
| FR-02.1 | User can add a family member with: Full Name (required), Gender, Date of Birth, Date of Death, Birth Place, Death Place, Occupation, Biography/Notes, Profile Photo, Email, Phone, Address | P0 |
| FR-02.2 | User can mark dates as approximate (e.g., "circa 1945") | P0 |
| FR-02.3 | User can mark a member as living or deceased | P0 |
| FR-02.4 | User can edit any member's information at any time | P0 |
| FR-02.5 | User can soft-delete a member (with warning about relationship impacts) | P0 |
| FR-02.6 | User can permanently delete a member and all their relationships | P1 |
| FR-02.7 | User can upload a profile photo from device gallery or camera | P1 |
| FR-02.8 | User can add multiple photos to a member's gallery | P2 |
| FR-02.9 | User can add multiple life events (e.g., graduation, immigration) | P2 |
| FR-02.10 | Gender field supports: Male, Female, Non-Binary, Other, Unknown | P0 |

### FR-03: Relationship Management

| ID | Requirement | Priority |
|---|---|---|
| FR-03.1 | User can define a PARENT-CHILD relationship, specifying sub-type: Biological, Adoptive, Foster, Step | P0 |
| FR-03.2 | User can define a SPOUSE/PARTNER relationship, specifying sub-type: Married, Domestic Partner, Separated, Divorced, Widowed | P0 |
| FR-03.3 | Sibling relationships are auto-derived from shared parents (not manually entered) | P0 |
| FR-03.4 | Half-siblings are identified when persons share exactly one parent | P0 |
| FR-03.5 | User can add marriage/union dates and end dates to spouse relationships | P0 |
| FR-03.6 | User can add relationship notes (e.g., adoption date, ceremony location) | P1 |
| FR-03.7 | A person can have multiple spouse records (sequential marriages) | P0 |
| FR-03.8 | A person can have both biological and adoptive parents | P0 |
| FR-03.9 | User can remove any defined relationship | P0 |
| FR-03.10 | Grandparent, aunt/uncle, cousin relationships are auto-derived for display | P1 |
| FR-03.11 | User can define arbitrary "other" relationships (godparent, guardian) | P2 |

### FR-04: Tree Visualization

| ID | Requirement | Priority |
|---|---|---|
| FR-04.1 | App renders an interactive, pannable, zoomable tree diagram | P0 |
| FR-04.2 | Ancestor View: shows selected person's ancestors upward (parents, grandparents) | P0 |
| FR-04.3 | Descendant View: shows selected person's descendants downward (children, grandchildren) | P0 |
| FR-04.4 | Full Tree View: combines ancestors and descendants | P1 |
| FR-04.5 | User can tap a person node in the tree to view their profile | P0 |
| FR-04.6 | Tree nodes display: photo thumbnail, name, birth/death years | P0 |
| FR-04.7 | Tree nodes visually indicate: deceased (greyed), gender (color/icon), root person | P1 |
| FR-04.8 | Spouse pairs are displayed side-by-side connected by a horizontal line | P0 |
| FR-04.9 | "Center on Person" button recenters the view on selected person | P1 |
| FR-04.10 | "Fit to Screen" button resizes tree to fit viewport | P1 |
| FR-04.11 | Generation labels (Gen 1, Gen 2...) shown on tree axis | P2 |
| FR-04.12 | User can long-press a node to open a context menu (Edit, View Profile, Add Child, etc.) | P2 |

### FR-05: Search & Browse

| ID | Requirement | Priority |
|---|---|---|
| FR-05.1 | Full-text search across member names | P0 |
| FR-05.2 | Filter by: living status, gender, date range (birth year) | P1 |
| FR-05.3 | Browse all members in a paginated list view | P0 |
| FR-05.4 | Sort members by: name (A-Z), birth date, date added | P1 |

### FR-06: Import & Export

| ID | Requirement | Priority |
|---|---|---|
| FR-06.1 | Export full tree to JSON (custom format) | P0 |
| FR-06.2 | Import family tree from previously exported JSON | P0 |
| FR-06.3 | Validate JSON on import before committing (schema validation) | P0 |
| FR-06.4 | Export member summary list to PDF | P1 |
| FR-06.5 | Export tree diagram image to PNG/PDF | P2 |
| FR-06.6 | Share exported file via native device share sheet | P1 |
| FR-06.7 | Import/Export GEDCOM format (genealogy standard) | P3 |

### FR-07: Settings & Personalization

| ID | Requirement | Priority |
|---|---|---|
| FR-07.1 | Toggle light/dark theme | P1 |
| FR-07.2 | Set default tree to load on startup | P1 |
| FR-07.3 | Configure privacy: hide sensitive fields for living members | P2 |
| FR-07.4 | Set app lock with biometrics or PIN | P2 |
| FR-07.5 | Manage local storage (see size, clear photos) | P2 |

---

## 3. Non-Functional Requirements

### 3.1 Performance

| ID | Requirement | Target |
|---|---|---|
| NFR-P1 | Cold app launch time | < 3 seconds |
| NFR-P2 | Tree rendering for 200 nodes | < 3 seconds |
| NFR-P3 | Tree pan/zoom frame rate | ≥ 60fps |
| NFR-P4 | Search result return time | < 500ms |
| NFR-P5 | Add/Save member operation | < 1 second |
| NFR-P6 | JSON export for 500 members | < 5 seconds |

### 3.2 Scalability

| ID | Requirement |
|---|---|
| NFR-S1 | Support up to 10,000 family members per tree without performance degradation |
| NFR-S2 | Support up to 20 simultaneous family trees |
| NFR-S3 | Tree visualization must paginate or virtualize nodes beyond 500 for performance |
| NFR-S4 | Architecture must support future cloud sync without major refactoring |

### 3.3 Reliability

| ID | Requirement |
|---|---|
| NFR-R1 | No data loss on unexpected app crash (all writes use transactions) |
| NFR-R2 | Soft delete with 30-day recovery window |
| NFR-R3 | JSON import uses atomic transactions (all-or-nothing) |
| NFR-R4 | App functions 100% offline; network never required for core features |
| NFR-R5 | Graceful error messages for all user-facing failures |

### 3.4 Security & Privacy

| ID | Requirement |
|---|---|
| NFR-SEC1 | All local data stored in SQLite with optional SQLCipher encryption |
| NFR-SEC2 | Photos stored in app's sandboxed private directory |
| NFR-SEC3 | No analytics, no telemetry, no data sent to third parties without explicit consent |
| NFR-SEC4 | Exported JSON should be clearly labeled as user's private data |
| NFR-SEC5 | Optional biometric/PIN lock for app access |

### 3.5 Accessibility

| ID | Requirement |
|---|---|
| NFR-A1 | WCAG 2.1 AA compliance across all screens |
| NFR-A2 | Full support for iOS VoiceOver and Android TalkBack |
| NFR-A3 | Minimum tap target size: 44x44 points (Apple HIG) |
| NFR-A4 | All text scales with system font size settings |
| NFR-A5 | Color is never the sole indicator of information |

### 3.6 Platform Support

| Platform | Minimum Version |
|---|---|
| iOS | 14.0+ |
| Android | API 24 (Android 7.0)+ |

### 3.7 Maintainability

- Clean Architecture with strict layer separation (Presentation → Domain → Data)
- Unit test coverage ≥ 70% for Domain layer (use cases, business logic)
- All public classes and methods documented
- Database migrations versioned and tested
- No hardcoded strings — all user-visible text in localization files (prep for i18n)

---

## 4. User Stories

### Epic 1: Family Tree Setup

```
US-01  As a new user, I want to be guided through creating my first 
       family tree so that I can start building without confusion.

US-02  As a user, I want to give my family tree a meaningful name 
       so that I can distinguish it from others I may create later.

US-03  As a user, I want to set a "root person" for my tree 
       so that the visualization has a clear starting anchor.

US-04  As a user, I want to create multiple family trees 
       so that I can manage maternal and paternal lines separately.

US-05  As a user, I want to see a quick summary of each tree 
       (member count, generations) so that I know at a glance what's there.
```

### Epic 2: Member Management

```
US-06  As a user, I want to add a new family member with their basic 
       personal details so that I can build the tree's data.

US-07  As a user, I want to upload or capture a profile photo 
       for a member so that the tree feels personal and visual.

US-08  As a user, I want to mark a member as deceased and record 
       their date of death so that the tree is historically accurate.

US-09  As a user, I want to mark dates as approximate (circa) 
       when I don't know the exact date.

US-10  As a user, I want to edit any field on a member's profile 
       at any time so that I can correct errors or add new information.

US-11  As a user, I want to delete a family member with a clear 
       warning about cascading relationship removals.

US-12  As a user, I want to add a biography/notes for a member 
       so that I can preserve stories and context beyond dates and names.
```

### Epic 3: Relationship Management

```
US-13  As a user, I want to link two people as parent and child, 
       specifying if the relationship is biological, adoptive, foster, 
       or step so that the tree reflects the real family structure.

US-14  As a user, I want a person to have BOTH biological AND adoptive 
       parents recorded, clearly labeled differently.

US-15  As a user, I want to link two people as spouses/partners, 
       specifying the relationship status and marriage dates.

US-16  As a user, I want to record multiple spouse relationships 
       for one person (sequential marriages) with dates for each.

US-17  As a user, I want siblings to be automatically shown when 
       they share parents, so I don't need to manually define them.

US-18  As a user, I want to clearly see who is a half-sibling 
       vs a full sibling on the member's profile.

US-19  As a user, I want to view all of a person's relationships 
       in one organized section of their profile.

US-20  As a user, I want to remove a relationship between two people 
       without deleting either person from the tree.
```

### Epic 4: Tree Visualization

```
US-21  As a user, I want to see my family tree as an interactive 
       diagram so that I can understand relationships visually.

US-22  As a user, I want to pan and zoom the tree view freely 
       so that I can navigate large trees easily.

US-23  As a user, I want to switch between Ancestor View 
       (upward toward grandparents) and Descendant View 
       (downward toward children) depending on what I'm exploring.

US-24  As a user, I want to tap a person node on the tree 
       to open their profile directly.

US-25  As a user, I want to tap a "center on root" button 
       to quickly return to the anchor person in a large tree.
```

### Epic 5: Search & Browse

```
US-26  As a user, I want to search for a member by name 
       so that I can quickly jump to their profile in a large tree.

US-27  As a user, I want to browse all members in a list view 
       so that I can get an overview and spot duplicates.

US-28  As a user, I want to filter the member list by living status 
       and gender so that I can find subsets quickly.
```

### Epic 6: Import & Export

```
US-29  As a user, I want to export my entire family tree to a JSON file 
       so that I can back it up to cloud storage or share it.

US-30  As a user, I want to import a JSON file to restore a tree 
       so that my data is never permanently tied to one device.

US-31  As a user, I want to be clearly warned if an import will 
       overwrite an existing tree, with an option to merge instead.

US-32  As a user, I want to export a PDF report of my family members 
       so that I can share a readable document with relatives.

US-33  As a user, I want to share the exported file directly from 
       the app using my device's share sheet.
```

### Epic 7: Settings

```
US-34  As a user, I want to toggle between light and dark mode 
       so that the app is comfortable to use in any lighting.

US-35  As a user, I want to set a PIN or biometric lock 
       so that private family data is protected on shared devices.
```

---

## 5. Screen List & Navigation Flow

### 5.1 Full Screen Inventory

| # | Screen Name | Purpose | Priority |
|---|---|---|---|
| S-01 | Splash Screen | Branding, DB init, navigation routing | P0 |
| S-02 | Onboarding (3 slides) | Feature tour, first-tree creation prompt | P0 |
| S-03 | Home / Dashboard | Tree cards, quick stats, quick-add FAB | P0 |
| S-04 | Tree Visualization | Interactive pannable/zoomable tree canvas | P0 |
| S-05 | Member Profile | Full detail view, relationships, photo | P0 |
| S-06 | Add / Edit Member | Multi-section form, photo picker, validation | P0 |
| S-07 | Add Relationship | Person picker + relationship type selector | P0 |
| S-08 | All Members List | Paginated list, search bar, filters | P0 |
| S-09 | Search Screen | Full-text search with type-ahead | P0 |
| S-10 | Import / Export | JSON/PDF export + file import options | P0 |
| S-11 | Settings | Theme, privacy, backup, about, version | P1 |
| S-12 | Tree Settings | Tree name, root person, delete tree | P1 |
| S-13 | Relationship Detail | View/edit a specific relationship record | P1 |
| S-14 | Member Media Gallery | All photos for one person | P2 |
| S-15 | Life Events Timeline | Chronological events for one person | P2 |
| S-16 | Deleted Members | Soft-deleted members with restore option | P2 |

### 5.2 Navigation Architecture

```
App Root
│
├── Splash Screen (S-01)
│   └── [first launch] → Onboarding (S-02)
│   └── [returning]   → Home/Dashboard (S-03)
│
├── Home / Dashboard (S-03)              [Bottom Nav: Home]
│   ├── → Tree Visualization (S-04)
│   ├── → Tree Settings (S-12)
│   └── FAB → Add Member (S-06)
│
├── Tree Visualization (S-04)
│   ├── Tap node → Member Profile (S-05)
│   └── Long press → context menu
│
├── Members Tab (S-08)                   [Bottom Nav: Members]
│   ├── → Member Profile (S-05)
│   │   ├── → Add/Edit Member (S-06)
│   │   ├── → Add Relationship (S-07)
│   │   ├── → Media Gallery (S-14)
│   │   └── Relationship item → Relationship Detail (S-13)
│   └── Search → Search Screen (S-09)
│
├── Export / Import Tab (S-10)           [Bottom Nav: Data]
│
└── Settings Tab (S-11)                  [Bottom Nav: Settings]
    └── → Privacy, Theme, Lock, About
```

### 5.3 Navigation Pattern

Use a **Bottom Navigation Bar** with 4 tabs:
1. 🏠 Home (Dashboard + Tree View)
2. 👥 Members (List + Search)
3. 📁 Data (Import/Export)
4. ⚙️ Settings

Modals/Sheets for: Add Member, Add Relationship, Delete confirmations
Full-screen push for: Member Profile, Tree Visualization, Relationship Detail

---

## 6. Database Design

### 6.1 Design Principles

- **SQLite** (via drift ORM) — offline-first, zero server cost
- **UUID primary keys** — safe for future sync/merge across devices
- **Soft delete** — `is_deleted` flag + `deleted_at` timestamp
- **Versioned schema** — drift migration system for safe upgrades
- **Bidirectional relationships** — stored as directed edges; both directions stored for query performance
- **Multi-tree support** — every entity carries a `tree_id`

---

### 6.2 Full Schema

```sql
-- ============================================================
-- TABLE: family_tree
-- One record per family tree the user creates
-- ============================================================
CREATE TABLE family_tree (
    id              TEXT    PRIMARY KEY,            -- UUID
    name            TEXT    NOT NULL,               -- "Smith Family"
    description     TEXT,
    root_person_id  TEXT,                           -- FK → person.id (nullable until set)
    cover_photo_path TEXT,
    member_count    INTEGER DEFAULT 0,              -- denormalized cache
    created_at      TEXT    NOT NULL,               -- ISO 8601
    updated_at      TEXT    NOT NULL
);

-- ============================================================
-- TABLE: person
-- One record per individual family member
-- ============================================================
CREATE TABLE person (
    -- Identity
    id                  TEXT    PRIMARY KEY,        -- UUID
    tree_id             TEXT    NOT NULL REFERENCES family_tree(id),

    -- Name
    first_name          TEXT    NOT NULL,
    middle_name         TEXT,
    last_name           TEXT,
    maiden_name         TEXT,                       -- birth surname
    nickname            TEXT,
    name_prefix         TEXT,                       -- Mr, Mrs, Dr
    name_suffix         TEXT,                       -- Jr, Sr, III

    -- Demographics
    gender              TEXT    NOT NULL DEFAULT 'UNKNOWN',
                                                    -- MALE | FEMALE | NON_BINARY | OTHER | UNKNOWN
    is_living           INTEGER NOT NULL DEFAULT 1, -- boolean

    -- Dates
    birth_date          TEXT,                       -- ISO 8601 (YYYY-MM-DD or partial YYYY-MM)
    birth_date_approx   INTEGER NOT NULL DEFAULT 0, -- boolean: "circa"
    death_date          TEXT,
    death_date_approx   INTEGER NOT NULL DEFAULT 0,

    -- Places
    birth_place         TEXT,
    death_place         TEXT,
    current_location    TEXT,

    -- Personal Details
    occupation          TEXT,
    biography           TEXT,
    nationality         TEXT,
    religion            TEXT,
    education           TEXT,

    -- Contact (optional, for living members)
    email               TEXT,
    phone               TEXT,
    address             TEXT,
    website             TEXT,

    -- Media
    profile_photo_id    TEXT REFERENCES media(id),  -- FK to primary photo

    -- Soft Delete
    is_deleted          INTEGER NOT NULL DEFAULT 0,
    deleted_at          TEXT,

    -- Audit
    created_at          TEXT    NOT NULL,
    updated_at          TEXT    NOT NULL
);

CREATE INDEX idx_person_tree_id ON person(tree_id);
CREATE INDEX idx_person_last_name ON person(last_name);
CREATE INDEX idx_person_birth_date ON person(birth_date);

-- ============================================================
-- TABLE: relationship
-- Directed edge in the family graph.
-- Every parent-child relationship stores TWO rows:
--   (parent, child, PARENT_OF) and (child, parent, CHILD_OF)
-- Every spouse relationship stores TWO rows:
--   (personA, personB, SPOUSE_OF) and (personB, personA, SPOUSE_OF)
-- This enables efficient single-person queries without self-joins.
-- ============================================================
CREATE TABLE relationship (
    id                  TEXT    PRIMARY KEY,        -- UUID
    tree_id             TEXT    NOT NULL REFERENCES family_tree(id),

    person_id           TEXT    NOT NULL REFERENCES person(id),
    related_person_id   TEXT    NOT NULL REFERENCES person(id),

    -- Relationship type (directed)
    relationship_type   TEXT    NOT NULL,
        -- PARENT_OF | CHILD_OF | SPOUSE_OF | PARTNER_OF

    -- Sub-type qualifies the relationship
    sub_type            TEXT,
        -- For PARENT_OF / CHILD_OF: BIOLOGICAL | ADOPTIVE | FOSTER | STEP
        -- For SPOUSE_OF: MARRIED | DOMESTIC_PARTNER | SEPARATED | DIVORCED | WIDOWED
        -- For PARTNER_OF: PARTNER

    is_current          INTEGER NOT NULL DEFAULT 1, -- false = historical (e.g., divorced)
    start_date          TEXT,                       -- marriage date, adoption date
    start_date_approx   INTEGER NOT NULL DEFAULT 0,
    end_date            TEXT,                       -- divorce date, death of spouse
    end_date_approx     INTEGER NOT NULL DEFAULT 0,
    notes               TEXT,

    -- Soft Delete
    is_deleted          INTEGER NOT NULL DEFAULT 0,
    deleted_at          TEXT,

    -- Audit
    created_at          TEXT    NOT NULL,
    updated_at          TEXT    NOT NULL,

    -- Prevent exact duplicate directed edges
    UNIQUE (person_id, related_person_id, relationship_type, sub_type)
);

CREATE INDEX idx_rel_person_id ON relationship(person_id);
CREATE INDEX idx_rel_related_person_id ON relationship(related_person_id);
CREATE INDEX idx_rel_tree_id ON relationship(tree_id);
CREATE INDEX idx_rel_type ON relationship(relationship_type);

-- ============================================================
-- TABLE: media
-- Photos and documents attached to persons or the tree
-- ============================================================
CREATE TABLE media (
    id              TEXT    PRIMARY KEY,            -- UUID
    tree_id         TEXT    NOT NULL REFERENCES family_tree(id),
    person_id       TEXT    REFERENCES person(id),  -- nullable (tree-level media)

    type            TEXT    NOT NULL DEFAULT 'PHOTO',
                                                    -- PHOTO | DOCUMENT | AUDIO
    file_path       TEXT    NOT NULL,               -- local file path in app sandbox
    file_name       TEXT    NOT NULL,
    file_size_bytes INTEGER,
    mime_type       TEXT,

    title           TEXT,
    description     TEXT,
    date_taken      TEXT,
    date_approx     INTEGER NOT NULL DEFAULT 0,

    is_deleted      INTEGER NOT NULL DEFAULT 0,
    deleted_at      TEXT,
    created_at      TEXT    NOT NULL,
    updated_at      TEXT    NOT NULL
);

CREATE INDEX idx_media_person_id ON media(person_id);

-- ============================================================
-- TABLE: life_event  (Phase 2)
-- Timeline events beyond birth and death
-- ============================================================
CREATE TABLE life_event (
    id              TEXT    PRIMARY KEY,
    person_id       TEXT    NOT NULL REFERENCES person(id),
    tree_id         TEXT    NOT NULL REFERENCES family_tree(id),

    event_type      TEXT    NOT NULL,
        -- BIRTH | DEATH | MARRIAGE | DIVORCE | GRADUATION | IMMIGRATION |
        -- MILITARY_SERVICE | ORDINATION | BAPTISM | CUSTOM
    title           TEXT    NOT NULL,               -- custom label if CUSTOM
    description     TEXT,
    event_date      TEXT,
    event_date_approx INTEGER NOT NULL DEFAULT 0,
    event_place     TEXT,
    media_id        TEXT REFERENCES media(id),

    created_at      TEXT    NOT NULL,
    updated_at      TEXT    NOT NULL
);

-- ============================================================
-- TABLE: app_settings
-- Key-value store for user preferences
-- ============================================================
CREATE TABLE app_settings (
    key             TEXT    PRIMARY KEY,
    value           TEXT    NOT NULL,
    updated_at      TEXT    NOT NULL
);

-- Default settings seed data:
-- ('theme', 'system')           → light | dark | system
-- ('default_tree_id', '')
-- ('show_living_details', '1')
-- ('app_lock_enabled', '0')
-- ('last_export_date', '')
-- ('schema_version', '1')
```

### 6.3 Entity Relationship Summary

```
family_tree (1) ──────< person (*) >────── media (*)
                                │
                        relationship (*)
                    [self-referencing via person_id & related_person_id]
                                │
                         life_event (*)
```

### 6.4 Schema Migration Strategy

Use **drift's migration API**:
- Each schema change increments `schemaVersion`
- Migrations run in sequence on app upgrade
- Always test migrations with a copy of production data
- Store `schema_version` in `app_settings` table as a sanity check

---

## 7. API Design

### 7.1 Architecture: Repository Pattern

The data layer exposes typed Repository interfaces to the Domain layer. This mirrors Spring Data JPA, making it familiar.

```
Domain Layer calls:
  PersonRepository.findById(id)
  PersonRepository.save(person)

Data Layer implements:
  PersonRepositoryImpl (uses drift DAO)

Future: CloudPersonRepositoryImpl (uses HTTP client → Spring Boot)
```

### 7.2 Local Repository Contracts (Dart interface signatures)

```dart
// ─── FAMILY TREE REPOSITORY ──────────────────────────────
abstract class FamilyTreeRepository {
  Future<List<FamilyTree>>   getAllTrees();
  Future<FamilyTree?>        getTreeById(String id);
  Future<FamilyTree>         createTree(CreateTreeRequest request);
  Future<FamilyTree>         updateTree(String id, UpdateTreeRequest request);
  Future<void>               deleteTree(String id);  // cascades to persons
  Future<TreeStats>          getTreeStats(String treeId);
}

// ─── PERSON REPOSITORY ───────────────────────────────────
abstract class PersonRepository {
  Future<List<Person>>       getPersonsByTree(String treeId);
  Future<Person?>            getPersonById(String id);
  Future<Person>             createPerson(CreatePersonRequest request);
  Future<Person>             updatePerson(String id, UpdatePersonRequest request);
  Future<void>               softDeletePerson(String id);
  Future<void>               hardDeletePerson(String id);
  Future<List<Person>>       searchPersons(String treeId, PersonSearchQuery query);
  Future<List<Person>>       getDeletedPersons(String treeId);
  Future<void>               restorePerson(String id);
}

// ─── RELATIONSHIP REPOSITORY ──────────────────────────────
abstract class RelationshipRepository {
  Future<List<Relationship>> getRelationshipsForPerson(String personId);
  Future<List<Person>>       getParentsOf(String personId);
  Future<List<Person>>       getChildrenOf(String personId);
  Future<List<Person>>       getSpousesOf(String personId);
  Future<List<Person>>       getSiblingsOf(String personId);   // derived
  Future<List<Person>>       getHalfSiblingsOf(String personId); // derived
  Future<Relationship>       createRelationship(CreateRelationshipRequest request);
  Future<Relationship>       updateRelationship(String id, UpdateRelationshipRequest r);
  Future<void>               deleteRelationship(String id);
}

// ─── MEDIA REPOSITORY ─────────────────────────────────────
abstract class MediaRepository {
  Future<List<Media>>        getMediaForPerson(String personId);
  Future<Media>              saveMedia(SaveMediaRequest request);
  Future<void>               deleteMedia(String id);
}

// ─── EXPORT/IMPORT REPOSITORY ─────────────────────────────
abstract class DataPortRepository {
  Future<String>             exportTreeToJson(String treeId);   // returns JSON string
  Future<FamilyTree>         importTreeFromJson(String json);   // atomic import
  Future<Uint8List>          exportToPdf(String treeId, PdfExportOptions opts);
}

// ─── SEARCH REPOSITORY ────────────────────────────────────
abstract class SearchRepository {
  Future<List<Person>>       searchAll(String treeId, String query);
  Future<List<Person>>       filterPersons(String treeId, FilterOptions opts);
}
```

### 7.3 Use Cases (Domain Layer)

```
Use Case                        Calls
─────────────────────────────────────────────────────────────────
AddPersonUseCase                PersonRepository.createPerson()
UpdatePersonUseCase             PersonRepository.updatePerson()
DeletePersonUseCase             PersonRepository.softDeletePerson()
                                RelationshipRepository.deleteRelationshipsForPerson()
AddRelationshipUseCase          RelationshipRepository.createRelationship() ×2 (both directions)
GetFamilyTreeGraphUseCase       PersonRepository + RelationshipRepository (graph build)
ExportTreeUseCase               DataPortRepository.exportTreeToJson()
ImportTreeUseCase               DataPortRepository.importTreeFromJson()
SearchPersonsUseCase            SearchRepository.searchAll()
GetPersonDetailUseCase          PersonRepository.getPersonById()
                                RelationshipRepository.getRelationshipsForPerson()
```

### 7.4 Future Cloud REST API (Spring Boot)

Design these endpoints for Phase 3, leveraging your existing Spring Boot experience:

```
BASE URL: https://api.familytree.app/v1

AUTH
  POST   /auth/register                 Register new user account
  POST   /auth/login                    Obtain JWT token
  POST   /auth/refresh                  Refresh JWT token
  DELETE /auth/logout                   Revoke session

TREES
  GET    /trees                         List user's trees
  POST   /trees                         Create a new tree
  GET    /trees/{treeId}                Get tree metadata
  PUT    /trees/{treeId}                Update tree
  DELETE /trees/{treeId}                Delete tree

SYNC
  POST   /trees/{treeId}/sync/push      Push local changes (delta sync)
  GET    /trees/{treeId}/sync/pull      Pull remote changes since timestamp
  GET    /trees/{treeId}/sync/status    Check sync status

PERSONS
  GET    /trees/{treeId}/persons        List all persons
  POST   /trees/{treeId}/persons        Create person
  GET    /trees/{treeId}/persons/{id}   Get person
  PUT    /trees/{treeId}/persons/{id}   Update person
  DELETE /trees/{treeId}/persons/{id}   Soft delete person

RELATIONSHIPS
  GET    /trees/{treeId}/relationships              List all
  POST   /trees/{treeId}/relationships              Create
  DELETE /trees/{treeId}/relationships/{id}         Delete

MEDIA
  POST   /trees/{treeId}/media          Upload photo/document
  GET    /trees/{treeId}/media/{id}     Download media
  DELETE /trees/{treeId}/media/{id}     Delete media

SHARING (Phase 4)
  POST   /trees/{treeId}/invites        Invite collaborator
  GET    /trees/{treeId}/members        List collaborators
  DELETE /trees/{treeId}/members/{userId}   Remove collaborator
```

**Sync Strategy Note**: Use a **timestamp-based delta sync** (last_synced_at). Each entity carries `updated_at`. On sync push, client sends all records modified since `last_synced_at`. Conflict resolution rule: **server wins** (simplest for solo development); upgrade to **last-write-wins with conflict UI** in Phase 4.

---

## 8. Family Relationship Data Model

### 8.1 Core Concept: Directed Graph

The family is modeled as a **directed graph** where:
- **Nodes** = Persons
- **Edges** = Relationships (directed, typed)

```
        [John Smith, 1940]
              │
        PARENT_OF (BIOLOGICAL)
              │
              ▼
       [Mary Smith, 1965] ──SPOUSE_OF──> [Tom Jones, 1963]
              │
        PARENT_OF (BIOLOGICAL)
              │
        ┌─────┴─────┐
        ▼           ▼
  [Alice, 1990] [Bob, 1992]
                            ↑
                      (siblings derived: both have same parents)
```

### 8.2 Relationship Type Taxonomy

```
RELATIONSHIP_TYPE     SUB_TYPE                  Notes
────────────────────────────────────────────────────────────────────
PARENT_OF             BIOLOGICAL                Natural/birth parent
                      ADOPTIVE                  Legal adoption
                      FOSTER                    Foster care (temporary/permanent)
                      STEP                      Parent via marriage only

CHILD_OF              BIOLOGICAL                Mirror of PARENT_OF (stored for perf.)
                      ADOPTIVE
                      FOSTER
                      STEP

SPOUSE_OF             MARRIED                   Legal marriage
                      DOMESTIC_PARTNER          Committed non-marriage partnership
                      SEPARATED                 Marriage not legally ended
                      DIVORCED                  Legal divorce
                      WIDOWED                   Spouse is deceased

────────────────────────────────────────────────────────────────────
DERIVED (not stored — computed at query time)

SIBLING_OF            FULL                      Share both parents
                      HALF                      Share one parent
                      STEP                      No shared biological parent

GRANDPARENT_OF        (derived: parent's parent)
GRANDCHILD_OF         (derived)
AUNT_UNCLE_OF         (derived: parent's sibling)
NIECE_NEPHEW_OF       (derived)
COUSIN_OF             (derived: parent's sibling's child)
```

### 8.3 Bidirectional Storage Strategy

To enable efficient queries ("who are all the people related to Person X?"), every relationship is stored **twice** as directed edges:

When user adds "John is the biological father of Mary":
- Row 1: `(john_id, mary_id, PARENT_OF, BIOLOGICAL)`
- Row 2: `(mary_id, john_id, CHILD_OF, BIOLOGICAL)`

This allows a single index scan on `person_id` to retrieve all relationships for any person, avoiding expensive self-joins on large trees.

### 8.4 Sibling Derivation Algorithm

```
getSiblingsOf(personId):
    parents = getParentsOf(personId)

    allSiblings = []
    sharedParentCount = Map<personId → count>

    for each parent in parents:
        children = getChildrenOf(parent.id)
        for each child in children:
            if child.id != personId:
                sharedParentCount[child.id]++

    for each (siblingId, count) in sharedParentCount:
        if count == parents.size:
            → FULL_SIBLING
        else:
            → HALF_SIBLING
```

### 8.5 Complex Family Scenarios

| Scenario | How It's Handled |
|---|---|
| Adopted child + biological parents | Person has two PARENT_OF edges: one BIOLOGICAL, one ADOPTIVE |
| Remarriage with children from prior marriage | Spouse B is STEP parent of Person A's prior children |
| Same-sex parents | No gender restriction on PARENT_OF — supports any pairing |
| Unknown parent | Placeholder person created: "Unknown Father of [Name]" |
| Multiple marriages | Two separate SPOUSE_OF edges, one `is_current=0`, one `is_current=1` |
| Twins | Both children linked to same two parents (they become siblings automatically) |
| Grandparent raising grandchild | Use ADOPTIVE sub_type to reflect legal/social reality |

### 8.6 Graph Traversal for Tree Visualization

```
buildAncestorTree(rootPersonId, maxGenerations):
    tree = new Graph()
    queue = [(rootPersonId, 0)]

    while queue is not empty:
        (personId, generation) = queue.dequeue()
        if generation > maxGenerations: continue

        person = personRepository.getById(personId)
        tree.addNode(person, generation)

        parents = relationshipRepository.getParentsOf(personId)
        spouses = relationshipRepository.getSpousesOf(personId)

        for each parent:
            tree.addEdge(parent, person, PARENT_OF)
            queue.enqueue((parent.id, generation + 1))

        for each spouse:
            tree.addNode(spouse, generation)       ← same level
            tree.addEdge(person, spouse, SPOUSE_OF)

    return tree
```

---

## 9. Technology Stack Recommendation

### 9.1 Decision Rationale

As a Java/Spring Boot developer learning mobile, the goal is to **minimize unfamiliar decisions** while choosing tools with long-term viability.

### 9.2 Recommended Stack

```
┌────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                  │
│  Flutter (Dart)  ·  Riverpod (state)  ·  go_router    │
├────────────────────────────────────────────────────────┤
│                    DOMAIN LAYER                        │
│  Pure Dart Use Cases  ·  Domain Entities  ·  Failures  │
├────────────────────────────────────────────────────────┤
│                    DATA LAYER                          │
│  drift ORM (SQLite)  ·  image_picker  ·  file paths   │
├────────────────────────────────────────────────────────┤
│                    PLATFORM                            │
│  iOS 14+  ·  Android 7+  (single Flutter codebase)    │
└────────────────────────────────────────────────────────┘
```

### 9.3 Technology Decisions & Justifications

| Technology | Role | Why This Choice | Alternative Considered |
|---|---|---|---|
| **Flutter** | Mobile framework | Single codebase for iOS+Android; Dart is similar to Java (typed, OOP, familiar syntax); strong ecosystem | React Native (JavaScript, less familiar pattern for Java devs) |
| **Dart** | Language | Flutter's native language; very similar to Java (classes, generics, null safety); fast to learn | N/A (Flutter requires Dart) |
| **drift** (moor) | SQLite ORM | Type-safe SQL with codegen; mirrors Spring Data JPA exactly; supports complex joins, migrations, streams | sqflite (raw SQL, more boilerplate), Isar (NoSQL, different paradigm) |
| **Riverpod** | State management | Type-safe, testable, composable; easier than BLoC; better than vanilla Provider | BLoC (more complex, steeper curve), Provider (less structured) |
| **go_router** | Navigation | Declarative routing similar to Spring MVC URL mapping; supports deep links, nested routes | Navigator 2.0 (verbose), auto_route |
| **pdf (dart)** | PDF export | Pure Dart, no native deps; programmatic PDF generation; good for reports | printing package, platform-native PDF |
| **image_picker** | Photo selection | Official Flutter plugin; handles camera + gallery on both platforms | flutter_image_picker_plus |
| **path_provider** | File storage | Official; finds app sandbox directories on both platforms | N/A |
| **json_serializable** | JSON codegen | Annotation-based serialization; similar to Jackson in Spring Boot | manually written toJson/fromJson |
| **uuid** | ID generation | UUID v4 generation; essential for offline-safe IDs | nanoid |
| **intl** | Date formatting | Official i18n package; locale-aware date display | timeago, jiffy |
| **flutter_secure_storage** | Sensitive data | AES encryption for keys/tokens; backed by Keychain/KeyStore | shared_preferences (not secure) |
| **freezed** | Immutable models | Code-generated immutable value objects; similar to Lombok in Java | Manual copyWith, equatable |
| **fl_chart** | Statistics charts | Beautiful charts for dashboard stats (not tree viz) | charts_flutter |

### 9.4 Tree Visualization Approach

**Recommendation: Custom Flutter Canvas (CustomPainter)**

Rationale: Third-party graph packages (graphview, flutter_treeview) do not handle the specific layout requirements of family trees (spouse pairs, multi-parent connections, generation lanes). A custom canvas gives full control.

Implementation plan:
1. **Phase 1**: Use `InteractiveViewer` + `CustomPaint` for basic tree
2. **Phase 2**: Optimize with `RepaintBoundary`, node virtualization
3. **Phase 3**: Consider `flutter_graphview` fork or custom canvas with WebGL

Layout algorithm: **Reingold-Tilford algorithm** (standard for tree layout). A Dart implementation is straightforward given the algorithm is well-documented.

### 9.5 Project Structure (Clean Architecture)

```
lib/
├── core/
│   ├── errors/          # Failure classes
│   ├── usecases/        # Base use case interface
│   ├── utils/           # UUID generator, date utils
│   └── constants/       # App constants, colors
│
├── features/
│   ├── tree/
│   │   ├── data/
│   │   │   ├── datasources/    # drift DAOs
│   │   │   ├── models/         # drift table defs + JSON models
│   │   │   └── repositories/   # implementations
│   │   ├── domain/
│   │   │   ├── entities/       # pure Dart FamilyTree, Person, Relationship
│   │   │   ├── repositories/   # abstract interfaces
│   │   │   └── usecases/       # AddPersonUseCase, etc.
│   │   └── presentation/
│   │       ├── providers/      # Riverpod providers
│   │       ├── screens/        # Flutter screens
│   │       └── widgets/        # reusable widgets
│   │
│   ├── member/            # same structure
│   ├── relationship/      # same structure
│   ├── visualization/     # tree canvas, layout algorithm
│   ├── search/
│   ├── export_import/
│   └── settings/
│
├── database/
│   ├── app_database.dart  # drift database class
│   ├── tables/            # drift table definitions
│   └── daos/              # drift DAOs
│
└── main.dart
```

**Why this structure?** It mirrors the layered architecture of a Spring Boot application, making the mental model immediately familiar.

### 9.6 Future Backend (Phase 3) — Spring Boot

```
spring-boot-backend/
├── src/main/java/com/familytree/
│   ├── config/         # SecurityConfig, JwtConfig, CorsConfig
│   ├── auth/           # AuthController, JwtService, UserService
│   ├── tree/           # TreeController, TreeService, TreeRepository
│   ├── person/         # PersonController, PersonService, PersonRepository
│   ├── relationship/   # RelationshipController...
│   ├── sync/           # SyncController, DeltaSyncService
│   ├── media/          # MediaController, S3StorageService
│   └── shared/         # BaseEntity, PageResponse, ErrorResponse
```

Tech: Spring Boot 3 + Spring Security (JWT) + Spring Data JPA + PostgreSQL + AWS S3 (media)

---

## 10. Development Roadmap

### Overview

```
Phase 1: MVP Core (16 weeks)     → Usable app, local only
Phase 2: Polish & Features (8w)  → Production-quality
Phase 3: Cloud Sync (12 weeks)   → Multi-device support
Phase 4: Advanced (ongoing)      → GEDCOM, collaboration
```

---

### Phase 1: MVP Core (16 Weeks)

**Goal**: A functional, local-only family tree app you'd be comfortable using yourself.

| Milestone | Weeks | Deliverables |
|---|---|---|
| **M1: Foundation** | 1–2 | Flutter project setup, clean architecture skeleton, drift DB, basic navigation |
| **M2: Data Layer** | 3–4 | All drift DAOs, repositories, codegen, unit tests for data layer |
| **M3: Member CRUD** | 5–6 | Add Member form, Edit Member, Member Profile screen, photo picker |
| **M4: Member List** | 7–8 | All Members list, soft delete with confirmation, basic search |
| **M5: Relationships** | 9–11 | Add Relationship screen, relationship display on profile, derived siblings |
| **M6: Tree Visualization** | 12–14 | CustomPainter canvas, ancestor view, descendant view, pan/zoom |
| **M7: Import/Export + Polish** | 15–16 | JSON export/import, dashboard screen, onboarding, bug fixes |

**Week 1-2 Detail (Foundation)**:
- Install Flutter SDK, Android Studio / VS Code
- Create project with clean architecture folders
- Configure drift database, write first table definitions
- Set up go_router navigation skeleton
- Configure Riverpod
- Write first unit test

**Learning Resources** (Java dev perspective):
- Dart for Java developers: https://dart.dev/guides/language/coming-from/java-to-dart
- drift documentation: https://drift.simonbinder.eu
- Riverpod docs: https://riverpod.dev

---

### Phase 2: Polish & Production (8 Weeks)

**Goal**: App ready for App Store / Play Store submission.

| Milestone | Weeks | Deliverables |
|---|---|---|
| **M8: Multiple Trees** | 1–2 | Tree switcher, tree settings screen, tree delete |
| **M9: PDF Export** | 3–4 | Member list PDF, styled report, share sheet integration |
| **M10: UI Polish** | 5–6 | Dark mode, accessibility audit, responsive layout, animations |
| **M11: Testing & Store Prep** | 7–8 | Integration tests, TestFlight beta, app icons, screenshots, privacy policy |

---

### Phase 3: Cloud Sync (12 Weeks)

**Goal**: Multi-device support and optional family sharing.

| Milestone | Weeks | Deliverables |
|---|---|---|
| **M12: Backend Setup** | 1–3 | Spring Boot project, Docker, PostgreSQL, JWT auth endpoints |
| **M13: Sync API** | 4–6 | Delta sync endpoints, conflict resolution (server-wins), API tests |
| **M14: Flutter Sync** | 7–9 | Sync repository, background sync service, sync status UI |
| **M15: Auth & Accounts** | 10–12 | Registration/login screens, account settings, device management |

---

### Phase 4: Advanced Features (Ongoing)

| Feature | Estimated Effort | Value |
|---|---|---|
| GEDCOM import/export | 3 weeks | High (genealogy standard) |
| Tree image export (PNG/PDF) | 2 weeks | High |
| Life events timeline view | 2 weeks | Medium |
| Media gallery per person | 2 weeks | Medium |
| Family sharing & collaboration | 4 weeks | High |
| DNA hint integration | 4 weeks | Low (complexity) |
| Historical records API (Ancestry, FamilySearch) | 6 weeks | High but complex |
| Localization (multi-language) | 2 weeks | Medium |
| Widget (home screen) | 1 week | Low |

---

## 11. MVP Scope vs Future Scope

### 11.1 MVP (Phase 1 — Ship This First)

```
✅ INCLUDED IN MVP
───────────────────────────────────────────────────────
Core:
  ✅ Single family tree per app install
  ✅ Add/Edit/Delete family members (all core fields)
  ✅ Profile photo from gallery
  ✅ Mark members as living or deceased
  ✅ Approximate dates ("circa")

Relationships:
  ✅ Parent-child (biological, adoptive, foster, step)
  ✅ Spouse/partner (with dates and status)
  ✅ Derived siblings (auto-computed)
  ✅ Multiple spouses support

Visualization:
  ✅ Interactive tree with pan and zoom
  ✅ Ancestor view (upward)
  ✅ Descendant view (downward)
  ✅ Tap node → member profile

Data:
  ✅ JSON export
  ✅ JSON import with validation
  ✅ Offline-first (100% local)

Search:
  ✅ Search by name
  ✅ All members list view

UX:
  ✅ Light theme
  ✅ Onboarding flow
  ✅ Empty state handling
  ✅ Confirmation dialogs for destructive actions
```

### 11.2 Post-MVP (Phase 2+)

```
🔜 PHASE 2 (ENHANCED)
───────────────────────────────────────────────────────
  🔜 Multiple family trees
  🔜 Dark mode
  🔜 PDF export (member list report)
  🔜 Tree settings screen
  🔜 App lock (biometrics/PIN)
  🔜 Member notes/biography rich text
  🔜 Derived extended relationships display (grandparents, cousins)
  🔜 Long-press node context menu (tree view)
  🔜 "Fit to screen" and "Center on root" buttons
  🔜 Accessibility audit & remediation

☁️  PHASE 3 (CLOUD)
───────────────────────────────────────────────────────
  ☁️  User accounts (registration/login)
  ☁️  Cloud backup
  ☁️  Multi-device sync
  ☁️  Family sharing (invite collaborators)
  ☁️  Conflict resolution UI

🚀 PHASE 4 (ADVANCED)
───────────────────────────────────────────────────────
  🚀 GEDCOM import/export
  🚀 Media gallery per member
  🚀 Life events timeline view
  🚀 Tree image/PDF export
  🚀 Localization (multi-language)
  🚀 DNA platform integration hints
  🚀 Merge two trees
  🚀 Push notifications (birthday reminders)
```

### 11.3 Explicit MVP Exclusions

These are intentionally out of scope for MVP to keep delivery timeline realistic:

- ❌ User accounts / authentication (local only)
- ❌ Cloud storage or sync
- ❌ PDF export (Phase 2)
- ❌ GEDCOM format (Phase 4)
- ❌ Collaborative editing (Phase 3)
- ❌ Multiple trees (Phase 2, but architecture supports it)
- ❌ Dark mode (Phase 2)
- ❌ Tree image export (Phase 4)
- ❌ DNA integration (Phase 4)
- ❌ Push notifications (Phase 4)

---

## 12. Risk & Mitigation

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Flutter learning curve delays timeline | High | Medium | Budget 2x time for Weeks 1–4; follow official Flutter codelabs first |
| Tree visualization complexity (custom canvas) | High | High | Start with InteractiveViewer wrapping a basic tree; iterate; this is the hardest feature |
| Database migration errors causing data loss | Medium | Critical | Always test migrations on a copy; write migration rollback logic; test on real device |
| iOS/Android platform differences in image picker | Medium | Low | Use official `image_picker` plugin; test on both platforms early |
| JSON import format changes breaking older exports | Medium | Medium | Version the JSON schema (add `"schema_version": 1` to every export); write migration logic |
| Scope creep extending MVP timeline | High | High | Strictly enforce MVP/Non-MVP boundary; log all ideas in backlog; ship MVP first |
| App rejection from App Store | Low | High | Read Apple's Human Interface Guidelines early; no third-party tracking; clear privacy policy |
| Sibling derivation algorithm performance on large trees | Low | Medium | Cache derived relationships; avoid recomputing on every render; use indexed queries |

---

## Appendix A: JSON Export Schema (v1)

```json
{
  "schema_version": 1,
  "exported_at": "2026-06-04T10:30:00Z",
  "tree": {
    "id": "uuid",
    "name": "Smith Family Tree",
    "description": "Three generations of Smiths",
    "root_person_id": "uuid"
  },
  "persons": [
    {
      "id": "uuid",
      "first_name": "John",
      "last_name": "Smith",
      "gender": "MALE",
      "birth_date": "1940-06-15",
      "birth_date_approx": false,
      "death_date": null,
      "is_living": true,
      "occupation": "Engineer",
      "biography": "Born in Delhi...",
      "profile_photo_filename": "photo_uuid.jpg"
    }
  ],
  "relationships": [
    {
      "id": "uuid",
      "person_id": "uuid-john",
      "related_person_id": "uuid-mary",
      "relationship_type": "PARENT_OF",
      "sub_type": "BIOLOGICAL",
      "start_date": null,
      "end_date": null,
      "is_current": true,
      "notes": null
    }
  ],
  "media_manifest": [
    {
      "id": "uuid",
      "person_id": "uuid",
      "filename": "photo_uuid.jpg",
      "title": "Profile photo"
    }
  ]
}
```

---

## Appendix B: Recommended First-Week Steps

1. Install Flutter SDK (stable channel): `flutter.dev/docs/get-started/install`
2. Run `flutter doctor` — resolve all issues
3. Create project: `flutter create family_tree_app --org com.yourname`
4. Add dependencies to `pubspec.yaml`: drift, riverpod, go_router, freezed, json_serializable
5. Run code generation: `flutter pub run build_runner build`
6. Create folder structure (see Section 9.5)
7. Write your first drift table (`PersonTable`) and DAO
8. Write a unit test that inserts and retrieves a Person
9. Build a basic "Add Person" screen connected to the DAO
10. Celebrate. The hardest part is starting.

---

*This document is a living artifact. Update it as requirements evolve.*
*Version history should be tracked in git alongside the codebase.*
*Next step: Review this PRD, then begin with M1 (Foundation) implementation.*
