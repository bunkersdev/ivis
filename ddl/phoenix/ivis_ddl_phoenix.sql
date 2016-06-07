CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].STG_PRIMARY_PLANT_LOOKUP(
plant integer not null,
name varchar,
affiliate_code varchar,
valuation_area integer,
sales_org integer,
company_code integer,
display_name varchar,
primary_ind varchar,
group_num integer,
insert_dt varchar,
created_by varchar
CONSTRAINT pk PRIMARY KEY (plant) ) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';


CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].STG_SAP_MATERIAL_DETAIL(
material_no varchar not null,
d56_item_no varchar not null,
sap_d56_item_no varchar,
company_code varchar,
plant_id integer not null,
supply_plant_id integer,
supply_plant_company_code varchar,
jda_affiliate_code varchar,
material_description varchar,
material_type varchar,
standard_cost double,
currency varchar,
base_uom varchar,
insert_dt varchar,
created_by varchar  
CONSTRAINT pk PRIMARY KEY (material_no, d56_item_no, plant_id) ) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';


CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].STG_SAP_PLANT_COMPANY_MASTER(
plant_id integer not null,
name varchar,
valuation_area varchar,
company_code integer,
plant_cust varchar,
plant_vendor varchar,
aff_code varchar,
warehouse varchar,
currency varchar,
insert_dt varchar,
created_by varchar    
CONSTRAINT pk PRIMARY KEY (plant_id) ) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';


CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].INV_VISIBILITY_COMMENTARY_F(
affiliate_code varchar not null,
group_desc varchar not null,
affiliate_desc varchar,
plant_id varchar,
company_code varchar,
actual_boh_act_bk_usd double,
actual_boh_pln_bk_usd double,
actual_boh_upd_bk_usd double,
net_boh_pln_usd double,
net_boh_act_usd double,
plan_boh_gross double,
actual_boh_pln_bk_varnc_usd double,
net_boh_pln_bk_varnc_usd double,
reason_code varchar,
reason_desc varchar,
commentary varchar,
created_by varchar,
created_date varchar,
last_upd_by varchar,
last_upd_date varchar,
period integer not null,
year integer not null,
delete_flag varchar,
CONSTRAINT pk PRIMARY KEY (affiliate_code,group_desc,period,year) ) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';
