CREATE OR REPLACE VIEW ANTIFRAUD.v_tet_cards_for_antifraud as 
SELECT 'pc' as source,
c.id ||'.'||c.client_code as source_id,
c.client_code as cid,
c.tet_account_number as account_id,
c.tet_card_acct as account,
c.id as card_id,
DECODE(c.card_number, '4%','Visa','5%','Mastercard',c.card_number) as sub_type_name,
SUBSTR(c.real_card_number, 1, 6) || 'NNNNNN' || SUBSTR(c.real_card_number, 13, 4) AS pan_mask,
DECODE(c.card_number, '4%','Visa','5%','Mastercard',c.card_number) as ps,
c.sms_mobile_phone as phone,
TO_CHAR(TO_DATE(c.date_expiry, 'DD.MM.YYYY'), 'YYYY-MM-DD HH24:MI:SS') AS ended,
TO_CHAR(c.date_registered, 'YYYY-MM-DD HH24:MI:SS') AS created,
TO_CHAR(c.close_date, 'YYYY-MM-DD HH24:MI:SS') AS closed,
c.tet_state_code as status_code,
DECODE(c.tet_state_code, '0','Активный','1','Украденный','2','Потерянный','3','Нет денег','4','Pick-up','5','Нечестный','6','Не активный','A','По желанию банка','B','По желанию картодержателя','H','Closed by TSM wallet','S','Suspended by TSM',c.tet_state_code) as status_name,
TO_CHAR(c.modified_on, 'YYYY-MM-DD HH24:MI:SS') as updated
FROM ibs.Tet_Cards c
;