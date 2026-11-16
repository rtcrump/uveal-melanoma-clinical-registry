-- Uveal Melanoma Clinical Registry, version 0.1.0 (beta)
-- Empty database definition built from codebook.csv. No patient rows.
-- REDCap remains the system of record. This file does not create the clinical database.
-- studyid is the record key. REDCap stores it on patient_information;
-- it is repeated here on every table so a fork can stand up without REDCap.
-- Repeating tables allow more than one row per patient (a second plaque,
-- another image set). One-row tables do not.
-- Coded fields are TEXT. The codes are in codebook.csv.
-- A checkbox can hold more than one code. See the code book.
-- Columns marked identifier exist so the structure is honest.
-- Do not load names, health numbers, dates, or other identifiers into a public copy.

-- patient_information: one row per patient
CREATE TABLE "patient_information" (
  "studyid" TEXT,
  "patient_firstname" TEXT,  -- identifier
  "patient_lastname" TEXT,  -- identifier
  "patient_phn" TEXT,  -- identifier
  "patient_dob" TEXT,  -- identifier
  "patient_phone" TEXT,  -- identifier
  "patient_email" TEXT,  -- identifier
  "patient_address1" TEXT,  -- identifier
  "patient_address2" TEXT,  -- identifier
  "patient_city" TEXT,
  "patient_province" TEXT,
  "patient_postal" TEXT,  -- identifier
  PRIMARY KEY ("studyid")
);

-- participant_information: one row per patient
CREATE TABLE "participant_information" (
  "studyid" TEXT NOT NULL,
  "patient_birthyear" INTEGER,
  "patient_sex" TEXT,
  "patient_smokingstatus" TEXT,
  "patient_educationlevel" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- tumor_location: one row per patient
CREATE TABLE "tumor_location" (
  "studyid" TEXT NOT NULL,
  "location_eye" TEXT,  -- checkbox; more than one code allowed
  "location_choroid" TEXT,
  "location_ciliary" TEXT,
  "location_iris" TEXT,
  "location_extrascleral" TEXT,
  "location_conjunctiva" TEXT,
  "location_melanoma" TEXT,
  "location_hemangioma" TEXT,
  "location_metastasized" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- tumor_characteristics: one row per patient
CREATE TABLE "tumor_characteristics" (
  "studyid" TEXT NOT NULL,
  "character_usapex" REAL,
  "character_rxpt" REAL,
  "character_radial" REAL,
  "character_circumferential" REAL,
  "character_surfacearea" REAL,
  "character_retinalsurface" REAL,
  "character_maculatumor" REAL,
  "character_opticedge" REAL,
  "character_nerve" REAL,
  "character_fovea" REAL,
  "character_tstage" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- imaging: more than one row per patient
CREATE TABLE "imaging" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "imaging_fundus" TEXT,
  "imaging_fundusdate" TEXT,  -- identifier
  "imaging_pet" TEXT,
  "imaging_petdate" TEXT,  -- identifier
  "imaging_ct" TEXT,
  "imaging_ctdate" TEXT,  -- identifier
  "imaging_ctlocation" TEXT,  -- checkbox; more than one code allowed
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- tfsom: one row per patient
CREATE TABLE "tfsom" (
  "studyid" TEXT NOT NULL,
  "tfsom_epicentre" TEXT,
  "tfsom_diameter" REAL,
  "tfsom_thickness" REAL,
  "tfsom_pigment" TEXT,
  "tfsom_subretinal" TEXT,
  "tfsom_drusen" TEXT,
  "tfsom_hollowness" TEXT,
  "tfsom_lesion" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- gep: one row per patient
CREATE TABLE "gep" (
  "studyid" TEXT NOT NULL,
  "gep_id" TEXT,  -- identifier
  "gep_collectiondate" TEXT,  -- identifier
  "gep_reportdate" TEXT,  -- identifier
  "gep_specimenid" TEXT,
  "gep_results" TEXT,
  "gep_prame" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- brachytherapy: more than one row per patient
CREATE TABLE "brachytherapy" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "brachy_undergone" TEXT,
  "brachy_plaquedate" TEXT,  -- identifier
  "brachy_duration" REAL,
  "brachy_plaquediameter" INTEGER,
  "brachy_notch" TEXT,
  "brachy_ep930" TEXT,
  "brachy_ep2342" TEXT,
  "brachy_ep933" TEXT,
  "brachy_ep1821" TEXT,
  "brachy_ep2343" TEXT,
  "brachy_ep1513" TEXT,
  "brachy_ep2029n" TEXT,
  "brachy_ep2340n" TEXT,
  "brachy_ep2031" TEXT,
  "brachy_seeds" INTEGER,
  "brachy_activity" REAL,
  "brachy_i125" TEXT,
  "brachy_pd103" TEXT,
  "brachy_rxplaque" REAL,
  "brachy_apexplaque" REAL,
  "brachy_sclera" REAL,
  "brachy_lenscentre" REAL,
  "brachy_opticdisc" REAL,
  "brachy_fovea" INTEGER,
  "brachy_rxapex" INTEGER,
  "brachy_apexdose" INTEGER,
  "brachy_scleradose" INTEGER,
  "brachy_lensdose" REAL,
  "brachy_foveadose" REAL,
  "brachy_discdose" REAL,
  "brachy_superiorrectus" TEXT,
  "brachy_medialrectus" TEXT,
  "brachy_inferiorrectus" TEXT,
  "brachy_lateralrectus" TEXT,
  "brachy_superioroblique" TEXT,
  "brachy_inferioroblique" TEXT,
  "brachy_totalmuscles" INTEGER,
  "brachy_plaquehematoma" TEXT,
  "brachy_plaquevessels" INTEGER,
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- enucleation: more than one row per patient
CREATE TABLE "enucleation" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "enucleation_undergone" TEXT,
  "enucleation_brachy" TEXT,
  "enucleation_date" TEXT,  -- identifier
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- metastatic: more than one row per patient
CREATE TABLE "metastatic" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "metastatic" TEXT,
  "metastatic_date" TEXT,  -- identifier
  "metastatic_location" TEXT,  -- checkbox; more than one code allowed
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- death: one row per patient
CREATE TABLE "death" (
  "studyid" TEXT NOT NULL,
  "death" TEXT,
  "death_date" TEXT,  -- identifier
  "death_cause" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);
