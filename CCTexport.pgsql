--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clinical_trials; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.clinical_trials (
    nct numeric(8,0) NOT NULL,
    trial_name text NOT NULL,
    description text,
    status character varying(30) NOT NULL,
    number_of_patients integer NOT NULL,
    type character varying(20) NOT NULL,
    phase text[],
    start_date date NOT NULL,
    end_date date NOT NULL,
    age text[],
    sex character varying(6),
    CONSTRAINT clinical_trials_check CHECK ((end_date > start_date)),
    CONSTRAINT clinical_trials_number_of_patients_check CHECK ((number_of_patients >= 0)),
    CONSTRAINT clinical_trials_phase_check CHECK ((phase <@ ARRAY['n/a'::text, 'early phase 1'::text, 'phase 1'::text, 'phase 2'::text, 'phase 3'::text, 'phase 4'::text])),
    CONSTRAINT clinical_trials_status_check CHECK (((status)::text = ANY ((ARRAY['active not recruiting'::character varying, 'enrolling by invitation'::character varying, 'not yet recruiting'::character varying, 'recruiting'::character varying, 'terminated'::character varying, 'unknown'::character varying, 'withdrawn'::character varying, 'completed'::character varying])::text[]))),
    CONSTRAINT clinical_trials_type_check CHECK (((type)::text = ANY ((ARRAY['interventional'::character varying, 'observational'::character varying])::text[])))
);


ALTER TABLE public.clinical_trials OWNER TO mapeter;

--
-- Name: condition; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.condition (
    cancer_type text NOT NULL
);


ALTER TABLE public.condition OWNER TO mapeter;

--
-- Name: eligibility; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.eligibility (
    age text[] NOT NULL,
    sex character varying(6) NOT NULL,
    CONSTRAINT eligibility_age_check CHECK ((age <@ ARRAY['child'::text, 'adult'::text, 'older adult'::text])),
    CONSTRAINT eligibility_sex_check CHECK (((sex)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying, 'all'::character varying])::text[])))
);


ALTER TABLE public.eligibility OWNER TO mapeter;

--
-- Name: institution; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.institution (
    institution_name text NOT NULL,
    contact_person_name character varying(30),
    phone_number character varying(20) NOT NULL,
    email character varying(50) NOT NULL,
    address_street character varying(50),
    address_city character varying(30),
    address_state character varying(30),
    address_zipcode character varying(10),
    address_country character varying(30)
);


ALTER TABLE public.institution OWNER TO mapeter;

--
-- Name: intervention; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.intervention (
    treatment character varying(200) NOT NULL,
    treatment_type character varying(50) NOT NULL
);


ALTER TABLE public.intervention OWNER TO mapeter;

--
-- Name: location; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.location (
    location_name text NOT NULL,
    address_city character varying(30) NOT NULL,
    address_state character varying(30),
    address_zipcode character varying(30),
    address_country character varying(30) NOT NULL
);


ALTER TABLE public.location OWNER TO mapeter;

--
-- Name: saves; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.saves (
    user_name character varying(30) NOT NULL,
    nct numeric(8,0) NOT NULL
);


ALTER TABLE public.saves OWNER TO mapeter;

--
-- Name: sponsors; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.sponsors (
    nct numeric(8,0) NOT NULL,
    institution_name text NOT NULL
);


ALTER TABLE public.sponsors OWNER TO mapeter;

--
-- Name: study; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.study (
    primary_measurements text,
    secondary_measurements text,
    other text,
    nct numeric(8,0) NOT NULL,
    cancer_type text NOT NULL,
    treatment character varying(200) NOT NULL,
    treatment_type character varying(50) NOT NULL
);


ALTER TABLE public.study OWNER TO mapeter;

--
-- Name: takes_place; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.takes_place (
    location_name text NOT NULL,
    nct numeric(8,0) NOT NULL
);


ALTER TABLE public.takes_place OWNER TO mapeter;

--
-- Name: user_account; Type: TABLE; Schema: public; Owner: mapeter
--

CREATE TABLE public.user_account (
    user_name character varying(30) NOT NULL,
    user_phone_number character varying(20),
    user_email character varying(50) NOT NULL,
    user_password character varying(50) NOT NULL
);


ALTER TABLE public.user_account OWNER TO mapeter;

--
-- Data for Name: clinical_trials; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.clinical_trials (nct, trial_name, description, status, number_of_patients, type, phase, start_date, end_date, age, sex) FROM stdin;
4414150	A Trial of SHR-1802 in Patients With Failure of Standard Treatment for Advanced Malignant Tumours	This is the first study to test SHR-1802 in humans. The primary purpose of this study is to see if SHR-1802 is safe and tolerable for patients with locally advanced/unresectable or metastatic malignancies that are refractory to available therapy or for which no standard therapy is available.	completed	28	interventional	{"phase 1"}	2020-06-17	2022-03-15	{adult,"older adult"}	all
4125524	Terahertz Metamaterials for Tumour Marker Concentration Identification	The research the investigators plan to undertake involves the use of a metamaterial at terahertz frequencies. Serum samples will be tested using the metamaterial to determine if this method can be used to measure the concentration of tumour markers present in the sample. Patients who have been tested for CEA, LDH, CA-125, CA 19-9, CA 15-3, total-hCG and AFP will be used for both the positive and negative samples.	unknown	520	observational	{n/a}	2021-05-17	2021-10-01	{adult,"older adult"}	all
3621124	Maladaptive Adipose Tissue Activity in Cancer	The purpose of this pilot research is to study brown adipose tissue, a type of fat that increases metabolism (burns energy) during exposure to cold, and how it may contribute to the weight loss observed in cancer.	terminated	3	observational	{n/a}	2018-08-16	2020-05-20	{adult,"older adult"}	all
1750580	Safety Study of BMS-986015 (Anti-KIR) in Combination With Ipilimumab in Subjects With Selected Advanced Tumor	To assess the safety and tolerability, characterize the dose-limiting toxicities (DLTs), and identify the maximally tolerated dose (MTD) of BMS-986015 given in combination with ipilimumab in subjects with select advanced (metastatic and/or unresectable) solid tumors.	completed	22	interventional	{"phase 1"}	2012-12-01	2015-04-01	{adult,"older adult"}	all
1714739	A Study of an Anti-KIR Antibody Lirilumab in Combination With an Anti-PD1 Antibody Nivolumab and Nivolumab Plus an Anti-CTLA-4 Ipilimumab Antibody in Patients With Advanced Solid Tumors	To assess the safety and tolerability and preliminary anti-tumor activity of lirilumab (BMS-986015) given in combination with nivolumab (BMS-936558) and to identify dose limiting toxicities (DLTs) and the maximally tolerated dose (MTD) of the combination. In addition, to assess the combinations of lirilumab and nivolumab or lirilumab and nivolumab plus ipilimumab (BMS-734016) in subjects with advanced (metastatic and/or unresectable) refractory solid tumors.	completed	337	interventional	{"phase 1","phase 2"}	2012-10-07	2019-12-13	{adult,"older adult"}	all
3052868	Analysis of Neurocognitive Elements of Attention After Chemotherapy	Data for this study will be obtained from the University of Texas Southwestern Medical Center Simmons Comprehensive Cancer Center. Participants will be recruited through Simmons Cancer Center. One hundred female breast cancer patients who have completed adjuvant chemotherapy will be enrolled. In order to reach this number, it is estimated that up to 125 eligible participants will need to be recruited. The study will last approximately two years. Participants will undergo one cognitive testing session, and each subject's total participation time will last no more than two hours.	completed	75	interventional	{n/a}	2011-07-01	2014-05-01	{adult,"older adult"}	female
4396223	Avelumab and Methotrexate in in Low-risk Gestational Trophoblastic Neoplasias as First Line Treatment	Gestational trophoblastic neoplasias (GTN) are characterized by the persistence of elevated hCG titers after complete uterine evacuation of a partial hydatidiform mole (PHM) or a complete hydatidiform mole.\n\nLow-risk GTN patients (FIGO score ‚â§ 6) are commonly treated with single agent treatment (methotrexate or actinomycin-D) The cure rate, assessed by hCG normalization, is obtained in 65 to 75% of patients with these agents GTN patients with resistance to these treatments are treated with another single agent drug or polychemotherapy regimens, such as EMA-CO or BEP regimen.\n\nChemotherapy standard regimens are old and toxic for these young lady patients, with potential long term effects detrimental for further maternity and quality of life\n\nThere is a strong rational for investigating the anti-PDL1 monoclonal antibody avelumab in chemoresistant GTN patients. Several elements suggest that the normal pregnancy immune tolerance is "hijacked" by GTN cell for proliferating :\n\n* Spontaneous regressions of metastastic GTN are regularly observed, thereby the role of immune system for rejecting GTN cells.\n* Strong and constant overexpression of PDL1 and NK cells has been found in all subtypes and settings of GTN tumors from French reference gestational trophoblastic center.\n* Complete and durable responses to pembrolizumab were reported in 3 patients with multi-chemoresistant GTN in United Kingdom.\n* Three cases of hCG normalization with avelumab in 6 patients with chemo-resistant GTN enrolled in TROPHIMMUN cohort A (resistant to a mono-chemotherapy).\n* Cytotoxicity of avelumab is mediated through antibody dependent cell cytotoxicity (ADCC) by NK cells.	recruiting	26	interventional	{"phase 1","phase 2"}	2020-02-12	2026-07-12	{adult,"older adult"}	female
3135769	Avelumab in Chemo-resistant Gestational Trophoblastic Neoplasias	Gestational trophoblastic neoplasias (GTN) are characterized by the persistence of elevated hCG titers after complete uterine evacuation of a partial hydatidiform mole (PHM) or a complete hydatidiform mole. GTN patients are commonly treated with single agent treatment (methotrexate or actinomycine-D) or polychemotherapy (first line treatment EMA-CO) according to the predicted risk of resistance to single agent treatment by FIGO score. GTN patients with resistance to these treatments are treated with another single agent drug or polychemotherapy regimens.\n\nChemotherapy standard regimens are old and toxic for these young lady patients, with potential long term effects detrimental for further maternity and quality of life. There is a need for modern targeted agents with better benefit/toxicity profiles.\n\nThere is a strong rational for investigating the anti-PDL1 monoclonal antibody avelumab in chemoresistant GTN patients. Several elements suggest that the normal pregnancy immune tolerance is "hijacked" by GTN cell for proliferating :\n\n* Spontaneous regressions of metastasic GTN are regularly observed, thereby the role of immune system for rejecting GTN cells.\n* Strong and constant overexpression of PDL1 and NK cells has been found in all subtypes and settings of GTN tumors from French reference gestational trophoblastic center.\n* The case of complete and durable response to pembrolizumab was reported in a patient with multi chemo-resistant GTN.	completed	24	interventional	{"phase 2"}	2017-02-21	2021-03-17	{adult,"older adult"}	female
2534506	Study of Urelumab in Subjects With Advanced and/or Metastatic Malignant Tumors	The purpose of this study is to assess the safety and tolerability of BMS-663513 in subjects with advanced and/or metastatic malignant tumors.	completed	18	interventional	{"phase 1"}	2015-11-06	2016-11-11	{adult,"older adult"}	all
2582827	QUILT-3.014: A Trial of ABI-011 Administered Weekly in Patients With Advanced Solid Tumors or Lymphomas	The primary objective of study CA601.2 is to determine the maximum tolerated dose (MTD) or recommended {phase 2} dose (RP2D) of ABI-011 when administered by intravenous (IV) infusion on Days 1, 8, and 15, followed by a week of rest, in patients with advanced solid tumor malignancies or lymphomas. The MTD will be determined using a standard 3+3 design. The secondary objectives are to evaluate the safety and toxicity profile, to evaluate the plasma pharmacokinetics (PK), to assess the biological activity and pharmacodynamics, and to make a preliminary assessment of tumor response in patients with advanced solid tumors or lymphomas. The exploratory objectives are to determine the genomic and proteomic profile of patients' tumors to identify gene mutations, gene amplifications, levels of protein expression, and pinpoint oncoproteins. Correlations between genomic/proteomic profiles and efficacy outcomes will be assessed and principal metabolites of ABI-011 will be determined, if possible.\n\nApproximately 45-60 patients will be treated to determine dose limiting toxicities (DLTs), the MTD, and/or RP2D of ABI-011. Once the RP2D is identified, expansion of this cohort (up to 10 patients) will occur.	withdrawn	0	interventional	{"phase 1"}	2017-11-13	2019-08-23	{adult,"older adult"}	all
3788382	Failure to Adjuvant Therapy After Pancreatic Resection for Pancreatic Cancer	This study aims to evaluate the rate of patients submitted to pancreatic resection for pancreatic cancer, who fail to access to adjuvant therapy or do not complete adjuvant therapy. The purpose is to give an overview concerning the most frequent conditions and/or reasons associated with failure or omission of adjuvant therapy.	recruiting	316	observational	{n/a}	2019-01-01	2023-06-30	{adult,"older adult"}	all
4637256	Evaluation of Outcomes From Treatment of Benign or Malignant Gastroesophageal Diseases	This study will be a retrospective chart review of patients who have been diagnosed with benign or malignant pancreatic disease under the practice of Dr. Rohan Jeyarajah, M.D., Dr. Houssam Osman M.D., and Dr. Edward Cho M.D., Sc.M. at Methodist Health System Hospital in Richardson, TX. The Investigators plan to conduct an analysis of patients meeting the inclusion criteria from 2005 to present. Study will also be conducted by the PI, Sub-Is, surgery fellows, office staff and clinical research coordinator who are delegated to do by the PI. Data will be obtained by looking through either the investigator's patients from their practice or through a national database. Data will be analyzed primarily by the study conductors.	recruiting	500	observational	{n/a}	2019-03-06	2025-01-30	{adult,"older adult"}	all
5076266	COVID-19 Related Financial Hardship and Distress in Women Who Decline TMIST (EA1151) Participation	The purpose of this study is to find out whether factors that lead Women of Color to decline participation in the breast cancer screening trial EA1151 (TMIST) differ from non-women of color.	active not recruiting	14	observational	{n/a}	2022-03-14	2024-10-30	{adult,"older adult"}	female
3359239	Atezolizumab Given in Combination With a Personalized Vaccine in Patients With Urothelial Cancer	The purpose of this study is to determine the good and bad effects of atezolizumab given in combination with a personalized cancer vaccine in patients with urothelial cancer either after surgery to remove organ where the tumor arose (for example, removal of the bladder) or for urothelial cancer that has spread to other organs.	completed	10	interventional	{"phase 1"}	2019-05-08	2021-10-12	{adult,"older adult"}	all
876408	Review of Molecular Profiling-Real Time Polymerase Chain Reaction (Rt-Pcr) in Unknown Primary Cancer	This will be a retrospective review of 30 patients with unknown primary cancer who have had commercially available RT-PCR assays performed on biopsied tumors, in order to determine if the assay results are consistent with clinical features and useful for planning initial therapy or changing therapy.	completed	30	observational	{n/a}	2009-05-01	2010-11-01	{adult,"older adult"}	all
2159742	Prospective Follow-up of Outcomes in Patients Receiving Photodynamic Therapy for Neoplastic Diseases	From 1996-present, we have used photodynamic therapy (PDT) to treat a number of neoplastic diseases both on prospective research protocols (for head and neck cancer, pleural malignancies, peritoneal carcinomatosis or sarcomatosis and prostate cancer) as well as for FDA approved and off label or compassionate exemption indications (neoplasms of the skin, bronchus, esophagus, head and neck and pleura). The goal of this treatment is to maximize quality of life and organ function while minimizing the chance of tumor recurrence. As such, we would like to retrospectively review the treatment parameters of all patients who undergo/underwent PDT (including operative notes and photodynamic therapy records) and treatment outcomes (including all organ functions, performance status, tumor recurrence, laboratory values and any other data present in the routinely documented follow up visits). For patients who have died or were lost to follow-up prior to initiation of this study, a retrospective review of available data will be performed. For patients who are still being actively followed after PDT or who receive PDT after the initiation of this study, informed consent will be obtained for obtaining continued follow-up data prospectively and any previous data will be collected retrospectively.. These subjects will continue to receive care from their current physicians according to standard medical practice and no attempt will be made to alter the types of follow-up, radiologic or other diagnostic studies or medical treatment as a result of enrollment in this study. All data will be de-identified and added to our already existing PDT treatment outcome databases for outcomes analysis, quality improvement and reporting of results in abstract and manuscript forms.	active not recruiting	400	observational	{n/a}	2011-07-01	2027-12-01	{adult,"older adult"}	all
2575898	Feasibility of a Creative Writing Intervention in an Advanced Cancer Population: A Single Arm, Consecutive Cohort Study	To assess the feasibility of a creative writing intervention in an advanced cancer population. Given it is a relatively simple intervention delivered by a non-clinician, the investigators are interested in better understanding its pattern of effect on patient psychological adjustment. The investigators aim to assess its feasibility in this study in order to inform a future larger study that will utilize a control arm.	completed	23	interventional	{n/a}	2016-01-14	2018-09-04	{child,adult,"older adult"}	all
489086	Topical Tazarotene in Treating Patients With Basal Cell Skin Cancer and Basal Cell Nevus Syndrome on the Face	RATIONALE: Drugs used in chemotherapy, such as tazarotene, work in different ways to stop the growth of tumor cells, either by killing the cells or by stopping them from dividing.\n\nPURPOSE: This phase II trial is studying topical tazarotene to see how well it works in treating patients with basal cell skin cancer and basal cell nevus syndrome on the face.	completed	36	interventional	{"phase 2"}	2004-07-01	2012-06-01	{adult,"older adult"}	all
5714748	Application of mRNA Immunotherapy Technology in Epstein-Barr Virus-related Refractory Malignant Tumors	The purpose of this study is to evaluate the efficacy and safety of mRNA vaccine for the EBV-positive Advanced Malignant Tumors.	recruiting	9	interventional	{"phase 1"}	2022-11-18	2025-01-01	{adult,"older adult"}	all
3266042	Registry Protocol- Melphalan Percutaneous Hepatic Perfusion for the Treatment of Unresectable Hepatic Malignancy	Collection of Safety, Efficacy and Resource Utilization Information in Patients Who Have Received Melphalan PHP with the Delcath Hepatic Delivery System for the Treatment of Unresectable Hepatic Malignancy	unknown	200	observational	{n/a}	2016-01-14	2020-02-01	{child,adult,"older adult"}	all
5615974	A Phase I/II Study of LM-101 Injection in Patients With Advanced Malignant Tumors	This study is to assess the safety and tolerability, obtain Maximum Tolerated Dose (MTD) and/or the recommended {phase 2} dose (RP2D) of LM-101 as a single agent or in combination in patients with advanced malignant tumors	recruiting	145	interventional	{"phase 1","phase 2"}	2023-01-11	2025-08-01	{adult,"older adult"}	all
5516914	A Phase Ib/II Clinical Trial of LBL-007 Combined With Tislelizumab in the Treatment of Malignant Tumors	This trial is an open and multicenter phase Ib/II clinical study, which aims to evaluate the safety, tolerability, PK characteristics, immunogenicity, and effectiveness.	recruiting	490	interventional	{"phase 1","phase 2"}	2022-09-01	2025-06-30	{adult,"older adult"}	all
1678690	An Exploratory Study of Gemcitabine Hydrochloride Oral Formulation (D07001-F4) in Subjects With Malignant Tumors	Open-label, Phase 0, dose-escalation study of 3 successive cohorts (3 subjects per cohort), to determine and characterize the plasma PK of gemcitabine HCl oral formulation (D07001-F4) administered once on Day 1 with 7 Days of study follow-up. In addition, oral tolerability and safety will also be assessed during this 1-week period.	completed	11	interventional	{"early phase 1"}	2012-08-01	2014-04-01	{adult,"older adult"}	all
1092247	The Effect of Ketogenic Diet on Malignant Tumors- Recurrence and Progress	The aim of the study is, to study the efficacy of the ketogenic diet in delaying or preventing recurrence and tumor growth progression of patients who have been previously treated by concomitant chemoradiotherapy (6 months) for high-grade glial tumors.\n\nIt will be an open-label trial of nutritional intervention for up to 1 year. An interim analysis of the data will be carried out to assess safety, compliance and efficacy of the diet. This will be reviewed by both SHS and the Clinical trial team.	unknown	40	interventional	{n/a}	2010-03-01	2011-09-01	{adult,"older adult"}	all
1907685	Dose Escalation, Safety and Pharmacokinetic Study of AVE8062 Combined With Docetaxel in Patients With Advanced Solid Tumors	Primary Objective:\n\nTo determine the dose limiting toxicity (DLT), the maximum administered dose (MAD) and the maximum tolerated dose (MTD) of AVE8062 and docetaxel in combination administered sequentially on D1 \\& D2 respectively every 3 weeks in patients with advanced solid tumors.\n\nSecondary Objectives:\n\n* To define the overall safety profile of the combination.\n* To characterize the pharmacokinetic (PK) profile of AVE8062 and docetaxel when administered in combination.\n* To evaluate anti-tumor activity of the combination.\n* To evaluate potential predictive biomarkers.\n\nThe study includes a tumoral pharmacogenomic sub-study conducted in a subset of sites. The objective to analyse a set of biological biomarkers in order to identify a potential predictive signature of efficacy for AVE8062 in combination with docetaxel.	completed	58	interventional	{"phase 1"}	2006-06-01	2011-02-01	{adult,"older adult"}	all
2687386	A Study of Intravenous EEDVsMit in Children With Recurrent / Refractory Solid or CNS Tumours Expressing EGFR	This is an open-label, sequential dose exploration study of single agent EEDVSMit administered by intravenous (IV) infusion twice weekly, followed by weekly maintenance dosing, in children with recurrent/refractory solid or CNS tumours.	terminated	9	interventional	{"phase 1"}	2016-02-08	2021-12-29	{child,adult}	all
3160599	Restricted Calorie Ketogenic Diet as a Treatment in Malignant Tumors	Malignant tumor incidence showed an upgrade trend in recent years. Standard therapy for malignant tumor includes surgery followed by radiation and chemotherapy. Despite optimal treatment the prognosis remains poor. There is an urgent need for more effective therapies. The Warburg effect has been widely observed in human cancers. The main energy supply of tumor cells are aerobic glycolysis. Therefore, they are highly dependent on glucose metabolism. Recently, some scholars have suggested that 'Restricted calorie Ketogenic Diet (RKD)' might be able to inhibit glycolysis and thus anti-tumor by restricting carbohydrate intake. This will 'starve' cancer cells, which will lead to cell death. There are many animal and in vitro studies shown that RKD can reduce the tumor size and thus tumor cell growth of malignant tumors. However, a consistent positive result can not be found within a small sample of clinical trials. In this study, 40 patients with malignant tumors will be treated with or without RKD. The safety and efficacy of RKD and the patients' tolerance will be observed in order to understand whether this therapy can be a potential new treatment This clinical study is comparatively large internationally. It is the first domestically. This study is essential to extend the survival of patients with malignant tumors, and to study clinical nutrition support and its metabolic pathways for malignant tumors.	unknown	40	interventional	{n/a}	2018-03-01	2020-12-01	{adult}	all
1553448	Studying Gene Expression in Samples From Younger Patients With Neuroblastoma	RATIONALE: Studying samples of blood and tumor tissue from patients with cancer in the laboratory may help doctors learn more about changes that occur in DNA and identify biomarkers related to cancer. It may also help doctors find better ways to treat cancer.\n\nPURPOSE: This research trial studies gene expression in samples from younger patients with neuroblastoma.	completed	75	observational	{n/a}	2012-03-01	2013-03-01	{child,adult}	all
5776732	Effect of CaviionTM Precaution Medical Adhesive-related Skin Injury in Tumor Patients With PICC Catherizaion	Malignant tumor patients are at high risk of medical adhesive-related skin injuryÔºàMARSIÔºâ.MARSI can cause local skin ulceration, increase the difficulty of fixation and maintenance frequency, even cause unplanned extubation, and increase the pain and economic burden of the patient's re-installation.Malignant tumor patients with long-term PICC are prone to MARSI.CaviionTM can form a protective film on the skin.Applying CaviionTM before using the adhesive can effectively protect the skin and reduce the occurrence of rash.In China, CaviionTM is mostly used in infants and young children, but adults lack corresponding report and application data.Therefore, it is necessary to carry out corresponding randomized controlled study on adult patients, especially malignant tumors	active not recruiting	165	interventional	{n/a}	2022-03-07	2023-12-30	{adult,"older adult"}	all
4343859	A Study of IMMH-010 in Patients With Advanced Malignant Solid Tumors	Phase I study of IMMH-010 in patients with advanced malignant solid tumors	enrolling by invitation	186	interventional	{"phase 1"}	2020-05-14	2023-12-01	{adult,"older adult"}	all
4084067	Indocyanine Green (ICG) Guided Tumor Resection	This is a study to assess the ability of Indocyanine Green (ICG) to identify neoplastic disease. For many pediatric solid tumors, complete resection of the primary site and/or metastatic deposits is critical for achieving a cure. An optimal intra-operative tool to help visualize tumor and its margins would be of benefit. ICG real-time fluorescence imaging is a technique being used increasingly in adults for this purpose. We propose to use it during surgery for pediatric malignancies. All patients with tumors that require localization for resection or biopsy of the tumor and/or metastatic lesions will be eligible.\n\nPrimary Objective\n\nTo assess the feasibility of Indocyanine Green (ICG)-mediated near-infrared (NIR) imagery to identify neoplastic disease during the conduct of surgery to resect neoplastic lesions in children and adolescents. NIR imaging will be done at the start of surgery to assess NIR-positivity of the lesion(s) and at the end of surgery to assess completeness of resection. Separate assessments will be made for the following different histologic categories:\n\n1. Osteosarcoma\n2. Ewing Sarcoma\n3. Rhabdomyosarcoma (RMS)\n4. Non-Rhabdomyosarcoma Soft Tissue Sarcoma (NRSTS)\n5. Neuroblastoma\n6. Renal tumors (Only bilateral Wilms Tumor patients will be included.)\n7. Metastatic pulmonary deposits\n8. Liver tumors, lymphoma, other rare tumors, and nodules of unknown etiology\n\nExploratory Objectives\n\n1. To compare the ICG uptake by primary vs metastatic site and pre-treated (chemotherapy, radiation, or both) vs non-pre-treated.\n2. Assess the sensitivity and specificity of NIR imagery to find additional lesions not identified by standard of care intraoperative inspection and tactile feedback.\n3. Assess the sensitivity and specificity of NIR imagery to find additional lesions not identified on preoperative diagnostic imaging.\n4. Assess the sensitivity and specificity of NIR imagery for identifying residual disease at the conclusion of a tumor resection.	recruiting	312	interventional	{"phase 1"}	2020-02-07	2025-12-31	{child,adult,"older adult"}	all
2786199	Histological Differentiation Grade Predicted by Ultrasound Backscatterer Imaging	Histological grade of hepatocellular carcinoma (HCC) is an important prognostic factor affecting patient survival. It has been divided into four grades from I to IV on the basis of histological differentiation. Grade I is the best differentiated consisting of small tumor cells arranged in thin trabeculae. Cells with higher grade are larger and less differentiated with hyperchromatic nuclei and loss of trabecular pattern.\n\nUltrasound is an imaging modality frequently used to evaluate liver tumors because of its convenience, real-time, less expensive and no radiation exposure. However, ultrasonographic evaluation by conventional B-mode image is semi quantitative and subjective. It still cannot replace liver biopsy for the evaluation of HCC.\n\nThis study is aimed to quantify the image characters of B-mode image and the scatterer properties using Nakagami distribution. Nakagami parameter is a general model to describe the distribution of scatterers. Therefore, the investigators hypothesized that Nakagami parameter may also reflect the histological changes in different grades of HCC.\n\nIn this study, the resected HCC tumor samples will be collected from the participants who are going to receive surgical resection, and the tumor US images and Nakagami values will be obtained via the single-element ultrasound system. The correlation between the ultrasound backscatter parameter and the differentiation grade will be analyzed.	unknown	100	observational	{n/a}	2015-06-01	2018-06-01	{adult,"older adult"}	all
1509612	Additive Homeopathy in Cancer Patients	The investigators aim to investigate the validity of their previous results in a randomized prospective, placebo-controlled, double-blind, multicenter controlled evaluation of questionnaires in patients with advanced malignant tumors. The investigators plan to compare the treatment outcome (quality of life and survival) in tumor patients, receiving standard or "add-on" homeopathic treatment.\n\nThe null hypothesis is that "add-on" homeopathic treatment does not create a benefit for cancer patients. In addition the investigators evaluate survival time.	completed	150	interventional	{"phase 3"}	2012-02-01	2019-07-31	{adult,"older adult"}	all
1503905	Neoadjuvant Chemotherapy for Operable Premenopausal Breast Cancer Patients	The current study is a multicentre, randomized, open (unblended), prospective clinical trial which is sponsored by the researchers. The trial is designed to compare the effectiveness between docetaxel plus epirubicin, and docetaxel plus epirubicin plus cyclophosphamide as neoadjuvant chemotherapy for operable premenopausal breast cancer patients, and also to compare the outcomes associated with chemo-induced amenorrhea between the two neoadjuvant chemotherapies. The investigators will randomly assign 600 premenopausal female patients with operable breast cancer to receive four cycles of docetaxel and epirubicin (TE); or four cycles of docetaxel, epirubicin, and cyclophosphamide (TEC). After every two cycles of neoadjuvant chemotherapy, the investigators will estimate the effectiveness of therapy. Patients will undergo modified radical mastectomy or breast-conserving surgery after four cycles of neoadjuvant chemotherapy, and then receive postoperative chemotherapy (two cycles), radiation therapy, herceptin targeted therapy or hormone therapy according to the NCCN (2011) guideline. The follow-up will be ten years after surgeries. The primary aim is to examine whether the docetaxel and epirubicin (TE) will be as effective as the docetaxel, epirubicin, and cyclophosphamide (TEC) (pCR rate, cCR rate, PR rate, SD rate, progression-free survival (PFS) and overall survival (OS)). The secondary aim is to correlate chemo (TE/TEC)-induced amenorrhea with outcomes in premenopausal women.	unknown	600	interventional	{n/a}	2011-12-01	2021-12-01	{adult,"older adult"}	female
4793672	Establishment of Tongue Image Database and Machine Learning Model for Malignant Tumors Diagnosis	The tongue images of malignant tumors and corresponding healthy people will be collected to establish the tongue image database. Deep learning will be carried out by computer and artificial intelligence to construct the early screening, diagnosis, prognosis and prognosis model of various malignant tumors based on tongue image for the diagnosis and treatment of malignant tumors.	unknown	10000	observational	{n/a}	2021-04-06	2023-02-02	{adult,"older adult"}	all
4797039	MRI-Guided Cryoablation for Focal Native Prostate Cancer	The purpose of this research is to collect data about the MRI cryoablation procedure your doctor(s) would normally perform in order to treat the participants focal prostate cancer and to evaluate the participants condition after the participants treatment is performed.\n\nParticipants have been asked to take part in this research because the participants have been diagnosed with prostate cancer and scheduled to have an ablation procedure.	recruiting	100	observational	{n/a}	2020-12-01	2030-12-01	{adult,"older adult"}	male
5396391	A Clinical Trial to Evaluate Effect of IAP0971 in Patients With Advanced Malignant Tumors	This is a Phase I Clinical Trial to Evaluate the Safety, Tolerability and Preliminary Effectiveness of IAP0971 in Patients with Advanced Malignant Tumors.	recruiting	140	interventional	{"phase 1","phase 2"}	2022-06-22	2024-11-30	{adult,"older adult"}	all
4980690	Clinical Trial of IBC0966 in Patients With Advanced Malignant Tumors	This is a phase I/IIa study to evaluate the safety, tolerability and efficacy of IBC0966 for the treatment of subjects with advanced malignant tumors.	recruiting	228	interventional	{"phase 1","phase 2"}	2021-08-31	2025-12-01	{adult,"older adult"}	all
5108298	Improving Adolescent and Young Adult Self-Reported Data in ECOG-ACRIN Trials	The purpose of this study is to evaluate feasibility and acceptability of completing PROs among AYAs randomized to Choice PRO vs Fixed PRO.	recruiting	400	interventional	{"early phase 1"}	2021-11-10	2024-11-01	{adult}	all
5707910	Clinical Study of Therapeutic Immunological Agent for EBV-positive Advanced Malignant Tumors	To evaluate the safety of therapeutic immunological agent against EBV-positive advanced malignancies, examining the incidence, type of occurrence, and severity of adverse events in relation to the agent tested, and initially exploring the effectiveness of the immunological agent.	recruiting	9	interventional	{"phase 1"}	2023-02-10	2025-01-01	{adult,"older adult"}	all
5877924	A Study of NBL-020 Injection in Subjects With Advanced Malignant Tumors.	This study aims to evaluate the safety and tolerability of NBL-020 injection in subjects with advanced malignant tumors, and determine the dose limiting toxicity (DLT), maximum tolerable dose (MTD) (if any), recommended phase II dose (RP2D), and dosing regimen of NBL-020.	not yet recruiting	200	interventional	{"phase 1"}	2023-05-01	2026-08-01	{adult,"older adult"}	all
3931720	Clinical Research of ROBO1 Specific BiCAR-NK/T Cells on Patients With Malignant Tumor	Immunotherapy has become the major breakthrough and the most promising treatment, with the host of development of tumor biology, molecular biology and immunology. ROBO1 is a potential target and spectacular paradigm in the diagnosis and treatment of solid tumors. This study is for evaluation of the safety and efficacy of ROBO1 CAR-NK/T cell immunotherapy for malignant tumors.	unknown	20	interventional	{"phase 1","phase 2"}	2019-05-01	2022-05-01	{adult,"older adult"}	all
4881981	A Phase I Study Evaluating the Safety of Stereotactic Central Ablative Radiation Therapy (SCART) for Bulky Metastatic or Recurrent Cancer	We aim to evaluate the feasibility and toxicity of testing the tolerance and immunogenic effects of high-dose SCART radiotherapy in patients with bulky metastatic or recurrent cancer in the setting of a single-arm phase I clinical trial.\n\nThe primary endpoint of the study was to determine dose-limiting toxicities (DLT)s and the Maximum Tolerated Dose (MTD) of SCART to bulky metastatic or recurrent cancers.	unknown	12	interventional	{"phase 1"}	2021-06-05	2022-05-05	{adult,"older adult"}	all
5779514	Effect of Mirabegron on Promoting Brown Adipose Tissue Activation	In previous preclinical studies, our group found that Mirabegron, a clinical drug, could activate brown adipose tissue and inhibit tumor growth in tumour-bearing mice.Investigators look forward to further evaluating the effect of Mirabegron-mediated brown adipose tissue activation, so as to provide new drug applications for clinical cancer prevention and treatment	recruiting	20	interventional	{n/a}	2022-08-18	2023-12-31	{adult,"older adult"}	all
5653284	A Study of AK130 in Patients With Advanced Malignant Tumors	A Phase I open label, dose-escalation and expansion study to evaluate the safety, tolerability, pharmacokinetics and anti-tumor activity of AK130 (TIGIT/TGF-Œ≤ bifunctional fusion protein) in patients with advanced malignant tumors.	not yet recruiting	72	interventional	{"phase 1"}	2023-01-01	2025-01-01	{adult,"older adult"}	all
1543542	A Phase II Multi-institutional Study Assessing Simultaneous In-field Boost Helical Tomotherapy for 1-3 Brain Metastases	Helical tomotherapy is a novel radiation treatment machine that combines two existing technologies: spiral radiotherapy treatments combined with simultaneous computed tomotherapy imaging of the body. This new machine can potentially allow radiation treatments to be focused more precisely, and delivered more accurately than with existing radiation machines. In this study, helical tomotherapy will be used to provide radiation treatments (whole brain radiotherapy, daily over 10 treatments) that are commonly used to treat cancer metastatic to the brain. In addition, the individual spots of cancer (metastases) in the brain will be treated to a higher dose (approximately 2 times higher) than the dose to the whole brain. The purpose of this study is to determine the effectiveness of whole brain radiation with lesion boosting with the helical tomotherapy machine.	completed	91	interventional	{"phase 2"}	2010-04-01	2016-04-01	{adult,"older adult"}	all
4672473	Treatment of Malignant Tumors With Antigen Peptide-specific DC-CTL Cells and Decitabine	Tumor-specific antigens can be induced by demethylation drugs. Antigen-targeting DC-CTL cells supposed to eliminate cancer cells efficiently and specifically. In this study investigators co-culture DCs cells with peptides derived from tumor specific antigen to generate antigen-specific DC-CTLs (Ag-CTL). Following treatment with demethylation drugs, Ag-CTL will be used to eliminate tumor cells. This study aims to evaluate the effectiveness and safety of Ag-CTL combined with demethylation drugs.	recruiting	60	interventional	{"phase 1","phase 2"}	2020-10-30	2023-07-28	{adult,"older adult"}	all
5394428	A Multi Center Study of Sexual Toxicities After Radiotherapy	The purpose of this research is to understand how radiotherapy and other cancer treatments impact sexual function in female cancer patients and to try to answer a question about why some patients who receive radiotherapy are more likely to have side effects than others. The results of this study may improve our understanding of why sexual side effects occur and in turn develop predictive models and biomarkers of sexual side effects and other side effects that may impact sexual function. The results of this study may also lead to improvements in the techniques used to deliver radiotherapy or the development of interventions that will prevent or reduce sexual side effects and improve quality of life for female patients with cancer.	recruiting	300	observational	{n/a}	2022-10-04	2026-08-31	{adult,"older adult"}	female
5781555	A Study of Diffusing Alpha Radiation Therapy for Target Treatments of Malignant Tumors	This study is a Compassionate clinical study for the treatment of Malignant Tumors. The primary endpoint of the study is to assess the frequency, severity and causality of acute adverse events related to the DaRT treatment. Adverse events will be assessed and graded according to Common Terminology and Criteria for Adverse Events (CTCAE) version 5.0. The secondary endpoint is to assess the tumor response to DaRT treatment assessed using the Response Evaluation Criteria in Solid Tumors (RECIST) (Version 1.1) 3 months after DaRT seed insertion.	recruiting	100	interventional	{n/a}	2023-03-22	2025-02-01	{adult,"older adult"}	all
4805060	A Study to Evaluate the Tolerance and Pharmacokinetics of TQB2858 Injection in Subjects With Terminal Malignant Tumors	This study is a phase I study to evaluate the safety and tolerability of TQB2858 injection in patients with advanced malignancy.	recruiting	30	interventional	{"phase 1"}	2021-04-23	2025-12-12	{adult,"older adult"}	all
4416672	Validation of the Italian Version of the PRO-CTCAE	The aim of this study is to complete the validation process by testing the remaining two psychometric properties (validity and responsiveness) of the Italian version of the PRO-CTCAE in a large group of patients. In particular, for the first time this study will validate the tool for individual types of cancer and will provide information on psychometric properties based on the type of treatment used in clinical practice.	recruiting	3675	observational	{n/a}	2018-07-01	2024-07-01	{adult,"older adult"}	all
5198817	A Trial of SHR-2002 Injection or Combined With Other Anti-cancer Medication in Advanced Malignant Tumors of Patients	The study is being conducted to evaluate safety, tolerability, pharmacokinetics and preliminary efficacy of SHR-2002 injection monotherapy and in combination with other anti-cancer therapy for advanced malignant tumors of patients. To explore the reasonable dosage of SHR-2002 injection monotherapy and dosage regimen of combination therapy for advanced malignant tumors of patients.	enrolling by invitation	240	interventional	{"phase 1"}	2022-02-22	2023-06-30	{adult,"older adult"}	all
5779163	A Phase I/II Clinical Trial of LBL-033 in the Treatment of Advanced Malignant Tumors	This trial is an open and multicenter phase I/II clinical study, which aims to evaluate the safety, tolerability, PK characteristics, immunogenicity, and effectiveness.	recruiting	468	interventional	{"phase 1","phase 2"}	2023-04-14	2026-03-31	{adult,"older adult"}	all
5214482	A Study of AK112 in Advanced Malignant Tumors	Phase Ib/II open label, multicenter study to evaluate the efficacy and safety of AK112 (anti-PD-1 and VEGF bispecific antibody) combined with AK117ÔºàAnti-CD47 AntibodyÔºâwith or without chemotherapy in advanced malignant tumors	recruiting	160	interventional	{"phase 1","phase 2"}	2022-01-25	2024-01-25	{adult,"older adult"}	all
2167581	Confrontation Phenotypes and Genotypes of Epithelial Odontogenic Tumors of the Jaws	Systematically compare the phenotype and genotype of epithelial odontogenic tumors in children and adults with a clinical, radiographic, pathologic and molecular level.\n\nEither:\n\nestablish an observatory of this multidisciplinary tumor establish a tumor bank annotated scale unparalleled testing pathophysiological hypotheses search for prognostic factors.	completed	319	observational	{n/a}	2011-01-01	2014-09-01	{child,adult,"older adult"}	all
5193721	A Clinical Study of the Safety and Tolerability of SHR-1901 in Subjects With Advanced Malignant Tumors	The study is being conducted to evaluate the efficacy, and safety of SHR-1901 in subjects with advanced malignant tumors.To explore the reasonable dosage of SHR-1901.	recruiting	180	interventional	{"phase 1"}	2022-02-10	2024-08-31	{adult,"older adult"}	all
5728541	Dose Escalation and Expansion Study of SYH2043 in Patients With Advanced Malignant Tumors	The aim of this study is designed to evaluate the safety, tolerability, pharmacokinetics, and preliminary antitumor activity of SYH2043 in patients with advanced malignant tumors.	not yet recruiting	367	interventional	{"phase 1"}	2023-03-01	2026-03-01	{adult,"older adult"}	all
5868876	A Study of AK127 Combined With AK104 in Patients With Advanced Malignant Tumors	A Phase Ia/Ib open labelÔºåclinical study evaluating the safety, tolerability and preliminary efficacy of AK127 in combination with AK104 in patients with advanced malignant tumors	not yet recruiting	205	interventional	{"phase 1"}	2023-07-03	2026-02-01	{adult,"older adult"}	all
2159820	Lower Dose Decitabine (DAC)-Primed TC (Carboplatin-Paclitaxel) Regimen in Ovary Cancer	Ovarian cancer is the most lethal gynecological cancer and the 5th leading cause of cancer death in women. Most patients are typically diagnosed with advanced-stage disease. Platinum-paclitaxel regimen has been widely adopted as a standard first-line treatment for advanced ovarian cancer. Multiple collaborative randomised phase III trials evaluating the addition of a third chemotherapy agent, maintenance therapy or alternative taxanes failed to demonstrate significant improvements over a standard carboplatin/taxane doublet.\n\nDecitabine (DAC), one major DNA demethylating agent, has been approved for treatment of preleukemic hematological disease myelodysplastic syndrome (MDS) by the Food and Drug Administration. Past trials of these with high doses, i.e., the use of maximal tolerated dose, for patients with solid tumors showed a low therapeutic index, due to extreme toxicities that have probably confounded the ability to document the true clinical response.\n\nLow dose DNA demethylation agent decitabine (DAC) can resensitize the therapeutic indexes of resistent ovary cancer cells in vivo and in vitro.\n\nThe investigators hypothesized that DAC-triggered epigenetic reprogramming of tumor cells and possible immune cells could induce pronounced long-dated clinical effect by chemosensitization- and immunopotentiation-driven maximal eradicating roles on the minimal/residual lesions in primary patients with poor prognosis.	recruiting	500	interventional	{"phase 2","phase 3"}	2014-06-01	2024-06-01	{adult,"older adult"}	female
5229497	A Phase Ib/II Study of AK112 in Combination With AK117 in Advanced Malignant Tumors	Phase Ib/II open label, multicenter study to evaluate the efficacy and safety of AK112 (anti-PD-1 and VEGF bispecific antibody) combined with AK117#AntiCD47 Antibody# in advanced malignant tumors	recruiting	114	interventional	{"phase 1","phase 2"}	2022-05-04	2024-02-01	{adult,"older adult"}	all
3920371	Evaluation of a Prototype Hand Held Hybrid Gamma Camera	The aim of the project is to undertake clinical development of a hybrid compact gamma camera that combines gamma ray and optical imaging. It is an extension of the previous pilot study using a newly developed handheld hybrid compact gamma camera in clinical arena.	completed	75	interventional	{n/a}	2017-06-13	2018-09-10	{adult,"older adult"}	all
5217940	Screening Women With Prior HPV for Anal Neoplasia	The goal of this single arm trial is to prospectively evaluate screening methods for anal cancer precursors in HIV uninfected women with a history of lower genital tract neoplasias and cancers.	recruiting	300	interventional	{n/a}	2022-03-02	2026-11-01	{adult,"older adult"}	female
2309931	ISOperistaltic Versus ANTIperistaltic Anastomosis After Laparoscopic Right Colectomy for Cancer	The study will provide a precise control compared to the two interventions (iso vs antiperistaltic anastomoses) with thorough measurements of the postoperative variables and complications to improve the evaluation of the surgical technique. It will also enable an evaluation of the quality of life after the procedures.	completed	108	interventional	{n/a}	2014-06-01	2017-11-01	{adult,"older adult"}	all
5082545	Phase I Study of SHR-2002 + SHR-1316 in Patients With Advanced Malignant Tumors	This is {phase 1} study FIH to check "Dose Escalation, Dose expansion and Indication expansion". This study is AUSTRALIA only study.	recruiting	50	interventional	{"phase 1"}	2021-11-23	2025-09-01	{adult,"older adult"}	all
5223231	Evaluation of LBL-019 Monotherapy or Combined With Anti-PD-1 Antibody in the Treatment of Advanced Malignant Tumors	This trial is a phase I/II study, which is designed to evaluate the safety, tolerance, pharmacokinetic characteristics, receptor occupancy (RO), immunogenicity and effectiveness of LBL-019 monotherapy or combined with anti-PD-1 antibody in patients with advanced malignant tumors.	recruiting	486	interventional	{"phase 1","phase 2"}	2022-02-24	2025-10-22	{adult,"older adult"}	all
5110807	A Clinical Study to Evaluate the Tolerability and Pharmacokinetics of TQB3617 Capsule in Patients With Advanced Malignant Tumors	TQB3617 is a bromodomain and extra-terminal (BET) inhibitor that can competitively bind to bromodomains (BRDs) with Acetylated lysine(Kac) and block or partially block the role of KAc in subsequent gene transcription and regulation of chromatin structure, thereby playing an anti-tumor role.	recruiting	38	interventional	{"phase 1"}	2022-01-05	2022-12-01	{adult,"older adult"}	all
5235542	A Phase Ib/II Study of AK104 and AK117 in Combination With or Without Chemotherapy in Advanced Malignant Tumors	Phase Ib/II open label, multicenter study to evaluate the efficacy and safety of AK104 (anti-PD-1 and CTLA-4 bispecific antibody) and AK117#AntiCD47 Antibody# combined with or without chemotherapy in advanced malignant tumors	recruiting	130	interventional	{"phase 1","phase 2"}	2022-07-12	2024-03-01	{adult,"older adult"}	all
3146624	Evaluation of Patients Satisfaction of Attachment Retained Versus Clasp Retained Obturators in Unilateral Total Maxillectomy	OBJECTIVE to evaluate patients satisfaction of obturator with attachment versus conventional obturator in treatment of unilateral maxillectomy .	completed	14	interventional	{n/a}	2015-12-01	2017-03-28	{child,adult,"older adult"}	all
4708210	Study of the Efficacy and Safety of IBI319 in Patients With Advanced Malignant Tumors	An open-label, multicenter, phase Ia/Ib study to evaluate the safety, tolerance and preliminary efficacy of IBI319 in patients with advanced malignant tumors	active not recruiting	256	interventional	{"phase 1"}	2021-04-28	2023-06-21	{adult,"older adult"}	all
5450744	131I-TLX-101 for Treatment of Newly Diagnosed Glioblastoma (IPAX-2)	This is an open label, single arm, parallel-group, multicentre, and dose finding study to evaluate the safety of ascending radioactive dose levels of 131I-TLX101 administered intravenously in combination with best standard of care in newly diagnosed GBM patients.	recruiting	12	interventional	{"phase 1"}	2023-04-01	2025-06-01	{adult,"older adult"}	all
4128085	A Study to Evaluate the Tolerance and Pharmacokinetics of TQB3804 in Subjects With Advanced Malignant Tumors	This is a study to evaluate the tolerance, dose-limiting toxicity (DLT), phase II recommended dose (RP2D), and maximum tolerated dose (MTD) of single and multiple oral doses of TQB3804 in patients with advanced malignant tumors.	unknown	30	interventional	{"phase 1"}	2019-11-15	2021-10-01	{adult,"older adult"}	all
1946672	Lower-Limb Drainage Mapping in Pelvic Lymphadenectomy for Gynaecological Cancer	The purpose of this study is to evaluate the feasibility of an isotopic technique to identify, and to map the lower-limb drainage nodes during pelvic lymphadenectomy for gynaecological cancers. The diagnostic value of our mapping method will be assessed, and we will determine the incidence of lymhedema.	completed	44	interventional	{"phase 4"}	2013-07-01	2021-06-04	{adult,"older adult"}	female
4702841	CAR - Œ≥ Œ¥ T Cells in the Treatment of Relapsed and Refractory CD7 Positive T Cell-derived Malignant Tumors	This is a study on the clinical application of chimeric antigen receptor modified Œ≥Œ¥ T cells (CAR - Œ≥Œ¥ T cells) in relapsed and refractory CD7 Positive T cell-derived malignant tumors.The main purpose of this study was to evaluate the efficacy of car - Œ≥ Œ¥ T cell infusion in patients with relapsed and refractory CD7 Positive T cell-derived malignancies.	unknown	8	interventional	{"early phase 1"}	2020-06-03	2022-12-01	{child,adult,"older adult"}	all
1825993	RANDOMISED STUDY OF EPIDURAL VS MPCA MORPHINE VS TAPP IN LAPAROSCOPIC SIGMOIDECTOMY	The investigators would study the control of postoperative pain with peridural catheter, morphine PCA ev or Transabdominal block.	unknown	225	interventional	{"phase 3"}	2013-04-01	2015-04-01	{adult,"older adult"}	all
4996446	ALPPS Combined With Tislelizumab in Liver Malignancy	Study design: Prospective, single-center, phase IIa clinical trial; Primary endpoint: Recurrence free survival; Secondary endpoints: Safety, overall survival; Main characteristics of patients: Liver malignancy, required (extended) hemihepatectomy, insufficient liver reserve; Study approaches: The experimental group is treated with ALPPS combined with Tislelizumab, and the control group was treated with ALPPS; Sample size: 20 (10:10); Study process: In experimental group, patients who meet the inclusion criteria will receive ALPPS stage I surgery, treated with Tislelizumab 2-4 weeks after stage I surgery, and receive ALPPS stage II surgery 2-4 weeks after Tislelizumab treatment, and treated with Tislelizumab q3W 6-12 months after stage II surgery; In control group, patients who meet the inclusion criteria will receive ALPPS stage I surgery, and receive ALPPS stage II surgery 3-6 weeks after stage I surgery.	recruiting	20	interventional	{"phase 2"}	2020-08-01	2023-08-01	{adult,"older adult"}	all
4757103	Surgical Approach for Retrorectal Tumors Cohort	Aim of the study :\n\nTo evaluate postoperative outcomes of all surgical approach for retrorectal tumors.\n\nMethods :\n\nFrom 2005 to 2020, all consecutive patients who underwent surgery for a retrorectal tumor in two referral tertiary center were prospectively collected.\n\nConsidering our exlusion criterias, data from XX patients were analyzed. The cohort was separated into 2 groups according to tumor localization regarding the third sacral vertebra.\n\nShort and longterm outcomes were compared between the two groups.\n\nPrimary outcome :\n\n90 days postoperative morbidity rate	completed	21	observational	{n/a}	2021-01-01	2021-05-01	{adult,"older adult"}	all
5616195	Application of 3D Printed Prosthesis in Limb Salvage Surgery for Bone Tumors	To report the patients who underwent 3D-printed bone prosthesis replacement in Henan Cancer Hospital in the next 10 years, and collect the postoperative complications and limb function of these patients.	not yet recruiting	80	observational	{n/a}	2023-02-28	2032-12-30	{child,adult,"older adult"}	all
1991652	Collaborative Wilms Tumour Africa Project	Significant progress has been made in the treatment of Wilms tumor in high income countries, where survival is now around 85% - 90%. Survival in low income countries is much lower; specific challenges include late presentation, malnutrition, less intense supportive care facilities and failure to complete treatment.\n\nA comprehensive treatment guideline was introduced in Malawi in 2006 which included nutritional support and social support to enable parents to complete treatment. Survival has increased to around 50%; 95% of children completed their treatment. A multi-disciplinary group of African clinicians and 'state of the art' experts produced a consensus treatment guideline for children with Wilms tumor in sub-Saharan Africa. This guideline will be implemented as a multi-center prospective clinical trial in 2014 in six - eight institutes, expecting about 200 new patients per year.\n\nThe hypothesis is that 2 year event free survival will be 50%, with \\<10% failure to complete treatment and \\<10% treatment related mortality. Other research questions include efficacy and toxicity of preoperative chemotherapy and the comparison of surgical staging, local pathology and central review pathology in stratifying postoperative chemotherapy.	recruiting	400	observational	{n/a}	2014-01-01	2024-12-01	{child,adult}	all
5237206	Study of SUPLEXA in Patients With Metastatic Solid Tumours and Haematologic Malignancies	This {phase 1}, first-in-human (FIH), open-label study is designed to assess the safety, tolerability, and preliminary clinical efficacy of repeated intravenous (IV) infusions of SUPLEXA monotherapy in subjects with measurable metastatic solid tumours and haematologic malignancies	active not recruiting	60	interventional	{"phase 1"}	2022-04-28	2025-02-01	{adult,"older adult"}	all
2075606	Circulating Tumour Cells in Somatuline Autogel Treated NeuroEndocrine Tumours Patients	Circulating tumour cells (CTCs) are detectable in the blood in around 50% of patients with functioning NeuroEndocrine Tumours (NET) arising in the midgut area (tumours which are secreting hormones and are located in the area in the middle of the digestive system) and their presence usually means that the prognosis for the patient is poor. CTCs have also been shown to be valuable as predictive markers following treatment and there is increasing interest in using CTCs as 'liquid biopsies' that can help to inform treatment decisions. CTC analysis has the benefit of being relatively non- invasive and quick compared with a conventional CT scan and is therefore an attractive method of monitoring the tumour throughout the treatment period.\n\nThe purpose of this study is to assess the clinical value that enumeration will have in predicting the clinical symptomatic response and progression free survival in patients receiving Somatuline Autogel for functioning midgut NETs over a one year period.	completed	50	interventional	{"phase 4"}	2014-05-01	2017-06-01	{adult,"older adult"}	all
130169	A {phase 1} Open-Label Study of E7974 Administered on Days 1 and 15 of a 28-Day Cycle in Patients With Solid Malignancies	The purpose of this study is to determine the maximum tolerated dose (MTD) of E7974 administered on Days 1 and 15 of a 28-day cycle in subjects with solid malignancies that have progressed following effective therapy or for which no effective therapy exists.	completed	30	interventional	{"phase 1"}	2006-01-01	2009-08-01	{adult,"older adult"}	all
5616182	Application of LARS Ligament in Bone Prosthesis Replacement	This is a single-center, prospective, real-world observational study designed to enroll all patients eligible for enrollment. Basic data, treatment methods, postoperative complications and limb function were collected. The differences in postoperative complications, postoperative limb function and so on between patients who underwent LARS ligament implantation and bone prosthesis replacement (ligament group) and patients who underwent bone prosthesis replacement (control group) were compared.	not yet recruiting	100	observational	{n/a}	2023-03-01	2032-02-28	{child,adult,"older adult"}	all
5377970	Implementation of a Prehabilitation Program for Surgical Patients	Frailty is a state of increased vulnerability to stressors with increased rates of poor outcomes. Surgery is one of these stressors, and previous research has therefore shown increased rates of morbidity and mortality in frail patients undergoing surgery. Prehabilitation programs can help mitigate the negative outcomes associated with frailty. The investigators hope to implement a newly developed prehabilitation pilot program in the Maine Medical Center Surgical Oncology Clinic to initially evaluate adherence, self-efficacy, and health-related quality of life.	recruiting	20	interventional	{n/a}	2022-06-25	2023-07-31	{adult,"older adult"}	all
1906632	Gene Expression Profiling of Malignant Tumor Predict the Therapeutic Response of DC-CIK Immunotherapy	To investigate gene expression profile and immunological associated analysis relating to immunotherapy response of patients with malignant tumor after DC-CIK immunotherapy.	unknown	50	interventional	{n/a}	2013-05-01	2021-12-01	{adult,"older adult"}	all
4891718	CIVO Intratumoural Microdosing of Anti-Cancer Therapies in Australia	This is a multi-center, open-label Phase 0 Master Protocol in Australia designed to study the localized pharmacodynamics (PD) of anti-cancer therapies within the tumour microenvironment (TME) when administered intratumourally in microdose quantities via the CIVO device in patients with surface accessible solid tumours for which there is a scheduled surgical intervention. CIVO stands for Comparative In Vivo Oncology. Multiple substudies will include specified investigational agents and combinations to be evaluated.	withdrawn	0	interventional	{"early phase 1"}	2021-09-15	2022-06-05	{adult,"older adult"}	all
165802	A Phase I Open Label Study of E7974 Administered on a Day 1 of 21-Day Cycle In Patients With Advanced Solid Tumors	The purpose of this study is to determine the maximum tolerated dose (MTD) of E7974 after bolus IV administration, on Day 1 of a 21-day cycle, to patients with advanced solid tumors that have progressed following effective therapy or for which no effective therapy exists.	completed	40	interventional	{"phase 1"}	2006-05-01	2009-01-01	{adult,"older adult"}	all
5661591	Effect of Fluconazole on Pharmacokinetics of SHR2554 in Healthy Subjects	The study is being conduct to evaluate fluconazole effect of on SHR2554 in condition of single-canter, open-label, single-dose in healthy subjects. To explore the SHR2554 pharmacokinetics change under use of fluconazole and insure the safety with SHR2554 combined with fluconazole.	completed	18	interventional	{"phase 1"}	2023-02-28	2023-03-31	{adult}	all
5592262	Pharmacokinetic Test of High-fat Diet After Oral Administration of SHR2554 in Healthy Subjects	The objective of the study is to assess the effect of food on the pharmacokinetics, and safety of SHR2554 Tablets in healthy subjects.	completed	20	interventional	{"phase 1"}	2022-11-15	2022-12-14	{adult}	all
1993498	Chronic Toxicities Related to Treatment in Patients With Localized Cancer	The aims of the cohort will be to quantify impact of cancer treatments toxicities , and to generate predictors of chronic toxicity in patients with non-metastatic cancer. Study of the original cohort will be focused on localized breast cancer patients, other localisation in non-metastatic setting will be explored furtherwise, fist of all in lung cancer.\n\nThe project will include four specific aims :\n\n1. To develop a database of chronic treatment related toxicity in a cohort of 14750 women with stage I-III breast cancer (= non metastatic), whatever these treatments are (surgery; radiation therapy; chemotherapy ...)\n2. To describe incidence, clinical presentation, and outcome of chronic toxicities.\n3. To describe the psychological, the social and the economic impacts of chronic toxicities.\n4. To generate predictors for chronic toxicities in order to prevent them, based upon biological criteria.\n\nThe expected impact of these toxicities, when identified, will be to improve quality of life and to decrease health cost, by the early identification of patients at high risk of toxicity. Such early identification could lead to prevent toxic effect by: a. developing prevention strategies, b. substituting toxic treatment by a non (less) toxic one.\n\nAlso, such cohort will offer a quantification of the impact of treatment toxicity, that could be further used to quantify medical usefulness of strategies that aim at decreasing treatment toxicities (implementation of predictive biomarker for resistance, cytotoxic-free regimen etc...)	recruiting	14750	interventional	{n/a}	2012-02-20	2034-03-01	{adult,"older adult"}	female
1711502	Epidemiology and Management of Metastatic Breast Cancer	This is a multicenter, national, retrospective chart-review study that will be based on the collection of data from electronical or paper-based medical records with available data on female patients diagnosed with metastatic brest cancer . The main purpose of this study is to provide accurate, evidence based description on the incidence of progression of metastatic breast cancer and its clinical management.	completed	128	observational	{n/a}	2013-01-01	2013-06-01	{adult,"older adult"}	female
5478135	A Remote Evaluation of NAVIFY Oncology Hub Using Clinical Simulation	This work seeks to understand current clinical workflow practice and validate use cases for NAVIFY Oncology Hub.\n\nThe main purpose of NAVIFY Oncology Hub is to enhance clinical and operational effectiveness, from diagnostic workup to treatment planning and management. This might free up providers' time and capacity to provide better and more personalized care to patients.\n\nThis research protocol builds on previous work that validated clinical simulation methods as a means for clinicians to generate useful insights during the testing and development of digital health tools (Gardner et al. 2020).\n\nAccordingly, this study aims to test the ability of NAVIFY Oncology Hub to increase the work efficiency of oncologists and reduce the cognitive burden/mental fatigue associated with patient care and decision-making.\n\nThe insights generated will be used to guide the development of NAVIFY Oncology Hub and optimise user experience, as well as provide a better understanding of the opportunities for it to have maximal impact in the decision-making process.	completed	27	interventional	{n/a}	2022-05-15	2022-11-03	{adult,"older adult"}	all
4367870	COVID-19 Detection Test in Oncology	EVIDENCE is a non interventional, French, multicenter study. Patients will be screened by local severe acute respiratory syndrome coronavirus 2 (SARS-CoV-2) immunoassay in their oncology department (rapid diagnostic test (RDT) or enzyme-linked immunosorbent assay (ELISA)). In patients with positive local SARS-CoV-2 immunoassay, a centralized SARS-CoV-2 ELISA will be performed in order to double check the immune response of all patients considered immune by local immunoassay.	completed	441	observational	{n/a}	2020-05-23	2022-04-30	{adult,"older adult"}	all
5810987	Remote Education Strategies Training Oncology Residents for End-of-Life Discussions	Difficult conversations are common in oncology practice and patient-centered communication is essential to care for individuals with cancer. Within oncology training programs, communication training is mostly unstructured observation and feedback in the clinic and many learners receive inadequate training. Currently, educational resources are limited, and residents have indicated a desire for more education on end-of-life communication skills. A formal communication curriculum could fill a gap and help to standardize teaching and evaluation.\n\nThe overall goal of this study is to establish an effective communication skills curriculum for oncology residents that can be delivered remotely and that addresses difficult conversations with cancer patients. Through this preliminary study, we will explore the feasibility of a randomized controlled trial comparing different training experiences to understand how best to help oncology residents develop strong end-of-life communication skills.	recruiting	40	interventional	{n/a}	2023-01-01	2024-03-01	{adult,"older adult"}	all
1644890	A Phase III Study of NK105 in Patients With Breast Cancer	To verify the non-inferiority of NK105, a paclitaxel-incorporating micellar nanoparticle, to paclitaxel in terms of the progression-free survival in patients with metastatic or recurrent breast cancer.	completed	436	interventional	{"phase 3"}	2012-07-01	2017-01-01	{adult,"older adult"}	female
2651987	Efficacy and Safety Study in Pancreatic or Midgut Neuroendocrine Tumours Having Progressed Radiologically While Previously Treated With Lanreotide Autogel¬Æ 120 mg	This study aims to explore the efficacy and safety of lanreotide Autogel¬Æ 120 mg administered every 14 days in subjects with grade 1 or 2, metastatic or locally advanced, unresectable pancreatic or intestinal neuroendocrine tumours (NETs) once they have progressed on the standard dose of lanreotide Autogel¬Æ 120 mg every 28 days.	completed	99	interventional	{"phase 2"}	2015-12-15	2019-10-24	{adult,"older adult"}	all
4624165	Patient Perspective of Telemedicine in Gynecology Oncology	Research question: do patients in a gynecologic oncology practice value the use of telemedicine as an adjunct to in-person visits and in what circumstances might patients not find these visits to be sufficient?	unknown	200	observational	{n/a}	2020-11-01	2021-05-01	{adult,"older adult"}	female
1703754	Adenoviral Vector Monotherapy or Combination With Chemotherapy in Subjects With Recurrent/Metastatic Breast Cancer.	Phase II, randomized, safety and efficacy study in recurrent/metastatic breast cancer with accessible lesions.\n\nPrimary End point is rate of Progression Free Survival (PFS) at the 16 week treatment time point. Hypothesis: Adenoviral vector (Ad-RTS-hIL-12) alone and in combination with chemotherapy (palifosfamide) is safe and efficacious.	completed	12	interventional	{"phase 2"}	2013-03-01	2014-12-01	{adult,"older adult"}	all
4958226	A Study to Assess the Effect of Capivasertib on Midazolam in Patients With Advanced Solid Tumours	This is an open-label, fixed-sequence study to evaluate the effect of capivasertib on the pharmacokinetics (PK) of midazolam, a sensitive CYP3A substrate. The PK of midazolam will be assessed when administered alone and in combination with repeated doses of capivasertib.	completed	21	interventional	{"phase 1"}	2021-10-15	2023-02-07	{adult,"older adult"}	all
433485	Topical Sirolimus in Patients With Basal Cell Nevus Syndrome and in Healthy Participants	RATIONALE: Studying samples of blood and tissue from patients with basal cell nevus syndrome and from healthy participants in the laboratory may help doctors learn more about changes that may occur in DNA and identify biomarkers related to basal cell nevus syndrome. Chemoprevention is the use of certain drugs to keep cancer from forming, growing, or coming back. The use of sirolimus may keep basal cell skin cancer from forming in patients with basal cell nevus syndrome.\n\nPURPOSE: This phase I trial is studying topical sirolimus in patients with basal cell nevus syndrome and in healthy participants.	completed	16	interventional	{"phase 1"}	2007-03-01	2008-03-01	{adult,"older adult"}	all
1478438	A Multicenter "Ablate and Resect" Study of Novilase¬Æ Interstitial Laser Therapy for the Ablation of Small Breast Cancers	This study will determine the rate of complete tumor ablation of small breast cancers (‚â§ 20mm) by Novilase Interstitial Laser Therapy (ILT), and determine the sensitivity and specificity of imaging (MRI, mammography and ultrasound) in detecting residual tumor post ILT ablation as correlated to histopathology from the post-ablation excision.	unknown	60	interventional	{n/a}	2012-04-01	2021-08-01	{adult,"older adult"}	female
\.


--
-- Data for Name: condition; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.condition (cancer_type) FROM stdin;
Malignant Tumours
Malignant Tumour
Cancer Nos
CANCER, NOS
CANCER,NOS
Gestational Trophoblastic Neoplasias (GTN)
Neoplastic Disease
Pancreatic Malignant Neoplasm Primary
Breast Cancer, NOS
Urothelial/Bladder Cancer, Nos
Unknown Primary Cancer
Primary Malignant Neoplasm of Lung|Primary Malignant Neoplasm of Gastrointestinal Tract
Neoplastic Syndrome
Malignant Tumors
Hepatic Malignant Neoplasm Primary Non-Resectable
Advanced Neoplastic Disease
Solid Tumours|CNS Tumours
Neoplastic Syndrome|Neuroblastoma
Tumour
Neoplastic Disease|Solid Tumor
Neoplastic Disease|Pathology
Breast Cancer Nos Premenopausal
Malignant Tumor
Primary Malignant Neoplasm of Prostate (Diagnosis)
Advanced Malignant Tumors
Malignant Neoplasms
Breast Cancer, NOS|CNS Primary Tumor, NOS|Cervical Cancer, NOS|Colorectal Cancer, NOS|Leukemia, NOS|Lymphoma, NOS|Miscellaneous Neoplasm, NOS
Metastasis to Brain of Primary Cancer
Epithelial Odontogenic Tumours
Primary Malignant Neoplasm of Ovary|FIGO Stages II to IV
HPV-related Lower Genital Tract Neoplasias|HPV-related Anal Neoplasias|Early Stage Lower Genital Tract Cancers
Primary Malignant Neoplasm of Ascending Colon
Terminal Malignant Tumors
Neoplastic Disease|Glioblastoma|Glioblastoma Multiforme
Gynaecological Malignant Tumours With Indication of Pelvic Lymphadenectomy
CAR|Malignant Tumors
Sigmoidal Tumour
Liver Malignant Tumors
Wilms Tumour
Oncology
NeuroEndocrine Tumours
Cancer, Malignant Tumors
Prehabilitation|Oncology|Surgical Oncology
Solid Tumour
Breast Cancer Nos Metastatic Recurrent
Pancreatic Tumours|Midgut Neuroendocrine Tumours
Neoplastic Syndrome|Non-melanomatous Skin Cancer
\.


--
-- Data for Name: eligibility; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.eligibility (age, sex) FROM stdin;
{adult,"older adult"}	all
{adult,"older adult"}	female
{child,adult,"older adult"}	all
{child,adult}	all
{adult}	all
{adult,"older adult"}	male
\.


--
-- Data for Name: institution; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.institution (institution_name, contact_person_name, phone_number, email, address_street, address_city, address_state, address_zipcode, address_country) FROM stdin;
Jiangsu HengRui Medicine Co., Ltd.	National Institutes of Health	301-496-4000	olib@od.nih.gov	9000 Rockville Pike	Bethesda	Maryland	20892	United States
Durham University	National Institutes of Health	301-496-4001	olib@od.nih.gov	9001 Rockville Pike	Bethesda	Maryland	20893	United States
Virginia Commonwealth University	National Institutes of Health	301-496-4002	olib@od.nih.gov	9002 Rockville Pike	Bethesda	Maryland	20894	United States
Bristol-Myers Squibb	National Institutes of Health	301-496-4003	olib@od.nih.gov	9003 Rockville Pike	Bethesda	Maryland	20895	United States
University of Texas Southwestern Medical Center	National Institutes of Health	301-496-4005	olib@od.nih.gov	9005 Rockville Pike	Bethesda	Maryland	20897	United States
Hospices Civils de Lyon	National Institutes of Health	301-496-4006	olib@od.nih.gov	9006 Rockville Pike	Bethesda	Maryland	20898	United States
NantBioScience, Inc.	National Institutes of Health	301-496-4008	olib@od.nih.gov	9008 Rockville Pike	Bethesda	Maryland	20900	United States
Universita di Verona	National Institutes of Health	301-496-4009	olib@od.nih.gov	9009 Rockville Pike	Bethesda	Maryland	20901	United States
Methodist Health System	National Institutes of Health	301-496-4010	olib@od.nih.gov	9010 Rockville Pike	Bethesda	Maryland	20902	United States
Eastern Cooperative Oncology Group	National Institutes of Health	301-496-4011	olib@od.nih.gov	9011 Rockville Pike	Bethesda	Maryland	20903	United States
Matthew Galsky	National Institutes of Health	301-496-4012	olib@od.nih.gov	9012 Rockville Pike	Bethesda	Maryland	20904	United States
SCRI Development Innovations, LLC	National Institutes of Health	301-496-4013	olib@od.nih.gov	9013 Rockville Pike	Bethesda	Maryland	20905	United States
Abramson Cancer Center at Penn Medicine	National Institutes of Health	301-496-4014	olib@od.nih.gov	9014 Rockville Pike	Bethesda	Maryland	20906	United States
Dartmouth-Hitchcock Medical Center	National Institutes of Health	301-496-4015	olib@od.nih.gov	9015 Rockville Pike	Bethesda	Maryland	20907	United States
UCSF Benioff Children's Hospital Oakland	National Institutes of Health	301-496-4016	olib@od.nih.gov	9016 Rockville Pike	Bethesda	Maryland	20908	United States
West China Hospital	National Institutes of Health	301-496-4017	olib@od.nih.gov	9017 Rockville Pike	Bethesda	Maryland	20909	United States
Delcath Systems Inc.	National Institutes of Health	301-496-4019	olib@od.nih.gov	9019 Rockville Pike	Bethesda	Maryland	20911	United States
LaNova Medicines Limited	National Institutes of Health	301-496-4020	olib@od.nih.gov	9020 Rockville Pike	Bethesda	Maryland	20912	United States
Nanjing Leads Biolabs Co.,Ltd	National Institutes of Health	301-496-4021	olib@od.nih.gov	9021 Rockville Pike	Bethesda	Maryland	20913	United States
InnoPharmax Inc.	National Institutes of Health	301-496-4022	olib@od.nih.gov	9022 Rockville Pike	Bethesda	Maryland	20914	United States
Tel-Aviv Sourasky Medical Center	National Institutes of Health	301-496-4023	olib@od.nih.gov	9023 Rockville Pike	Bethesda	Maryland	20915	United States
Sanofi	National Institutes of Health	301-496-4024	olib@od.nih.gov	9024 Rockville Pike	Bethesda	Maryland	20916	United States
Dr David Ziegler	National Institutes of Health	301-496-4025	olib@od.nih.gov	9025 Rockville Pike	Bethesda	Maryland	20917	United States
Second Affiliated Hospital of Guangzhou Medical University	National Institutes of Health	301-496-4026	olib@od.nih.gov	9026 Rockville Pike	Bethesda	Maryland	20918	United States
Children's Oncology Group	National Institutes of Health	301-496-4027	olib@od.nih.gov	9027 Rockville Pike	Bethesda	Maryland	20919	United States
Second Affiliated Hospital, School of Medicine, Zhejiang University	National Institutes of Health	301-496-4028	olib@od.nih.gov	9028 Rockville Pike	Bethesda	Maryland	20920	United States
St. Jude Children's Research Hospital	National Institutes of Health	301-496-4029	olib@od.nih.gov	9029 Rockville Pike	Bethesda	Maryland	20921	United States
National Taiwan University Hospital	National Institutes of Health	301-496-4030	olib@od.nih.gov	9030 Rockville Pike	Bethesda	Maryland	20922	United States
Medical University of Vienna	National Institutes of Health	301-496-4031	olib@od.nih.gov	9031 Rockville Pike	Bethesda	Maryland	20923	United States
Sun Yat-Sen Memorial Hospital of Sun Yat-Sen University	National Institutes of Health	301-496-4032	olib@od.nih.gov	9032 Rockville Pike	Bethesda	Maryland	20924	United States
Zhejiang Cancer Hospital	National Institutes of Health	301-496-4033	olib@od.nih.gov	9033 Rockville Pike	Bethesda	Maryland	20925	United States
Mayo Clinic	National Institutes of Health	301-496-4034	olib@od.nih.gov	9034 Rockville Pike	Bethesda	Maryland	20926	United States
SUNHOÔºàChinaÔºâBioPharmaceutical CO., Ltd.	National Institutes of Health	301-496-4035	olib@od.nih.gov	9035 Rockville Pike	Bethesda	Maryland	20927	United States
Tianjin Chasesun Pharmaceutical Co., LTD	National Institutes of Health	301-496-4037	olib@od.nih.gov	9037 Rockville Pike	Bethesda	Maryland	20929	United States
NovaRock Biotherapeutics, Ltd	National Institutes of Health	301-496-4040	olib@od.nih.gov	9040 Rockville Pike	Bethesda	Maryland	20932	United States
Asclepius Technology Company Group (Suzhou) Co., Ltd.	National Institutes of Health	301-496-4041	olib@od.nih.gov	9041 Rockville Pike	Bethesda	Maryland	20933	United States
Baptist Health, Louisville	National Institutes of Health	301-496-4042	olib@od.nih.gov	9042 Rockville Pike	Bethesda	Maryland	20934	United States
Zhejiang Provincial People's Hospital	National Institutes of Health	301-496-4043	olib@od.nih.gov	9043 Rockville Pike	Bethesda	Maryland	20935	United States
Akeso	National Institutes of Health	301-496-4044	olib@od.nih.gov	9044 Rockville Pike	Bethesda	Maryland	20936	United States
Lawson Health Research Institute	National Institutes of Health	301-496-4045	olib@od.nih.gov	9045 Rockville Pike	Bethesda	Maryland	20937	United States
Shenzhen University General Hospital	National Institutes of Health	301-496-4046	olib@od.nih.gov	9046 Rockville Pike	Bethesda	Maryland	20938	United States
Icahn School of Medicine at Mount Sinai	National Institutes of Health	301-496-4047	olib@od.nih.gov	9047 Rockville Pike	Bethesda	Maryland	20939	United States
Alpha Tau Medical LTD.	National Institutes of Health	301-496-4048	olib@od.nih.gov	9048 Rockville Pike	Bethesda	Maryland	20940	United States
National Cancer Institute, Naples	National Institutes of Health	301-496-4049	olib@od.nih.gov	9049 Rockville Pike	Bethesda	Maryland	20941	United States
Suzhou Suncadia Biopharmaceuticals Co., Ltd.	National Institutes of Health	301-496-4050	olib@od.nih.gov	9050 Rockville Pike	Bethesda	Maryland	20942	United States
Assistance Publique - H√¥pitaux de Paris	National Institutes of Health	301-496-4053	olib@od.nih.gov	9053 Rockville Pike	Bethesda	Maryland	20945	United States
CSPC Ouyi Pharmaceutical Co., Ltd.	National Institutes of Health	301-496-4055	olib@od.nih.gov	9055 Rockville Pike	Bethesda	Maryland	20947	United States
Chinese PLA General Hospital	National Institutes of Health	301-496-4057	olib@od.nih.gov	9057 Rockville Pike	Bethesda	Maryland	20949	United States
University of Leicester	National Institutes of Health	301-496-4059	olib@od.nih.gov	9059 Rockville Pike	Bethesda	Maryland	20951	United States
Hospital Universitario Virgen de la Arrixaca	National Institutes of Health	301-496-4061	olib@od.nih.gov	9061 Rockville Pike	Bethesda	Maryland	20953	United States
Chia Tai Tianqing Pharmaceutical Group Co., Ltd.	National Institutes of Health	301-496-4062	olib@od.nih.gov	9062 Rockville Pike	Bethesda	Maryland	20954	United States
Atridia Pty Ltd.	National Institutes of Health	301-496-4063	olib@od.nih.gov	9063 Rockville Pike	Bethesda	Maryland	20955	United States
Cairo University	National Institutes of Health	301-496-4067	olib@od.nih.gov	9067 Rockville Pike	Bethesda	Maryland	20959	United States
Innovent Biologics (Suzhou) Co. Ltd.	National Institutes of Health	301-496-4068	olib@od.nih.gov	9068 Rockville Pike	Bethesda	Maryland	20960	United States
Telix International Pty Ltd	National Institutes of Health	301-496-4069	olib@od.nih.gov	9069 Rockville Pike	Bethesda	Maryland	20961	United States
PersonGen BioTherapeutics (Suzhou) Co., Ltd.	National Institutes of Health	301-496-4072	olib@od.nih.gov	9072 Rockville Pike	Bethesda	Maryland	20964	United States
Corporacion Parc Tauli	National Institutes of Health	301-496-4073	olib@od.nih.gov	9073 Rockville Pike	Bethesda	Maryland	20965	United States
Fudan University	National Institutes of Health	301-496-4074	olib@od.nih.gov	9074 Rockville Pike	Bethesda	Maryland	20966	United States
University Hospital, Montpellier	National Institutes of Health	301-496-4075	olib@od.nih.gov	9075 Rockville Pike	Bethesda	Maryland	20967	United States
Henan Cancer Hospital	National Institutes of Health	301-496-4076	olib@od.nih.gov	9076 Rockville Pike	Bethesda	Maryland	20968	United States
Amsterdam UMC, location VUmc	National Institutes of Health	301-496-4077	olib@od.nih.gov	9077 Rockville Pike	Bethesda	Maryland	20969	United States
Alloplex Biotherapeutics Inc	National Institutes of Health	301-496-4078	olib@od.nih.gov	9078 Rockville Pike	Bethesda	Maryland	20970	United States
Ipsen	National Institutes of Health	301-496-4079	olib@od.nih.gov	9079 Rockville Pike	Bethesda	Maryland	20971	United States
Eisai Inc.	National Institutes of Health	301-496-4080	olib@od.nih.gov	9080 Rockville Pike	Bethesda	Maryland	20972	United States
MaineHealth	National Institutes of Health	301-496-4082	olib@od.nih.gov	9082 Rockville Pike	Bethesda	Maryland	20974	United States
Capital Medical University	National Institutes of Health	301-496-4083	olib@od.nih.gov	9083 Rockville Pike	Bethesda	Maryland	20975	United States
Presage Biosciences	National Institutes of Health	301-496-4084	olib@od.nih.gov	9084 Rockville Pike	Bethesda	Maryland	20976	United States
UNICANCER	National Institutes of Health	301-496-4086	olib@od.nih.gov	9086 Rockville Pike	Bethesda	Maryland	20978	United States
AstraZeneca	National Institutes of Health	301-496-4087	olib@od.nih.gov	9087 Rockville Pike	Bethesda	Maryland	20979	United States
Prova Health Limited	National Institutes of Health	301-496-4088	olib@od.nih.gov	9088 Rockville Pike	Bethesda	Maryland	20980	United States
McMaster University	National Institutes of Health	301-496-4090	olib@od.nih.gov	9090 Rockville Pike	Bethesda	Maryland	20982	United States
Nippon Kayaku Co., Ltd.	National Institutes of Health	301-496-4091	olib@od.nih.gov	9091 Rockville Pike	Bethesda	Maryland	20983	United States
TriHealth Inc.	National Institutes of Health	301-496-4093	olib@od.nih.gov	9093 Rockville Pike	Bethesda	Maryland	20985	United States
Alaunos Therapeutics	National Institutes of Health	301-496-4094	olib@od.nih.gov	9094 Rockville Pike	Bethesda	Maryland	20986	United States
Yale University	National Institutes of Health	301-496-4098	olib@od.nih.gov	9098 Rockville Pike	Bethesda	Maryland	20990	United States
Novian Health Inc.	National Institutes of Health	301-496-4099	olib@od.nih.gov	9099 Rockville Pike	Bethesda	Maryland	20991	United States
\.


--
-- Data for Name: intervention; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.intervention (treatment, treatment_type) FROM stdin;
SHR-1802	DRUG
Terahertz metamaterials	DIAGNOSTIC_TEST
Resting Energy Expenditure	PROCEDURE
Lirilumab	DRUG
Cognitive Assessment	OTHER
Avelumab Injection	DRUG
Avelumab administration at 10mg/kg	DRUG
ABI-011	DRUG
Adjuvant Therapy After Pancreatic Resection	MISC
Treatment of Benign or Malignant Gastroesophageal Diseases	MISC
Questionnaire	OTHER
Atezolizumab	DRUG
Review of Molecular Profiling-Real Time Polymerase Chain Reaction	MISC
Data Collection	OTHER
First Session	OTHER
tazarotene	DRUG
EBV mRNA vaccine	BIOLOGICAL
Urelumab	DRUG
Melphalan Percutaneous Hepatic Perfusion	MISC
LM101	DRUG
LBL-007 Injection	DRUG
Gemcitabine HCl Oral Formulation	DRUG
Nutritional support with Standard diet	OTHER
AVE8062	DRUG
Mitoxantrone packaged EDV (EnGeneIC Delivery Vehicle)	DRUG
ketogenic diet	OTHER
gene expression analysis	GENETIC
3M CaviionTM	OTHER
Indocyanine Green	DRUG
Ultrasound Backscatterer Imaging	MISC
Additive classical homeopathy	DRUG
Docetaxel	DRUG
Tongue images, coating on the tongue and clinical data of patients with malignant tumors and healthy people will be collected.	OTHER
MR guided cryoablation	PROCEDURE
IAP0971	DRUG
IBC0966	BIOLOGICAL
IMMH-010	DRUG
Questionnaires	OTHER
EBV immunological agent	BIOLOGICAL
NBL-020 for Injection	DRUG
BiCAR-NK/T cells (ROBO1 CAR-NK/T cells)	BIOLOGICAL
SCART radiation therapy	RADIATION
Mirabegron	DRUG
AK130	DRUG
Whole Brain XRT 30Gy/10 fractions with	RADIATION
DC-CTL	BIOLOGICAL
No intervention	OTHER
 Experimental	DEVICE
 PRO-CTCAE items	OTHER
 SHR-2002 injection„ÄÅCamrelizumab for Injection, SHR-1316 injection, SHR-1701 injection	DRUG
 LBL-033 for Injection	DRUG
 AK112	DRUG
 Confrontation Phenotypes and Genotypes	MISC
 SHR-1901	DRUG
 SYH2043	DRUG
 AK127 Q3W IV infusion ,AK104 10mg/kg Q3W IV infusion	DRUG
 Decitabine (DTC Arm)	DRUG
 gamma camera imaging	OTHER
 Diagnostic tests for anal cancer screening	DIAGNOSTIC_TEST
 antiperistaltic side-to-side ileocecal anastomosis	PROCEDURE
 TQB2858 injection	DRUG
 SHR-2002 and SHR-1316	DRUG
 LBL-019 Injection	DRUG
 TQB3617	DRUG
 AK104	DRUG
 attachment retained obturator	OTHER
 IBI319	DRUG
 131I-IPA	DRUG
 TQB3804	DRUG
 Lower-limb drainage isotopic intraoperative detection	PROCEDURE
 Chimeric antigen receptor modified Œ≥Œ¥ T cells	DRUG
 L-BUPIVACAINE ; MORPHINE	DRUG
 Tislelizumab	DRUG
 Resection of the retrorectal tumor	PROCEDURE
 3D printed bone prosthesis replacement surgery	OTHER
 Wilms tumor follow up	MISC
 SUPLEXA	BIOLOGICAL
 lanreotide acetate	DRUG
 E7974	DRUG
 LARS ligament and bone prosthesis replacement was performed	OTHER
 Thinkific Prehabilitation Exercise Program	OTHER
 DC-CIK Immunotherapy	BIOLOGICAL
 MVC-101	BIOLOGICAL
 blood sampling	PROCEDURE
 Epidemiology and Management	MISC
 NAVIFY Oncology Hub	DEVICE
 COVID-19 Detection Test	MISC
 RESTORE	OTHER
 NK105	DRUG
 Lanreotide autogel 120 mg	DRUG
 Survey	OTHER
 Ad-RTS-hIL-12 and Veledimex	GENETIC
 SHR2554 Tablets	DRUG
 SHR2554	DRUG
 Capivasertib	DRUG
 sirolimus	DRUG
 Novilase Interstitial Laser Therapy	DEVICE
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.location (location_name, address_city, address_state, address_zipcode, address_country) FROM stdin;
Tianjin Medical University Cancer Institute and Hospital	Tianjin	Tianjin	300060	China
Department of Engineering Durham University	Durham	\N	DH1 3LE	United Kingdom
Virginia Commonwealth University/ Massey Cancer Center	Richmond	Virginia	23298-0070	United States
H. Lee Moffitt Cancer Center & Research Institute	Tampa	Florida	33612	United States
Ucsf	San Francisco	California	94115	United States
University of Texas Southwestern Medical Center Simmons Comprehensive Cancer Center	Dallas	exas	75235	United States
Lyon Sud Hospital Center	Pierre-Bénite	\N	69495	France
Institut Bergonie	Bordeaux Cedex	\N	33076	France
Chan Soon-Shiong Institute for Medicine	El Segundo	California	90245	United States
University of Verona Hospital	Verona	\N	37134	Italy
Trinity Surgical Consultants,  Methodist Richardson Medical Center	Richardson	Texas	75082	United States
University of Michigan	Ann Arbor	Michigan	48109	United States
Icahn School of Medicine at Mount Sinai	New York	New York	10029	United States
Tennessee Oncology, PLLC	Nashville	Tennessee	37023	United States
Abramson Cancer Center of the University of Pennsylvania	Philadelphia	Pennsylvania	19104	United States
Dartmouth-Hitchcock Medical Center	Lebanon	New Hampshire	3756	United States
Children's Hospital and Research Center Oakland	Oakland	California	94609	United States
West China Hospital,  Sichuan University	Chengdu	Sichuan	610041	China
Local Institution	Kobe-shi	Hyogo	6500017	Japan
Southampton University Hospitals and University of Southampton	Southampton	\N	\N	United Kingdom
Sun Yat-sen University Cancer Center	Guangzhou	\N	\N	China
Anhui Cancer Hospital	Hefei	Anhui	230031	China
Georgia Regents University- Cancer Center	Augusta	Georgia	30912	United States
Tel-Aviv Sourasky Medical Center	Tel Aviv-Yafo	\N	\N	Israel
Sanofi	Paris	\N	\N	France
Sydney Children's Hospital	Randwick	New South Wales	2031	Australia
the Second Affiliated Hospital of Guangzhou Medical University	Guangzhou	Guangdong	\N	China
National Institutes of Health	Bethesda	Maryland 	20892	United States
Zhejiang University	Hangzhou	ZheJiang	310009	China
St. Jude Children's Research Hospital	Memphis	Tennessee	38105	United States
National Taiwan University Hospital	Taipei	\N	10051	Taiwan
Michael Frass	Wien	\N	1120	Austria
The first People's Hospital of Foshan	Foshan	Guangdong	528000	China
Cancer Hospital of the University of Chinese Academy of Sciences (Zhejiang Cancer Hospital)	Hangzhou	Zhejiang	310022	China
Mayo Clinic	Rochester	Minnesota	55905	United States
Shanghai East Hospital	Shanghai	Shanghai	200120	China
The Affiliated Tumor Hospital of Harbin Medical University	Harbin	Heilongjiang	150081	China
Guangdong Provincial People's Hospital	Guangzhou	Guangdong	\N	China
Fairbanks Memorial Hospital	Fairbanks	Alaska	99701	United States
West China Hospital	Chendu	Sichuan	610041	China
NovaRock Biotherapeutics	Ewing Township	New Jersey	8628	United States
Department of Oncology,  Suzhou Kowloon Hospital,  Shanghai Jiaotong University School of Medicine	Suzhou	Jiangsu	215021	China
Innovative Cancer Institute	Miami	Florida	33143	United States
Zhejiang Provincial People's Hospital	Hangzhou	Zhejiang	30000	China
Alberta Health Services,  Cross Cancer Institute	Edmonton	Alberta	T6G 1Z2	Canada
Shenzhen University General Hospital	Shenzhen	Guangdong	518000	China
Emory University	Atlanta	Georgia	30322	United States
Hadassah Ein Kerem	Jerusalem	\N	\N	Israel
Oncologia Medica per la Patologia Toracica- IRCCS Giovanni Paolo II	Bari	\N	\N	Italy
Henan Science and Technology University First Affiliated Hospital	Luoyang	Henan	471003	China
Fujian Cancer Hospital	Fuzhou	Fujian	350014	China
Zhejiang Cancer Hospital	Hangzhou	Zhejiang	310000	China
Stomatologie et Chirurgie Maxillofaciale - Pitie Salpetriere	Paris	\N	75013	France
Zhongshan Hospital Affiliated to Fudan University	Shanghai	Shanghai	200433	China
Cancer Hospital Chinese Academy of Medical Sciences	Beijing	Beijing	100021	China
Chinese PLA General Hospital	Beijing	Beijing	100853	China
University of Leicester	Leicester	\N	LE1 7RH	United Kingdom
Hospital Universitario Virgen de La Arrixaca	Murcia	\N	30120	Spain
Jinlin Cancer Hospital	Changchun	Jilin	130000	China
Icon Cancer Centre	Brisbane	Queensland	4101	Australia
Union hospital Tongji Medical College Huazhong University of Science and Technology	Wuhan	Hubei	430022	China
Sun Yat-sen University Cancer Cen	Guangzhou	Guangdong	510060	China
Shanghai Renji Hospital	Shanghai	\N	\N	China
Mohamed Yahia Sharaf	Cairo	\N	11599	Egypt
Gold Coast University Hospital	Gold Coast	Queensland	\N	Australia
HEGP	Paris	Ile-de-France	75	France
Anhui Provincial Hospital	Hefei	Anhui	230000	China
Corporacion Parc Tauli	Sabadell	Sabadell-Barcelona	8208	Spain
Fudan University Shanghai Cancer Center	Shanghai	\N	200062	China
Uhmontpellier	Montpellier	\N	34295	France
Department of Bone and Soft Tissue 	Henan Cancer Hospital	Zhengzhou	Henan	China
Mbingo Mission Hospital	Bamenda	\N	\N	Cameroon
Greenslopes Private Hospital/Gallipoli Medical Research Foundation	Brisbane	Queeensland	4120	Australia
Basingstoke & North Hampshire Hospital	Basingstoke	\N	\N	United Kingdom
Nevada Cancer Institute	Las Vegas	Nevada	89135	United States
Maine Medical Center	Portland	Maine	4101	United States
Capital Medical Unvierstiy Cancer Center/ Beijing Shijitan Hospital	Beijing	\N	100038	China
Chris O'Brien Lifehouse	Camperdown	New South Wales	2050	Australia
Sylvester Comprehensive Cancer Center - University of Miami	Miami	Florida	33136	United States
Gustave roussy	Villejuif	\N	94805	France
Doina Coste Gherasim	Baia Mare	\N	\N	Romania
Prova Health Limited	London	\N	SE13XF	United Kingdom
Centre Hospitalier de Boulogne sur Mer	Boulogne-sur-Mer	\N	\N	France
Juravinski Cancer Centre - Hamilton Health Sciences	Hamilton	Ontario	L8V 5C2	Canada
Japan Sites	Tokyo	\N	\N	Japan
Erasme Hospital	Bruxelles	\N	1070	Belgium
Baptist Cancer Institute	Jacksonville	Florida	32207	United States
Beijing Tongren Hospital Affiliated to Capital Medical University	Beijing	Beijing	100730	China
Research Site	Aurora	Colorado	80045	United States
The Breast Center of Southern Arizona	Tucson	Arizona	85712	United States
\.


--
-- Data for Name: saves; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.saves (user_name, nct) FROM stdin;
user001	4414150
johndoe	4125524
alice_wonder	3621124
user003	1750580
user004	1714739
sarah_smith	3052868
user006	4396223
robert_jones	3135769
user008	2582827
user009	3788382
emma_johnson	4637256
user011	5076266
mike_miller	3359239
user013	876408
user014	2159742
alex_turner	2575898
user016	489086
user017	5714748
sophia_wilson	2534506
user019	3266042
user020	5615974
william_clark	5516914
user022	1678690
user023	1092247
olivia_andrews	1907685
user025	2687386
user026	3160599
noah_roberts	1553448
user028	5776732
user029	4084067
ava_morris	2786199
user031	1509612
user032	1503905
liam_turner	4793672
user034	4797039
user035	5396391
mia_campbell	4980690
user037	4343859
user038	5108298
logan_brown	5707910
user040	5877924
user041	3931720
harper_stewart	4881981
user043	5779514
user044	5653284
evelyn_rodriguez	1543542
user046	4672473
user047	5394428
james_miller	5781555
user049	4416672
user050	5198817
sophia_james	5779163
user052	5214482
user053	2167581
ethan_scott	5193721
user055	5728541
user056	5868876
olivia_smith	2159820
user058	5229497
user059	3920371
noah_miller	5217940
user061	2309931
user062	4805060
mia_johnson	5082545
user064	5223231
user065	5110807
liam_wilson	5235542
user067	3146624
user068	4708210
ava_clark	5450744
user070	4128085
user071	1946672
oliver_roberts	4702841
user073	1825993
user074	4996446
emma_turner	4757103
user076	5616195
user077	1991652
ethan_stewart	5237206
user079	2075606
user080	130169
ava_jones	5616182
user082	5377970
user083	1906632
oliver_morris	4891718
user085	165802
user086	1993498
sophia_clark	1711502
user088	5478135
user089	4367870
logan_smith	5810987
user091	1644890
user092	2651987
mia_miller	4624165
user094	1703754
user095	5661591
james_clark	5592262
user097	4958226
user098	433485
test	1678690
test	4414150
\.


--
-- Data for Name: sponsors; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.sponsors (nct, institution_name) FROM stdin;
4414150	Jiangsu HengRui Medicine Co., Ltd.
4125524	Durham University
3621124	Virginia Commonwealth University
1750580	Bristol-Myers Squibb
1714739	Bristol-Myers Squibb
3052868	University of Texas Southwestern Medical Center
4396223	Hospices Civils de Lyon
3135769	Hospices Civils de Lyon
2582827	NantBioScience, Inc.
3788382	Universita di Verona
4637256	Methodist Health System
5076266	Eastern Cooperative Oncology Group
3359239	Matthew Galsky
876408	SCRI Development Innovations, LLC
2159742	Abramson Cancer Center at Penn Medicine
2575898	Dartmouth-Hitchcock Medical Center
489086	UCSF Benioff Children's Hospital Oakland
5714748	West China Hospital
2534506	Bristol-Myers Squibb
3266042	Delcath Systems Inc.
5615974	LaNova Medicines Limited
5516914	Nanjing Leads Biolabs Co.,Ltd
1678690	InnoPharmax Inc.
1092247	Tel-Aviv Sourasky Medical Center
1907685	Sanofi
2687386	Dr David Ziegler
3160599	Second Affiliated Hospital of Guangzhou Medical University
1553448	Children's Oncology Group
5776732	Second Affiliated Hospital, School of Medicine, Zhejiang University
4084067	St. Jude Children's Research Hospital
2786199	National Taiwan University Hospital
1509612	Medical University of Vienna
1503905	Sun Yat-Sen Memorial Hospital of Sun Yat-Sen University
4793672	Zhejiang Cancer Hospital
4797039	Mayo Clinic
5396391	SUNHOÔºàChinaÔºâBioPharmaceutical CO., Ltd.
4980690	SUNHOÔºàChinaÔºâBioPharmaceutical CO., Ltd.
4343859	Tianjin Chasesun Pharmaceutical Co., LTD
5108298	Eastern Cooperative Oncology Group
5707910	West China Hospital
5877924	NovaRock Biotherapeutics, Ltd
3931720	Asclepius Technology Company Group (Suzhou) Co., Ltd.
4881981	Baptist Health, Louisville
5779514	Zhejiang Provincial People's Hospital
5653284	Akeso
1543542	Lawson Health Research Institute
4672473	Shenzhen University General Hospital
5394428	Icahn School of Medicine at Mount Sinai
5781555	Alpha Tau Medical LTD.
4416672	National Cancer Institute, Naples
5198817	Suzhou Suncadia Biopharmaceuticals Co., Ltd.
5779163	Nanjing Leads Biolabs Co.,Ltd
5214482	Akeso
2167581	Assistance Publique - H√¥pitaux de Paris
5193721	Suzhou Suncadia Biopharmaceuticals Co., Ltd.
5728541	CSPC Ouyi Pharmaceutical Co., Ltd.
5868876	Akeso
2159820	Chinese PLA General Hospital
5229497	Akeso
3920371	University of Leicester
5217940	Icahn School of Medicine at Mount Sinai
2309931	Hospital Universitario Virgen de la Arrixaca
4805060	Chia Tai Tianqing Pharmaceutical Group Co., Ltd.
5082545	Atridia Pty Ltd.
5223231	Nanjing Leads Biolabs Co.,Ltd
5110807	Chia Tai Tianqing Pharmaceutical Group Co., Ltd.
5235542	Akeso
3146624	Cairo University
4708210	Innovent Biologics (Suzhou) Co. Ltd.
5450744	Telix International Pty Ltd
4128085	Chia Tai Tianqing Pharmaceutical Group Co., Ltd.
1946672	Assistance Publique - H√¥pitaux de Paris
4702841	PersonGen BioTherapeutics (Suzhou) Co., Ltd.
1825993	Corporacion Parc Tauli
4996446	Fudan University
4757103	University Hospital, Montpellier
5616195	Henan Cancer Hospital
1991652	Amsterdam UMC, location VUmc
5237206	Alloplex Biotherapeutics Inc
2075606	Ipsen
130169	Eisai Inc.
5616182	Henan Cancer Hospital
5377970	MaineHealth
1906632	Capital Medical University
4891718	Presage Biosciences
165802	Eisai Inc.
1993498	UNICANCER
1711502	AstraZeneca
5478135	Prova Health Limited
4367870	UNICANCER
5810987	McMaster University
1644890	Nippon Kayaku Co., Ltd.
2651987	Ipsen
4624165	TriHealth Inc.
1703754	Alaunos Therapeutics
5661591	Jiangsu HengRui Medicine Co., Ltd.
5592262	Jiangsu HengRui Medicine Co., Ltd.
4958226	AstraZeneca
433485	Yale University
1478438	Novian Health Inc.
\.


--
-- Data for Name: study; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.study (primary_measurements, secondary_measurements, other, nct, cancer_type, treatment, treatment_type) FROM stdin;
Dose limiting toxicity, Days 1-21	Percentage of patients with adverse events, from the first drug administration to within 90 days for the last SHR-1802 dose|Rates of dose suspension, dose reduction and dose discontinuation caused by investigational drug related adverse events, At pre-defined intervals from initial dose up to 24 months|ORR, At pre-defined intervals from initial dose up to 24 months|DOR, At pre-defined intervals from initial dose up to 24 months|DCR, At pre-defined intervals from initial dose up to 24 months|PFS, At pre-defined intervals from initial dose up to 24 months|Maximum Concentration (Cmax) of SHR-1802, At pre-defined intervals from initial dose through final study visit (up to 24 months)|Time of Maximum Concentration (Tmax) of SHR-1802, At pre-defined intervals from initial dose through final study visit (up to 24 months)|Area Under the Curve (AUC) of SHR-1802, At pre-defined intervals from initial dose through final study visit (up to 24 months)|Terminal Half-Life (T1/2) of SHR-1802, At pre-defined intervals from initial dose through final study visit (up to 24 months)|Clearance (CL) of SHR-1802, At pre-defined intervals from initial dose through final study visit (up to 24 months)|Volume of Distribution at Steady State (Vss) of SHR-1802, At pre-defined intervals from initial dose through final study visit (up to 24 months)|Evaluation of the immunogenicity of SHR-1802, Serum sampling to assess the potential for anti-drug antibody (ADA) formation., At pre-defined intervals from initial dose through final study visit (up to 24 months)	\N	4414150	Malignant Tumours	SHR-1802	DRUG
Evidence of detection for any marker, Any correlation showing a difference between samples with marker concentrations above and below the standard threshold values used for tests within the NHS., 18 months	Quantifying the quality of detection per marker, Percentage of detectable samples for each specific marker which showed any evidence of detection in outcome 1., 18 months	\N	4125524	Malignant Tumour	Terahertz metamaterials	DIAGNOSTIC_TEST
Difference in resting energy expenditure between brown adipose tissue (BAT)-positive and BAT-negative patients with cancer., Characterization of the energy metabolism profiles of cancer patients with and without evidence of BAT activation will be assessed utilizing one sided t-test., 27 Months	Difference in energy expenditure between room temperature and response to warm exposure (energy expenditure) in BAT-positive and BAT-negative cancer patients., Assessment of environmental modulation as an effective strategy to mitigate maladaptive BAT activation in patients with malignancy will be assessed by two-sided t-test., 27 Months	\N	3621124	Cancer Nos	Resting Energy Expenditure	PROCEDURE
Safety as measured by the rate of adverse events, and serious adverse events, Approximately 510 days	Efficacy as measured by tumor assessment, Assessed from the start of treatment (ay 1) to the end of treatment (week 60) and for 90 days in follow-up|The maximum observed serum concentration (Cmax) of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2. (EOI is end of infusion, EOT is end of treatment|The time of maximum observed serum concentration (Tmax) of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2|Area under the serum concentration-time curve in one dosing interval [AUC(TAU)] of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2|Area under the serum concentration-time curve from time zero extrapolated to infinite time [AUC(INF)] of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, EOT, follow-up 1 and follow-up 2|Apparent total body clearance (CL) of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2|Apparent volume of distribution at steady state (Vss) of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2|Serum half-life (T-HALF) of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2|Trough observed serum concentration (Cmin) of BMS-986015 and Ipilimumab, up to 18 timepoints following each dose during Weeks 1, (0h, EOI and 24h), 2, 3, 4, 10, (0h, EOI and 24h), 11, 13, 24, (0h and EOI), 36, 48, 60, follow-up 1 and follow-up 2|Immunogenicity as measured by the incidence of Ipilimumab and anti-Killer cell immunoglobulin-like receptor (KIR) (BMS-986015) anti-drug antibodies (ADA), up to 11 timepoints during Weeks 1, 3, 4, 10, 13, 24, 36,48, 60, follow-up 1 and follow-up 2	\N	1750580	CANCER, NOS	Lirilumab	DRUG
Number of Participants With Adverse Events (AEs) - Parts 1, 2 and 5, An Adverse Event (AE) is defined as any new untoward medical occurrence or worsening of a pre-existing medical condition in a clinical investigation participant administered an investigational (medicinal) product and that does not necessarily have a causal relationship with this treatment., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Serious Adverse Events (SAEs) - Parts 1, 2 and 5, A Serious Adverse Event (SAE) is any untoward medical occurrence that at any dose: results in death, is life-threatening, requires inpatient hospitalization or causes prolongation of existing hospitalization, results in persistent or significant disability/incapacity, is a congenital anomaly/birth defect, or is an important medical event., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Adverse Events (AEs) Leading to Discontinuation - Parts 1, 2 and 5, Number of participants that experienced an AE leading to discontinuation. An AE is defined as any new untoward medical occurrence or worsening of a pre-existing medical condition in a clinical investigation participant administered an investigational (medicinal) product and that does not necessarily have a causal relationship with this treatment., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|The Number of Participant Deaths in the Study - Parts 1, 2 and 5, The number of participants who died., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Clinical Laboratory Test Abnormalities - Parts 1, 2 and 5, Number of participants that experienced a clinical laboratory test abnormality, including hematology and serum chemistry, and thyroid panel abnormalities. Abnormalities considered are those Grade 3-4 events with a \\>= 1 grade increase from baseline. Laboratory tests are graded using National Cancer Institute (NCI) Common Terminology Criteria for Adverse Events (CTCAE) version 4.03 where Grade 3 is severe, and Grade 4 is life threatening. Baseline is defined as the last non-missing measurement prior to the first dosing date and time., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Objective Response Rate (ORR), Objective Response Rate (ORR) is defined as the percent of participants whose best overall response (BOR) is either a complete response (CR) or partial response (PR). BOR for a participant was derived using investigator-provided tumor measurements per RECIST v1.1. CR is defined as the disappearance of all target lesions. Any pathological lymph nodes (whether target or non-target) must have reduction in short axis to \\< 10 mm. PR is defined as at least a 30% decrease in the sum of diameters of target lesions, taking as reference the baseline sum diameters., From first dose up to approximately 2.5 years	Disease Control Rate (DCR) - Part 3, Disease Control Rate (DCR) is defined as the percentage of participants with a best overall response (BOR) of complete response (CR), partial response (PR), or stable disease (SD). CR is defined as the disappearance of all target lesions. Any pathological lymph nodes (whether target or non-target) must have reduction in short axis to \\< 10 mm. PR is defined as at least a 30% decrease in the sum of diameters of target lesions, taking as reference the baseline sum diameters. SD is defined as neither sufficient shrinkage to qualify for PR nor sufficient increase to qualify for progressive disease (PD), taking as reference the smallest sum diameters while on study. All participants will be monitored by radiographic assessment every 8 weeks from first dose to Week 48, and every 12 weeks thereafter until PD or treatment discontinuation., From first dose up to approximately 2.5 years|Median Duration of Response (mDOR) - Parts 3 and 5, DOR is defined as the time from the date of first response (CR or PR) to the date of first objectively documented tumor progression as determined using RECIST v1.1 or death due to any cause, whichever occurs first. Participant who remain alive and have not progressed were censored on the date of their last evaluable tumor assessment. Participants who started subsequent anticancer therapy without a prior reported progression were censored at the last evaluable tumor assessment prior to initiation of the subsequent anticancer therapy. CR is defined as the disappearance of all target lesions. Any pathological lymph nodes (whether target or non-target) must have reduction in short axis to \\< 10 mm. PR is defined as at least a 30% decrease in the sum of diameters of target lesions, taking as reference the baseline sum diameters., From first dose to the date of the first documented tumor progression as determined or death due to any cause, whichever occurs first. (Up to approximately 2.5 years)|Median Time to Response (mTTR) - Part 3, TTR is defined as the time from the first dosing date to the date of the first documented objective response (CR or PR). CR is defined as the disappearance of all target lesions. Any pathological lymph nodes (whether target or non-target) must have reduction in short axis to \\< 10 mm. PR is defined as at least a 30% decrease in the sum of diameters of target lesions, taking as reference the baseline sum diameters., From date of first dose of study medication to the date of the first documented objective response (up to approximately 2.5 years)|The Number of Participants With >=50% or >=80% Tumor Reduction - Parts 3 and 5, Depth of response is defined as the target tumor burden percent change from baseline at nadir for each participant as measured by the number of participants with \\>= 50% and \\>= 80% tumor reduction. Tumor assessments are performed every 8 weeks from first dose date for 48 weeks, and then every 12 weeks thereafter until progressive disease (PD) or treatment discontinuation, whichever occurs earlier., From first dose until progressive disease (PD) or treatment discontinuation, whichever occurs earlier. (Up to approximately 2.5 years)|Overall Survival (OS) - Part 3, Overall Survival (OS) is defined as the time from date of first dose of study medication to the date of death for any cause. A participant who has not died will be censored at last known date alive. OS for a participant who initiated new cancer treatment, will also be censored at the date of the new treatment initiation. Estimated by Kaplan-Meier Method., From date of first dose of study medication to the date of death for any cause. (Up to approximately 2.5 years)|Progression Free Survival (PFS) - Part 3, PFS is defined as the time from the first dosing date to the date of first objectively documented disease progression or death due to any cause, whichever occurs first. Participants who died without a reported prior progression was considered to have progressed on the date of their death. Participants alive with no progression were censored on the last evaluable tumor assessment date. Participants who started subsequent therapy with no prior progression were censored at the last evaluable tumor assessment prior to initiation of the subsequent therapy. Participants with no post-baseline tumor assessment and alive were censored on the date of first dose. Progression is defined as At least a 20% increase in the sum of diameters of target lesions. The sum must also demonstrate an absolute increase of at least 5 mm. (Note: the appearance of one or more new lesions is also considered progression). Clinical deterioration in the absence of radiographic evidence is not considered progression., From first dose to the date of first objectively documented disease progression or death due to any cause, whichever occurs first. (Up to approximately 2.5 years)|Progression Free Survival Rate (PFSR) at 6 Months - Part 3, Percentage of treated participants remaining progression free and surviving at 6 months. For those participants who remain alive and have not progressed, PFS will be censored on the date of the last tumor assessment. Progression is defined as At least a 20% increase in the sum of diameters of target lesions. The sum must also demonstrate an absolute increase of at least 5 mm. (Note: the appearance of one or more new lesions is also considered progression). Clinical deterioration in the absence of radiographic evidence is not considered progression., At 6 months after first dose|Number of Participants With Adverse Events (AEs) - Part 3, An Adverse Event (AE) is defined as any new untoward medical occurrence or worsening of a pre-existing medical condition in a clinical investigation participant administered an investigational (medicinal) product and that does not necessarily have a causal relationship with this treatment., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Serious Adverse Events (SAEs) - Part 3, A Serious Adverse Event (SAE) is any untoward medical occurrence that at any dose: results in death, is life-threatening, requires inpatient hospitalization or causes prolongation of existing hospitalization, results in persistent or significant disability/incapacity, is a congenital anomaly/birth defect, or is an important medical event., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Adverse Events (AEs) Leading to Discontinuation - Part 3, Number of participants that experienced an AE leading to discontinuation. An AE is defined as any new untoward medical occurrence or worsening of a pre-existing medical condition in a clinical investigation participant administered an investigational (medicinal) product and that does not necessarily have a causal relationship with this treatment., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|The Number of Participant Deaths in the Study - Part 3, The number of participants who died., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Clinical Laboratory Test Abnormalities - Part 3, Number of participants that experienced a clinical laboratory test abnormality, including hematology and serum chemistry, and thyroid panel abnormalities. Abnormalities considered are those Grade 3-4 events with a \\>= 1 grade increase from baseline. Laboratory tests are graded using National Cancer Institute (NCI) Common Terminology Criteria for Adverse Events (CTCAE) version 4.03 where Grade 3 is severe, and Grade 4 is life threatening. Baseline is defined as the last non-missing measurement prior to the first dosing date and time., From first dose to 150 days post last dose (up to an average of 51 weeks and a maximum of 2.5 years)|Number of Participants With Anti-Drug Antibodies (ADA) - Parts 1, 2 and 5, Number of participants observed as ADA positive at baseline, ADA positive (post-baseline), and ADA negative (post-baseline). Baseline is defined as the last sample before initiation of treatment\n\nBaseline ADA Positive Participant: A participant with baseline ADA positive sample.\n\nADA Positive Participant: Participant with \\>=1 ADA +ve sample relative to baseline (baseline ADA -ve, or ADA titer \\>= 9-fold for Lirilumab and \\>= 4-fold for Nivolumab relative to baseline +ve titer) at any time after first dose during the defined observation time period.\n\nADA Negative Participant: A participant with no ADA positive sample after the initiation of treatment., From first dose to 100 days after last dose (up to approximately 126 weeks)|The Number of Participants With PD-L1 Status at Pretreatment - Parts 1, 2 and 5, The number of participants with 1% or 5% PD-L1 expression in the tumor cell membrane. Participants are considered positive if they show \\>=1% or \\>= 5% PD-L1 expression in the tumor cell membrane and negative if they show \\< 1% or \\< 5%. PD-L1 expression is defined as the percent of tumor cells demonstrating plasma membrane PDL1 staining of any intensity. PD-L1 will be evaluated by immunohistochemistry (IHC).\n\nPD-L1 status at pretreatment is considered positive if any pretreatment sample is positive.\n\nPDL1= programmed cell death ligand 1, Pre-dose Day 1 (Cycles 1 ,3 ,5, 7, 9), Pre-dose Day 29 (Cycle 1, 2)|Maximum Observed Plasma Concentration (Cmax) - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Area Under the Plasma Concentration-Time Curve From Time Zero to the Time of the Last Quantifiable Concentration [AUC(0-T)] - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Area Under the Plasma Concentration-Time Curve in 1 Dosing Interval [AUC(TAU)] - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Time of Maximum Observed Concentration (Tmax) - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Half-life (T-HALF) - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data., Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Clearance Per Time (CLT) - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Trough Observed Concentration (Cmin, Also Known as CTAU) - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Area Under the Pasma Concentration-Time Curve From Time Zero Extrapolated to Infinite Time ([AUC(INF)] - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. AUC(INF) was based on appropriate characterization of the elimination phase of the concentration versus time curve, which was unable to be performed due to limited sampling in this study., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|Apparent Volume of Distribution During Terminal Phase (Vz) - Parts 1, 2 and 5, Pharmacokinetics of lirilumab were derived from serum concentration versus time data. VZ was based on appropriate characterization of the elimination phase of the concentration versus time curve, which was unable to be performed due to limited sampling in this study., Pre-dose, end of infusion, 24, 168, and 336 hours post dose on day 1 cycle 1 and pre-dose on day 29 cycle 1. Pre-dose, end of infusion, 24 and 168 hours post dose on cycle 2 day 29.|End of Infusion Concentration (Ceoi) - Parts 1, 2 and 5 (Liri), Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose and end of infusion on cycle 1 day 1 and cycle 2 day 29.|Ctrough - Parts 1, 2 and 5 (Liri), Pharmacokinetics of lirilumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose on cycle 1 day 29 and Pre-dose and end of infusion on cycle 2 day 29.|End of Infusion Concentration (Ceoi) - Parts 1, 2 and 5 (Nivo), Pharmacokinetics of nivolumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., Pre-dose and end of infusion on cycle 1 day 1 and cycle 2 day 29.|Ctrough - Parts 1, 2 and 5 (Nivo), Pharmacokinetics of nivolumab were derived from serum concentration versus time data. Geometric CV data is not available, therefore the Arithmetic %CV is represented in the table below., 336 hours post dose on cycle 1 day 1 (cycle 1 day 15) and pre-dose and end of infusion on cycle 2 day 29.	\N	1714739	CANCER,NOS	Lirilumab	DRUG
Knowledge of cognitive outcomes of cancer treatment in breast cancer, battery of neuropsychological tests is approximately 45-60 minutes. Participants will also be asked to complete a packet of several questionnaires including several self-rated measures of mood and quality of life, in addition to a brief questionnaire to obtain information about exercise, sleep, and education and employment backgrounds, 1 day	\N	\N	3052868	Cancer Nos	Cognitive Assessment	OTHER
Incidence of Dose limiting toxicities of methotrexate and avelumab combination in low-risk GTN patients as first line., Safety run-in: dose-limiting toxicities (DLT) will be determined during the first 3 months after the start of treatment, treatment duration 3 months (median estimation)|Rate of patients with successful normalization of hCG, The main endpoint of this study is the rate of patients with successful normalization of hCG allowing for treatment discontinuation (hCG normalization). Patients will continue on treatment until the weekly hCG assays reach the institutional normal threshold, and then for 3 additional cycles, or otherwise will be stopped in the case of resistance, defined as a rise (a \\> 20% rise between two assays, observed twice on three consecutive weekly assays) or a plateau (a \\< 10% decrease between two assays observed three times on four consecutive weekly assays) in the hCG level, or unacceptable toxicity and/or death., treatment duration 3 months (median estimation)	Evaluate the safety of methotrexate and avelumab combination administration, To assess the rate of treatment-emergent adverse events (TEAEs) and treatment-related adverse events (AEs), treatment-related Grade ‚â• 3 AEs, and immune-related AEs, according to National Cancer Institute (NCI) Common Terminology Criteria for Adverse Events Version 5.0 (CTCAE v5.0), during treatment duration (3 months), 1 month after end of treatment and 36 months after end of treatment (median : 8 months 1/2).|To assess the efficacy of avelumab and methotrexate in terms of resistance-free survival in low-risk GTN patients as first line setting, Resistance rate will be evaluated according to hCG level., during treatment (3 months median), 1 month after the end of treatment and 36 months after the end of treatment|To assess the efficacy of avelumab and methotrexate in terms of resistance-free survival in low-risk GTN patients as first line setting, Resistance-free survival will be evaluated according to hCG level., during treatment (3 months median), 1 month after the end of treatment and 36 months after the end of treatment|To assess the efficacy of avelumab and methotrexate in terms of relapse free survival in low-risk GTN patients as first line setting after an initial hCG normalization that enabled study treatment discontinuation, Relapse-free survival will be evaluated in the case of relapse requiring treatment resumption after a hCG normalization that enabled study treatment discontinuation, during treatment (3 months median), 1 month after the end of treatment and 36 months after the end of treatment|To assess the efficacy of avelumab and methotrexate in terms of overall survival in low-risk GTN patients as first line setting, Overall survival, during treatment (3 months median), 1 month after end of treatment and 36 months after end of treatment	\N	4396223	Gestational Trophoblastic Neoplasias (GTN)	Avelumab Injection	DRUG
The rate of patients with successful normalization of hCG assays, Clinical efficacy of avelumab administration will be evaluated by the rate of patients with successful normalization of hCG assays allowing for treatment discontinuation (hCG normalization). Patients will continue on treatment until the hCG assays, measured weekly, reach the institutional normal threshold and then for 3 additional cycles., up to 6 months	Resistance free survival, Number of patients alive free resistance (defined as a rise ‚â• 20% rise over between two assays in three consecutive weekly hCG assays or plateau ‚â§ 10% decrease between two assays in four consecutive weekly hCG), up to 6 months|Progression free survival, Number of patients alive progression free survival (defined as a rise ‚â• 20% rise over between two assays in three consecutive weekly hCG assays or plateau ‚â§ 10% decrease between two assays in four consecutive weekly hCG), up to 6 months|Overall survival, Number of patients alive 1 months after the end of treatment., up to 6 months|Overall response rate according to RECIST, Radiological response to avelumab assessed by the overall response rate according to RECIST version 1.1 criteria and immune-related RECIST criteria assessed by imaging (TAP CT scanner and / or MRI if contraindication) after cycle 4, 8 and 12, up to 6 months|NCI CTCAE version 4.0, The safety of avelumab administration will be evaluated throughout the duration of treatment (6 months max) and until the end of patient follow up (1 month after treatment discontinuation) according to NCI CTCAE version 4.0, up to 7 months|Kinetics of hCG, Modeled hCGres parameter calculated with weekly values of hCG measured during treatment days after start of Avelumab treatment., up to 7 months|PD-L1 expression in tumor samples, To predict the efficacy of anti-PD-L1 immunotherapy, we will quantify and characterize the intra and peritumoral immune infiltrate of GTN, up to 7 months|Phenotype of the intratumoral immune cell infiltrate, Immunohistochemistry with anti PD-L1, anti CD3, anti CD8, anti CD4, anti CD56 (uterine NK cells), anti FoxP3 primary antibodies will be performed on serial cuts of formalin fixed and paraffin embedded specimens from patients treated with avelumab., up to 7 months|Phenotype of the peritumoral immune cell infiltrate, Immunohistochemistry with anti PD-L1, anti CD3, anti CD8, anti CD4, anti CD56 (uterine NK cells), anti FoxP3 primary antibodies will be performed on serial cuts of formalin fixed and paraffin embedded specimens from patients treated with avelumab., up to 7 months	\N	3135769	Gestational Trophoblastic Neoplasias (GTN)	Avelumab administration at 10mg/kg	DRUG
Determine maximum tolerated dose (MTD) of ABI-011, Determine the maximum tolerated dose (MTD) for repeated dosing of ABI-011, During Cycle 1 and each 28-Day treatment cycle, End of Study, Follow-up, approximately up to 1 year	Evaluate safety and toxicity profile of ABI-011, Evaluate safety and toxicity profile for repeated dosing of ABI-011. Number of subjects with adverse events (AEs), laboratory, electrocardiogram (ECG), echocardiogram, and ophthalmologic assessments, tumor pain and vital signs., During Cycle 1 and each 28-Day treatment cycle, End of Study, Follow-up, approximately up to 2 years total|Evaluate pharmacokinetics (PK) analysis; elimination rate constant, Evaluate drug concentration time data by individual subject for repeated dosing of ABI-011., Cycle 1 (Days 1,2,3); Cycle 2 (Days 1, 2, 3); Cycle 3 (Days 1, 2, 3)|Evaluate pharmacokinetics (PK) analysis; elimination half-life, Evaluate drug concentration time data by individual subject for repeated dosing of ABI-011., Cycle 1 (Days 1,2,3); Cycle 2 (Days 1, 2, 3); Cycle 3 (Days 1, 2, 3)|Evaluate pharmacokinetics (PK) analysis; volume of distribution, Evaluate drug concentration time data by individual subject for repeated dosing of ABI-011., Cycle 1 (Days 1,2,3); Cycle 2 (Days 1, 2, 3); Cycle 3 (Days 1, 2, 3)|Evaluate pharmacokinetics (PK) analysis; maximum plasma drug concentration (Cmax), Evaluate drug concentration time data by individual subject for repeated dosing of ABI-011., Cycle 1 (Days 1,2,3); Cycle 2 (Days 1, 2, 3); Cycle 3 (Days 1, 2, 3)|Evaluate pharmacokinetics (PK) analysis; time to maximum concentration (tmax), Evaluate drug concentration time data by individual subject for repeated dosing of ABI-011., Cycle 1 (Days 1,2,3); Cycle 2 (Days 1, 2, 3); Cycle 3 (Days 1, 2, 3)|Evaluate pharmacokinetics (PK) analysis; area under the time-concentration curve (AUC), Evaluate drug concentration time data by individual subject for repeated dosing of ABI-011., Cycle 1 (Days 1,2,3); Cycle 2 (Days 1, 2, 3); Cycle 3 (Days 1, 2, 3)|Tumor response, Tumor response based on assessment of target and non-target lesions according to response evaluation criteria in solid tumors (RECIST) criteria., Baseline and Every 8 weeks through Cycle 6, then every 12 weeks, approximately up to 2 years total	\N	2582827	Neoplastic Disease	ABI-011	DRUG
Rate of patients who fail to receive adjuvant therapy and reasons for that, The amount of patients who will not receive adjuvant therapy after pancreatic resection for malignancy (when do indication exists) will be recorded, 6 months|Rate of patients who fail to complete adjuvant therapy and reasons for that, The amount of patients who will not complete adjuvant therapy after pancreatic resection for malignancy will be recorded, 9 months	Disease free survival of patients enrolled, 18 months	\N	3788382	Pancreatic Malignant Neoplasm Primary	Adjuvant Therapy After Pancreatic Resection	MISC
Overall Survival, We will be examining all treatments of benign or malignant pancreatic cancer by measuring the following outcome: overall survival, 2005 to 2019	\N	\N	4637256	Pancreatic Malignant Neoplasm Primary	Treatment of Benign or Malignant Gastroesophageal Diseases	MISC
Compare the proportion of WOC EAQ201 participants who experience COVID-related financial hardship vs non-WOC EAQ201 participants, Composite outcome, defined as answering in the affirmative to any of the following personal changes due to COVID: layoff or furlough, insurance loss, work hours reduction, new job/increased hours to increase income, food or housing insecurity OR answering in the affirmative to any of the following household changes due to COVID: greater or equal to 20% income lose, savings use for living expenses, home sale/refinance, increased debt, declared bankruptcy, Through study completion, an average of 1 year	Compare the proportions of WOC vs non-WOC EAQ201 participants with COVID-related change in their material condition, a composite measure, Self-reported material condition of any of the following: \\>20% income loss, savings use, home sale or refinance, loans, reaching credit limits, becoming subject to a collection agency, or bankruptcy in the last 3 months (binary), Through study completion, an average of 1 year|Compare the proportions of WOC vs non-WOC EAQ201 participants with COVID-specific perceived financial distress, Adapted from the summary item from COST measure (continuous) "COVID-19 has been a financial hardship to my family, Through study completion, an average of 1 year|Compare the proportion of WOC in TMIST participants vs EAQ201 participants, Race/ethnicity, age, insurance, and ZIP, Through study completion, an average of 1 year	Compare the proportion of WOC vs non-WOC EAQ201 participants with COVID-related employment change, a composite measure, Employment change of any of the following: Self-reported work hours reduction, layoff or furlough, sick time, vacation time use or new job/increased hours to increase income (binary), Through study completion, an average of 1 year|Compare the proportions of WOC vs non-WOC EAQ201 participants with COVID-specific perceived distress and perceived susceptibility to COVID and breast cancer, Adapted from Penedo (personal communication) to capture the emotional response to COVID related to fear of infection, financial anxiety, housing and food insecurity (single items) (categorical)(11 items) Single items for breast cancer and COVID-19, modified from previous studies of intention to undergo breast cancer screening. (categorical) (2 items), Through study completion, an average of 1 year|Compare the proportions of WOC vs non-WOC EAQ201 participants with relative increase in smoking and alcohol use, risk factors for breast cancer, Assess change in frequency or amount of tobacco or alcohol use during COVID compared to before COVID. Will not assess absolute amount of use. (categorical) (2 items), Through study completion, an average of 1 year|Compare participant-reported quality of life, anxiety and depression between WOC and non-WOC EAQ201 participants, Participant-Reported Outcomes Measurement Information System (PROMIS)-1018 10-item physical and mental health assessment. Sum of item responses (continuous) (10 items) PROMIS Anxiety 4-item Short Form. Sum of item responses (continuous) (4 items) PROMIS Depression 4-item Short Form. Sum of item responses (continuous) (4 items), Through study completion, an average of 1 year|Assess the effects of sociodemographic characteristics, and federal-, state- or local-level COVID-19 factors on TMIST participation, in WOC vs non-WOC, Compare maximum number of COVID-19 cases, state unemployment during shelter-in-place, local unemployment during shelter-in-place) on TMIST participation, stratified by WOC vs non-WOC, Through study completion, an average of 1 year	5076266	Breast Cancer, NOS	Questionnaire	OTHER
Number of neoantigens, Feasibility parameter: Number of neoantigens identified per subject, up to 24 months|Number of peptides synthesized, Feasibility parameter: Number of peptides synthesized per subject for vaccination, up to 24 months|Vaccine Production time, Feasibility parameter:, up to 24 months|Proportion of consent to tissue acquisition phase, Feasibility parameter: Proportion of subjects who consent to the tissue acquisition phase for whom a vaccine product is prepared, up to 24 months|Proportion of subjects eligible for the treatment phase, Feasibility parameter: Proportion of subjects eligible for the treatment phase who complete the priming course of vaccination plus atezolizumab, up to 24 months|Number of toxicities, Safety will be assessed by the frequency of toxicities as assessed by NCI-CTCAE 4.0 criteria, up to 24 months	Objective Response Rate, Objective Response Rate by RECIST 1.1 . RECIST: complete response, partial response, stable disease, and progressive disease., up to 24 hours|Duration of response, The duration of response by RECIST 1.1 and immune-related RECIST criteria in patients with metastatic disease, up to 24 months|Time to Progression In Adjuvant patients, Time-to-progression in adjuvant patients using RECIST: complete response, partial response, stable disease, and progressive disease, up to 24 months|Overall Survival, Number of participants living, up to 24 months	\N	3359239	Urothelial/Bladder Cancer, Nos	Atezolizumab	DRUG
To correlate the tissue of origin predicted by the RT-PCR assay with clinical and pathologic features of patients with carcinoma of unknown primary site., 6 months	To correlate the tissue of origin predicted by the RT-PCR with actual primary sites found subsequently in a subset of patients., 6 months|To evaluate the utility of RT-PCR assay results in guiding treatment selection in patients with carcinoma of unknown primary site., 6 months	\N	876408	Unknown Primary Cancer	Review of Molecular Profiling-Real Time Polymerase Chain Reaction	MISC
Survival and disease free, 10 years	\N	\N	2159742	Neoplastic Disease	Data Collection	OTHER
Feasibility of a creative writing intervention in an advanced cancer population, Anyone completing the first intervention with the creative writer will be evaluable for the feasibility outcome. If the investigators see 50% of patients completing 3 months of the creative writing intervention then this would indicate the intervention should be examined in a larger pilot study., 29 months	\N	\N	2575898	Primary Malignant Neoplasm of Lung|Primary Malignant Neoplasm of Gastrointestinal Tract	First Session	OTHER
Complete Response Rate, The primary endpoint used to evaluate tazarotene efficacy for BCC chemotherapy was the complete response (CR) rate, defined as the complete visible disappearance of a patient's "target" lesion during the the 18 months of tazarotene application and its failure to recur during the ensuing 18-months. We defined surgical removal of a target lesion as a treatment failure. The primary endpoint was assessed based on intention to treat analysis such that any subject who underwent the baseline evaluation and applied at least 1 dose of tazarotene was included in the analysis. Drop-outs were considered non-responders. A priori treatment success for tazarotene was defined as a CR rate of at least 50%, and treatment failure was defined as a CR rate of 25% or less., 36 months	Time to Lesion Clearance, 36 months|Time to Progression, 36 months|Estimated Duration of Complete Response, 36 months|Overall Response at Treated Lesions, 36 months	\N	489086	Neoplastic Syndrome	tazarotene	DRUG
Adverse events, Adverse events defined as the number of participants with adverse events according, up to 12 months|Objective response rate, ORR is defined as the percentage of patients who achieve a response, which can either be complete response (complete disappearance of lesions) or partial response (reduction in the sum of maximal tumor diameters by at least 30% or more), up to 12 months|Progress-Free Survival, PFS is defined as the time from the administration of the first dose to first disease, up to 12 months|Overall Survival, OS is defined as the time from the administration of the first dose to death., up to 12 months	\N	\N	5714748	Malignant Tumors	EBV mRNA vaccine	BIOLOGICAL
Safety of urelumab monotherapy as measured by the dose limiting toxicity (DLT) in subjects with advanced and/or metastatic malignant tumors, From day 1 of treatment up to 60 days of follow-up|Safety of urelumab monotherapy as measured by adverse events (AEs) and serious adverse events (SAEs) in subjects with advanced and/or metastatic malignant tumors, From day 1 of treatment up to 60 days of follow-up|Tolerability of urelumab monotherapy as measured by the DLT in subjects with advanced and/or metastatic malignant tumors, From day 1 of treatment up to 60 days of follow-up|Tolerability of urelumab monotherapy as measured by AEs and SAEs in subjects with advanced and/or metastatic malignant tumors, From day 1 of treatment up to 60 days of follow-up	Safety of urelumab-nivolumab combination therapy as measured by AEs and SAEs in subjects with advanced and/or metastatic malignant tumors, From day 1 of treatment up to 100 days of follow-up|Tolerability of urelumab-nivolumab combination therapy as measured by AEs and SAEs in subjects with advanced and/or metastatic malignant tumors, From day 1 of treatment up to 100 days of follow-up|Cmax (Maximum observed serum concentration) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|Ctrough (Trough observed serum concentration) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|Tmax (Time of maximum observed serum concentration) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|AUC(0-T) [Area under the concentration-time curve from time zero to the last quantifiable concentration] of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|AUC(TAU) [Area under the concentration-time curve in one dosing interval] of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|AUC(INF) [Area under the concentration-time curve from time zero to infinity and the extrapolated area] of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|T-HALF (Elimination half life) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|CLT (Total body clearance) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|Vss (Volume of distribution at steady state) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|AI (Accumulation Index: ratio of AUC(TAU) and Cmax in cycle at steady state to those after the first cycle) of urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 3, 4, 5, 6, 7, 12, 16, up to 60 days of follow up|Cmax of urelumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|Coeff of urelumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|Ctrough of urelumab and nivolumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|Tmax of urelumab and nivolumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|AUC(0-T) of urelumab and nivolumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|AUC(TAU) of urelumab and nivolumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|AUC(INF) of urelumab and nivolumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|T-HALF of urelumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|CLT of urelumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|Vss of urelumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 3, 4, 5, 6, 9, up to 100 days of follow up|Anti-drug Antibody (ADA) status of the subject in response to Urelumab when administered alone, 21 days/cycle for Urelumab monotherapy, Cycle 1, 2, 4, 8, 12, 16, up to 60 days of follow up|ADA status of the subject in response to Urelumab and Nivolumab when co-administered, 28 days/cycle for combination therapy of Urelumab and Nivolumab, Cycle 1, 2, 4, 5, 9, up to 100 days of follow up|Best overall response (BOR) of urelumab monotherapy, Every 6-8 weeks during the treatment period|BOR of urelumab and nivolumab combination therapy, Every 6-8 weeks during the treatment period	\N	2534506	Malignant Tumors	Urelumab	DRUG
Gather key safety data on the use of CHEMOSAT Kit (Gen 2 filter)., Data to be collected at: Baseline, treatment and post treatment laboratory values and clinical measurements until time of discharge, Post-procedure (up to 30 days after CS-PHP)	Percentage of treatment with CHEMOSAT each patient receives, The percentage of treatments with CHEMOSAT each patient receives based on primary tumor, From the first CHEMOSAT treatment through the last, [timeframe an average of 12-months if 6 cycles completed]|Evaluation of Best Overall Response, Evaluation of patient best overall response (partial response or complete response, when applicable), from the date of first CHEMOSAT treatment through last CHEMOSAT treatment, or treatment discontinuation or death (whichever occurs first) [assessed up to 24 months]|Evaluation of resource utilization, Percentage of days spent in ICU, step-down area, From the first CHEMOSAT treatment through the last CHEMOSAT treatment [assessed up to 24 months]|Evaluate time to treatment failure, Time of first CHEMOSAT treatment to time of treatment failure, time from first CHEMOSAT treatment to the date of last CHEMOSAT treatment [assesed up to 24 months]	\N	3266042	Hepatic Malignant Neoplasm Primary Non-Resectable	Melphalan Percutaneous Hepatic Perfusion	MISC
Incidence of adverse events (AEs), Phase 1, 48 weeks|Incidence of dose-limitingtoxicity (DLT), Phase 1, 48 weeks|Incidence of serious adverse event (SAE), Phase 1, 48 weeks|Temperature in ‚ÑÉ, Phase 1, 48 weeks|Pulse in BPM(Beat per Minute), Phase 1, 48 weeks|Blood Pressure in mmHg, Phase 1, 48 weeks|Weight in Kg, Phase 1, 48 weeks|Height in centimeter, Phase 1, 48 weeks|Laboratory tests-Blood Routine examination, Phase 1, 48 weeks|Laboratory tests-Urine Routine test, Phase 1, 48 weeks|Laboratory tests-Blood biochemistry, Phase 1, 48 weeks|Laboratory tests- Coangulation function, Phase 1, 48 weeks|Echocardiography- LVEF(Left Ventricular Ejection Fraction) in percentage, Phase 1, 48 weeks|12-lead electrocardiogram (ECG) in RR, PR, QRS, QT, QTcF etc., Phase 1, 48 weeks|ECOG(Eastern Cooperative Oncology Group) score, Phase 1, 48 weeks|Overall Response Rate (ORR), Phase 2, 64 weeks	Pharmacokinetic (PK) Parameter: Maximum Observed Concentration (Cmax), Phase 1 and 2, 112 weeks|PK Parameter:Time of Maximum Observed Concentration (Tmax), Phase 1 and 2, 112 weeks|PK Parameter: Area Under the Concentration-time Curve(AUC), Phase 1 and 2, 112 weeks|PK Parameter: Steady State Maximum Concentration(Cmax,ss), Phase 1 and 2, 112 weeks|PK Parameter: Steady State Minimum Concentration(Cmin,ss), Phase 1 and 2, 112 weeks|PK Parameter: Systemic Clearance at Steady State (CLss), Phase 1 and 2, 112 weeks|PK Parameter: Accumulation Ratio (Rac), Phase 1 and 2, 48 weeks|PK Parameter: Elimination Half-life (t1/2), Phase 1, 112 weeks|PK Parameter: Volume of Distribution at Steady-State (Vss), Phase 1 and 2, 112 weeks|PK Parameter: Degree of Fluctuation (DF), Phase 1 and 2, 112 weeks|Immunogenicity of LM-101, Phase 1 and 2; Anti-Drug antibody and Nab (if neccessary) will be tested., 112 weeks|Receptor Occupancy of LM-101, Phase 1, 48 weeks|Biomarker correlation (CD8/CD47/CD68/CD163/PD-L1), Phase 1 and 2, 112 weeks|Duration of Response (DOR) in Month, Phase 2, 64 weeks|Disease control rate (DCR) in percentage, Phase 2, 64 weeks|progression-free survival (PFS) in Month, Phase 2, 64 weeks|Overall survival (OS) in Month, Phase 2, 64 weeks|Changes of target lesions from baseline in Millimeter., Phase 2, 64 weeks|Safety: AE/SAE (Number of participants with treatment-related adverse events as assessed by CTCAE v5.0), Phase 2, 64 weeks|Temperature in ‚ÑÉ, Phase 2, 64 weeks|Pulse in BPM(Beat per Minute), Phase 2, 64 weeks|Blood Pressure in mmHg, Phase 2, 64 weeks|Weight in Kg, Phase 2, 64 weeks|Height in centimeter, Phase 2, 64 weeks|Laboratory tests-Blood Routine examination, Phase 2, 64 weeks|Laboratory tests-Urine Routine test, Phase 2, 64 weeks|Laboratory tests-Blood biochemistry, Phase 2, 64 weeks|Laboratory tests- Coangulation function, Phase 2, 64 weeks|12-lead electrocardiogram (ECG) in RR, PR, QRS, QT, QTcF etc., Phase 2, 64 weeks|ECOG(Eastern Cooperative Oncology Group) score, Phase 2, 64 weeks	\N	5615974	Malignant Tumors	LM101	DRUG
Progression-free survival of patients., within 10 years after diagnosis|Overall survival of the patients, within 10 years after diagnosis	The pathological remission rate of patients after neoadjuvant chemotherapy., within 80 days after diagnosis (after 4 cycles of neoadjuvant chemotherapy)|The clinical remission rate of patients after neoadjuvant chemotherapy, within 80 days after diagnosis (after 4 cycles of neoadjuvant chemotherapy)	\N	1503905	Breast Cancer Nos Premenopausal	Docetaxel	DRUG
The differences of tongue images between patients with malignant tumors and healthy people., 1 year|Overall Survival (OS), 3 years	Disease free survivalÔºàDFSÔºâ, 1 year	\N	4793672	Malignant Tumor	Tongue images, coating on the tongue and clinical data of patients with malignant tumors and healthy people will be collected.	OTHER
Objective Response Rate (ORR), ORR (complete response (CR) + partial response (PR)), as assessed by Response Evaluation Criteria in Solid Tumors (RECIST), refers to the percentage of study subjects who achieve a complete response or partial response, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal (30+7 days after drug withdrawal or before the start of new anti-tumor therapy|Dose-limiting toxicitiesÔºàDLTÔºâ, DLT is defined as toxicity during the DLT observation period (3 weeks after the first dose)., DLT is defined as toxicity during the DLT observation period. The duration of DLT observation period is from the first dose to 3 weeks after the first dose|Maximum tolerated dose (MTD), MTD is defined as the hightest dose level at which no more than 1 out of 6 subjects experiences a DLT during the first cycles, At the end of Cycle 1 (each cycle is 21days)	Cmax, Maximum serum concentration, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal (30+7 days after drug withdrawal or before the start of new anti-tumor therapy)|immunogenicity, The immunogenicity is evaluated by the incidence of anti-drug antibodies (ADA) and neutralizing antibodies (if applicable) in subjects, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal (30+7 days after drug withdrawal or before the start of new anti-tumor therapy)|Disease Control Rate(DCR), DCR per RECIST 1.1 is defined as the percentage of participants with a best overall response of Complete Response (CR), Partial Response (PR) or Stable Disease (SD)., All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal (30+7 days after drug withdrawal or before the start of new anti-tumor therapy)|Duration of Response(DOR), To measure duration of response, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal (30+7 days after drug withdrawal or before the start of new anti-tumor therapy)|Tmax, After taking a single dose, Time to reach maximum plasma concentration, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal (30+7 days after drug withdrawal or before the start of new anti-tumor therapy)	\N	5516914	Malignant Tumors	LBL-007 Injection	DRUG
gemcitabine (dFdC) and difluorodeoxyuridine (dFdU) plasma concentration and gemcitabine triphosphate (dFdCTP) concentration in PBMC, Day 1-5	the proportion of subjects experiencing adverse events all grades, change from baseline in clinical laboratory test results, vital sign measurements, and physical examination findings, Day 1-8 (+/- 1) days	\N	1678690	Malignant Tumors	Gemcitabine HCl Oral Formulation	DRUG
To study the effect of the ketogenic diet on tumor growth progression and longevity in patients with Malignant glioblastoma., This will be done by comparing tumor size by repeated MRI studies (every 2 months)	Quality of life, Performance scale and quality of life evaluation (Karnofsky and EQ5D scale)	\N	1092247	Malignant Tumors	Nutritional support with Standard diet	OTHER
Number of Participants With Dose Limiting Toxicities (DLTs), 3 weeks (cycle 1)	Number of Participants with Adverse Events, Up to disease progression or unacceptable toxicity or study discontinuation criteria (median treatment of 4 cycles)|Plasma concentration of AVE8062 and its metabolite, Before AVE8062 infusion, immediately prior to the end of AVE8062 infusion, 5, 10, 25, 45 and 60 minutes then 2, 4, 6, 8-10 and 24 hours post AVE8062 infusion (cycle 1)|Plasma concentration of docetaxel, Before docetaxel infusion (corresponding to 24 hours post AVE8062 infusion), 15 minutes before the end of docetaxel infusion, 15 and 45 minutes post docetaxel infusion (cycle 1)|Response evaluation criteria in solid tumors (RECIST) defined objective response, Up to disease progression or unacceptable toxicity or study discontinuation criteria (median treatment of 4 cycles)|Biomarkers expression profile of each patient in order to identify preliminary correlation with antitumor activity of the combination treatment in patients with available pre-treatment biopsy, End of treatment or until disease progression or unacceptable toxicity or study discontinuation criteria	\N	1907685	Advanced Neoplastic Disease	AVE8062	DRUG
MTD at which fewer than one third of patients experience dose limiting toxicity as assessed by CTCAE v4.0, To determine a recommended phase 2 dose (RP2D) for EEDVsMit administered intravenously in children with recurrent / refractory solid or CNS tumours expressing EGFR, Day 28 (cycle 1)|Incidence of treatment-related adverse events as assessed by CTCAE v4.0, To define and describe the toxicities of EEDVSMit administered on these schedules in children with recurrent/refractory solid or CNS tumours, Up to 35 days after the completion of study treatment|Incidence of all adverse events as assessed by CTCAE v4.0, clinically significant changes in vital signs, ECGs and clinical laboratory tests, Assess the safety and tolerability of EEDVSMit in children with recurrent/refractory solid or CNS tumours., Up to 35 days after the completion of study treatment	Assess disease response according to RECIST version 1.1 for children with recurrent/refractory solid or CNS tumours, To preliminarily define the anti-tumour activity of EEDVSMit and assess response rates using RECIST version 1.1 criteria in children with recurrent/refractory solid or CNS tumours within the confines of a phase 1 study., Up to 35 days after the completion of study treatment|Assess overall survival, Assess overall survival (OS) in children with recurrent/refractory solid or CNS tumours treated with EEDVSMit on this schedule, 12 months from the date the last subject was enrolled in the study.|Time to response assessed by radiological imaging and RECIST v1.1, Estimate the time to response., Evaluated at Day 56 (after cycle 2), then every second cycle to the end of study treatment (up to 12 months)	\N	2687386	Solid Tumours|CNS Tumours	Mitoxantrone packaged EDV (EnGeneIC Delivery Vehicle)	DRUG
Adverse events of patients on high-fat diet, The main focus of this period is to recruit patients and collect clinical data for patients with glioblastoma multiforme on restricted calorie ketogenic diet. The safety and tolerability of the treatment will be evaluated.This can be measured by reports of adverse incidences., 2 year	\N	\N	3160599	Malignant Tumors	ketogenic diet	OTHER
Expression of TŒ≤RIII in the neuroblastic tumor and stroma of patients with advanced-stage NBL|Correlation between TŒ≤RIII levels and TGF-Œ≤ signaling correlate with NBL stage, tumor stroma content, surface TŒ≤RIII expression, and TGF-Œ≤ signaling	\N	\N	1553448	Neoplastic Syndrome|Neuroblastoma	gene expression analysis	GENETIC
Incidence of medical viscose-related skin injury, Including mechanical injury (exfoliation, skin tear, tension injury), dermatitis (contact dermatitis and allergic dermatitis), others (immersion and folliculitis), 1year	\N	\N	5776732	Tumour	3M CaviionTM	OTHER
Sensitivity and specificity rates of the ICG guided neoplastic disease identification, The 312 patients (39 patients in each of the 8 categories) will be evaluated for this objective., up to 24 hours post-surgery	\N	\N	4084067	Neoplastic Disease|Solid Tumor	Indocyanine Green	DRUG
Recurrence-free survival, Suspected recurrences will be confirmed by CT or MRI., within two years after surgery|Liver-related mortality, five years	\N	\N	2786199	Neoplastic Disease|Pathology	Ultrasound Backscatterer Imaging	MISC
EORTC-QLQ-C30 Score, Quality of life was evaluated by using the Global Health Status assessed by the European Organisation for Research and Treatment of Cancer Quality of Life Questionnaire-Core 30 (EORTC-QLQ-C30), which was completed by participants throughout the study.\n\nThe score of the scale ranges from 0-100, where high values mean good health status, while lower values indicate poor health status., baseline and at 18 weeks	Survival, Survival was assessed by chart review, at every study visit (every 9 weeks throughout the trial), and by information of the central mortality registry of Austria, 2 years for the individual patient (=whole study duration)	\N	1509612	Malignant Tumors	Additive classical homeopathy	DRUG
Technical success of the MR-guided cryoablation, Determine the technical success of the MR-guided cryoablation as measured by complete target lesion ablation., Will assess for 5 years with interval assessment each year|Safety of the MR-guided cryoablation, Determine safety of the MR-guided cryoablation using continuous MR imaging during the procedure., Will assess for 5 years with interval assessment each year|Examine short term tumor recurrence, Examine short term tumor recurrence over 6 months with contrast enhanced MRI and as required MR or U/S guided biopsy of prostate bed if PSA biochemical recurrence., Will assess for 5 years with interval assessment each year	MR procedure time., We will examine the time for each step in the process to create a stream-lined process and minimize MR procedure time., Will assess for 5 years with interval assessment each year	\N	4797039	Primary Malignant Neoplasm of Prostate (Diagnosis)	MR guided cryoablation	PROCEDURE
To evaluate the safety of IAP0971 (Phase I), MTD/RP2D; Incidence and frequency of DLT; AE, SAE occurrence and frequency (according to NCI CTCAE 5.0)., Through finishing Phase I, an average of 1 year|To evaluate the effectiveness of IAP0971 (Phase IIa), Objective response rate(ORR), Until disease progression, assessed up to 3 years	Pharmacokinetics (PK) CmaxÔºàPhase I), PK parameters Cmax following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) Css,maxÔºàPhase I), PK parameters Css,max following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) Css,minÔºàPhase I), PK parameters Css,min following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) Css,avÔºàPhase I), PK parameters Css,av following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) AUCssÔºàPhase I), PK parameters AUCss following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) CLssÔºàPhase I), PK parameters CLss following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) VssÔºàPhase I), PK parameters Vss following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) RÔºàPhase I), PK parameters R following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) DFÔºàPhase I), PK parameters DF following multiple doses, After multiple doses ,assessed up to 1 year|Pharmacokinetics (PK) TmaxÔºàPhase I), PK parameters Tmax following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) AUC0-tÔºàPhase I), PK parameters AUC0-t following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) AUC0-‚àûÔºàPhase I), PK parameters AUC0-‚àû following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) CLÔºàPhase I), PK parameters CL following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) VdÔºàPhase I), PK parameters Vd following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) t1/2ÔºàPhase I), PK parameters t1/2 following single dose, After single dose ,assessed up to 1 year|Pharmacokinetics (PK) ŒªzÔºàPhase I), PK parameters Œªz following single dose, After single dose ,assessed up to 1 year|To evaluate the immunogenicity of IAP0971 in patients with advanced malignant tumors (Phase I), Incidence of anti-drug antibody (ADA) and neutralizing antibodies (NAb) against IAP0971, After finishing Phase I, an average of 1 year|To evaluate the effectiveness of IAP0971 in patients with advanced malignant tumors (Phase I), Overall survival (OS) according to RECIST 1.1 or Lugano 2014, After finishing Phase I, an average of 1 year|To evaluate the effectiveness of IAP0971 in patients with advanced malignant tumors (Phase I), Objective response rate (ORR) according to RECIST 1.1 or Lugano 2014, After finishing Phase I, an average of 1 year|To evaluate the immunogenicity of IAP0971 in patients with advanced malignant tumors (Phase IIa), Incidence of anti-drug antibody (ADA) and neutralizing antibodies (NAb) against IAP0971, After finishing Phase IIa, assessed up to 3 years|o evaluate the effectiveness of IAP0971 in patients with advanced malignant tumors (Phase IIa), PFS according to RECIST 1.1 or Lugano 2014, After finishing Phase IIa, assessed up to 3 years|o evaluate the effectiveness of IAP0971 in patients with advanced malignant tumors (Phase IIa), DCR according to RECIST 1.1 or Lugano 2014, After finishing Phase IIa, assessed up to 3 years|o evaluate the effectiveness of IAP0971 in patients with advanced malignant tumors (Phase IIa), OS according to RECIST 1.1 or Lugano 2014, After finishing Phase IIa, assessed up to 3 years	\N	5396391	Advanced Malignant Tumors	IAP0971	DRUG
Frequency of adverse events (AEs) and SAEs (Phase ‚Ö†), To investigate the safety characteristics., 3 months after end event visit|Dose limiting toxicities (DLTs) (Phase ‚Ö†), To determine the maximum tolerated dose (MTD) and the recommended Phase 2 dose (RP2D)., 28 days after first dose|Objective response rate (ORR) in dose expansion (Phase ‚Ö°a), To explore the clinical effectiveness. Tumor response based on RECIST 1.1 or Lugano 2014., Baseline through up to 2 years or until disease progression	Pharmacokinetic (PK) Cmax (Phase ‚Ö†), PK parameters (Cmax) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) Tmax (Phase ‚Ö†), PK parameters (Tmax) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) AUC 0-t (Phase ‚Ö†), PK parameters (AUC 0-t ) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) AUC 0-‚àû (Phase ‚Ö†), PK parameters (AUC 0-‚àû) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) t1/2 (Phase ‚Ö†), PK parameters (t1/2) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) Œªz (Phase ‚Ö†), PK parameters (Œªz) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) Css,max (Phase ‚Ö†), PK parameters (Css,max) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) Css,min (Phase ‚Ö†), PK parameters (Css,min) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Pharmacokinetic (PK) AUCss (Phase ‚Ö†), PK parameters (AUCss) following single dose., Day1Ôºå2Ôºå3Ôºå7Ôºå14Ôºå21, 28 of DLT observation period , Day1of each subsequent cycle (each cycle is 7 days), and at the End of Treatment visit, up to about 2 years|Objective response rate (ORR) in dose escalation (Phase ‚Ö†), Tumor response based on RECIST 1.1 or Lugano 2014., Baseline through up to 2 years or until disease progression|Incidence of adverse events (AEs) and SAEs (Phase ‚Ö†), To investigate the safety characteristics., 3 months after end event visit|Immunogenicity of IBC0966 (Phase ‚Ö†), The frequency of anti-drug antibodies (ADA) against IBC0966.(Phase ‚Ö†), 3 months after end event visit|Progression free survival (PFS) (Phase ‚Ö°a), PFS as assessed using RECIST 1.1 or Lugano 2014., Baseline through up to 2 years or until disease progression|Overall survival (OS) (Phase ‚Ö°a), OS as assessed using RECIST 1.1 or Lugano 2014., Baseline through up to 2 years or until disease progression|Disease control rate (DCR) (Phase ‚Ö°a), DCR as assessed using RECIST 1.1 or Lugano 2014., Baseline through up to 2 years or until disease progression|Incidence of adverse events (AEs) and SAEs (Phase ‚Ö°a), To investigate the safety characteristics., 3 months after end event visit|Immunogenicity of IBC0966 (Phase ‚Ö°a), The frequency of anti-drug antibodies (ADA) against IBC0966.(Phase ‚Ö°a), 3 months after end event visit	\N	4980690	Advanced Malignant Tumors	IBC0966	BIOLOGICAL
Dose-limiting toxicity (DLT), To identify the dose-limiting toxicity (DLT) in dose escalation study., Part A Dose escalation study at the end of Cycle 1 (Cycle1 is 21 days)|Adverse reaction rate, Observe all the participants in any adverse events occurred during the period of clinical research, including clinical symptoms and signs of life, an abnormal in laboratory tests, record its clinical characteristics, severity, occurrence time, duration, treatment and prognosis, and determine its and the correlation between test drugs. NCI-CTCAE 5.0 standard was used to evaluate drug safety., From date of singing informed consent until the 30 days after the last study dose or the start date of a new anti-cancer therapy, whichever came first.	Cmax, Peak plasma concentration., Part A Dose escalation study: At the end of Cycle1(Cycle1 is 21 days), Part B Food effect study: At the end of Cycle0(Cycle0 is 4 days).|Tmax, Time to peak plasma concentration., Part A Dose escalation study: At the end of Cycle1(Cycle1 is 21 days), Part B Food effect study: At the end of Cycle0(Cycle0 is 4 days).|AUC, Area under the plasma concentration versus time curve., Part A Dose escalation study: At the end of Cycle1(Cycle1 is 21 days), Part B Food effect study: At the end of Cycle0(Cycle0 is 4 days).|Objective response rate (ORR), ORR is defined as the percentage of participants who have best overall response (BOR) of complete response (CR) or partial response (PR) at the time of data cutoff as assessed by RECIST 1.1., From date of first dose until the date of first documented progression or date of death from any cause, whichever came first (up to approximately 2 years).|Duration of response (DOR), DOR is defined as the time from the first documentation of CR or PR to the date of first documentation of disease progression or death (whichever occurs first) as assessed by RECIST 1.1., From date of first dose until the date of first documented progression or date of death from any cause, whichever came first (up to approximately 2 years).|Disease control rate (DCR), DCR is defined as the percentage of participants who have BOR of CR or PR or stable disease (SD) at the time of data cutoff as assessed by RECIST 1.1., From date of first dose until the date of first documented progression or date of death from any cause, whichever came first (up to approximately 2 years).|Progression-free survival (PFS), PFS is defined as the time from the first study dose date to the date of first documentation of disease progression as assessed by RECIST 1.1., From date of first dose until the date of first documented progression or date of death from any cause, whichever came first (up to approximately 2 years).	\N	4343859	Malignant Neoplasms	IMMH-010	DRUG
Evaluate completion of PROs among AYAs randomized to Choice PRO vs Fixed PRO., Evaluate feasibility and acceptability of completing PROs among AYAs randomized to Choice PRO vs Fixed PRO., Feasibility at 1 month and acceptability at baseline	\N	Evaluate AYAs' HRQOL priorities and HRQOL PRO trajectories, The goal of the ranking exercise is to evaluate the importance of HRQOL domain rank choice PROs and examine their changes over time., Through study completion, an average of 1 year|Access and Utilization, To evaluate access to and utilization of psychosocial and financial resources using items from the Consumer-Based Cancer Care Value Index (CCVI)., Assessed up to 52 months|To summarize AYAs' preferences for how their PRO data should be shared with them, their families, and/or their providers., Solicit AYAs preferences with regard to possible applications for their PRO data, including sharing PRO data with their medical teams and/or their families, and providing participants with summary feedback., Assessed up to 52 months	5108298	Breast Cancer, NOS|CNS Primary Tumor, NOS|Cervical Cancer, NOS|Colorectal Cancer, NOS|Leukemia, NOS|Lymphoma, NOS|Miscellaneous Neoplasm, NOS	Questionnaires	OTHER
Adverse events, Adverse events defined as the number of participants with adverse events according, up to 12 months|Objective response rate, ORR is defined as the percentage of patients who achieve a response, which can either be complete response (complete disappearance of lesions) or partial response (reduction in the sum of maximal tumor diameters by at least 30% or more), up to 12 months|Progress-Free Survival, PFS is defined as the time from the administration of the first dose to first disease, up to 12 months|Overall Survival, OS is defined as the time from the administration of the first dose to death., up to 12 months	\N	\N	5707910	Malignant Tumor	EBV immunological agent	BIOLOGICAL
Adverse events, Number of subjects with adverse events (AEs), Screening up to study completion, an average of 2 years|Number of participants experiencing Dose-Limiting Toxicities (DLTs), According to National Cancer Institute Common Terminology Criteria for Adverse Events Version 5.0 (NCI-CTCAE v.5.0), Up to 42 days	PK of SHR-2002 + SHR-1316, To check Maximum concentration (Cmax), Before and after SHR-2002 and SHR-1316 infusion throughout the study, an average of 2 years|PK of SHR-2002 + SHR-1316, To check AUC last, Before and after SHR-2002 and SHR-1316 infusion throughout the study, an average of 2 years|Immunogenicity of SHR-2002 + SHR-1316, ADA of SHR-2002 + SHR-1316, Before and after SHR-2002 and SHR-1316 infusion throughout the study, an average of 2 years	\N	5082545	Advanced Malignant Tumors	 SHR-2002 and SHR-1316	DRUG
The occurrence of all adverse events (AEs) and severe adverse events (SAEs)., adverse events (AEs) and severe adverse events (SAEs), From the first administration to 30 days after the end of the last administration, up to approximately 2 years	Cmax, Observed maximum concentration, 14 days|AUC0-t, AUC0-t, 14 days|AUC0-inf, AUC0-inf, 14 days|Tmax, Time to maximum concentration, 14 days|t1/2, Apparent terminal Half-Life, 14 days|Vz, Vz, 14 days|ORR, Objective response rate, Up to approximately 2 years.|DCR, Disease control rate, Up to approximately 2 years.|PFS, Progression free survival, Up to approximately 2 years.|DOR, Duration of response, Up to approximately 2 years.|OS, Overall survival, Up to approximately 2 years.|Anti NBL-020 antibody (ADA) and neutralizing antibody (Nab)., Anti NBL-020 antibody and neutralizing antibody., 14 days|NBL-020 receptor occupancy rate for tumor necrosis factor type ‚Ö° receptor (TNFR2)., NBL-020 receptor occupancy rate for tumor necrosis factor type ‚Ö° receptor., 14 days|Concentration of free tumor necrosis factor type ‚Ö° receptor (TNFR2)., Concentration of free tumor necrosis factor type ‚Ö° receptor., 14 days	\N	5877924	Advanced Malignant Tumors	NBL-020 for Injection	DRUG
Occurrence of treatment related adverse events as assessed by CTCAE v4.03, Defined as \\>= Grade 3 signs/symptoms, laboratory toxicities, and clinical events) that are possibly, likely, or definitely related to study treatment., 1 year	\N	\N	3931720	Malignant Tumor	BiCAR-NK/T cells (ROBO1 CAR-NK/T cells)	BIOLOGICAL
Toxicity, radiation treatment-related grade 3+ non-hematologic adverse events, 12 months	Assessment of the antitumor effect, PR or CR defined by radiology., 12 months|Evaluation of quality of life (QoL)., Evaluation of quality of life (QoL)., 12 months|Biomarkers, T cell activities and/or NGS sequencing, 3-6 months	\N	4881981	Malignant Neoplasms	SCART radiation therapy	RADIATION
The growth of brown adipose tissue by PET-CT, Growth of brown adipose tissue after 28 days of oral administration of Mirabegron was measured by standard uptake value (SUV) values measured by PET-CT ., Day 0 and Day 28	blood glucose and glucose tolerance test ( GTT ) by Hematological tests, The change of glucose( mmol/L ) and glucose tolerance test( mmol/L ) after 28 days of oral administration of Mirabegron by Hematological tests ., Day 0 and Day 28	\N	5779514	Tumour	Mirabegron	DRUG
Incidence and severity of participants with adverse events (AEs), From time ICF is signed until 90 days after last dose of AK130|Number of participants with DLTs, During the first four weeks of treatment with AK130	Objective response rate (ORR), Up to approximately 2 years|Disease control rate (DCR), Up to approximately 2 years|Progression-free survival (PFS), Up to approximately 2 years|Overall survival (OS), Up to approximately 2 years|Duration of Response (DOR), Up to approximately 2 years|Time to response (TTR), Up to approximately 2 years|Maximum observed concentration (Cmax) of AK130, The endpoints for assessment of PK include serum concentrations of AK130 at different timepoints after AK130 administration., From first dose of study drug through end of treatment (up to approximately 2 years)|Minimum observed concentration(Cmin) of AK130, The endpoints for assessment of PK include serum concentrations of AK130 at different timepoints after AK130 administration., From first dose of study drug through end of treatment (up to approximately 2 years)|Area under the curve (AUC) of AK130 for assessment of pharmacokinetics, The endpoints for assessment of PK include serum concentrations of AK130 at different timepoints after AK130 administration., From first dose of study drug through end of treatment (up to approximately 2 years)|Number of subjects who develop detectable anti-drug antibodies (ADAs), From first dose of study drug through 30 days after last dose of study drug	\N	5653284	Advanced Malignant Tumors	AK130	DRUG
Overall survival, At approximately end of year 4 (study completion)|Local disease control rate at 6 months, At approximately 2.5 years|CNS disease control rate at 6 months, At approximately 2.5 years	Assessment of RTOG versus RECIST versus Volumetric MRI criteria, At approximately end of year 4 (study completion)|Health related quality of life, At approximately end of year 4 (study completion)|Karnofsky performance status, AT approximately end of year 4 (study completion)|Mini mental status exam cognition, At approximately end of year 4 (study completion)|Acute toxicity, At approximately end of year 4 (study completion)|Late toxicity, At approximately end of year 4 (study completion)|Changes in MRI endpoints, Assessment in changes of diffusional weighted imaging and magnetic resonance spectroscopy. Changes at 3 months post-treatment and 6 months post-treatment will be compared to baseline (pre-treatment)., Measured at baseline, and 3 months and 6 months post-treatment	\N	1543542	Metastasis to Brain of Primary Cancer	Whole Brain XRT 30Gy/10 fractions with	RADIATION
PFS, progression free survival time, From date of initial treatment until the date of first documented progression, assessed up to 36 months.	OS, over all survival time, From date of diagnosis until the end of the follow-up, assessed up to 36 months.	\N	4672473	Malignant Tumor	DC-CTL	BIOLOGICAL
Establish Sexual Quality of Life Cohort, Establish a cohort of patients with female sexual organs receiving radiotherapy, 2 years	Describe sexual quality of life, Describe sexual quality of life for patients with female sexual organs receiving radiotherapy, 2 years|Describe dosimetric predictors of sexual outcomes, Describe the dosimetric predictors of sexual outcomes for patients with female sexual organs receiving radiotherapy, 2 years|Describe imaging predictors of sexual outcomes, Describe the imaging predictors of sexual outcomes for patients with female sexual organs receiving radiotherapy, 2 years|Describe microbiome predictors of sexual outcomes, Describe the microbiome predictors of sexual outcomes for patients with female sexual organs receiving radiotherapy, 2 years	\N	5394428	Malignant Neoplasms	No intervention	OTHER
To assess the frequency, severity and causality of acute adverse events., The primary endpoint of the study is to assess the frequency, severity and causality of acute adverse events related to the DaRT treatment. Adverse events will be assessed and graded according to Common Terminology and Criteria for Adverse Events (CTCAE) version 5.0., From Day 0 (DaRT insertion )	To assess the tumor response to DaRT treatment, The secondary endpoint is to assess the tumor response to DaRT treatment assessed using the Response Evaluation Criteria in Solid Tumors (RECIST) (Version 1.1), 3 months after DaRT seed insertion	\N	5781555	Malignant Tumor	 Experimental	DEVICE
Determine the maximum tolerated dose of E7974 in patients with solid malignancies., Duration of each cycle will be 28 days; patients will attend a follow-up visit 30 days after last study treatment. Follow-up for safety and efficacy will occur 6 months after the last patient is accrued to the study.	Assess E7974 for safety, efficacy, pharmacokinetics and pharmacodynamics; evaluate the efficacy of E7974 in patients with metastatic, refractory prostate cancer., Duration of each cycle will be 28 days; patients will attend a follow-up visit 30 days after last study treatment. Follow-up for safety and efficacy will occur 6 months after the last patient is accrued to the study.	\N	130169	Cancer, Malignant Tumors	 E7974	DRUG
Validity of the italian version of the PRO-CTCAE, Evaluation of the validity (degree to which an instrument accurately measures the underlying phenomenon) of single items of the PRO-CTCAE, Italian version, for each of the type of cancer considered, at baseline (up to 3weeks)|Validity of the italian version of the PRO-CTCAE, Evaluation of the validity (degree to which an instrument accurately measures the underlying phenomenon) of single items of the PRO-CTCAE, Italian version, for each of the type of cancer considered, at 3 weeks (up to 6 weeks)|Responsiveness of the italian version of the PRO-CTCAE, Evaluation of responsiveness (ability of an instrument to show a change when there has been a change in the phenomenon) of single items of the PRO-CTCAE for each of the types of cancer considered., at baseline (up to 3 weeks)|Responsiveness of the italian version of the PRO-CTCAE, Evaluation of responsiveness (ability of an instrument to show a change when there has been a change in the phenomenon) of single items of the PRO-CTCAE for each of the types of cancer considered., at 3 weeks (up to 6 weeks)	Differences in psychometric measures according to tumor type and treatment, Evaluate any differences in psychometric measures according to:\n\n* type of cancer (breast, lung, liver ...)\n* type of treatment (chemotherapy, hormone therapy, immunotherapy, ...), at 3 weeks (up to 6 weeks)	\N	4416672	Malignant Neoplasms	 PRO-CTCAE items	OTHER
Maximum tolerated dose, The Maximum tolerated dose of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection, first dose of study medication up to 21 days|Recommended phase II dose, The Recommended phase II dose of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection, first dose of study medication up to 21 days|Incidence and severity of adverse events (AEs)/serious adverse events (SAEs), Incidence and severity of adverse events (AEs)/serious adverse events (SAEs) graded by Common Terminology Criteria for Adverse Events (CTCAE) v5.0, from signature completion of ICF to 90 days after the last dose or to the beginning of the new anti-cancer therapy, whichever came first, assessed up to 24 weeks	Tmax, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|Cmax, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|AUC0-t, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|AUC0-‚àû, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|t1/2, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|CL, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|Vss, PK parameters of single dose of SHR-2002 injection monotherapy, 0.5 hour before first dose to the 336 hours after first dose|Cmax, ss, PK parameters of multiple doses of SHR-2002 monotherapy, 0.5 hour before second dose to the 30 days after last dose|Ctrough, ss, PK parameters of multiple doses of SHR-2002 monotherapy, 0.5 hour before second dose to the 30 days after last dose|Rac, PK parameters of multiple doses of SHR-2002 monotherapy, 0.5 hour before second dose to the 30 days after last dose|RO, Receptor occupancy, PD indicators of SHR-2002 injection monotherapy, 0.5 hour before second dose to the 30 days after last dose|Cytokine concentration, PD indicators of SHR-2002 injection monotherapy, 0.5 hour before second dose to the 30 days after last dose|Ctrough, ss, PK parameters of SHR -2002, Camrelizumab for Injection, SHR-1316 injection and SHR-1701 injection during combination therapy period, 0.5 hour before second dose to the 90 days after last dose|Rac, PK parameters of SHR -2002, Camrelizumab for Injection, SHR-1316 injection and SHR-1701 injection during combination therapy period, 0.5 hour before second dose to the 90 days after last dose|ADA, Anti-drug antibody, Immunogenicity of SHR-2002 in monotherapy and combination therapy, Camrelizumab for Injection, SHR-1316 injection and SHR-1701 injection, 0.5 hour before second dose to the 90 days after last dose|NAb, Immunogenicity of Camrelizumab for Injection, SHR-1316 injection and SHR-1701 injection, 0.5 hour before second dose to the 90 days after last dose|ORR, Objective Response Rate, Efficacy endpoints of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection in treatment of patients with Advanced Malignant Tumors, from the date of the first dose to the date of disease progression evaluated based on RECIST v1.1 criteria, death, lost to follow-up, voluntary withdrawal, or initiation of other anti-tumor treatment, whichever occurs first, assessed up to 6 months]|DoR, Duration of response, Efficacy endpoints of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection in treatment of patients with Advanced Malignant Tumors, from the date of the firstly documented tumor response to the date of the firstly documented disease progression or the date of death for any reason, assessed up to 6 months|DCR, Disease control rate, Efficacy endpoints of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection in treatment of patients with Advanced Malignant Tumors, from the date of the first dose to the date of the firstly documented disease progression (evaluated based on RECIST v1.1 criteria) or the date of death for any reason, assessed up to 6 months|PFS, Progression-free survival, Efficacy endpoints of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection in treatment of patients with Advanced Malignant Tumors, from the date of the first dose to the date of the firstly documented disease progression (evaluated based on RECIST v1.1 criteria) or the date of death for any reason, assessed up to 6 months|OS, Overall survival, Efficacy endpoints of SHR-2002 injection monotherapy or in combination with Camrelizumab for Injection, or SHR-1316 injection, or SHR-1701 injection in treatment of patients with Advanced Malignant Tumors, from the date of the first dose to the date of death for any reasonÔºåassessed up to 100 months	\N	5198817	Advanced Malignant Tumors	 SHR-2002 injection„ÄÅCamrelizumab for Injection, SHR-1316 injection, SHR-1701 injection	DRUG
Dose-limiting toxicitiesÔºàDLTÔºâ, DLT describes side effects of a drug or other treatment that are serious enough to prevent an increase in dose or level of that treatment., At the end of Cycle 1Ôºà28 days after the first prespecified doseÔºâ|Maximum tolerated dose (MTD), MTD is defined as the hightest dose level at which no more than 1 out of 6 subjects experiences a DLT during the first cycles, At the end of Cycle 1Ôºà28 days after the first prespecified doseÔºâ	Cmax, Maximum serum concentration, From all subjects signed the informed consent form up to the completion of the follow-up period of drug withdrawal (30 days after drug withdrawal or before the start of new anti-tumor therapy|Tmax, After taking a single dose, Time to reach maximum plasma concentration, From all subjects signed the informed consent form up to the completion of the follow-up period of drug withdrawal (30 days after drug withdrawal or before the start of new anti-tumor therapy|immunogenicity, The immunogenicity is evaluated by the incidence of anti-drug antibodies (ADA) and neutralizing antibodies (if applicable) in subjects, From all subjects signed the informed consent form up to the completion of the follow-up period of drug withdrawal (30 days after drug withdrawal or before the start of new anti-tumor therapy|Disease Control Rate(DCRÔºâ, Percentage of participants achieving CR and PR and stable disease (SD)., From all subjects signed the informed consent form up to the completion of the follow-up period of drug withdrawal (30 days after drug withdrawal or before the start of new anti-tumor therapy|Duration of Response(DORÔºâ, The period from the participants first achieving CR or PR to disease progression., From all subjects signed the informed consent form up to the completion of the follow-up period of drug withdrawal (30 days after drug withdrawal or before the start of new anti-tumor therapy|Objective Response Rate (ORR), Objective Response Rate (complete response (CR) + partial response (PR)), as assessed by Response Evaluation Criteria in Solid Tumors (RECIST 1.1), refers to the percentage of study subjects who achieve a complete response or partial response. This Secondary Outcome Measure was used for efficacy observations in Phase I study, From all subjects signed the informed consent form up to the completion of the follow-up period of drug withdrawal (30 days after drug withdrawal or before the start of new anti-tumor therapy.	\N	5779163	Advanced Malignant Tumors	 LBL-033 for Injection	DRUG
Number of patients with Adverse Events (AEs), Characterization of incidence, severity and abnormal clinically significant laboratory findings of AEs, Up to approximately 2 years|Objective Response Rate (ORR), Up to approximately 2 years	Disease control rate (DCR), Up to approximately 2 years|Duration of Response (DOR), Up to approximately 2 years|Time to response (TTR), Up to approximately 2 years|Progression free survival (PFS), Up to approximately 2 years|Overall survival (OS), Up to approximately 2 years	\N	5214482	Advanced Malignant Tumors	 AK112	DRUG
Phenotypic and genotypic lines connected to the epithelial odontogenic tumours, In particular, to define the link between the genotype PTCH1, the size of the tumor, its osteolytic character and the predictive factors of recurrence.\n\nData collection at M6, M12, M18, M24 from the surgery date, Month 24 from the surgery date	\N	\N	2167581	Epithelial Odontogenic Tumours	 Confrontation Phenotypes and Genotypes	MISC
Safety endpoints: Number of subjects with adverse events and the severity of adverse events, every 4 weeks after treatment initiationÔºàthrough study completionÔºåaverage 5 months)|DLT, during the first 28-day cycle of SHR-1901 treatment|MTD, 4 weeks after treatment initiation|RP2D, 4 weeks after treatment initiation	\N	\N	5193721	Advanced Malignant Tumors	 SHR-1901	DRUG
AE, Occurrence and frequency of Adverse Event, Up to approximately 3 years|SAE, Serious Adverse Event, Up to approximately 3 years|DLT, Dose-limiting Toxicity (DLT), At the end of Cycle 1 (each cycle is 28 days)|MTD, The maximum tolerated dose (MTD) (if available), At the end of Cycle 1 (each cycle is 28 days)|RP2D, Recommended phase 2 dose (RP2D) in stage A, At the end of Stage A (approximately 1 year)	AUC, Area under the plasma concentration versus time curve (AUC), Up to approximately 3 years|Cmax, Peak Plasma Concentration (Cmax), Up to approximately 3 years|t1/2, Half-life (t1/2), Up to approximately 3 years|Tmax, Time to peak drug concentration (Tmax), Up to approximately 3 years|Vz/F, Apparent volume of distribution, Up to approximately 3 years|CL/F, Apparent clearance, Up to approximately 3 years|pRb, Explore the relationship between phosphor-retinoblastoma protein (pRb) and efficacy, Up to approximately 3 years|ORR, Objective Response Rate, Up to approximately 3 years|PFS, Progression-free Survival, Up to approximately 3 years|OS, Overall Survival, Up to approximately 3 years|DoR, Duration of Response (DoR), Up to approximately 3 years|DCR, Disease Control Rate (DCR), Up to approximately 3 years	\N	5728541	Advanced Malignant Tumors	 SYH2043	DRUG
Incidence and severity of adverse events(AE);, Incidence and severity of AEs is aim to evaluate the safety of AK127 and AK104, Up to approximately 2 years|Incidence of serious adverse events(SAE);, Incidence of SAE is aim to evaluate the safety of AK127 and AK104., Up to approximately 2 years|Incidence of immune-related adverse events(irAE);, Incidence of irAE is aim to evaluate the safety of AK127 and AK104., Up to approximately 2 years|The incidence of suspected unexpected serious adverse reactions(SUSAR);, The incidence of SUSAR is aim to evaluate the safety of AK127 and AK104., Up to approximately 2 years|Incidence of dose-limiting toxicity(DLT);, The purpose of DLT is to find the Phase II recommended dose(RP2D) or MTD., Up to approximately 2 years|Number of participants with clinically significant changes in laboratory assessment data as assessed by CTCAE v5.0., Monitor and summerize all data derive from clinically significant changes in laboratory assessment data per Common Terminology Criteria for Adverse Events(CTCAE)5.0., Up to approximately 2 years|AE that leads to the termination or suspension of treatment., AE that leads to the termination or suspension of treatment is aim to evaluate the safety of AK127 and AK104., Up to approximately 2 years	Objective response rate(ORR), ORR is proportion of subjects with complete response(CR) or partial response(PR), based on Response Evaluation Criteria in Solid Tumors(RECIST) v1.1(Solid Tumor)or Lugano 2014 Evaluation Criteria(lymphoma)., Up to approximately 2 years|Disease control rate(DCR), Disease control rate(DCR) is defined as the proportion of subjects achieving a best of response(BOR) of confirmed CR and PR and stable disease(SD) per RECIST v1.1(Solid Tumor)or Lugano 2014 Evaluation Criteria(lymphoma)., Up to approximately 2 years|duration of response(DoR), Duration of response(DoR) is defined as the period from the first documentation of confirmed response(CR or PR) to the first documentation of progressive disease(PD) (as per RECIST v1.1(Solid Tumor)or Lugano 2014 Evaluation Criteria(lymphoma)) or death due to any cause, whichever occurs first., Up to approximately 2 years|time to response(TTR), Time to response(TTR) is defined as the time from the first dose of investigational products until the first confirmation of CR or PR., Up to approximately 2 years|progression-free survival(PFS), Progression-free survival(PFS) is defined as the time from the first dose of investigational products until documentation of progressive disease(PD)(as per RECIST v1.1) or death due to any cause, whichever occurs first., Up to approximately 2 years|overall survival(OS), Overall survival(OS) is defined as the time from the first dose of investigational products until death due to any cause., Up to approximately 2 years|The drug concentration of AK127 and AK104 in serum, The drug concentration of AK127 and AK104 in serum was used to assess the blood concentration of AK127 and AK104 at different dosing time points., Up to approximately 2 years|maximum concentration(Cmax)of AK127 and AK104 in serum, Maximum concentration(Cmax) is to evaluate the Pharmacokinetics(PK) of AK127 and AK104., Up to approximately 2 years|peak time(Tmax) of AK127 and AK104 in serum, Peak time(Tmax)is to evaluate the Pharmacokinetics(PK) of AK127 and AK104., Up to approximately 2 years|half time(t1/2) of AK127 and AK104 in serum, Half time(t1/2) is to evaluate the Pharmacokinetics(PK) of AK127 and AK104., Up to approximately 2 years|area under curve(AUC)of AK127 and AK104 in serum, Area under curve(AUC) is to evaluate the Pharmacokinetics(PK) of AK127 and AK104., Up to approximately 2 years|clearance rate(CL) of AK127 and AK104 in serum, Clearance rate(CL) is to evaluate the Pharmacokinetics(PK) of AK127 and AK104., Up to approximately 2 years|apparent volume of distribution(Vd) of AK127 and AK104 in serum, Apparent volume of distribution(Vd) is to evaluate the Pharmacokinetics(PK) of AK127 and AK104., Up to approximately 2 years|Number and percentage of subjects with anti-drug antibody(ADA) to AK127 and AK104, The immunogenicity of AK127 and AK104 will be assessed by summarizing the number of subjects who develop detectable anti-drug antibodies (ADAs)., Up to approximately 2 years	\N	5868876	Advanced Malignant Tumors	 AK127 Q3W IV infusion ,AK104 10mg/kg Q3W IV infusion	DRUG
Progression-free survival in DTC treated advanced ovary cancer, The primary endpoint of this trial was progression-free survival (PFS), defined as the time from the date of randomisation to the date of the first occurrence of any of the following events: appearance of any new lesions that could be measured or assessed clinically; or CA125 criteria of disease progression. For patients with measurable disease, clinical or radiographical tumour measurements had priority over CA125 levels, and progression during treatment could not be declared on the basis of CA125 alone., up to 20 months|Overall survival rate in DTC treated advanced ovary cancer, Overall survival (OS), defined as the time from random assignment to death as a result of any cause, response rate, and adverse events.response to treatment, toxicity, and quality of life. Toxicities were evaluated per course and per patient (worst score over all courses)., 30 months|Overall response rate in DTC treated advanced ovary cancer, Tumor measurements were made before each cycle by physical examination, before every third cycle by imaging methods in patients with measurable or evaluable disease, and after the last cycle. The same tumor assessment methods that were employed for baseline measurement were used for each repeat evaluation. Tumor response was graded according to Response Evaluation Criteria in Solid Tumors (RECIST)., 1 year|Toxicity in DTC treated advanced ovary cancer, Adverse events and toxicities were graded according to the National Cancer Institute Common Toxicity Criteria (NIC-CTC). Toxicities were recorded continuously; blood chemistry parameters were measured before each treatment cycle and weekly thereafter.Quality of life was assessed with the use of the European Organization for Research and Treatment of Cancer (EORTC) QLQ-C30 and QLQ-OV28 questionnaires., 8 months	Pharmacokinetics of lower-dose decitabine, Blood samples were obtained prior to treatment and at 0.25, 0.5, 1, 2, 4, 6, 8, and 24 hours after the first and fifth dose of decitabine. Plasma samples were stored and processed and further analyzed utilizing liquid chromatography/tandem mass spectrometry.\n\nPeak plasma concentration (Cmax) or area under the plasma concentration versus time curve (AUC) will be obtained from more than 10 patients treated at a decitabine dose level of 7mg/m2/d., up to 8 weeks	Pharmacodynamics of lower-dose decitabine, To assess the pharmacodynamics of decitabine and to establish its relationship to clinical PFS, before and after decitabine treatment, peripheral blood mononuclear cells and/or tumor samples will be harvested for measurement of the expression and methylation profile including genes such as MLH1, RASSF1A, HOXA10, and HOXA11 by quantitative polymerase chain reaction (qPCR) and methylation-sensitive PCR analyses., up to 8 weeks	2159820	Primary Malignant Neoplasm of Ovary|FIGO Stages II to IV	 Decitabine (DTC Arm)	DRUG
Number of patients with Adverse Events (AEs), Characterization of incidence, severity and abnormal clinically significant laboratory findings of AEs, Up to approximately 2 years|Number of patients experiencing dose-limiting toxicities (DLTs), During the first 3 weeks|Objective Response Rate (ORR), Up to approximately 2 years	Disease control rate (DCR), Up to approximately 2 years|Duration of Response (DOR), Up to approximately 2 years|Time to response (TTR), Up to approximately 2 years|Progression free survival (PFS), Up to approximately 2 years|Overall survival (OS), Up to approximately 2 years	\N	5229497	Advanced Malignant Tumors	 AK112	DRUG
Agreement of the visualisation of radiopharmaceutical uptake between the hybrid gamma camera and the standard clinical gamma camera for the sites investigated., The subjective assessment of scintigraphic images obtained using the hybrid camera under test and the standard clinical gamma camera.\n\nThe image data will be didvdiid into the different exam types and scored using a 3 point scale., 1 year	The clinical optimisation of the hybrid gamma camera image display, Following subjective assessment of the recorded images the data set will be reviewed by experienced observers and the display fusion will be modified to obtain the clearest visualisation of radiopharmaceutical uptake., 1 year	\N	3920371	Tumour	 gamma camera imaging	OTHER
Sensitivity and specificity of anal cytology, Test sensitivity and specificity, Baseline	Concordance of self- and clinician-collected PCR testing, Proportionate concordance of high-risk HPV testing, baseline|Prevalence of hrHPV types at baseline, Proportion of subjects with high-risk HPV and subtype proportions, Baseline|hrHPV with Cobas PCR testing (self-collected), Presence of high-risk HPV subtype, Baseline|hrHPV with Cobas PCR testing (self-collected), Presence of high-risk HPV subtype, 12 months|hrHPV with Cobas PCR testing (self-collected), Presence of high-risk HPV subtype, 24 months|hrHPV with Cobas PCR testing (clinician-collected), Presence of high-risk HPV subtype, Baseline|hrHPV with Cobas PCR testing (clinician-collected), Presence of high-risk HPV subtype, 12 months|hrHPV with Cobas PCR testing (clinician-collected), Presence of high-risk HPV subtype, 24 months|Prevalence of aHSIL at baseline, Proportion of subjects with aHSIL, Baseline|Incidence of aHSIL at follow-up, Proportion of subjects with new aHSIL during follow-up period, 24 months|Screening Experience Survey, Survey measures anal cancer screening test acceptability. Each item is scored 0-3, with higher score indicting more acceptability. 0-3. There is no total scale. Each question is scored separately and the overall results are used qualitatively., Baseline|Incidence of hrHPV, by type, Proportion of subjects with new hrHPV infection, 12 months|Incidence of hrHPV, by type, Proportion of subjects with new hrHPV infection, 24 months|Proportion of subjects with new hrHPV infection, Proportion of subjects with prevalent hrHPV without measurable hrHPV at follow-up, 12 months|Proportion of subjects with new hrHPV infection, Proportion of subjects with prevalent hrHPV without measurable hrHPV at follow-up, 24 months	\N	5217940	HPV-related Lower Genital Tract Neoplasias|HPV-related Anal Neoplasias|Early Stage Lower Genital Tract Cancers	 Diagnostic tests for anal cancer screening	DIAGNOSTIC_TEST
postoperative complications, Number of patients with postoperative complications and grade of Clavien-Dindo, within the first 30 days up to one year after surgery	Operating time, During surgery|Anastomosis time, From the enteromy to its closure.|Hospital length of say, participants will be followed for the duration of hospital stay, an expected average of 4 days|first tolerance day, First day taking liquids without vomits or abdominal distension, participants will be followed for the duration of hospital stay, an expected average of 4 days|first flatus day, participants will be followed for the duration of hospital stay, an expected average of 4 days|first faeces day, participants will be followed for the duration of hospital stay, an expected average of 4 days|Orocecal transit, Using hydrogen breath test curves. preoperative, at day 2 postoperative, 1 month, 6 months and 1 year., up to one year|Gastrointestinal life quality, Using gastrointestinal quality life index questionnaire. preoperative, 1 month, 6 months and 1 year., up to one year	\N	2309931	Primary Malignant Neoplasm of Ascending Colon	 antiperistaltic side-to-side ileocecal anastomosis	PROCEDURE
Incidence of adverse events, The incidence of all adverse events (AE), serious adverse events (SAE) and treatment-related adverse events (TEAEs), Each subject started from the signing of the informed consent until 30 days after the last administration or the start of a new target indication	\N	\N	4805060	Terminal Malignant Tumors	 TQB2858 injection	DRUG
safety and tolerability, To evaluate the safety, tolerability of LBL-019 monotherapy or combined with anti-PD-1 antibody, which is according to the number of DLT and the number of treatment related AES, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months	Cmax, Maximum serum concentration, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months|immunogenicity, The immunogenicity is evaluated by the incidence of anti-drug antibodies (ADA) and neutralizing antibodies (if applicable) in subjects;, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months|Pharmacodynamics, Receptor occupancy, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months|ORR, Objective Response Rate, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months|DCR, Disease Control Rate, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months|DOR, To measure duration of response, All subjects signed the informed consent form to the completion of the follow-up period of drug withdrawal. The maximum time is 24 months	\N	5223231	Advanced Malignant Tumors	 LBL-019 Injection	DRUG
Maximum tolerated dose (MTD), The highest dose of a drug or treatment that does not cause unacceptable side effects., Baseline up to 48 weeks|Adverse events (AEs) and serious adverse events (SAEs), The occurrence of all AEs and SAEs, Baseline up to 48 weeks	Time to reach maximum (peak) plasma concentration following drug administrationÔºàTmaxÔºâ, To characterize the pharmacokinetics of TQB3617 by assessment of time to reach maximum plasma concentration after single and multiple dosing, Pre-dose, 30 minutes, 1, 2, 3, 4, 6, 8,12, 24, 48, 72, 96, 120,168 hours after oral administration of a single drug delivery; 30 minutes, 1, 2, 3, 4, 6, 8,12, 24 hours of day 28; 30 minutes before oral administration on day 8, day 15, day 22, day 28.|Maximum (peak) plasma drug concentration ÔºàCmaxÔºâ, Cmax is the maximum plasma concentration of TQB3617 or metabolite(s)., Pre-dose, 30 minutes, 1, 2, 3, 4, 6, 8,12, 24, 48, 72, 96, 120,168 hours after oral administration of a single drug delivery; 30 minutes, 1, 2, 3, 4, 6, 8,12, 24 hours of day 28; 30 minutes before oral administration on day 8, day 15, day 22, day 28.|Elimination half-life (to be used in one-or non- compartmental model) Ôºàt1/2Ôºâ, t1/2 is time it takes for the blood concentration of TQB3617 or metabolite(s) to drop by half., Pre-dose, 30 minutes, 1, 2, 3, 4, 6, 8,12, 24, 48, 72, 96, 120,168 hours, after oral administration of a single drug delivery.|Maximum (peak) steady-state plasma drug concentration during a dosage interval ÔºàCmax,ssÔºâ, Maximum (peak) steady-state plasma drug concentration during a dosage interval, Pre-dose, 30 minutes, 1, 2, 3, 4, 6, 8,12, 24, 48, 72, 96, 120,168 hours after oral administration of a single drug delivery; 30 minutes, 1, 2, 3, 4, 6, 8,12, 24 hours of day 28; 30 minutes before oral administration on day 8, day 15, day 22, day 28.|Minimum steady-state plasma drug concentration during a dosage interval ÔºàCss-minÔºâ, Minimum steady-state plasma drug concentration during a dosage interval, Pre-dose, 30 minutes, 1, 2, 3, 4, 6, 8,12, 24, 48, 72, 96, 120,168 hours after oral administration of a single drug delivery; 30 minutes, 1, 2, 3, 4, 6, 8,12, 24 hours of day 28; 30 minutes before oral administration on day 8, day 15, day 22, day 28.|Concentration at the end of the dosing interval AUCtau,ss, To characterize the pharmacokinetics of TQB3617 by assessment of area the concentration at the end of the administration interval, Pre-dose, 30 minutes, 1, 2, 3, 4, 6, 8,12, 24, 48, 72, 96, 120,168 hours after oral administration of a single drug delivery; 30 minutes, 1, 2, 3, 4, 6, 8,12, 24 hours of day 28; 30 minutes before oral administration on day 8, day 15, day 22, day 28.|Overall response rate (ORR), Percentage of participants achieving complete response (CR) and partial response (PR)., up to 96 weeks|Progress Free SurvivalÔºàPFSÔºâ, From the start of randomization to the first tumor progression or time of death., up to 96 weeks|Disease control rateÔºàDCRÔºâ, Percentage of participants achieving complete response (CR) and partial response (PR) and stable disease (SD)., up to 96 weeks|Duration of Response (DOR), The time when the participants first achieved complete or partial remission to disease progression., up to 96 weeks|Overall SurvivalÔºàOSÔºâ, From date of first administration of test drug until the date of death from any causeÔºå, assessed up to 100 months	\N	5110807	Advanced Malignant Tumors	 TQB3617	DRUG
Number of patients with Adverse Events (AEs), Up to approximately 2 years|Objective Response Rate (ORR), Up to approximately 2 years	Disease control rate (DCR), Up to approximately 2 years|Duration of Response (DoR), Up to approximately 2 years|Time to response (TTR), Up to approximately 2 years|Progression free survival (PFS), Up to approximately 2 years|Overall survival (OS), Up to approximately 2 years|Maximum observed concentration (Cmax) of AK117 and AK104, The endpoints for assessment of PK include serum concentrations of AK117 and AK104 at different timepoints after study drug administration., From first dose of study drug to last dose of of study drug|Minimum observed concentration (Cmin) of AK117 and AK104 at steady state, The endpoints for assessment of PK include serum concentrations of AK117 and AK104 at different timepoints after study drug administration., From first dose of study drug to last dose of of study drug|Number of subjects who develop detectable anti-drug antibodies (ADAs), The immunogenicity of AK117 and AK104 will be assessed by summarizing the number of subjects who develop detectable anti-drug antibodies (ADAs)., From first dose of study drug through 30 days after last dose of study drug	\N	5235542	Advanced Malignant Tumors	 AK104	DRUG
patient satisfaction, questionnaires"The Obturator Functioning Scale", 1 month|patient satisfaction, questionnaires " The European Organization for Research and Treatment of Cancer Head and Neck 35", 1 month	\N	\N	3146624	Tumour	 attachment retained obturator	OTHER
Number of patients with DLT, AE, treatment-related AE (TRAE), immune-related AEs (irAE), AE of special interest (AESI), serious adverse event (SAE), discontinuation of study drug due to AE, dose-limiting toxicity (DLT) assessed by CTCAE v5.0, up to 2 years	Overall response rate (ORR) based on RECIST v1.1 criteria and Lugano 2014 criteria., up to 2 years|Progression-free survival (PFS) based on RECIST v1.1 criteria and Lugano 2014 criteria, up to 2 years|Overall Survival (OS) based on RECIST v1.1 criteria and Lugano 2014 criteria, up to 2 years|Time To Response(TTR) based on RECIST v1.1 criteria and Lugano 2014 criteria, up to 2 years|Duration of Response(DOR) based on RECIST v1.1 criteria and Lugano 2014 criteria, up to 2 years	\N	4708210	Advanced Malignant Tumors	 IBI319	DRUG
Incidence rate and the grade (severity) of DLTs, Incidence rate and the grade (severity) of DLTs based on the occurrence of Adverse Events (AEs) reported according to the NCI CTCAE v6.0. DLTs include any grade ‚â• 3 events considered possibly related to the study drug, but excludes cerebral oedema, and haematological toxicity., 8 weeks from the first dose of IMP until discharge from the second dosem, up to 62 weeks.|Safety, tolerability and RP2D, Assessing TEAEs type according to MedDRA (Medical Dictionary for Regulatory Activities), frequency, severity according to National Cancer Institute Common Terminology Criteria for Adverse Events (NCI CTCAE) V5.0, seriousness, and relationship of study treatment will be assessed. Laboratory abnormalities will be assessed according to the NCI CTCAE V5.0., From screening until end of study, assessed over 62 weeks. TEAEs - units are frequency (percentage) and severity. Laboratory - safety laboratory including liver functions test, report mean and out of range.	\N	\N	5450744	Neoplastic Disease|Glioblastoma|Glioblastoma Multiforme	 131I-IPA	DRUG
Postoperative complications, Complications of patients undergoing LARS ligament and bone prosthesis replacement., From surgery to 24 months after surgery|Limb function, Limb function was assessed using the Musculoskeletal Oncology Society (MSTS) scoring scale for seven items, namely movement, pain, stability, deformity, strength, functional activity, and emotional receptiveness. The highest possible score is 35, with 5 points allocated to each project., Patients were enrolled until 24 months after surgery	\N	\N	5616182	Malignant Tumor	 LARS ligament and bone prosthesis replacement was performed	OTHER
Dose-limiting toxicity (DLT), Subjects appear the following toxic reaction relate to the drug after treatment within 28 days ÔºöIII ¬∞or above of non-hematological toxicity, IV¬∞ hematological toxicity , neutropenia associated with fever., Baseline up to 28 days	Cmax, Cmax is the maximum plasma concentration of TQB3804 or metabolite(s)., Hour 0, 1, 2, 4, 6, 8, 10, 12, 18, 24, 48, 72, 96, 168 hours post-dose on single dose; Hour 0 of day 8,day 15,day14,day 22,day 28 on multiple dose and Hour 0, 1, 2, 4, 6, 8, 10, 12, 18, 24 hours post-dose on multiple dose of day 28.|Tmax, To characterize the pharmacokinetics of TQB3804 by assessment of time to reach maximum plasma concentration., Hour 0, 1, 2, 4, 6, 8, 10, 12, 18, 24, 48, 72, 96, 168 hours post-dose on single dose; Hour 0 of day 8,day 15,day14,day 22,day 28 on multiple dose and Hour 0, 1, 2, 4, 6, 8, 10, 12, 18, 24 hours post-dose on multiple dose of day 28.|AUC0-t, To characterize the pharmacokinetics of TQB3804 by assessment of area under the plasma concentration time curve from zero to infinity., Hour 0, 1, 2, 4, 6, 8, 10, 12, 18, 24, 48, 72, 96, 168 hours post-dose on single dose; Hour 0 of day 8,day 15,day14,day 22,day 28 on multiple dose and Hour 0, 1, 2, 4, 6, 8, 10, 12, 18, 24 hours post-dose on multiple dose of day 28.|Progression Free Survival (PFS), PFS defined as the time from first dose to the first documented progressive disease (PD) or death from any cause., Baseline up to 52 weeks|Objective Response Rate(ORR), Percentage of participants achieving complete response (CR) and partial response (PR)., Baseline up to 52 weeks|Disease Control Rate(DCR), Percentage of participants achieving Complete Response (CR) and Partial Response (PR) and Stable Disease (SD)., Baseline up to 52 weeks	\N	4128085	Advanced Malignant Tumors	 TQB3804	DRUG
Lower-limb drainage intraoperative isotopic detection rate in patients with pelvic lymphadenectomy for gynaecological cancers., day of surgery	Anatomy of lower-limb drainage, day of surgery|Percentage of patients with metastatic lower limb sampling, 2 weeks after surgery|Follow-up of patients to identify complications, and namely lower-limb lymphedema., 5 years	\N	1946672	Gynaecological Malignant Tumours With Indication of Pelvic Lymphadenectomy	 Lower-limb drainage isotopic intraoperative detection	PROCEDURE
ORR 3, 3-month objective response rate, three months after CAR-T cells infusion	\N	\N	4702841	CAR|Malignant Tumors	 Chimeric antigen receptor modified Œ≥Œ¥ T cells	DRUG
EVA (POSTOPERATIVE PAIN), The investigators asked the patient the postoperative pain during teh first 72 hours by EVA scale., 72 H POSTOPERATIVE	ADVERSE EFFECTS, the investigators look for adverse effects, five days	\N	1825993	Sigmoidal Tumour	 L-BUPIVACAINE ; MORPHINE	DRUG
recurrence free survival, recurrence free survival, 6 weeks	safety (incidence of adverse events and serious adverse events), incidence of adverse events and serious adverse events, 3 weeks|overall survival, overall survival, 6 weeks	\N	4996446	Liver Malignant Tumors	 Tislelizumab	DRUG
Postoperative morbidity rate, Postoperative morbidity according to Clavien Dindo, 90 days	Mortality rate, Mortality rate, 90 days|Reoperation rate, Any reoperation linked to surgical resection of the retrorectal tumor, 90 days|Quality of surgical resection, Evaluation of surgical margins according to pathological examination, 90 days|Conversion to open approach, Conversion to laparotomy in case of mini-invasive approach, 90 days|Rate of functional outcomes, Evaluation of fecal, 90 days|Rate of functional outcomes, Evaluation urinary functions, 90 days|Functional outcomes, Evaluation of sexual functions, 90 days	\N	4757103	Malignant Tumor	 Resection of the retrorectal tumor	PROCEDURE
complications, Complications were collected from patients who underwent 3D-printed bone prosthesis replacement surgery., From surgery to 24 months after surgery|Limb function, Limb function was assessed using the Musculoskeletal Oncology Society (MSTS) scoring scale for seven items, namely movement, pain, stability, deformity, strength, functional activity, and emotional receptiveness. The highest possible score is 35, with 5 points allocated to each project., Patients were enrolled until 24 months after surgery	\N	\N	5616195	Malignant Tumor	 3D printed bone prosthesis replacement surgery	OTHER
Event free survival, Percentage of patients with no event after two years of follow up., 2 years	\N	\N	1991652	Wilms Tumour	 Wilms tumor follow up	MISC
To assess safety and tolerability of SUPLEXA in subjects with malignant solid tumour and haematologic malignancies., Incidence of dose limiting toxicities measured by Incidence of adverse events and serious adverse events overall, by severity, by relationship to each study intervention, and those that led to discontinuation of study intervention., 24 months	Solid tumours cohort: To assess the efficacy of SUPLEXA in subjects with malignant solid tumour as assessed by the Investigator based on response evaluation criteria in solid tumours (RECIST) v1.1 or by changes in tumour-derived blood biomarkers., Objective response rate defined as the proportion of subjects with best overall response of either a complete response or partial response measured by Time to Progression (TTP), 24 months|Haematologic malignancies cohort: To assess the efficacy of SUPLEXA in subjects with haematologic malignancies (multiple myeloma, lymphoma and chronic lymphocytic leukemia)., Objective response rate as defined by standard of care., 24 months	\N	5237206	Oncology	 SUPLEXA	BIOLOGICAL
Assessment of Clinical Symptomatic Response, This endpoint was assessed using 2 efficacy variables:\n\n* CTCs, enumerated at baseline and Weeks 5, 17, 25, 53\n* Clinical symptomatic response, assessed by the use of symptom reporting\n\nSubjects recorded 24-hour symptom frequency and severity for 7 days prior to first treatment (baseline), throughout the study, and up to 28 days following final drug administration. Symptoms were recorded by answering predetermined questions on the interactive voice response system (IVRS).\n\nSubjects were considered to have a clinical symptomatic response between baseline and last study visit if any 1 of the following criteria were fulfilled: the average number of episodes of diarrhoea decreased by at least 50%, the average number of episodes of flushing decreased by at least 50%, the mode severity of flushing decreased by at least 1 level. Clinical symptomatic response was assessed as a qualitative variable (Yes/No) and reported according to CTC presence at baseline and overall., From baseline up to Week 53.|Percentage of Subjects With Time Point Responses According to Response Evaluation Criteria in Solid Tumours (RECIST) Assessments at Weeks 25 and 53, Subjects underwent Computed Tomography (CT) or Magnetic Resonance Imaging (MRI) scans at baseline, Visit 8 (Week 25) and Visit 15 (Week 53). Progression was assessed by investigators using RECIST v1.1, and classified as a complete response, partial response, stable disease, progressive disease or non evaluable.\n\nThe time point responses at Week 25 and Week 53 were analysed by CTC presence at baseline and overall. The percentage of subjects within each response category are presented. Percentages are based on the number of subjects in the concerned population with available responses., Week 25 and Week 53.	Mean Change From Baseline in Number of Episodes of Diarrhoea and Flushing, The effect of lanreotide Autogel on the symptoms of diarrhoea and flushing in subjects was assessed through subject reporting of symptoms every 24-hours for the 7 days prior to treatment (baseline), for the first 16 weeks and on days 11 to 17 after each subsequent injection interval. After the final study drug injection at Week 49, subjects provided 24-hour symptom frequency on days 11 to 28 (up to Week 53). Symptom frequency was recorded by answering predetermined questions on the IVRS.\n\nMean change from baseline in frequency (number of episodes) of diarrhoea and flushing are described at Visit 2 (average number of episodes in Week 1) and at Visit 14 (average number of episodes over days 11 to 17 after Week 49 injection and over days 11 to 28 after Week 49 injection) by CTC presence at baseline and overall. A negative change indicates an improvement in symptoms from baseline., From baseline up to Week 53.|Mode Symptom Severity of Episodes of Flushing, The effect of lanreotide Autogel on the mode severity of flushing was assessed through subject reporting of symptoms every 24-hours for the 7 days prior to treatment (baseline), for the first 16 weeks and on days 11 to 17 after each subsequent injection interval until Week 49. After the final study drug injection at Week 49, subjects provided 24-hour symptom severity on days 11 to 28 (up to Week 53). Symptom severity was recorded by answering predetermined questions on the IVRS using a three-point system (mild, moderate or severe). The mode (most frequent) intensity of flushing are reported at baseline and at Visit 14 (average number of episodes over days 11 to 17 after Week 49 injection and over days 11 to 28 after Week 49 injection). Percentages of subjects in each severity category are based on the number of subjects in the analysis set with available responses. Data is presented according to CTC presence at baseline and overall., From baseline up to Week 53.|Quality of Life (QoL) Questionnaire: European Organisation for Research and Treatment of Cancer (EORTC) QoL Questionnaire (QLQ)-C30, The effect of lanreotide Autogel treatment on QoL was assessed using the EORTC QLQ-C30 at baseline, Weeks 13 (Visit 5), 25 (Visit 8) and 53 (Visit 15/end of study). The 30 item scale is divided into 9 multi item scales (including 5 functional scales, 1 global health status/QoL scale and 3 general symptom scales) and 6 single items. Possible answers to the first 28 items (all items except the 2 concerning global quality of life) go from 1 (Not at all) to 4 (Very much). The answers for the 2 last questions (Q29- 30) go from 1 (Very poor) to 7 (Excellent). All of the scales and single-item measures range in score from 0 to 100. For multi-item scales, the raw score will be calculated by the addition of item responses divided by the number of items. Higher scores for global health and functional domains indicate a better QoL, while higher symptom scores indicate worse symptoms.\n\nThe mean change from baseline at each time point is reported for each of the category subscores., From baseline up to Week 53.|QoL Questionnaire: EORTC QLQ-G.I.NET21, The effect of lanreotide Autogel treatment on QoL was assessed using the EORTC QLQ-G.I.NET21 at baseline, Weeks 13 (Visit 5), 25 (Visit 8) and 53 (Visit 15/end of study). The QLQ-G.I.NET21 questionnaire contained 21 questions that used a 4-point scale (1 = Not at all, 2 = A little, 3 = Quite a bit, 4 = Very much) to evaluate 3 defined multi-item symptom scales (endocrine, gastrointestinal and treatment related side effects), 2 single item symptoms (bone/muscle pain and concern about weight loss), 2 psychosocial scales (social function and disease-related worries) and 2 other single items (sexuality and communication). Each individual subscore was transformed to range from 0 to 100. Higher scores indicate worse symptoms or more problems. The mean change from baseline at each time point is reported for each of the category subscores., From baseline up to Week 53.|Percentage of Subjects Alive and Progression Free at One Year, Subjects underwent CT or MRI scans at baseline and Week 53. Progression was assessed by investigators using RECIST v1.1. The best overall response to study treatment is the highest time point response achieved by the subject and was assessed as a complete response, partial response, stable disease, progressive disease or non evaluable. For analysis of PFS, event dates were assigned to the first time that progressive disease was noted or the date of death. In case of progressive disease followed by death, the first event was considered in the analysis. Censoring dates were defined in subjects with no progressive disease or death before end of study.\n\nAt one year (end of study), the mean percentage of subjects who were alive and progression free, as calculated using the Kaplan-Meier method, is reported by CTC presence and overall., From baseline up to Week 53.	\N	2075606	NeuroEndocrine Tumours	 lanreotide acetate	DRUG
Participant adherence to prehab program, Evaluate adherence through analysis of patient maintained exercise logs via number of days completed, Through study completion, on average 3 months|Correlation between patient pre-program self-efficacy evaluation and measured adherence to study prehabilitation program, Assess self-efficacy by evaluating the relationship between pre-program Self-Efficacy for Home Exercise Program Scale (0-72) score and adherence., Through study completion, on average 3 months|Patient Satisfaction, Assess patient satisfaction and barriers to adherence through a post prehab program survey., Last day of prehabilitation program (within week prior to surgery)|Quality of Life (Short Form- 36 Survey), Evaluate change in health-related quality of life before and after participation in the prehabilitation program., Completed at Day 0, Two weeks, Four weeks and Last day of prehabilitation program (within week prior to surgery)|Frailty (Risk Analysis Index), Evaluate change in frailty using Risk Analysis Index before and after participation in the prehabilitation program., Evaluated on Day 0 and at last visit prior to surgery, an average of 3 months	\N	\N	5377970	Prehabilitation|Oncology|Surgical Oncology	 Thinkific Prehabilitation Exercise Program	OTHER
T-Cell Receptor/B-Cell Receptor gene expression, 3 month	\N	\N	1906632	Malignant Tumor	 DC-CIK Immunotherapy	BIOLOGICAL
Quantification of Cell Death and Immune Cell Biomarkers by IHC and In-Situ Hybridization, Quantification of biomarker-positive and biomarker-negative cells will be performed within the tumour microenvironment around each of the injection sites in each resected patient sample by IHC and ISH. An aggregate analysis of this quantification may be done across patient samples in each substudy to evaluate trends in tumour response. The biomarkers evaluated may include, but are not limited to biomarkers for cell death (e.g. cleaved caspase 3), T-cells (e.g. CD3, CD8/Granzyme B, CD4), natural killer (NK)/myeloid cells (e.g. CD56/Granzyme B, CD86, CD68, CD163), and proinflammatory cytokines (e.g., interferon gamma, tumour necrosis factor alpha, interferon gamma-induced protein 10)., 4 hours-7 days after microdose injection	Number of Patients with Adverse Events, Relationship of AE to study drug(s) or CIVO device will be determined using an AE Relatedness Grading System., Up to 28 days after microdose injection	\N	4891718	Solid Tumour	 MVC-101	BIOLOGICAL
Determine the maximum tolerated dose of E7974 in patients with Advanced Solid Tumors., Duration of each cycle will be 21 days; patients will attend a follow-up visit 30 days after last study treatment. Follow-up for safety and efficacy will occur 6 months after the last patient is accrued to the study.	Assess E7974 for safety, pharmacokinetics (PK) and pharmacodynamics (PD) which will correlate AUC with clinical toxicity and efficacy., Duration of each cycle will be 21 days; patients will attend a follow-up visit 30 days after last study treatment. Follow-up for safety and efficacy will occur 6 months after the last patient is accrued to the study.	\N	165802	Cancer, Malignant Tumors	 E7974	DRUG
Evaluation of chronic toxicity in patients treated for non-metastatic breast cancer, 8 years	\N	\N	1993498	Breast Cancer Nos Metastatic Recurrent	 blood sampling	PROCEDURE
The incidence rate of progression of disease in a cohort of patients newly diagnosed with MBC, either De Novo or having progressed from a non-metastatic stage, At 12 and 18 months after diagnosis	The progression free survival (PFS) rates, At 12 and 18 months after diagnosis|The progression free survival (PFS) time, At 18 months after diagnosis|Time to progression (TTP), At 18 months after diagnosis|The clinical and pathological characteristics of newly diagnosed MBC patients, At 18 months after diagnosis|The socio-demographic and anthropometric characteristics of newly diagnosed MBC patients, At 18 months after diagnosis|Health care utilization associated with the disease in Romania, At 18 months after diagnosis	\N	1711502	Breast Cancer Nos Metastatic Recurrent	 Epidemiology and Management	MISC
System usability scale (SUS) 10-item survey, To assess the usability of NAVIFY Oncology Hub, 90 mins|Participant-reported efficiency when preparing for patient consultations, Likert Scale, To assess the efficiency of using NAVIFY Oncology Hub, 90 mins|Time taken to prepare for patient consultation, minutes, To assess the efficiency of using NAVIFY Oncology Hub, 90 mins|Paas Scale single-item survey, To assess the mental effort required with using NAVIFY Oncology Hub, 90 mins|NASA Task Load Index (NASA-TLX), To assess the mental effort required with using NAVIFY Oncology Hub, 90 mins	\N	\N	5478135	Oncology	 NAVIFY Oncology Hub	DEVICE
To evaluate the ability of SARS-CoV-2 immunoassays, following a positive result, to identify patients with very low risk of recurrence of COVID-19 within 3 months., The primary endpoint of this study is the recurrence of COVID-19 within 3 months following the immunoassay-positive result obtained before the inclusion in the study. The recurrence is defined by the presence of symptoms confirmed either by a positive reverse transcription-polymerase chain reaction (RT-PCR) result for SARS-CoV-2 or by the adjudication committee. Immunoassay will be said positive as per the predefined reference corresponding to the immunoassay., 3 months	To estimate the discordance rate between local immunoassay and a centralized ELISA in patients with a positive immunoassay, whatever the immunoassay., Agreement between the different immunoassays and the centralized ELISA, using the centralized ELISA as benchmark., 6 months|To identify patients with very low risk of recurrence of COVID-19 within 6 months following a positive immunoassay result., COVID-19 recurrence within 6 months following an immunoassay-positive result., 6 months|To characterize the evolution over time of the serologic response against SARS-CoV-2 (in a subgroup of patients)., Quantitative and qualitative detection of SARS-CoV-2-related antibodies and immune serum markers at baseline, 2-3 months and 4-6 months post-inclusion, in a subgroup of 200 patients., 6 months	\N	4367870	Oncology	 COVID-19 Detection Test	MISC
Collect information on the proportion of tumors ablated for sample size calculations in the pivotal trial, Evaluate the rate of complete tumor ablation by Novilase ILT of small breast cancers and characterize the correlation of imaging (MR, US, x-ray) in detecting residual post ablation with histopathology of the excised specimen.\n\nAn individual patient will be considered to have a complete ablation if the pathology results post excision demonstrates that no visible gross residual tumor is present., one month end point	To gain experience with the cosmetic outcome and rate of recovery tools, Evaluate satisfaction, utilizing the European Organization for Research and Treatment of Cancer Breast Cancer Specific Quality of Life Questionnaire (EORTC QLQ-BR23) survey and cosmetic outcome utilizing the physician-reported Four-Point Scoring System of Breast Cosmesis., One month end point	\N	1478438	Malignant Tumor	 Novilase Interstitial Laser Therapy	DEVICE
COM-ON (Communication in Oncology) Checklist, Validated rating scale assessing general and specific communication skills in oncology. Items are rated on a five-point Likert scale ranging from 0 = ''Skill not demonstrated at all'' to 5 = ''Skill fully demonstrated'', with higher scores denoting higher quality communication., 3 months|QQPPI (Questionnaire on the Quality of Physician-Patient Interaction), Validated patient-facing rating scale of for quality of physician communication. Items are rated on a five-point Likert scale ranging from 1 = ''I do not agree'' to 5 = ''I fully agree'', with higher scores denoting higher quality communication., 3 months|Assessment rubric for 'entrustable professional activities' (EPAs), Medical interaction analysis rating scale as defined by the Royal College of Physicians and Surgeons of Canada. Items are rated on a five-point Likert scale ranging from 1 = ''I do not agree'' to 5 = ''I fully agree'', with higher scores denoting higher quality communication., 3 months|Global rating scale, Overall rating scale of quality of physician communication. Items are rated on a five-point Likert scale ranging from 1 = ''I do not agree'' to 5 = ''I fully agree'', with higher scores denoting higher quality communication., 3 months	End-of-Life Professional Caregiver Survey (EPCS), Validated instrument assessing educational needs relating to palliative care for interprofessional members of the healthcare team. Items are rated on a five-point Likert scale ranging from 1 (lowest level of skill) to 5 (greatest level of skill), with higher scores denoting a higher level of skill., 3 months|RESTORED Questionnaire, Participant satisfaction with training intervention. Items are rated on a five-point Likert scale ranging from 1 = ''I do not agree'' to 5 = ''I fully agree'', with higher scores denoting higher satisfaction., Immediately after the intervention	\N	5810987	Oncology	 RESTORE	OTHER
Progression Free Survival, PFS is defined as the period from the day of randomization until the first observation of lesion progression or death from any cause. Disease progression is defined as PD according to RECIST Ver. 1.1.\n\nAssessment period was from the day of randomisation until the first observation of lesion progression or death, Baseline, every 6 weeks of study treatment period, and end of study,	Overall Survival, OS is defined as the period from the day of randomization until the day of death from any cause.\n\nAssessment period was from the day of randomisation until the first observation of lesion progression or death, Baseline, every 6 weeks of study treatment period, and end of study.|Overall Response Rate, ORR is the proportion of patients who are assessed as complete response or partial response as the best overall response among evaluable patients, according to RECIST Ver.1.1.\n\nAssessment period was from the day of randomisation until the first observation of lesion progression or death, Baseline, every 6 weeks of study treatment period, and end of study.	\N	1644890	Breast Cancer Nos Metastatic Recurrent	 NK105	DRUG
Median Progression Free Survival (PFS), PFS was defined as the time from first injection of lanreotide Autogel¬Æ 120 mg every 14 days to progression or death. Disease progression was assessed by tumour response evaluation according to RECIST v1.0, every 12 weeks, measured by independent central review using the same imaging technique (computed tomography \\[CT\\] scan or magnetic resonance imaging \\[MRI\\]) for each subject throughout the study. The median PFS time was estimated using the Kaplan Meier method for each cohort., From Day 1 up to Week 60 for the panNET cohort and Week 103 for the midgut NET cohort	Median Time to Progression, Time to Progression was defined as time from first injection of lanreotide Autogel¬Æ 120 mg every 14 days to progression. Disease progression was assessed by tumour response evaluation according to RECIST v1.0, every 12 weeks, measured by independent central review using the same imaging technique (CT scan or MRI) for each subject throughout the study. Median time to progression was estimated using the Kaplan Meier method for each cohort., From Day 1 up to Week 60 for the panNET cohort and Week 103 for the midgut NET cohort|Percentage of Subjects Alive and Progression Free, The percentage of subjects alive and progression-free was assessed throughout the study up to Week 60 for the panNET cohort and Week 96 for the midgut cohort. Disease progression was assessed by tumour response evaluation according to RECIST v1.0, every 12 weeks measured by independent central review using the same imaging technique (CT scan or MRI) for each subject throughout the study. The percentage of subjects alive and progression free was estimated using the Kaplan Meier method for each cohort., Weeks 12, 24, 36, 48, 60 (for both cohorts) and Weeks 72, 84 and 96 (for midgut NET cohort)|Overall Survival, Overall survival was defined as the time in months from the first injection of lanreotide Autogel¬Æ 120 mg every 14 days to death due to any cause. Median overall survival was estimated using the Kaplan Meier method for each cohort., From Day 1 up to Week 60 for the panNET cohort and Week 103 for the midgut NET cohort|Objective Response Rate (ORR), The ORR was defined as the percentage of subjects who achieve either complete response (CR) or partial response (PR) according to RECIST v1.0 criteria. ORR was evaluated every 12 weeks and results are presented for each cohort., Weeks 12, 24, 36, 48, 60 (for both cohorts) and Weeks 72, 84, and 96 (for midgut cohort)|Disease Control Rate (DCR), The DCR was defined as the percentage of subjects who achieved CR plus PR plus Stable Disease (SD), evaluated according to RECIST v1.0 criteria. The DCR at Weeks 24 and 48 is presented for each cohort., Weeks 24 and 48|Best Overall Response Rate, Best overall response was defined as the best response recorded from the initiation of treatment until disease progression, according to RECIST v1.0 evaluation. The percentage of subjects in each response category and those who were non-evaluable (i.e. with no tumour assessment after the start of study treatment) throughout the study are presented for each cohort., From Day 1 up to Week 60 for the panNET cohort and Week 103 for the midgut NET cohort|Median Duration of Stable Disease, Median duration of SD was the time from first injection of lanreotide Autogel¬Æ 120 mg every 14 days until the first occurrence of PD by central assessment. Disease progression was assessed by tumour response evaluation according to RECIST v1.0, every 12 weeks, measured using the same imaging technique (CT scan or MRI) for each subject throughout the study. Median duration of stable disease was estimated using the Kaplan Meier method for each cohort., From Day 1 up to Week 60 for the panNET cohort and Week 103 for the midgut NET cohort|Factors Associated With PFS, A univariate cox proportional hazards model was used to assess whether the following factors were associated with PFS:\n\n* Hepatic tumour load: \\>25% versus reference ‚â§25%\n* Tumour Grade: Grade 2 versus reference Grade 1,\n* Previous surgery of the primary tumour: No versus reference Yes,\n* Proliferation index Ki67: ‚â•10% versus reference \\<10%\n* Duration of treatment with lanreotide Autogel¬Æ 120 mg every 28 days by category: ‚â•median value versus reference \\<median value,\n* Age by category: ‚â•65 years versus reference \\<65 years,\n* Time from diagnosis to study entry by category: ‚â•3 years versus reference \\<3 years,\n* Time interval between the two CT scans (pre-screening/screening): ‚â•12 months versus reference \\<12 months and\n* Symptoms (diarrhoea or flushing at baseline): No versus reference Yes.\n\nEach factor was assessed for its importance in the Cox model for PFS in a univariate fashion., Screening/Baseline (Day 1)|Mean Change From Baseline in Number of Stools and Flushing Episodes, Symptom control was measured by the total number of stools (diarrhoea) and flushing episodes during the 7 days prior to the visit, reported orally by the subject to the investigator. The mean change from baseline in number of stools and flushing episodes reported at each visit is presented for each cohort., Baseline (Day 1), Weeks 8,12, 48 and end of study (approximately 64 weeks for panNET cohort and 108 weeks for midgut NET cohort)|Mean Change From Baseline in QoL Measured Using EORTC, QLQ-C30 v3.0 (Global Health Status Sub-score), Subjects were instructed to complete the 30 questions in the EORTC-QLQ-C30 v3.0 questionnaire at baseline and every 12 weeks throughout the study.\n\nThe global health status sub-score was assessed using the last 2 questions which represented subject's assessment of overall health \\& QoL. Each question was coded on a 7-point scale (1=very poor to 7=excellent). The sub-score was transformed to range from 0-100, with a high score for global health status representing a high QoL. The mean change from baseline in the transformed global health status are presented for the end of study/early withdrawal visit, with a positive change indicating an improvement in QoL., Baseline (Day 1) and end of study (approximately 64 weeks for panNET cohort and 108 weeks for midgut NET (and overall) cohort)|Mean Change From Baseline in EQ-5D-5L v1.0 Questionnaire (Descriptive System), Subjects were instructed to complete the EQ-5D-5L descriptive system at baseline and every 12 weeks throughout the study.\n\nThe EQ-5D-5L descriptive system comprised the following 5 dimensions: mobility, self-care, usual activities, pain/discomfort and anxiety/depression. Each dimension had 5 levels: no problems, slight problems, moderate problems, severe problems, extreme problems. The EQ-5D-5L health states, defined by the EQ-5D-5L descriptive system, was converted into a single index value with scores ranging from 0 (no problems) to 1 (extreme problems). The mean change from baseline at the end of study/early withdrawal visit is presented with a positive change from baseline in the index values indicating a worsening of symptoms., Baseline (Day 1) and end of study (approximately 64 weeks for panNET cohort and 108 weeks for midgut NET (and overall) cohort)|Mean Change From Baseline in EQ-5D-5L v1.0 Questionnaire (VAS), Subjects were instructed to complete the EQ-5D-5L VAS at baseline and every 12 weeks throughout the study. The EQ-5D-5L VAS recorded the subject's self-rated health on a vertical VAS which is numbered from 0 (worst health state) to 100 (best health state). The mean change from baseline at the end of study/early withdrawal visit is presented with a positive change in the VAS indicating an improvement in symptoms., Baseline (Day 1) and end of study (approximately 64 weeks for panNET cohort and 108 weeks for midgut NET (and overall) cohort)|Mean Change From Baseline in QoL Questionnaire Gastrointestinal Neuroendocrine Tumour 21 (QLQ-GI.NET21; 2006), Subjects were asked to complete the EORTC QLQ-GI.NET21 module which comprised 21 questions that used a 4-point scale (1 = Not at all, 2 = A little, 3 = Quite a bit, 4 = Very much) to evaluate 3 defined multi-item symptom scales (endocrine, gastrointestinal and treatment related side effects), 2 single item symptoms (bone/muscle pain and concern about weight loss), 2 psychosocial scales (social function and disease-related worries) and 2 other single items (sexuality and communication). Answers were converted into grading scale, with values between 0 and 100. Each individual sub-score was transformed to range from 0 to 100. The mean change from baseline at the end of study/early withdrawal visit is presented with a higher score representing more or worse problems., Baseline (Day 1) and end of study (approximately 64 weeks for panNET cohort and 108 weeks for midgut NET (and overall) cohort)|Mean Change From Baseline in Nonspecific Tumour Biomarkers, Nonspecific tumour peptide biomarkers (chromogranin A \\[CgA\\], neuron specific enolase \\[NSE\\] and plasma/urinary 5-hydroxyindoleacetic acid \\[5-HIAA\\]) were evaluated in both pancreas and midgut subjects at baseline and Week 12 and every 12 weeks thereafter. At all scheduled visits, except baseline, plasma/urinary 5-HIAA was only performed in subjects with symptoms of carcinoid syndrome (diarrhoea and/or flushing) or if urinary 5-HIAA was elevated (above upper limit of normal \\[ULN\\]) at baseline. Mean change from baseline values were normalised by the ULN (xULN) and are presented for each cohort., Baseline (Day 1) and end of study (approximately 64 weeks for panNET cohort and 108 weeks for midgut NET cohort)|Mean Change From Baseline in PanNet Specific Tumour Biomarkers: Pancreatic Polypeptide, Gastrin, PanNET specific tumour peptide biomarkers were evaluated in pancreas subjects at baseline. Only the tumour biomarkers that were above normal range at baseline were evaluated every 12 weeks thereafter and at the end of study visit. The mean change from baseline values in picomole/liter (pmol/L) are presented for the end of study visit., Baseline (Day 1) and end of study (approximately 64 weeks)|Mean Change From Baseline in PanNet Specific Tumour Biomarkers: Glucagon, PanNET specific tumour peptide biomarkers were evaluated in pancreas subjects at baseline. Only the tumour biomarkers that were above normal range at baseline were evaluated every 12 weeks thereafter and at the end of study visit. The mean change from baseline values in nanograms (ng)/L are presented for the end of study visit., Baseline (Day 1) and end of study (approximately 64 weeks)	\N	2651987	Pancreatic Tumours|Midgut Neuroendocrine Tumours	 Lanreotide autogel 120 mg	DRUG
Patient's perspective on telemedicine on a Likert Scale, Patient's perspective on telemedicine on a Likert Scale, Through survey completion, an average of 15 minutes	\N	\N	4624165	Oncology	 Survey	OTHER
Safety and tolerability of study drug therapy based on type and rate of adverse events and 16-week PFS rate., Approximately 24 weeks-Beginning from the time a patient signs the informed consent to the Follow up Tumor Assessment visit	Objective response rate (ORR) by modified RECIST v1.1, Proportion of subjects achieving a confirmed PR or CR according to modified RECIST v1.1, Approximately 24 weeks- From first study drug dose to Follow-Up Tumor Assessment Visit|Clinical Benefit rate: proportion of subjects with CR, PR, or SD by modified RECIST v1.1, Approximately 24 weeks|Estimate PFS by modified RECIST v1.1, Approximately 24 weeks, beginning at the first study drug administratrion and ending at the Follow up Tumor Assessment visit|Evaluate Pharmacodynamic tumor markers in tumor tissue samples that may correlate with objective tumor response and/or clinical outcome, Approximately 24 weeks, starting with first study drug administrationa and ending at the Follow up Tumor Assessment visit	\N	1703754	Breast Cancer Nos Metastatic Recurrent	 Ad-RTS-hIL-12 and Veledimex	GENETIC
Pharmacokinetic parameters of SHR2554: Cmax, day 1 to day 10|Pharmacokinetic parameters of SHR2554: AUC0-t, day 1 to day 10|Pharmacokinetic parameters of SHR2554: AUC0-‚àû, day 1 to day 10	Pharmacokinetic parameters of SHR2554: Tmax, day 1 to day 10|Pharmacokinetic parameters of SHR2554: t1/2, day 1 to day 10|Pharmacokinetic parameters of SHR2554: CL/F, day 1 to day 10|Pharmacokinetic parameters of SHR2554: Vz/F, day 1 to day 10|The incidence and severity of adverse events/serious adverse events, from ICF signing date to approximate day 18	\N	5661591	Malignant Tumor	 SHR2554 Tablets	DRUG
Pharmacokinetic parameters of SHR2554: Cmax, day 1 to day 10|Pharmacokinetic parameters of SHR2554: AUC0-t, day 1 to day 10|Pharmacokinetic parameters of SHR2554: AUC0-‚àû (if applicable), day 1 to day 10	Pharmacokinetic parameters of SHR2554: Tmax, day 1 to day 10|Pharmacokinetic parameters of SHR2554: t1/2, day 1 to day 10|Pharmacokinetic parameters of SHR2554: CL/F, day 1 to day 10|Pharmacokinetic parameters of SHR2554: Vz/F, day 1 to day 10|The incidence and severity of adverse events/serious adverse events., from ICF signing date to approximate day 17	\N	5592262	Malignant Tumor	 SHR2554	DRUG
Midazolam AUCinf, Area under the plasma concentration-time curve from zero to infinity, Cycle 1 Day 1, Cycle 1 Day 2, Cycle 1 Day 8, Cycle 1 Day 9, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Midazolam Cmax, Maximum observed plasma (peak) drug concentration, Cycle 1 Day 1, Cycle 1 Day 2, Cycle 1 Day 8, Cycle 1 Day 9, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)	Midazolam AUClast, Area under plasma concentration-time curve from zero to the last quantifiable concentration, Cycle 1 Day 1, Cycle 1 Day 2, Cycle 1 Day 8, Cycle 1 Day 9, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Midazolam t¬ΩŒªz, Half-life associated with terminal slope (Œªz) of a semilogarithmic concentration-time curve, Cycle 1 Day 1, Cycle 1 Day 2, Cycle 1 Day 8, Cycle 1 Day 9, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Midazolam tmax, Time to reach peak or maximum observed concentration, Cycle 1 Day 1, Cycle 1 Day 2, Cycle 1 Day 8, Cycle 1 Day 9, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib Ctrough, Observed lowest drug concentration reached before the next dose is administered, Cycle 1 Day 9 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib Cmax, Maximum observed plasma (peak) drug concentration, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib AUCœÑ, Area under plasma concentration-time curve in the dose interval, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib t¬ΩŒªz, Half-life associated with terminal slope (Œªz) of a semilogarithmic concentration-time curve, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib tmax, Time to reach peak or maximum observed concentration, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib CL/F, Apparent total body clearance of drug from plasma after extravascular administration, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib metabolite AZ14102143 Ctrough, Observed lowest drug concentration reached before the next dose is administered, Cycle 1 Day 9 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib metabolite AZ14102143 Cmax, Maximum observed plasma (peak) drug concentration, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib metabolite AZ14102143 AUCœÑ, Area under plasma concentration-time curve in the dose interval, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib metabolite AZ14102143 t¬ΩŒªz, Half-life associated with terminal slope (Œªz) of a semilogarithmic concentration-time curve, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Capivasertib metabolite AZ14102143 tmax, Time to reach peak or maximum observed concentration, Cycle 1 Day 12 and Cycle 1 Day 13 (Cycle 1 is 29 days)|Number of participants with adverse events and serious adverse events, Assessment of safety and tolerability of capivasertib (with or without the use of standard of care)and in combination with midazolam., From screening to disease progression or discontinuation from the study (up to 15 months)	\N	4958226	Solid Tumour	 Capivasertib	DRUG
Alterations in RNA as measured by microarray analysis|Alterations in protein expression as measured by 2-dimensional gel electrophoresis and matrix-assisted laser desorption ionization time-of-flight mass spectroscopy	\N	\N	433485	Neoplastic Syndrome|Non-melanomatous Skin Cancer	 sirolimus	DRUG
\.


--
-- Data for Name: takes_place; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.takes_place (location_name, nct) FROM stdin;
Tianjin Medical University Cancer Institute and Hospital	4414150
Department of Engineering Durham University	4125524
Virginia Commonwealth University/ Massey Cancer Center	3621124
H. Lee Moffitt Cancer Center & Research Institute	1750580
Ucsf	1714739
University of Texas Southwestern Medical Center Simmons Comprehensive Cancer Center	3052868
Lyon Sud Hospital Center	4396223
Institut Bergonie	3135769
Chan Soon-Shiong Institute for Medicine	2582827
University of Verona Hospital	3788382
Trinity Surgical Consultants,  Methodist Richardson Medical Center	4637256
University of Michigan	5076266
Icahn School of Medicine at Mount Sinai	3359239
Tennessee Oncology, PLLC	876408
Abramson Cancer Center of the University of Pennsylvania	2159742
Dartmouth-Hitchcock Medical Center	2575898
Children's Hospital and Research Center Oakland	489086
West China Hospital,  Sichuan University	5714748
Local Institution	2534506
Southampton University Hospitals and University of Southampton	3266042
Sun Yat-sen University Cancer Center	5615974
Anhui Cancer Hospital	5516914
Georgia Regents University- Cancer Center	1678690
Tel-Aviv Sourasky Medical Center	1092247
Sanofi	1907685
Sydney Children's Hospital	2687386
the Second Affiliated Hospital of Guangzhou Medical University	3160599
National Institutes of Health	1553448
Zhejiang University	5776732
St. Jude Children's Research Hospital	4084067
National Taiwan University Hospital	2786199
Michael Frass	1509612
The first People's Hospital of Foshan	1503905
Cancer Hospital of the University of Chinese Academy of Sciences (Zhejiang Cancer Hospital)	4793672
Mayo Clinic	4797039
Shanghai East Hospital	5396391
The Affiliated Tumor Hospital of Harbin Medical University	4980690
Guangdong Provincial People's Hospital	4343859
Fairbanks Memorial Hospital	5108298
West China Hospital	5707910
NovaRock Biotherapeutics	5877924
Department of Oncology,  Suzhou Kowloon Hospital,  Shanghai Jiaotong University School of Medicine	3931720
Innovative Cancer Institute	4881981
Zhejiang Provincial People's Hospital	5779514
National Institutes of Health	5653284
Alberta Health Services,  Cross Cancer Institute	1543542
Shenzhen University General Hospital	4672473
Emory University	5394428
Hadassah Ein Kerem	5781555
Oncologia Medica per la Patologia Toracica- IRCCS Giovanni Paolo II	4416672
Henan Science and Technology University First Affiliated Hospital	5198817
Fujian Cancer Hospital	5779163
Zhejiang Cancer Hospital	5214482
Stomatologie et Chirurgie Maxillofaciale - Pitie Salpetriere	2167581
Zhongshan Hospital Affiliated to Fudan University	5193721
Cancer Hospital Chinese Academy of Medical Sciences	5728541
National Institutes of Health	5868876
Chinese PLA General Hospital	2159820
Zhejiang Cancer Hospital	5229497
University of Leicester	3920371
Icahn School of Medicine at Mount Sinai	5217940
Hospital Universitario Virgen de La Arrixaca	2309931
Jinlin Cancer Hospital	4805060
Icon Cancer Centre	5082545
Union hospital Tongji Medical College Huazhong University of Science and Technology	5223231
Sun Yat-sen University Cancer Cen	5110807
Shanghai Renji Hospital	5235542
Mohamed Yahia Sharaf	3146624
Guangdong Provincial People's Hospital	4708210
Gold Coast University Hospital	5450744
Guangdong Provincial People's Hospital	4128085
HEGP	1946672
Anhui Provincial Hospital	4702841
Corporacion Parc Tauli	1825993
Fudan University Shanghai Cancer Center	4996446
Uhmontpellier	4757103
Department of Bone and Soft Tissue 	5616195
Mbingo Mission Hospital	1991652
Greenslopes Private Hospital/Gallipoli Medical Research Foundation	5237206
Basingstoke & North Hampshire Hospital	2075606
Nevada Cancer Institute	130169
Department of Bone and Soft Tissue 	5616182
Maine Medical Center	5377970
Capital Medical Unvierstiy Cancer Center/ Beijing Shijitan Hospital	1906632
Chris O'Brien Lifehouse	4891718
Sylvester Comprehensive Cancer Center - University of Miami	165802
Gustave roussy	1993498
Doina Coste Gherasim	1711502
Prova Health Limited	5478135
Centre Hospitalier de Boulogne sur Mer	4367870
Juravinski Cancer Centre - Hamilton Health Sciences	5810987
Japan Sites	1644890
Erasme Hospital	2651987
National Institutes of Health	4624165
Baptist Cancer Institute	1703754
Beijing Tongren Hospital Affiliated to Capital Medical University	5661591
Zhongshan Hospital Affiliated to Fudan University	5592262
Research Site	4958226
National Institutes of Health	433485
The Breast Center of Southern Arizona	1478438
\.


--
-- Data for Name: user_account; Type: TABLE DATA; Schema: public; Owner: mapeter
--

COPY public.user_account (user_name, user_phone_number, user_email, user_password) FROM stdin;
user001	123-456-7890	user001@example.com	passw0rd001
johndoe	234-567-8901	johndoe@example.com	johnDoe123
alice_wonder	345-678-9012	alice_wonder@example.com	w0nd3rLand
user003	456-789-0123	user003@example.com	P@ssw0rd003
user004	567-890-1234	user004@example.com	1234567890
sarah_smith	678-901-2345	sarah_smith@example.com	sarahS123
user006	789-012-3456	user006@example.com	Pa$$w0rd006
robert_jones	890-123-4567	robert_jones@example.com	R0bertJ0nes
user008	901-234-5678	user008@example.com	1234pass
user009	012-345-6789	user009@example.com	user009Pass
emma_johnson	234-567-8901	emma_johnson@example.com	emma1234
user011	345-678-9012	user011@example.com	password123
mike_miller	456-789-0123	mike_miller@example.com	millerMike
user013	567-890-1234	user013@example.com	P@ssw0rd013
user014	678-901-2345	user014@example.com	1234abcd
alex_turner	789-012-3456	alex_turner@example.com	turner123
user016	890-123-4567	user016@example.com	P@ssw0rd016
user017	901-234-5678	user017@example.com	user017Pass
sophia_wilson	012-345-6789	sophia_wilson@example.com	wilsonSophia
user019	234-567-8901	user019@example.com	P@ssw0rd019
user020	345-678-9012	user020@example.com	user020Pass
william_clark	456-789-0123	william_clark@example.com	ClarkWilliam
user022	567-890-1234	user022@example.com	passw0rd022
user023	678-901-2345	user023@example.com	user023Pass
olivia_andrews	789-012-3456	olivia_andrews@example.com	andrewsOlivia
user025	890-123-4567	user025@example.com	P@ssw0rd025
user026	901-234-5678	user026@example.com	12345pass
noah_roberts	012-345-6789	noah_roberts@example.com	noahR123
user028	234-567-8901	user028@example.com	password1234
user029	345-678-9012	user029@example.com	user029Pass
ava_morris	456-789-0123	ava_morris@example.com	morrisAva
user031	567-890-1234	user031@example.com	P@ssw0rd031
user032	678-901-2345	user032@example.com	1234qwer
liam_turner	789-012-3456	liam_turner@example.com	turnerLiam
user034	890-123-4567	user034@example.com	Pa$$w0rd034
user035	901-234-5678	user035@example.com	user035Pass
mia_campbell	012-345-6789	mia_campbell@example.com	campbellMia
user037	234-567-8901	user037@example.com	P@ssw0rd037
user038	345-678-9012	user038@example.com	1234abcd
logan_brown	456-789-0123	logan_brown@example.com	brownLogan
user040	567-890-1234	user040@example.com	passw0rd040
user041	678-901-2345	user041@example.com	user041Pass
harper_stewart	789-012-3456	harper_stewart@example.com	stewartHarper
user043	890-123-4567	user043@example.com	P@ssw0rd043
user044	901-234-5678	user044@example.com	12345pass
evelyn_rodriguez	012-345-6789	evelyn_rodriguez@example.com	evelynR123
user046	234-567-8901	user046@example.com	password1234
user047	345-678-9012	user047@example.com	user047Pass
james_miller	456-789-0123	james_miller@example.com	millerJames
user049	567-890-1234	user049@example.com	P@ssw0rd049
user050	678-901-2345	user050@example.com	1234qwer
sophia_james	789-012-3456	sophia_james@example.com	jamesSophia
user052	890-123-4567	user052@example.com	Pa$$w0rd052
user053	901-234-5678	user053@example.com	user053Pass
ethan_scott	012-345-6789	ethan_scott@example.com	scottEthan
user055	234-567-8901	user055@example.com	P@ssw0rd055
user056	345-678-9012	user056@example.com	1234567890
olivia_smith	456-789-0123	olivia_smith@example.com	smithOlivia
user058	567-890-1234	user058@example.com	passw0rd058
user059	678-901-2345	user059@example.com	user059Pass
noah_miller	789-012-3456	noah_miller@example.com	millerNoah
user061	890-123-4567	user061@example.com	P@ssw0rd061
user062	901-234-5678	user062@example.com	1234abcd
mia_johnson	012-345-6789	mia_johnson@example.com	johnsonMia
user064	234-567-8901	user064@example.com	password1234
user065	345-678-9012	user065@example.com	user065Pass
liam_wilson	456-789-0123	liam_wilson@example.com	wilsonLiam
user067	567-890-1234	user067@example.com	P@ssw0rd067
user068	678-901-2345	user068@example.com	12345pass
ava_clark	789-012-3456	ava_clark@example.com	clarkAva
user070	890-123-4567	user070@example.com	Pa$$w0rd070
user071	901-234-5678	user071@example.com	user071Pass
oliver_roberts	012-345-6789	oliver_roberts@example.com	robertsOliver
user073	234-567-8901	user073@example.com	P@ssw0rd073
user074	345-678-9012	user074@example.com	1234qwer
emma_turner	456-789-0123	emma_turner@example.com	turnerEmma
user076	567-890-1234	user076@example.com	passw0rd076
user077	678-901-2345	user077@example.com	user077Pass
ethan_stewart	789-012-3456	ethan_stewart@example.com	stewartEthan
user079	890-123-4567	user079@example.com	P@ssw0rd079
user080	901-234-5678	user080@example.com	1234567890
ava_jones	012-345-6789	ava_jones@example.com	jonesAva
user082	234-567-8901	user082@example.com	password1234
user083	345-678-9012	user083@example.com	user083Pass
oliver_morris	456-789-0123	oliver_morris@example.com	morrisOliver
user085	567-890-1234	user085@example.com	P@ssw0rd085
user086	678-901-2345	user086@example.com	1234abcd
sophia_clark	789-012-3456	sophia_clark@example.com	clarkSophia
user088	890-123-4567	user088@example.com	Pa$$w0rd088
user089	901-234-5678	user089@example.com	user089Pass
logan_smith	012-345-6789	logan_smith@example.com	smithLogan
user091	234-567-8901	user091@example.com	P@ssw0rd091
user092	345-678-9012	user092@example.com	1234567890
mia_miller	456-789-0123	mia_miller@example.com	millerMia
user094	567-890-1234	user094@example.com	passw0rd094
user095	678-901-2345	user095@example.com	user095Pass
james_clark	789-012-3456	james_clark@example.com	clarkJames
user097	890-123-4567	user097@example.com	P@ssw0rd097
user098	901-234-5678	user098@example.com	12345pass
user100	234-567-8901 	user100@example.com	password1234
test	123-456-7890	test@test.com	test
\.


--
-- Name: clinical_trials clinical_trials_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.clinical_trials
    ADD CONSTRAINT clinical_trials_pkey PRIMARY KEY (nct);


--
-- Name: condition condition_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.condition
    ADD CONSTRAINT condition_pkey PRIMARY KEY (cancer_type);


--
-- Name: eligibility eligibility_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.eligibility
    ADD CONSTRAINT eligibility_pkey PRIMARY KEY (age, sex);


--
-- Name: institution institution_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.institution
    ADD CONSTRAINT institution_pkey PRIMARY KEY (institution_name);


--
-- Name: intervention intervention_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.intervention
    ADD CONSTRAINT intervention_pkey PRIMARY KEY (treatment, treatment_type);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (location_name);


--
-- Name: saves saves_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.saves
    ADD CONSTRAINT saves_pkey PRIMARY KEY (user_name, nct);


--
-- Name: sponsors sponsors_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.sponsors
    ADD CONSTRAINT sponsors_pkey PRIMARY KEY (nct, institution_name);


--
-- Name: study study_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.study
    ADD CONSTRAINT study_pkey PRIMARY KEY (nct, cancer_type, treatment, treatment_type);


--
-- Name: takes_place takes_place_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.takes_place
    ADD CONSTRAINT takes_place_pkey PRIMARY KEY (nct, location_name);


--
-- Name: user_account user_account_pkey; Type: CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.user_account
    ADD CONSTRAINT user_account_pkey PRIMARY KEY (user_name);


--
-- Name: clinical_trials clinical_trials_age_sex_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.clinical_trials
    ADD CONSTRAINT clinical_trials_age_sex_fkey FOREIGN KEY (age, sex) REFERENCES public.eligibility(age, sex) ON DELETE RESTRICT;


--
-- Name: saves saves_nct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.saves
    ADD CONSTRAINT saves_nct_fkey FOREIGN KEY (nct) REFERENCES public.clinical_trials(nct) ON DELETE CASCADE;


--
-- Name: saves saves_user_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.saves
    ADD CONSTRAINT saves_user_name_fkey FOREIGN KEY (user_name) REFERENCES public.user_account(user_name) ON DELETE CASCADE;


--
-- Name: sponsors sponsors_institution_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.sponsors
    ADD CONSTRAINT sponsors_institution_name_fkey FOREIGN KEY (institution_name) REFERENCES public.institution(institution_name) ON DELETE SET NULL;


--
-- Name: sponsors sponsors_nct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.sponsors
    ADD CONSTRAINT sponsors_nct_fkey FOREIGN KEY (nct) REFERENCES public.clinical_trials(nct) ON DELETE SET NULL;


--
-- Name: study study_cancer_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.study
    ADD CONSTRAINT study_cancer_type_fkey FOREIGN KEY (cancer_type) REFERENCES public.condition(cancer_type) ON DELETE RESTRICT;


--
-- Name: study study_nct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.study
    ADD CONSTRAINT study_nct_fkey FOREIGN KEY (nct) REFERENCES public.clinical_trials(nct) ON DELETE CASCADE;


--
-- Name: study study_treatment_treatment_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.study
    ADD CONSTRAINT study_treatment_treatment_type_fkey FOREIGN KEY (treatment, treatment_type) REFERENCES public.intervention(treatment, treatment_type) ON DELETE RESTRICT;


--
-- Name: takes_place takes_place_location_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.takes_place
    ADD CONSTRAINT takes_place_location_name_fkey FOREIGN KEY (location_name) REFERENCES public.location(location_name) ON DELETE RESTRICT;


--
-- Name: takes_place takes_place_nct_fkey; Type: FK CONSTRAINT; Schema: public; Owner: mapeter
--

ALTER TABLE ONLY public.takes_place
    ADD CONSTRAINT takes_place_nct_fkey FOREIGN KEY (nct) REFERENCES public.clinical_trials(nct) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

