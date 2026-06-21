CREATE OR REPLACE VIEW ANTIFRAUD.v_client_upd_for_antifraud as 
SELECT a.id,
       'cbs' as source,
       c.id as source_id,
       c.code as cid,
       DECODE(c.subject, 'P', 'person', 'J', 'legal') as type,
       DECODE(c.typeof, 08, 'person', 'legal') as subtype,
       TO_CHAR(c.date_open, 'YYYY-MM-DD HH24:MI:SS') as created,
       TO_CHAR(c.date_modify, 'YYYY-MM-DD  HH24:MI:SS') as updated,
       c.code_filial as branch_code,
       CASE WHEN c.subject = 'P' THEN (
         CASE WHEN p.patronymic IS NULL THEN
             INITCAP(p.surname || ' ' || SUBSTR(p.first_name, 1, 1) || '.')
         ELSE
             INITCAP(p.surname || ' ' || SUBSTR(p.first_name, 1, 1) || '.' || SUBSTR(p.patronymic, 1, 1) || '.')
         END)
       WHEN c.subject = 'J' THEN INITCAP(c.name)
       END as name,
       CASE WHEN c.subject = 'P' THEN (
         CASE WHEN p.patronymic IS NULL THEN
             INITCAP(p.surname || ' ' || p.first_name)
         ELSE
             INITCAP(p.surname || ' ' || p.first_name || ' ' || p.patronymic)
         END)
       WHEN c.subject = 'J' THEN INITCAP(c.name)
       END as name_full,
       CASE WHEN c.subject = 'P' THEN (
         CASE WHEN p.patronymic IS NULL THEN
             UPPER(p.surname || ' ' || p.first_name)
         ELSE
             UPPER(p.surname || ' ' || p.first_name || ' ' || p.patronymic)
         END)
       WHEN c.subject = 'J' THEN UPPER(c.name)
       END as name_upper,
       (CASE WHEN c.subject = 'P' THEN TO_CHAR(p.birthday, 'YYYY-MM-DD') ELSE NULL END) as birthday,
       (CASE WHEN c.subject = 'P' THEN p.birth_place ELSE NULL END) as birthday_place,
       (CASE WHEN c.subject = 'P' THEN (SELECT v.CHAR_CODE FROM ibs.v_country v where v.CODE = p.passport_registration_country) ELSE NULL END) as citizenship,
       (CASE WHEN c.subject = 'P' and p.passport_registration_country = 860 THEN 1 when c.subject = 'P' and p.passport_registration_country <> 860 THEN 0 ELSE NULL END) as is_resident,
       (CASE WHEN c.subject = 'J' THEN TO_CHAR(j.registration_date, 'YYYY-MM-DD') ELSE NULL END) as state_reg_date,
       (CASE WHEN c.subject = 'P' THEN TO_CHAR(p.pinfl) ELSE c.inn END) as tax_code,
       (CASE WHEN c.subject = 'P' THEN (SELECT v1.Name FROM ibs.v_verifying_document_type v1 where v1.CODE = p.passport_type) ELSE NULL END) as doc_ident_type,
       (CASE WHEN c.subject = 'P' THEN p.passport_serial ELSE NULL END) as doc_ident_ser,
       (CASE WHEN c.subject = 'P' THEN p.passport_number ELSE NULL END) as doc_ident_numb,
       (CASE WHEN c.subject = 'P' THEN p.passport_serial || ' ' || p.passport_number ELSE NULL END) as doc_ident_numb_full,
       (CASE WHEN c.subject = 'P' THEN TO_CHAR(p.passport_registration_date, 'YYYY-MM-DD') ELSE NULL END) as doc_ident_date,
       (CASE WHEN c.subject = 'P' THEN TO_CHAR(p.passport_end_date, 'YYYY-MM-DD') ELSE NULL END) as doc_ident_end,
       (CASE WHEN c.subject = 'P' THEN p.passport_registration_place ELSE NULL END) as doc_ident_agency,
       c.condition as status_code,
       DECODE(c.condition, 'C','Закрыт','A','Утвержден','T','Закрыт временно','M','Закрыт основной','I','Неопределен','O','Открыт',c.condition) as status_name,
       TO_CHAR(c.date_validate, 'YYYY-MM-DD HH24:MI:SS') as activated,
       (CASE WHEN c.subject = 'P' and TO_CHAR(p.pinfl) in (SELECT h.inps FROM ibs.hr_emps h WHERE h.condition in ('A','AP','DB','OD','OF','I','OU','AO','OT','OS','OB','K','B','AS','AK','AT')) THEN 1 ELSE 0 END) as is_staff,
       c.address as address_full,
       c.mobile_phone as mobile_phone,
       c.phone as phone,
       c.email as email,
       c.a_client_code as rbs_id,
       a.what_changed
FROM ibs.client_account_protocol a     
JOIN ibs.client_current c on c.code = a.code and a.filial_code = c.code_filial 
LEFT JOIN ibs.client_physical_current p on p.code = c.code  and p.code_filial = c.code_filial 
LEFT JOIN ibs.client_juridical_current j on j.code= c.code  and j.code_filial = c.code_filial
;