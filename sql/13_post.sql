--
-- Name: drug_list_drug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.drug_list_drug_id_seq', 682, true);


--
-- Name: drug_prescription_drug_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.drug_prescription_drug_prescription_id_seq', 88, true);


--
-- Name: exams_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.exams_exam_id_seq', 1137, true);


--
-- Name: exams_list_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.exams_list_exam_id_seq', 2859, true);


--
-- Name: photo_new_photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.photo_new_photo_id_seq', 363, true);


--
-- Name: recall_recall_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.recall_recall_id_seq', 42, true);


--
-- Name: temp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.temp_id_seq', 15828, true);


--
-- Name: visit_visit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sqldiciotto
--

SELECT pg_catalog.setval('public.visit_visit_id_seq', 60, true);


--
-- Name: chemist chemist_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.chemist
    ADD CONSTRAINT chemist_pkey PRIMARY KEY (chemist_id);


--
-- Name: doctor_exam doctor_exams_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.doctor_exam
    ADD CONSTRAINT doctor_exams_pkey PRIMARY KEY (doctor_id, exam_id);


--
-- Name: drug_type drug_list_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.drug_type
    ADD CONSTRAINT drug_list_pkey PRIMARY KEY (drug_id);


--
-- Name: drug_prescription drug_prescription_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.drug_prescription
    ADD CONSTRAINT drug_prescription_pkey PRIMARY KEY (drug_prescription_id);


--
-- Name: exam_type exams_list_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam_type
    ADD CONSTRAINT exams_list_pkey PRIMARY KEY (exam_id);


--
-- Name: exam exams_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_pkey PRIMARY KEY (exam_id);


--
-- Name: general_practitioner general_practitioner_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.general_practitioner
    ADD CONSTRAINT general_practitioner_pkey PRIMARY KEY (practitioner_id);


--
-- Name: health_service health_service_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.health_service
    ADD CONSTRAINT health_service_pkey PRIMARY KEY (health_service_id);


--
-- Name: password_reset password_reset_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT password_reset_pkey PRIMARY KEY (user_id);


--
-- Name: password_reset password_reset_token_key; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT password_reset_token_key UNIQUE (token);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- Name: photo photo_new_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_new_pkey PRIMARY KEY (photo_id);


--
-- Name: province province_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.province
    ADD CONSTRAINT province_pkey PRIMARY KEY (province_id);


--
-- Name: recall recall_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.recall
    ADD CONSTRAINT recall_pkey PRIMARY KEY (recall_id);


--
-- Name: specialized_doctor specialized_doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.specialized_doctor
    ADD CONSTRAINT specialized_doctor_pkey PRIMARY KEY (doctor_id);


--
-- Name: comune temp_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.comune
    ADD CONSTRAINT temp_pkey PRIMARY KEY (comune_id);


--
-- Name: user_ user__pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.user_
    ADD CONSTRAINT user__pkey PRIMARY KEY (user_id);


--
-- Name: visit visit_pkey; Type: CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_pkey PRIMARY KEY (visit_id);


--
-- Name: unique_pending_exam_by_type; Type: INDEX; Schema: public; Owner: sqldiciotto
--

CREATE
UNIQUE INDEX unique_pending_exam_by_type ON public.exam USING btree (patient_id, exam_type) WHERE ((booked IS FALSE) AND (done IS FALSE) AND ((doctor_id IS NULL) OR (health_service_id IS NULL)));


--
-- Name: unique_pending_visit; Type: INDEX; Schema: public; Owner: sqldiciotto
--

CREATE
UNIQUE INDEX unique_pending_visit ON public.visit USING btree (practitioner_id, patient_id) WHERE (booked IS FALSE);


--
-- Name: chemist chemist_chemist_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.chemist
    ADD CONSTRAINT chemist_chemist_province_fkey FOREIGN KEY (chemist_province) REFERENCES public.province(province_id);


--
-- Name: chemist chemist_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.chemist
    ADD CONSTRAINT chemist_email_fkey FOREIGN KEY (chemist_id) REFERENCES public.user_(user_id);


--
-- Name: comune comune_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.comune
    ADD CONSTRAINT comune_province_fkey FOREIGN KEY (province) REFERENCES public.province(province_id);


--
-- Name: doctor_exam doctor_exams_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.doctor_exam
    ADD CONSTRAINT doctor_exams_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.specialized_doctor(doctor_id);


--
-- Name: doctor_exam doctor_exams_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.doctor_exam
    ADD CONSTRAINT doctor_exams_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exam_type(exam_id) ON
DELETE
CASCADE;


--
-- Name: drug_prescription drug_prescription_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.drug_prescription
    ADD CONSTRAINT drug_prescription_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: drug_prescription drug_prescription_practitioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.drug_prescription
    ADD CONSTRAINT drug_prescription_practitioner_id_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- Name: exam exam___recall_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam___recall_fkey FOREIGN KEY (recall) REFERENCES public.recall(recall_id);


--
-- Name: exam exam_health_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_health_service_id_fkey FOREIGN KEY (health_service_id) REFERENCES public.health_service(health_service_id);


--
-- Name: exam exam_practitioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exam_practitioner_id_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- Name: exam exams_doctor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_doctor_id_fkey FOREIGN KEY (doctor_id) REFERENCES public.specialized_doctor(doctor_id);


--
-- Name: exam exams_exam_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_exam_type_fkey FOREIGN KEY (exam_type) REFERENCES public.exam_type(exam_id);


--
-- Name: exam exams_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.exam
    ADD CONSTRAINT exams_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: general_practitioner general_practitioner_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.general_practitioner
    ADD CONSTRAINT general_practitioner_email_fkey FOREIGN KEY (practitioner_id) REFERENCES public.user_(user_id);


--
-- Name: general_practitioner general_practitioner_working_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.general_practitioner
    ADD CONSTRAINT general_practitioner_working_province_fkey FOREIGN KEY (working_province) REFERENCES public.province(province_id);


--
-- Name: health_service health_service_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.health_service
    ADD CONSTRAINT health_service_email_fkey FOREIGN KEY (health_service_id) REFERENCES public.user_(user_id);


--
-- Name: health_service health_service_operating_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.health_service
    ADD CONSTRAINT health_service_operating_province_fkey FOREIGN KEY (operating_province) REFERENCES public.province(province_id);


--
-- Name: password_reset password_reset_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.password_reset
    ADD CONSTRAINT password_reset_email_fkey FOREIGN KEY (user_id) REFERENCES public.user_(user_id);


--
-- Name: patient patient_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_email_fkey FOREIGN KEY (patient_id) REFERENCES public.user_(user_id);


--
-- Name: patient patient_general_practitioner_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_general_practitioner_email_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- Name: patient patient_living_province_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_living_province_fkey FOREIGN KEY (living_province) REFERENCES public.province(province_id);


--
-- Name: photo photo_new_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.photo
    ADD CONSTRAINT photo_new_email_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: recall recall_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.recall
    ADD CONSTRAINT recall_exam_id_fkey FOREIGN KEY (exam_type) REFERENCES public.exam_type(exam_id);


--
-- Name: recall recall_health_service_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.recall
    ADD CONSTRAINT recall_health_service_id_fkey FOREIGN KEY (health_service_id) REFERENCES public.health_service(health_service_id);


--
-- Name: specialized_doctor specialized_doctor_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.specialized_doctor
    ADD CONSTRAINT specialized_doctor_email_fkey FOREIGN KEY (doctor_id) REFERENCES public.user_(user_id);


--
-- Name: visit visit_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patient(patient_id);


--
-- Name: visit visit_practitioner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: sqldiciotto
--

ALTER TABLE ONLY public.visit
    ADD CONSTRAINT visit_practitioner_id_fkey FOREIGN KEY (practitioner_id) REFERENCES public.general_practitioner(practitioner_id);


--
-- PostgreSQL database dump complete
--

