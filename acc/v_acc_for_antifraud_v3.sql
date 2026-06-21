CREATE OR REPLACE VIEW ANTIFRAUD.v_acc_for_antifraud as 
SELECT 'cbs' as source,
       a.id as source_id,
       c.code as cid,
       TO_CHAR(a.acc_external) as account,
       a.code_coa as account_bal,
       s.text_reason as info,
       b.agr_num as contract_number,
       a.condition as status_code,
       DECODE(a.condition, 'C','Закрыт','A','Утвержден','O','Открыт',a.condition) as status_name,
       DECODE(a.code_coa, '22618',1,0) as is_card,
       v.char_code as currency,
       (a.saldo_out/100) as balance,
       TO_CHAR(a.date_open, 'YYYY-MM-DD HH24:MI:SS') as opened,
       DECODE(a.condition, 'C',TO_CHAR(a.date_change_condition, 'YYYY-MM-DD HH24:MI:SS')) as closed
FROM ibs.accounts a
    JOIN ibs.client_current c on a.client_uid = c.client_uid
    JOIN ibs.vits_currency v on v.code = a.code_currency
    LEFT JOIN ibs.bc_agreements b on b.client_id = c.id
    LEFT JOIN ibs.special_accounts s on s.acc_id = a.id
;