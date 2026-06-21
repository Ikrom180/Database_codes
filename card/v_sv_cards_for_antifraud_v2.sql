CREATE OR REPLACE VIEW ANTIFRAUD.v_sv_cards_for_antifraud as 
SELECT 'pc' as source,
c.id ||'.'||c.client_id as source_id,
c.client_id as cid,
c.contract_id as pc_id,
c.offline_account as account,
c.id as card_id,
'UZCard' as sub_type_name,
SUBSTR(c.card_number, 1, 6) || 'NNNNNN' || SUBSTR(c.card_number, 13, 4) as pan_mask,
'UZCard' as ps,
c.mobile_phone as phone,
TO_CHAR(TO_DATE(c.date_expiry, 'DD.MM.YYYY'), 'YYYY-MM-DD HH24:MI:SS') AS ended,
TO_CHAR(c.date_registered, 'YYYY-MM-DD HH24:MI:SS') AS created,
c.sv_state_code as status_code,
DECODE(c.sv_state_code, '0','Активный','1','Украденный','2','Потерянный','3','Нет денег','4','Pick-up','5','Нечестный','6','Не активный','A','По желанию банка','B','По желанию картодержателя','H','Closed by TSM wallet','S','Suspended by TSM',c.sv_state_code) as status_name,
TO_CHAR(c.date_modify, 'YYYY-MM-DD HH24:MI:SS') as updated
FROM ibs.Sv_Cards c
;