namespace Leyp.SQLServerDAL.Sales
{
    using Leyp.Model.Sales;
    using Leyp.SQLServerDAL;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;

    public class SalesQueryPublicDAL
    {
        public DataTable getMoGroup()
        {
            string strSql;
            strSql = "select group_id,group_desc from bs_mo_group order by group_id ";
            DataTable dtMoGroup = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtMoGroup;
        }

        public DataTable getMoStatusFlag()
        {
            string strSql;
            strSql = "select flag_id,flag_desc from bs_flag_desc Where doc_type='CP' AND flag0='Y' order by flag_id ";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }

        public DataTable getOrderTraceFlag(string doc_type)
        {
            string strSql;
            strSql = "select flag_id,flag_desc from bs_flag_desc Where doc_type='" + doc_type + "' AND so_order_trace='Y' order by flag_id ";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            dt.Rows.Add();
            dt.DefaultView.Sort = "flag_id";
            return dt;
        }

        public DataTable getOcStatus(int source_type, string user_id, string cp_state, string mo_group, string crdate1, string crdate2
            ,string crby, string date1, string date2, string mo1, string mo2, string brand1, string brand2, string cust1, string cust2,string own1,string own2, string showapart)
        {

            SqlParameter[] parameters = { new SqlParameter("@source_type", source_type)
                                        ,new SqlParameter("@user_id", user_id)
                                        ,new SqlParameter("@cp_state", cp_state)
                                        ,new SqlParameter("@mo_group", mo_group)
                                        ,new SqlParameter("@crdat1", crdate1), new SqlParameter("@crdat2", crdate2)
                                        ,new SqlParameter("@crby", crby)
                                        ,new SqlParameter("@dat1", date1), new SqlParameter("@dat2", date2)
                                        , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
                                        , new SqlParameter("@brand1", brand1), new SqlParameter("@brand2", brand2)
                                        , new SqlParameter("@cust1", cust1), new SqlParameter("@cust2", cust2)
                                        , new SqlParameter("@own1", own1), new SqlParameter("@own2", own2)
                                        , new SqlParameter("@showapart", showapart)};

            DataTable dtOc = SQLHelper.ExecuteProcedureRetrunDataTable("usp_GetOcStatus", parameters);
            return dtOc;
        }

        public DataTable getOcDepWaitTime(string fdep, string dat1, string dat2)
        {
            SqlParameter[] parameters = {new SqlParameter("@fdep", fdep)
                        ,new SqlParameter("@dat1", dat1)
                        ,new SqlParameter("@dat2", dat2)
                        };
            DataTable dtTranRec = SQLHelper.ExecuteProcedureRetrunDataTable("usp_dep_no_tran", parameters);
            return dtTranRec;
        }

        //查找制單生產追蹤表
        public DataTable getOrderTrace(int type, string user_id, string sales_group, string crdate1, string crdate2
            , string mo1, string mo2, string cust1, string cust2, string oc1, string oc2, string po1, string po2
            , string mo_status, string prd_status, string ret_hk_status
            , string sample_hk_status, string chk_color_status, string job_no_status)
        {

            SqlParameter[] parameters = { new SqlParameter("@type", type)
                ,new SqlParameter("@cr_date1", crdate1), new SqlParameter("@cr_date2", crdate2)
                , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
                , new SqlParameter("@cust1", cust1), new SqlParameter("@cust2", cust2)
                ,new SqlParameter("@user_id", user_id),new SqlParameter("@sales_group", sales_group)
                , new SqlParameter("@oc1", oc1), new SqlParameter("@oc2", oc2)
                , new SqlParameter("@po1", po1), new SqlParameter("@po2", po2)
                , new SqlParameter("@mo_status", mo_status), new SqlParameter("@prd_status", prd_status)
                , new SqlParameter("@ret_hk_status", ret_hk_status), new SqlParameter("@sample_hk_status", sample_hk_status)
                , new SqlParameter("@chk_color_status", chk_color_status), new SqlParameter("@job_no_status", job_no_status)
                };

            DataTable dtOc = SQLHelper.ExecuteProcedureRetrunDataTable("usp_so_order_trace", parameters);
            return dtOc;
        }



        //查找制單生產追蹤表
        public List<SaOrderTrace> getOrderTraceList(int type, string user_id, string sales_group, string crdate1, string crdate2
            , string mo1, string mo2, string cust1, string cust2, string oc1, string oc2, string mo_status, string prd_status, string ret_hk_status
            , string sample_hk_status, string chk_color_status, string job_no_status)
        {

            List<SaOrderTrace> list = new List<SaOrderTrace>();
            
            SqlParameter[] parameters = { new SqlParameter("@type", type)
                ,new SqlParameter("@cr_date1", crdate1), new SqlParameter("@cr_date2", crdate2)
                , new SqlParameter("@mo1", mo1), new SqlParameter("@mo2", mo2)
                , new SqlParameter("@cust1", cust1), new SqlParameter("@cust2", cust2)
                ,new SqlParameter("@user_id", user_id),new SqlParameter("@sales_group", sales_group)
                , new SqlParameter("@oc1", oc1), new SqlParameter("@oc2", oc2)
                , new SqlParameter("@mo_status", mo_status), new SqlParameter("@prd_status", prd_status)
                , new SqlParameter("@ret_hk_status", ret_hk_status), new SqlParameter("@sample_hk_status", sample_hk_status)
                , new SqlParameter("@chk_color_status", chk_color_status), new SqlParameter("@job_no_status", job_no_status)
                };

            DataTable dtOc = SQLHelper.ExecuteProcedureRetrunDataTable("usp_so_order_trace", parameters);
            for (int i = 0; i < dtOc.Rows.Count; i++)
            {
                SaOrderTrace item = new SaOrderTrace();
                DataRow dr = dtOc.Rows[i];
                item.id = dr["id"].ToString();
                item.order_date = dr["order_date"].ToString();
                item.it_customer = dr["it_customer"].ToString();
                list.Add(item);
            }
            return list;
        }

        public string updOrderTrace(string within_code, string mo_id, string prd_status
            , string ret_hk_status, string sample_hk_status, string chk_color_status, string chk_color_oth, string chk_color_date, string job_no
            ,string test_result, string test_status, string inv_no,string inv_date, string shipment,string shipment_oth, string awb_no, string sent_date
            , string remark, string mo_status)
        {



            string result = "";
            SQLHelp sh = new SQLHelp();
            string strSql ="";
            if (findOorderTrace(within_code, mo_id) == 0)
                strSql = "Insert Into so_order_trace (within_code,mo_id, prd_status,ret_hk_status, sample_hk_status, chk_color_status, chk_color_oth" +
                    ", chk_color_date, job_no,test_result, test_status, inv_no,inv_date, shipment,shipment_oth, awb_no, sent_date, remark, mo_status)"+
                    " Values ("
                    + "'" + within_code + "'" + "," + "'" + mo_id + "'" + "," + "'" + prd_status + "'" + "," + "'" + ret_hk_status + "'" + "," + "'" + sample_hk_status + "'"
                     + "," + "'" + chk_color_status + "'" + "," + "'" + chk_color_oth + "'" + "," + "'" + chk_color_date + "'" + "," + "'" + job_no + "'"
                      + "," + "'" + test_result + "'" + "," + "'" + test_status + "'" + "," + "'" + inv_no + "'" + "," + "'" + inv_date + "'" + "," + "'" + shipment + "'" + "," + "'" + shipment_oth + "'"
                      + "," + "'" + awb_no + "'" + "," + "'" + sent_date + "'" + "," + "'" + remark + "'" + "," + "'" + mo_status + "'"
                    +")";
            else
                strSql = "Update so_order_trace Set "
                    + "prd_status=" + "'" + prd_status + "'" + ",ret_hk_status=" + "'" + ret_hk_status + "'" + ",sample_hk_status=" + "'" + sample_hk_status + "'"
                    + ",chk_color_status=" + "'" + chk_color_status + "'" + ",chk_color_oth=" + "'" + chk_color_oth + "'" + ",chk_color_date=" + "'"
                    + chk_color_date + "'" + ",job_no=" + "'" + job_no + "'"+ ",test_result=" + "'" + test_result + "'" + ",test_status=" + "'" + test_status + "'"
                     + ",inv_no=" + "'" + inv_no + "'" + ",inv_date=" + "'" + inv_date + "'"
                    + ",shipment=" + "'" + shipment + "'" + ",shipment_oth=" + "'" + shipment_oth + "'"
                    + ",awb_no=" + "'" + awb_no + "'" + ",sent_date=" + "'" + sent_date + "'" + ",remark=" + "'" + remark + "'" + ",mo_status=" + "'" + mo_status + "'"
                    + " Where within_code='" + within_code + "' And mo_id='" + mo_id + "'";
            result = sh.ExecuteSqlUpdate(strSql);
            return result;
            
        }
        private int findOorderTrace(string within_code, string mo_id)
        {
            SQLHelp sh = new SQLHelp();
            string strSql="Select mo_id From so_order_trace Where within_code='"+within_code+"' AND mo_id='"+mo_id+"'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            int result = dt.Rows.Count;
            return result;
        }

        //查找制單檢驗記錄表
        public DataTable getMoTest(string mo_id)
        {

            SqlParameter[] parameters = { new SqlParameter("@mo_id", mo_id)
                };

            DataTable dtOc = SQLHelper.ExecuteProcedureRetrunDataTable("usp_mo_view_test", parameters);
            return dtOc;
        }


        public DataTable getCpFlag()
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "Select flag_id,flag_desc From bs_flag_desc Where doc_type='" + "CP" + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }

        public DataTable getDep()
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "Select dep_id,Rtrim(dep_id)+'--'+Rtrim(dep_cdesc) AS dep_cdesc From bs_dep Order By dep_id";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            dt.Rows.Add();
            dt.DefaultView.Sort = "dep_id";
            return dt;
        }
        public DataTable getJxDep()
        {
            SQLHelp sh = new SQLHelp();
            //string remote_db = "dgerp2.cferp.dbo.";
            //string strSql = "Select id,id+'--'+name AS name From "+remote_db+ "cd_department Where id='J03' OR id='J82' OR id='J86' Order By id";
            string strSql = "Select dep_id AS id,Rtrim(dep_id)+'--'+Rtrim(dep_cdesc) AS name From bs_dep Where dep_group='JX' Order By dep_id";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            dt.Rows.Add();
            dt.DefaultView.Sort = "id";
            return dt;
        }
        public DataTable getWork_type()
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "Select work_type_id,Rtrim(work_type_id)+'--'+Rtrim(work_type_desc) AS work_type_desc" +
                " From dgcf_pad.dbo.work_type Order By work_type_id";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            //dt.Rows.Add();
            //dt.DefaultView.Sort = "work_type_id";
            return dt;
        }
    }
}
