# Uveal Melanoma Clinical Registry

This repository is the field list for the clinical registry of the Alberta Ocular Brachytherapy Program. The lab site is [Ocular Oncology Outcomes Research](https://o3r.ca/). The registry itself is the clinical record for adults treated in that program; this repository is the description of that record, not the record.

Two files carry it.

`codebook.csv` is the code book. Each row is one variable: the name, the form, the type, the label, and the codes. A blank label is intentional. We withheld that wording.

`schema.sql` is an empty database with the same forms. It loads in SQLite, and it loads with no rows. Brachytherapy, enucleation, imaging, metastasis, and the questionnaires can have more than one row per patient. The other forms are one row per patient. `studyid` is the key on every table. In REDCap that key is stored on the patient form; it is repeated here so the file stands up without REDCap. Coded answers are text. The codes are in the code book. A checkbox may hold more than one code.

We cut the code book from the REDCap data dictionary exported on 6 October 2026. REDCap remains the system of record. Merging a pull request here does not write to the clinic. We decide what is adopted.

## Forks and proposals

Fork the repository if another centre wants the structure. Open an issue or a pull request if a label is wrong, a code is missing, or a form needs a field, and say what the field is for.

Do not put patient information in an issue, a pull request, or a commit. That includes names, health numbers, dates tied to a person, and screenshots of a chart. Do not paste instrument wording that is not yours to post.

## Wording we left out

EQ-5D-5L item wording belongs to EuroQol. VF-14 wording is not ours to republish, and neither are the CAHPS surgical-care items. Those columns are in the schema under their field names, and the code book marks them withheld. The visit-type and date fields on those forms are included, because those labels are ours.

PROM-UM wording is included. If you use those items, cite Weis E, Jiang J, Skalet AH, Shields CL, Crump RT. Psychometric Results of a New Patient-Reported Outcome Measure for Uveal Melanoma Post-Brachytherapy Treatment: The PROM-UM. *Cancers*. 2023;15:4142. https://doi.org/10.3390/cancers15164142

Name, health number, phone, email, and address columns are marked as identifiers. They are empty here. Leave them empty in any public copy.

## Asking for patient-level data

There is no patient-level file in this repository. A request for data goes through the lab site: [o3r.ca](https://o3r.ca/).

We read the question, the ethics status, and the fields you named from this code book. A file moves only after that review and a signed data-use agreement. If there is a charge, it is a cost-recovery quote for preparing and transferring the extract, issued through the university. There is no price list in this repository.

## License

The code book and the empty schema are [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/). Credit the Uveal Melanoma Clinical Registry, Ocular Oncology Outcomes Research. The license does not cover the withheld instrument wording, and it does not cover patient data.
