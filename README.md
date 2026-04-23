# 📡 Site Survey Tool for ISPs

A full-stack web application that helps Internet Service Providers plan and execute network equipment installations across large properties — apartment complexes, office buildings, campuses, and more.

---

## 🚀 Tech Stack

| Layer | Technology |
|---|---|
| Frontend | React.js + Tailwind CSS |
| Backend | Spring Boot (Java) |
| Database | MySQL |
| Auth | JWT (access + refresh tokens) |
| Mobile | Flutter (offline-first) |
| Storage | S3 / MinIO |
| Reports | JasperReports / iText |

---

## ✨ Features

- 🏢 **Property hierarchy** — manage campuses, buildings, floors, and spaces
- 🗺️ **Floor plan viewer** — upload PDFs/images, label and tag spaces on a canvas (MapLibre)
- 📋 **Survey checklists** — create templates, capture responses on web & mobile
- 📶 **RF integration** — import/overlay coverage data from Vistumbler, Kismet, SPLAT!
- 📄 **PDF reports** — auto-generate survey reports with one click
- 📊 **Dashboards** — survey completion and checklist status at a glance
- 🔒 **Role-based access** — org-level permissions + full audit log

---

## 🗂️ Project Milestones

| Milestone | Scope | Timeline |
|---|---|---|
| 1 – Core Setup | Auth, DB schema, project scaffolding | Weeks 1–2 |
| 2 – Floor Plans & Import | File upload, bulk CSV/XLSX import, hierarchy UI | Weeks 3–4 |
| 3 – Labeling & Checklists | Canvas tagging, offline mobile sync, survey capture | Weeks 5–6 |
| 4 – Reports & RF | PDF generation, dashboards, RF tool connectors, UAT | Weeks 7–8 |

---

## ⚙️ Getting Started

### Prerequisites
- Java 17+, Node.js 18+, MySQL 8+, Docker (optional)

### Backend
```bash
cd backend
./mvnw spring-boot:run
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```

### Docker (full stack)
```bash
docker-compose up --build
```

---

## 🗄️ Database

MySQL schema covers: `organizations`, `users`, `properties`, `buildings`, `floors`, `spaces`, `equipment`, `cable_paths`, `checklist_templates`, `checklist_responses`, `rf_scans`, `reports`, `files`, `attachments`, `audit_logs`.

See `/docs/db-diagram.png` for the full ER diagram.

---

## 📁 Repo Structure

```
├── backend/        # Spring Boot API
├── frontend/       # React + Tailwind UI
├── mobile/         # Flutter app
├── docs/           # DB diagram, API docs
└── docker-compose.yml
```

---

## 📄 License

MIT
