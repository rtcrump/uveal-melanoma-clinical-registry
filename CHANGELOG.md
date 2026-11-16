# Changelog

This project uses [semantic versioning](https://semver.org/).

## 0.1.0 (beta), 16 November 2026

The first versioned release. It replaces the unversioned field list posted on 12 November 2026.

- `codebook.csv` now has 105 variables across 11 forms. Variable names carry a form prefix (e.g., `patient_`, `brachy_`, `imaging_`).
- The patient-reported outcome forms (`eq5d5l`, `vf14`, `promum`, `promum_fu`, and `survey`) were removed to avoid potential copyright conflicts.
- The `uv_exposure`, `care_site`, `medical_history`, and `study_info` forms were removed, and `location` is now `tumor_location`.
- `schema.sql` is rebuilt from the new code book: 11 tables, with imaging, brachytherapy, enucleation, and metastasis as repeating tables.
