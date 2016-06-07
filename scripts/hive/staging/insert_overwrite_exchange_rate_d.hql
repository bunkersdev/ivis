use ${IVIS_HIVE_DATABASE};


INSERT OVERWRITE TABLE EXCHANGE_RATE_D SELECT
DATE_FK,
DM_LOAD_TIME,
DM_LOAD_USER,
DM_UPDATE_TIME,
DM_UPDATE_USER,
POSTING_AGENT_INSERT,
CONVERSION_FROM_CODE,
CONVERSION_TO_CODE,
CONVERSTION_FROM_DESCR,
CONVERSTION_TO_DESCR,
PLAN_AVG_EXCHANGE_RATE ,
PLAN_BOOK_EXCHANGE_RATE ,
UPDATE_AVG_EXCHANGE_RATE ,
UPDATE_BOOK_EXCHANGE_RATE ,
ACTUAL_AVG_EXCHANGE_RATE ,
ACTUAL_BOOK_EXCHANGE_RATE ,
FB_AVG_EXCHANGE_RATE ,
FB_BOOK_EXCHANGE_RATE ,
ACT_CUR_MONTH_EXCHANGE_RATE ,
PLAN_AVG_DEFAULT_EXCH_RATE ,
PLAN_BOOK_DEFAULT_EXCH_RATE ,
UPDATE_AVG_DEFAULT_EXCH_RATE ,
UPDATE_BOOK_DEFAULT_EXCH_RATE ,
MAJOR_BUSINESS,
CONSTANT_AVG_EXCHANGE_RATE ,
CONSTANT_BOOK_EXCHANGE_RATE ,
LBE_AVG_EXCHANGE_RATE ,
LBE_BOOK_EXCHANGE_RATE ,
CONST_NYP_AVG_EXCHANGE_RATE,
CONST_NYP_BOOK_EXCHANGE_RATE ,
PYR_AVG_EXCHANGE_RATE ,
PYR_BOOK_EXCHANGE_RATE,
EXCHANGE_RATE_F_PK   FROM LND_EXCHANGE_RATE_D;
