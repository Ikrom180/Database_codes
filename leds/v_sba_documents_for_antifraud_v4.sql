CREATE OR REPLACE VIEW ANTIFRAUD.v_sba_documents_for_antifraud as
SELECT 'cbs' as source, /*Система источник*/
c.code_filial||'.'||TO_CHAR(c.document_id) as id, /*Уникальный идентификатор платежа (Объединение полей uid_id и uid_dep_id)*/
TO_CHAR(c.document_id) as uid_id, /*Идентификатор платежа*/
c.code_filial as uid_dep_id, /*Идентификатор подразделения платежа*/
c.code_document as type_code, /*Идентификатор типа платежного документа*/
s.name as type_name, /*Наименование типа платежного документа*/
c.doc_numb as doc_num, /*Номер платежного документа*/
CASE
    WHEN pc.subject = 'P'
    THEN TO_CHAR(pcp.pinfl)
    WHEN pc.subject = 'J'
    THEN TO_CHAR(pc.inn)
    ELSE c.cl_inn
END as payer_tax_code, /*Плательщик. Налоговый номер*/
CASE WHEN pc.subject = 'P'
    THEN trim(Initcap(pcp.surname || ' ' || pcp.first_name || ' ' || pcp.patronymic))
    WHEN pc.subject = 'J'
    THEN INITCAP(pc.name)
    ELSE INITCAP(c.cl_name)
END as payer_name, /*Плательщик. Название*/
l.dt_acc as payer_account, /*Плательщик. Номер счета*/
c.cl_mfo as payer_bank_code, /*Плательщик. Идентификатор банка*/
pb.name as payer_bank_name, /*Плательщик. Название банка*/
CASE
    WHEN rc.subject = 'P'
    THEN to_char(rcp.pinfl)
    WHEN rc.subject = 'J'
    THEN TO_CHAR(rc.inn)
    ELSE c.cl_inn
END as receiver_tax_code, /*Получатель. Налоговый номер*/
CASE WHEN rc.subject = 'P'
    THEN  trim(Initcap(rcp.surname || ' ' || rcp.first_name || ' ' || rcp.patronymic))
    WHEN rc.subject = 'J'
    THEN INITCAP(rc.name)
    ELSE INITCAP(c.cl_name)
END as receiver_name, /*Получатель. Название*/
l.ct_acc as receiver_account, /*Получатель. Номер счета*/
c.co_mfo as receiver_bank_code, /*Получатель. Идентификатор банка*/
rb.name as receiver_bank_name, /*Получатель. Название банка*/
(c.sum_pay/100) as amount_dt, /*Дебет. Сумма платежа*/
v.char_code as currency_dt, /*Дебет. Валюта платежа*/
(c.sum_eqv/100) as amount_base, /*Сумма платежа в национальном эквиваленте*/
c.sym_id as purpose_code, /*Назначение платежа. Код назначения*/
c.pay_purpose as purpose_name, /*Назначение платежа. Имя назначения*/
pa.acc_external as account_dt, /*Счет по дебету*/
CASE 
    WHEN pc.code IS NOT NULL 
    THEN pc.code
    ELSE NULL 
END as cid_dt, /*Идентификатор клиента в АБС по дебету*/
ra.acc_external as account_ct, /*Счет по кредиту*/
CASE 
    WHEN rc.code IS NOT NULL 
    THEN rc.code
    ELSE NULL 
END as cid_ct, /*Идентификатор клиента в АБС по кредиту*/
pa.code_coa as account_bal_dt, /*Балансовый счет по дебету (по плану счетов)*/
ra.code_coa as account_bal_ct, /*Балансовый счет по кредиту (по плану счетов)*/
emp_c.login AS creator_code, /*Пользователь АБС, который создал документ. Логин*/
emp_c.name AS creator_name, /*Пользователь АБС, который создал документ. ФИО*/
emp_m.login AS confirmer_code, /*Пользователь АБС, который провел документ. Логин*/
emp_m.name AS confirmer_name, /*Пользователь АБС, который провел документ. ФИО*/
c.state_id as status_code, /*Статус документа. Код*/
ls.name as status_name, /*Статус документа. Наименование*/
y.name as channel, /*Канал формирования*/
TO_CHAR(c.date_enter, 'YYYY-MM-DD HH24:MI:SS') as created, /*Дата создания*/
TO_CHAR(c.date_value, 'YYYY-MM-DD HH24:MI:SS') as converted, /*Дата валютирования*/
l.operation_id as ext_id, /*ID платежа во внешней системе*/
TO_CHAR(lc.time, 'YYYY-MM-DD HH24:MI:SS') as updated /*Дата изменения*/
FROM ibs.leads_cur c
JOIN ibs.lead_protocol_cur lc on lc.lead_id = c.id
JOIN ibs.sba_documents l on l.lead_id = c.id
JOIN ibs.vits_currency v on v.code = c.code_currency
JOIN ibs.v_document s on s.code = c.code_document
JOIN ibs.s_doclead_state d on d.state_id = c.state_id
JOIN ibs.v_system y on y.code = c.sys_birth
JOIN ibs.accounts pa on pa.code = c.cl_acc
JOIN ibs.accounts ra on ra.code = c.co_acc
JOIN ibs.client_current pc on pc.client_uid = pa.client_uid
LEFT JOIN ibs.client_physical_current pcp on pcp.code = pc.code AND pcp.code_filial = pc.code_filial
JOIN ibs.client_current rc on rc.client_uid = ra.client_uid
LEFT JOIN ibs.client_physical_current rcp on rcp.code = rc.code AND rcp.code_filial = rc.code_filial
JOIN ibs.employee_current emp_c on emp_c.code = c.emp_birth
JOIN ibs.employee_current emp_m on emp_m.code = c.code_emp
JOIN ibs.v_lead_state ls on ls.state_id = c.state_id
JOIN ibs.v_bank pb on pb.code = c.cl_mfo
JOIN ibs.v_bank rb on rb.code = c.co_mfo
;