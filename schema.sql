-- Uveal Melanoma Clinical Registry
-- Empty database definition. No patient rows.
-- Built from the REDCap data dictionary exported 6 October 2026.
-- REDCap remains the system of record. This file does not create the clinical database.
-- studyid is the record key. REDCap stores it on patient_information;
-- it is repeated here on every table so a fork can stand up without REDCap.
-- Repeating tables allow more than one row per patient (a second plaque,
-- another image set, another questionnaire). One-row tables do not.
-- Coded fields are TEXT. The codes are in codebook.csv.
-- A checkbox can hold more than one code. See the code book.
-- Columns marked identifier exist so the structure is honest.
-- Do not load names, health numbers, or other identifiers into a public copy.
-- EQ-5D-5L, VF-14, and CAHPS columns are names only. Item wording is withheld.

-- patient_information: one row per patient
CREATE TABLE "patient_information" (
  "studyid" TEXT,
  "firstname" TEXT,  -- identifier
  "lastname" TEXT,  -- identifier
  "phn" TEXT,  -- identifier
  "dob" TEXT,
  "phone" TEXT,  -- identifier
  "email" TEXT,  -- identifier
  "address1" TEXT,  -- identifier
  "address2" TEXT,  -- identifier
  "city" TEXT,
  "province" TEXT,
  "postalcode" TEXT,  -- identifier
  PRIMARY KEY ("studyid")
);

-- participant_information: one row per patient
CREATE TABLE "participant_information" (
  "studyid" TEXT NOT NULL,
  "yearofbirth" INTEGER,
  "sex" TEXT,
  "smokingstatus" TEXT,
  "educationlevel" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- care_site: one row per patient
CREATE TABLE "care_site" (
  "studyid" TEXT NOT NULL,
  "care_location" TEXT,
  "accuro" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- medical_history: one row per patient
CREATE TABLE "medical_history" (
  "studyid" TEXT NOT NULL,
  "biop_date" TEXT,
  "genetics" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- study_info: one row per patient
CREATE TABLE "study_info" (
  "studyid" TEXT NOT NULL,
  "coog2" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- location: one row per patient
CREATE TABLE "location" (
  "studyid" TEXT NOT NULL,
  "tumor_location" TEXT,  -- checkbox; more than one code allowed
  "choroid" TEXT,
  "ciliary" TEXT,
  "iris" TEXT,
  "extrascleral" TEXT,
  "conjunctiva" TEXT,
  "melanoma" TEXT,
  "hemangioma" TEXT,
  "metastasized_elsewhere" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- tumor_characteristics: one row per patient
CREATE TABLE "tumor_characteristics" (
  "studyid" TEXT NOT NULL,
  "us_apex" REAL,
  "rx_pt" REAL,
  "radial" REAL,
  "circumferential" REAL,
  "surface_area" REAL,
  "retinal_surface" REAL,
  "macula_tumor" REAL,
  "optic_edge" REAL,
  "tumor_nerve" REAL,
  "tumor_fovea" REAL,
  "t_stage" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- imaging: more than one row per patient
CREATE TABLE "imaging" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "fundus" TEXT,
  "fundus_export" TEXT,
  "image_id" TEXT,
  "pet" TEXT,
  "ct" TEXT,
  "ct_scan" TEXT,  -- checkbox; more than one code allowed
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
  "castle_id" TEXT,  -- identifier
  "collection_date" TEXT,
  "order_date" TEXT,
  "receipt_date" TEXT,
  "report_date" TEXT,
  "specimen_id" TEXT,
  "castle_results" TEXT,
  "discriminant_score" REAL,
  "prame" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- brachytherapy: more than one row per patient
CREATE TABLE "brachytherapy" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "plaque" TEXT,
  "plaque_date" TEXT,
  "duration" REAL,
  "plaque_diameter" INTEGER,
  "notch" TEXT,
  "ep930" TEXT,
  "ep2342" TEXT,
  "ep933" TEXT,
  "ep1821" TEXT,
  "ep2343" TEXT,
  "ep1513" TEXT,
  "ep2029n" TEXT,
  "ep2340n" TEXT,
  "ep2031" TEXT,
  "seeds" INTEGER,
  "activity" REAL,
  "i125" TEXT,
  "pd103" TEXT,
  "rx_plaque" REAL,
  "apex_plaque" REAL,
  "sclera" REAL,
  "lens_centre" REAL,
  "optic_disc" REAL,
  "fovea" INTEGER,
  "rx_apex" INTEGER,
  "apex_dose" INTEGER,
  "sclera_dose" INTEGER,
  "lens_dose" REAL,
  "fovea_dose" REAL,
  "disc_dose" REAL,
  "superior_rectus" TEXT,
  "medial_rectus" TEXT,
  "inferior_rectus" TEXT,
  "lateral_rectus" TEXT,
  "superior_oblique" TEXT,
  "inferior_oblique" TEXT,
  "total_muscles" INTEGER,
  "plaque_hematoma" TEXT,
  "plaque_vessels" INTEGER,
  "plaques_notes" TEXT,
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- enucleation: more than one row per patient
CREATE TABLE "enucleation" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "enucleation" TEXT,
  "enucleation_brachytherapy" TEXT,
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
  "dead" TEXT,
  "dead_date" TEXT,  -- identifier
  "dead_cause" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- uv_exposure: one row per patient
CREATE TABLE "uv_exposure" (
  "studyid" TEXT NOT NULL,
  "diagnosis" TEXT,
  "diagnosisspecific" TEXT,
  "location" TEXT,  -- checkbox; more than one code allowed
  "birthlocation" TEXT,
  "currentcity" TEXT,
  "youthcities" TEXT,
  "adultcities" TEXT,
  "freckleage" TEXT,
  "umdiagnosis" TEXT,
  "electrician" TEXT,
  "welder" TEXT,
  "sunscreen" TEXT,
  "shirt" TEXT,
  "hat" TEXT,
  "sunglasses" TEXT,
  "corrective" TEXT,
  "umbrella" TEXT,
  "sunexposure" TEXT,
  "spf" TEXT,
  "skinreaction" TEXT,
  "sunburnyouth" TEXT,
  "sunburn20" TEXT,
  "sunburn30" TEXT,
  "sunburn10" TEXT,
  "blisteryouth" TEXT,
  "blister20" TEXT,
  "blister30" TEXT,
  "blister10" TEXT,
  "sunbedyouth" TEXT,
  "sunbed20" TEXT,
  "sunbed30" TEXT,
  "sunbed10" TEXT,
  "sunbedtan" TEXT,
  "sunbedgoggles" TEXT,
  "sunbedgoggles20" TEXT,
  "sunbedgoggles30" TEXT,
  "sunbedgoggles10" TEXT,
  "sunbedopengoggles" TEXT,
  "sunbedopengoggles20" TEXT,
  "sunbedopengoggles30" TEXT,
  "sunbedopengoggles10" TEXT,
  "sunbedopennogoggles" TEXT,
  "sunbedopennogoggles20" TEXT,
  "sunbedopennogoggles30" TEXT,
  "sunbedopennogoggles10" TEXT,
  "tan12months" TEXT,
  "outside" TEXT,
  "outside20" TEXT,
  "outside30" TEXT,
  "outside10" TEXT,
  "outsideweekend" TEXT,
  "outsideweekend20" TEXT,
  "outsideweekend30" TEXT,
  "outsideweekend10" TEXT,
  "outsidenotsummer" TEXT,
  "outsidenotsummer20" TEXT,
  "outsidenotsummer30" TEXT,
  "outsidenotsummer10" TEXT,
  "outsidenonsummerweekend" TEXT,
  "outsidenonsummerweekend20" TEXT,
  "outsidenonsummerweekend30" TEXT,
  "outsidenonsummerweekend10" TEXT,
  "reflected" TEXT,
  "reflectedlight" TEXT,
  "reflectedlight20" TEXT,
  "reflectedlight30" TEXT,
  "reflectedlight10" TEXT,
  "eyecolor" TEXT,
  "skincolor" TEXT,
  "history" TEXT,
  "organ" TEXT,
  "illnesses" TEXT,  -- checkbox; more than one code allowed
  "illnesses2" TEXT,  -- checkbox; more than one code allowed
  "illnessesrelative" TEXT,  -- checkbox; more than one code allowed
  "cancer" TEXT,
  "immuno" TEXT,
  PRIMARY KEY ("studyid"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- eq5d5l: more than one row per patient
CREATE TABLE "eq5d5l" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "eq5d_type" TEXT,
  "eq5d_date" TEXT,  -- identifier
  "eq5d_mobility" TEXT,  -- item text withheld
  "eq5d_selfcare" TEXT,  -- item text withheld
  "eq5d_activities" TEXT,  -- item text withheld
  "eq5d_pain" TEXT,  -- item text withheld
  "eq5d_anxiety" TEXT,  -- item text withheld
  "eq5d_vas" REAL,  -- item text withheld
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- vf14: more than one row per patient
CREATE TABLE "vf14" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "vf14_type" TEXT,
  "vf14_date" TEXT,  -- identifier
  "vf141" TEXT,  -- item text withheld
  "vf142" TEXT,  -- item text withheld
  "vf143" TEXT,  -- item text withheld
  "vf144" TEXT,  -- item text withheld
  "vf145" TEXT,  -- item text withheld
  "vf146" TEXT,  -- item text withheld
  "vf147" TEXT,  -- item text withheld
  "vf148" TEXT,  -- item text withheld
  "vf149" TEXT,  -- item text withheld
  "vf1410" TEXT,  -- item text withheld
  "vf1411" TEXT,  -- item text withheld
  "vf1412" TEXT,  -- item text withheld
  "vf1413" TEXT,  -- item text withheld
  "vf1414" TEXT,  -- item text withheld
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- promum: more than one row per patient
CREATE TABLE "promum" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "promum_type" TEXT,
  "promum_date" TEXT,  -- identifier
  "a1" TEXT,
  "a2" TEXT,
  "a3" TEXT,
  "a4" TEXT,
  "a5" TEXT,
  "b1" TEXT,
  "b2" TEXT,
  "c1" TEXT,
  "c2" TEXT,
  "c3" TEXT,
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- promum_fu: more than one row per patient
CREATE TABLE "promum_fu" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "fu_date" TEXT,  -- identifier
  "fu1" TEXT,
  "fu2" TEXT,
  "fu3" TEXT,
  "fu4" TEXT,
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);

-- survey: more than one row per patient
CREATE TABLE "survey" (
  "studyid" TEXT NOT NULL,
  "redcap_repeat_instance" INTEGER NOT NULL,
  "code" REAL,
  "cahps_date" TEXT,
  "cahps_001" TEXT,  -- item text withheld
  "cahps_002" TEXT,  -- item text withheld
  "cahps_003" TEXT,  -- item text withheld
  "cahps_004" TEXT,  -- item text withheld
  "cahps_005" TEXT,  -- item text withheld
  "cahps_006" TEXT,  -- item text withheld
  "cahps_007" TEXT,  -- item text withheld
  "cahps_008" TEXT,  -- item text withheld
  "cahps_009" TEXT,  -- item text withheld
  "cahps_010" TEXT,  -- item text withheld
  "cahps_011" TEXT,  -- item text withheld
  "cahps_012" TEXT,  -- item text withheld
  "cahps_013" TEXT,  -- item text withheld
  "cahps_014" TEXT,  -- item text withheld
  "cahps_015" TEXT,  -- item text withheld
  "cahps_016" TEXT,  -- item text withheld
  "cahps_017" TEXT,  -- item text withheld
  "cahps_018" TEXT,  -- item text withheld
  "cahps_019" TEXT,  -- item text withheld
  "cahps_020" TEXT,  -- item text withheld
  "cahps_021" TEXT,  -- item text withheld
  "cahps_022" TEXT,  -- item text withheld
  "cahps_023" TEXT,  -- item text withheld
  "cahps_024" TEXT,  -- item text withheld
  "cahps_025" TEXT,  -- item text withheld
  "cahps_026" TEXT,  -- item text withheld
  "cahps_027" TEXT,  -- item text withheld
  "cahps_028" TEXT,  -- item text withheld
  "cahps_029" TEXT,  -- item text withheld
  "cahps_030" TEXT,  -- item text withheld
  "cahps_031" TEXT,  -- item text withheld
  "cahps_032" TEXT,  -- item text withheld
  "cahps_033" TEXT,  -- item text withheld
  "cahps_034" TEXT,  -- item text withheld
  "cahps_035" TEXT,  -- item text withheld
  "cahps_036" TEXT,  -- item text withheld
  "cahps_037" TEXT,  -- item text withheld
  "cahps_038" TEXT,  -- item text withheld
  "cahps_039" TEXT,  -- item text withheld
  "cahps_040" TEXT,  -- item text withheld
  "cahps_041" TEXT,  -- item text withheld
  "cahps_042" TEXT,  -- item text withheld
  "cahps_043" TEXT,  -- item text withheld
  "cahps_044" TEXT,  -- item text withheld, checkbox; more than one code allowed
  "cahps_045" TEXT,  -- item text withheld
  "cahps_046" TEXT,  -- item text withheld, checkbox; more than one code allowed
  "cahps_047" TEXT,  -- item text withheld
  "eye_001" TEXT,
  "eye_002" TEXT,
  "eye_003" TEXT,
  "eye_004" TEXT,
  "eye_005" TEXT,
  "eye_006" TEXT,
  "eye_007" TEXT,
  "eye_008" TEXT,
  "eye_009" TEXT,
  "eye_010" TEXT,
  "eye_011" TEXT,
  "eye_012" TEXT,
  "eye_013" TEXT,
  "eye_0143a" TEXT,
  "eye_014b" TEXT,
  "eye_014c" TEXT,
  "eye_014d" TEXT,
  "eye_014e" TEXT,
  "eye_014f" TEXT,
  "eye_015" TEXT,
  "eye_016" TEXT,
  "eye_017" TEXT,
  "eye_018" TEXT,
  "eye_019" TEXT,
  "eye_020" TEXT,
  "eye_021" TEXT,
  PRIMARY KEY ("studyid", "redcap_repeat_instance"),
  FOREIGN KEY ("studyid") REFERENCES "patient_information" ("studyid")
);
