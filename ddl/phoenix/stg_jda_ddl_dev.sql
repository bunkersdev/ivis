CREATE TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].STG_D56_ITEM_NO (
A.invtype                 varchar,
A.listno                  varchar,
A.packsize                varchar,
A.labelcode               varchar,
A.sizecode                varchar,
B.listdesc                varchar,
B.line                    varchar,
B.linedesc                varchar,
B.subline                 varchar,
B.sublinedesc             varchar,
B.groupcode               varchar,
A.groupdesc             varchar,
B.subgroup                varchar,
B.subgroupdesc            varchar,
B.formcode                varchar,
B.formcodedesc            varchar,
B.packcodedesc            varchar,
B.ceuuom                  varchar,
B.ceufactor               varchar,
B.created_by              varchar,
B.creation_date           varchar,
B.last_upd_by             varchar,
B.last_upd_date           varchar,
B.status                  varchar,
B.source                  varchar,
B.datamart_last_upd_by    varchar,
B.datamart_last_upd_date  varchar,
B.original_insert_date    varchar,
B.last_date_sent_rgm      varchar,
B.last_date_upd_web       varchar,
B.last_date_sent_valid    varchar,
B.alt_ceuuom              varchar,
B.alt_ceufactor           varchar,
B.alt_ceucomment          varchar,
d56_item_no             varchar not null,
prod_type               varchar not null,
CONSTRAINT pk PRIMARY KEY (d56_item_no,prod_type) )  SALT_BUCKETS = 3,COMPRESSION='SNAPPY';



CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].STG_ITEM (
item_no  varchar not null,
A.descr  varchar,
A.affiliate  varchar,
A.affiliate_type  varchar,
A.std_cost  double,
A.std_price  double,
B.discontinue_date  varchar,
B.effective_date  varchar,
B.predcsr  varchar,
B.ceu_factor  integer,
B.plan_item  varchar,
B.add_item  integer,
B.abc_code  varchar,
B.mps  varchar,
B.drp  varchar,
B.major_business  varchar,
B.op_item_flag  varchar,
B.sop_attribute1  varchar,
B.sop_attribute2  varchar,
B.sop_attribute3  varchar,
B.sop_attribute4  varchar,
B.sop_attribute5  varchar,
B.sop_attribute6  varchar,
B.sop_attribute7  varchar,
B.sop_family  varchar,
B.d56_item_no_ok  varchar,
A.d56_item_no  varchar,
B.d56_inv_type  varchar,
B.d56_label_code  varchar,
B.d56_pack_code  varchar,
B.d56_list_nbr  varchar,
B.d56_size_code  varchar,
B.d56_prev_item  varchar,
B.d56_succ_item  varchar,
B.d56_conv_factor_ceu  double,
B.d56_conv_factor_desc  varchar,
B.d56_form  varchar,
B.d56_pack_code_desc  varchar,
B.d56_product_group  varchar,
B.d56_product_group_desc  varchar,
B.d56_product_group_subgroup  varchar,
B.d56_product_group_sbgrp_desc  varchar,
B.d56_product_line  varchar,
B.d56_product_line_desc  varchar,
B.d56_prod_subline  varchar,
B.d56_prod_subline_desc  varchar,
B.abt_internal_source  varchar,
A.source_loc  varchar,
A.pur_item_no  varchar,
A.pur_uom  varchar,
A.stock_uom  varchar,
A.sell_uom  varchar,
B.pur_stock_conv  double,
B.sell_stock_conv  double,
B.storage_type  varchar,
B.source_loc_email  varchar,
B.prodmgr_email  varchar,
B.comdir_email  varchar,
B.sample  varchar,
B.udc_deleteme  double,
B.attribute1  varchar,
B.attribute2  varchar,
B.attribute3  varchar,
B.attribute4  varchar,
B.attribute5  varchar,
B.attribute6  varchar,
B.attribute7  varchar,
B.aff_level1  varchar,
B.aff_level2  varchar,
B.aff_level3  varchar,
B.aff_level4  varchar,
B.aff_level5  varchar,
B.aff_level6  varchar,
B.aff_level7  varchar,
B.warehouse_to  varchar,
B.orig_item_no  varchar,
B.aff_group_code  varchar,
B.aff_group_desc  varchar,
B.class_code  varchar,
B.ss_tolerance  varchar,
B.replen_per_year double,
B.inc_order_qty  double,
B.shelf_life_days  double,
B.std_batch_size  double,
B.case_per_pal  double,
B.case_uom  varchar,
B.case_dim_volume  double,
B.case_dim_length  double,
B.case_dim_width  double,
B.case_dim_height  double,
B.case_weight double,
B.pallet_uom  varchar,
B.pallet_dim  double,
B.pallet_weight  double,
B.case_per_tl_pal  double,
B.case_per_tl_nopal  double,
B.case_per_cl_pal  double,
B.case_per_cl_nopal  double,
B.leadtime_published  double,
B.inactive_item  varchar,
B.delete_item  varchar,
B.new_item  varchar,
B.lot_control  varchar,
B.lot_size  integer,
B.manufcycle_time  integer,
B.master_sched_code  varchar,
B.min_order_qty  integer,
B.min_balance  integer,
B.planner_code  varchar,
B.planning_code  varchar,
B.wh_stock_code  varchar,
B.postponement  varchar,
B.order_policy_code  varchar,
B.order_setup_cost  integer,
B.dosage_form  varchar,
B.leadtime_replenish  double,
B.leadtime_mfg double,
B.leadtime_pur  double,
B.leadtime_customs  double,
B.leadtime_qa  double,
B.leadtime_testing  double,
B.leadtime_actual  double,
B.rec_id  varchar,
B.rec_num  double,
B.edit_ck_ok  varchar,
B.edit_code  varchar,
B.edit_err_type  varchar,
B.edit_err_cnt  double,
B.aff_ins_user  varchar,
B.aff_ins_date_time  varchar,
B.bt_edit_user  varchar,
B.bt_edit_date_time  varchar,
B.bt_maint_user  varchar,
B.bt_maint_date_time  varchar,
B.wm_last_upd_by  varchar,
B.wm_created_by  varchar,
B.wm_last_upd_date  varchar,
B.wm_creation_date  varchar,
B.wm_record_type  varchar,
B.hq_edit_date  varchar,
B.hq_edit_process_id  varchar,
B.hq_error_code  varchar,
B.hq_error_count  double,
B.hq_status  varchar,
B.datamart_last_upd_by  varchar,
B.datamart_last_upd_date  varchar,
B.gl_inv_division  varchar,
B.gl_sales_division  varchar,
B.gl_inv_performance  varchar,
B.gl_sales_performance  varchar,
B.invoice_location  varchar,
B.reporting_affiliate  varchar,
A.sending_location  varchar,
B.item_type_id  integer,
A.std_cost_currency  varchar,
B.transfer_price  double,
B.other_icb_cost  double,
B.plan_year_tran_price  double,
B.plan_year_other_icb_cost  double,
B.plan_year_std_cost double,
B.balance_sheet_item  varchar,
B.intran_days_to_planning_oh  varchar,
B.forcast_financial_inventory  varchar,
B.item_comment_franchise  varchar,
B.item_comment_site  varchar,
loc  varchar not null,
A.item_code  varchar,
B.orig_item_code  varchar,
B.item_dist_type  varchar,          
prod_type       varchar not null,
CONSTRAINT pk PRIMARY KEY (item_no,loc,prod_type) )  SALT_BUCKETS = 3,COMPRESSION='SNAPPY';



CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].STG_LOC_HIERARCHY (
B.level_1_id  integer,
B.level_1_code  varchar,
B.level_1_desc  varchar,
B.level_1_label_id  integer,
B.level_1_label_desc  varchar,
B.level_2_id  integer,
B.level_2_code  varchar,
B.level_2_desc  varchar,
B.level_2_label_id  integer,
B.level_2_label_desc  varchar,
B.level_3_id  integer,
B.level_3_code  varchar,
B.level_3_desc  varchar,
B.level_3_label_id  integer,
B.level_3_label_desc  varchar,
B.level_4_id  integer,
B.level_4_code  varchar,
B.level_4_desc  varchar,
B.level_4_label_id  integer,
B.level_4_label_desc  varchar,
B.level_5_id  integer,
B.level_5_code  varchar,
B.level_5_desc  varchar,
B.level_5_label_id  integer,
B.level_5_label_desc  varchar,
B.level_6_id  integer,
B.level_6_code  varchar,
B.level_6_desc  varchar,
B.level_6_label_id integer,
B.level_6_label_desc  varchar,
B.level_7_id  integer,
A.level_7_code  varchar,
A.level_7_desc  varchar,
B.level_7_label_id  integer,
B.level_7_label_desc  varchar,
B.level_8_id  integer,
A.level_8_code  varchar,
A.level_8_desc  varchar,
B.level_8_label_id  integer,
B.level_8_label_desc  varchar,
B.level_9_id  integer,
A.level_9_code  varchar,
A.level_9_desc  varchar,
B.level_9_label_id  integer,
B.level_9_label_desc  varchar,
B.level_10_id  integer,
level_10_code  varchar,
A.level_10_desc  varchar,
B.level_10_label_id  integer,
B.level_10_label_desc  varchar,
B.loc_type_id  integer,
B.loc_type_code  varchar,
B.loc_type_desc  varchar,
B.loc_distr_type_id  integer,
B.loc_distr_type_code  varchar,
B.loc_distr_type_desc  varchar,
B.model_id  integer,
B.loh_adjustment  varchar,
B.home_currency  varchar,
B.intl_loc  varchar,
B.fiscal_cal_id  integer,
B.fiscal_cal_desc  varchar,
B.fin_acctng_mths_4_4_5  integer,
B.record_flag  varchar,
B.delete_flag  varchar,
B.forecast_month  integer,
B.historical_months  integer,
B.gl_entity  varchar,
B.business_group  varchar,
B.business_group_desc  varchar,
division  varchar not null,
B.division_desc  varchar,
B.area  varchar,
B.area_desc  varchar,
B.sub_area  varchar,
B.sub_area_desc  varchar,
B.region  varchar,
B.region_desc  varchar,
B.sub_region  varchar,
B.sub_region_desc  varchar,
B.intl_domestic  varchar,
B.intl_domestic_desc  varchar,
B.mfg_distribution  varchar,
B.mfg_distribution_desc  varchar,
A.location_type  varchar,
B.location_type_desc  varchar,
A.affiliate  varchar,
A.affiliate_desc  varchar,
B.sub_affiliate  varchar,
B.sub_affiliate_desc  varchar,
loc  varchar not null,
B.loc_desc  varchar,
B.other  varchar,
B.other_desc  varchar,
B.created_by  varchar,
B.creation_date  varchar,
B.last_upd_by  varchar,
B.last_upd_date  varchar,
B.datamart_last_upd_by  varchar,
B.datamart_last_upd_date  varchar,
B.wh_level_plng_flag  varchar,
B.sending_schd_ship_flag  varchar,
B.allow_icb_method_for_intransit  varchar,
B.major_source_system  varchar,
B.reporting_affiliate_default  varchar,
B.gl_sales_division_default  varchar,
B.gl_inv_performance_default  varchar,
B.gl_sales_performance_default  varchar,
B.invoice_location_default  varchar,
B.alter_plant_default  varchar,
B.wip_cost_method  varchar,
B.inv_rptg_currency  varchar,
CONSTRAINT pk PRIMARY KEY (level_10_code,division,loc) )  SALT_BUCKETS = 3,COMPRESSION='SNAPPY';



CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].EXCHANGE_RATE_D(
date_fk  integer not null,
B.dm_load_time  varchar,
B.dm_load_user  varchar,
B.dm_update_time  varchar,
B.dm_update_user  varchar,
B.posting_agent_insert  varchar,
conversion_from_code  varchar,
conversion_to_code  varchar,
B.converstion_from_descr  varchar,
B.converstion_to_descr  varchar,
A.plan_avg_exchange_rate  double,
A.plan_book_exchange_rate  double,
A.update_avg_exchange_rate  double,
A.update_book_exchange_rate  double,
A.actual_avg_exchange_rate  double,
A.actual_book_exchange_rate  double,
B.fb_avg_exchange_rate  double,
B.fb_book_exchange_rate  double,
B.act_cur_month_exchange_rate  double,
B.plan_avg_default_exch_rate  double,
B.plan_book_default_exch_rate  double,
B.update_avg_default_exch_rate  double,
B.update_book_default_exch_rate  double,
A.major_business  varchar,
B.constant_avg_exchange_rate  double,
B.constant_book_exchange_rate  double,
B.lbe_avg_exchange_rate  double,
B.lbe_book_exchange_rate  double,
B.const_nyp_avg_exchange_rate double,
B.const_nyp_book_exchange_rate  double,
B.pyr_avg_exchange_rate  double,
B.pyr_book_exchange_rate double,
exchange_rate_f_pk  integer not null,
CONSTRAINT pk PRIMARY KEY (date_fk,conversion_from_code,conversion_to_code,exchange_rate_f_pk)) SALT_BUCKETS = 3,COMPRESSION='SNAPPY';



CREATE TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].USR_PERMISSION_MASTER (
usr_id  integer,
A.usr_frst_nm  varchar,
A.usr_lst_nm  varchar,
A.usr_mddl_nm  varchar,
A.usr_scm_id  varchar,
A.headquater_user  varchar,
B.created_by  varchar,
B.created_date  varchar,
B.last_upd_by  varchar,
B.last_upd_date  varchar,
B.usr_country  varchar,
B.active_user  varchar,
B.last_access_date  varchar,
B.ops_user  varchar,
A.usr_eml_id varchar,
CONSTRAINT pk PRIMARY KEY (usr_id) )  SALT_BUCKETS = 3,COMPRESSION='SNAPPY';

CREATE  TABLE IF NOT EXISTS [[APP_HBASE_DB_NAME]].SCP_WEB_USR_ACCESS_VW(
loc                     varchar,
usr_scm_id              varchar,
screen_name             varchar,
CONSTRAINT pk PRIMARY KEY (loc,usr_scm_id,screen_name) )  SALT_BUCKETS = 3,COMPRESSION='SNAPPY';



CREATE  TABLE IF NOT EXISTS  [[APP_HBASE_DB_NAME]].PRCS_BSNS_DAY_CAL (
calendar_dt  varchar not null,           
bsns_day_num  integer not null,        
bsns_cycle_id  integer,         
bsns_day_cal_desc varchar,      
created_by varchar,             
created_dt  varchar,            
gir_reconciliation_end_date varchar,    
last_upd_by  varchar,      
last_upd_date varchar,
CONSTRAINT pk PRIMARY KEY (calendar_dt,bsns_day_num) )  SALT_BUCKETS = 3,COMPRESSION='SNAPPY';

