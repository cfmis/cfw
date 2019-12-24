using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;


namespace Leyp.SQLServerDAL.Sales
{
    

    public class SaOrderTestTraceDAL
    {
        private string within_code = "0000";
        private string remote_db = "dgerp2.cferp.dbo.";
        public DataTable getOcByMo(string mo_id)
        {
            string strSql;
            strSql = "select a.season,b.mo_id,b.goods_id,b.customer_goods AS cust_item,b.customer_color_id AS cust_color,b.customer_size AS cust_size"+
                ",b.add_remark,b.brand_id AS division,d.english_name AS mat_desc " +
                " From " + remote_db + "so_order_manage a" +
                " Inner Join " + remote_db + "so_order_details b On a.within_code=b.within_code AND a.id=b.id AND a.ver=b.ver" +
                " Inner Join "+remote_db+"it_goods c On b.within_code=c.within_code AND b.goods_id=c.id"+
                " Left Join "+remote_db+ "cd_datum d On c.within_code=d.within_code AND c.datum=d.id"+
                " Where b.within_code='" + within_code + "' AND b.mo_id='" + mo_id + "'";
            DataTable dtOc = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtOc;
        }
        public DataTable getRecByMo(string mo_group,string date_from,string date_to,string mo_id,string ref_no,string item,string color,string size,string season)
        {
            string strSql;
            strSql = "select a.*,b.edesc AS lab_house_desc" +
                " From so_ordertest_trace a " +
                " Left Join so_ordertest_trace_lab b On a.lab_house=b.id " +
                " Where a.mo_id>=''";
            if (mo_group != "")
                strSql += " And a.mo_group='" + mo_group + "'";
            if (mo_id != "")
                strSql += " And a.mo_id='" + mo_id + "'";
            if (date_from != "" && date_to != "")
                strSql += " And a.rt_from_date>='" + date_from + "' And a.rt_from_date<'" + date_to + "'";
            if (mo_id != "")
                strSql += " And a.mo_id like '%" + mo_id + "%'";
            if (ref_no != "")
                strSql += " And a.ref_no like '%" + ref_no + "%'";
            if (item != "")
                strSql += " And a.cust_item like '%" + item + "%'";
            if (color != "")
                strSql += " And a.color like '%" + color + "%'";
            if (size != "")
                strSql += " And a.cust_size like '%" + size + "%'";
            if (season != "")
                strSql += " And a.season like '%" + season + "%'";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;



            //SqlParameter[] parameters = { new SqlParameter("@mo_group", mo_group)
            //    ,new SqlParameter("@date_from", date_from), new SqlParameter("@date_to", date_to)
            //    , new SqlParameter("@mo_id", mo_id)
            //    };

            //DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable("usp_so_ordertest_trace", parameters);
            //return dt;
        }
        
        
        
        
        public string updOrderTestTrace(string mo_id,string mo_group, string rt_from_date, string ref_no,string lab_house,string mat_desc
            ,string cust_item, string cust_size, string cust_color, string season, string division, string test_method
            , string bulk_mo, string sent_to_hk, string pass_to_lab, string test_results, string rsl, string rsl_rp_date
            , string appearance, string appearance_rp_date, string resist, string resist_rp_date, string salvia, string salvia_rp_date
            , string snap, string snap_rp_date, string underpart, string underpart_rp_date, string ftc_cmmts)
        {

           
            string result = "";
            SQLHelp sh = new SQLHelp();
            string strSql = "";
            if (findOorderTrace(mo_id) == 0)
                strSql = "Insert Into so_ordertest_trace (mo_id,mo_group,rt_from_date, ref_no,lab_house,mat_desc,cust_item,cust_size,cust_color,season,division,test_method" +
                    ",bulk_mo,sent_to_hk,pass_to_lab,test_results,rsl,rsl_rp_date,appearance,appearance_rp_date,resist,resist_rp_date,salvia,salvia_rp_date" +
                    ",snap,snap_rp_date,underpart,underpart_rp_date,ftc_cmmts)" +
                    " Values ("
                     + "'" + mo_id + "','" + mo_group + "','" + rt_from_date + "','" + ref_no + "','" + lab_house + "','" + mat_desc
                     + "','"  + cust_item + "','" + cust_size + "','" + cust_color + "','" + season
                     + "','" + division + "','" + test_method + "','" + bulk_mo + "','" + sent_to_hk
                     + "','" + pass_to_lab + "','" + test_results + "','" + rsl + "','" + rsl_rp_date
                     + "','" + appearance + "','" + appearance_rp_date + "','" + resist + "','" + resist_rp_date
                     + "','" + salvia + "','" + salvia_rp_date + "','" + snap + "','" + snap_rp_date
                     + "','" + underpart + "','" + underpart_rp_date + "','" + ftc_cmmts + "'"
                    + ")";
            else
                strSql = "Update so_ordertest_trace Set "
                    + "mo_group='" + mo_group + "'" + ",rt_from_date='" + rt_from_date + "'" + ",ref_no='" + ref_no + "'" + ",lab_house='" + lab_house + "'"
                    + ",mat_desc='" + mat_desc + "'" + ",cust_item='" + cust_item + "'" + ",cust_size='" + cust_size + "'"
                    + ",cust_color='" + cust_color + "'" + ",season='" + season + "'" + ",division='" + division + "'"
                    + ",test_method='" + test_method + "'" + ",bulk_mo='" + bulk_mo + "'" + ",sent_to_hk='" + sent_to_hk + "'"
                    + ",pass_to_lab='" + pass_to_lab + "'" + ",test_results='" + test_results + "'" + ",rsl='" + rsl + "'"
                    + ",rsl_rp_date='" + rsl_rp_date + "'" + ",appearance='" + appearance + "'" + ",appearance_rp_date='" + appearance_rp_date + "'"
                    + ",resist='" + resist + "'" + ",resist_rp_date='" + resist_rp_date + "'" + ",salvia='" + salvia + "'"
                    + ",salvia_rp_date='" + salvia_rp_date + "'" + ",snap='" + snap + "'" + ",snap_rp_date='" + snap_rp_date + "'"
                     + ",underpart='" + underpart + "'" + ",underpart_rp_date='" + underpart_rp_date + "'" + ",ftc_cmmts='" + ftc_cmmts + "'"
                    + " Where mo_id='" + mo_id + "'";
            result = sh.ExecuteSqlUpdate(strSql);
            return result;

        }


        private int findOorderTrace(string mo_id)
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "Select mo_id From so_ordertest_trace Where mo_id='" + mo_id + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            int result = dt.Rows.Count;
            return result;
        }


        public string updOrderTestInvoice(string invoice_id, string invoice_date, string report_no, string amount, string curr
            , string ref_report,string mo_id,string custcode,string brand)
        {


            string result = "";
            SQLHelp sh = new SQLHelp();
            string strSql = "";
            if (findOorderInvoice(invoice_id) == 0)
                strSql = "Insert Into so_ordertest_invoice (invoice_id,invoice_date,report_no,amount,curr,ref_report,mo_id,custcode,brand)" +
                    " Values ("
                     + "'" + invoice_id + "','" + invoice_date + "','" + report_no + "','" + amount + "','" + curr + "','" + ref_report + "','"
                     + mo_id + "','" + custcode + "','" + brand + "'"
                    + ")";
            else
                strSql = "Update so_ordertest_invoice Set " +
                    "invoice_date='" + invoice_date + "'" + ",report_no='" + report_no + "'" + ",amount='" + amount + "'"
                    + ",curr='" + curr + "'" + ",ref_report='" + ref_report + "'" + ",mo_id='" + mo_id + "'" + ",custcode='" + custcode + "'"
                     + ",brand='" + brand + "'"
                    + " Where invoice_id='" + invoice_id + "'";
            result = sh.ExecuteSqlUpdate(strSql);
            return result;

        }

        private int findOorderInvoice(string invoice_id)
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "Select invoice_id From so_ordertest_invoice Where invoice_id='" + invoice_id + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            int result = dt.Rows.Count;
            return result;
        }

        public DataTable getInvoiceData(string date_from,string date_to, string invoice_id,string mo_id,string custcode,string mo_group,string brand)
        {
            string strSql;
            strSql = "select a.* " +
                " From so_ordertest_invoice a " +
                " Where a.invoice_id>=''";

            if (date_from != "" && date_to != "")
                strSql += " And a.invoice_date>='" + date_from + "' And a.invoice_date<'" + date_to + "'";
            if (invoice_id != "")
                strSql += " And a.invoice_id like '%" + invoice_id + "%'";
            if (mo_id != "")
                strSql += " And a.mo_id like '%" + mo_id + "%'";
            if (custcode != "")
                strSql += " And a.custcode like '%" + custcode + "%'";
            if (mo_group != "")
                strSql += " And Substring(a.mo_id,3,1) = '" + mo_group + "'";
            if (brand != "")
                strSql += " And a.brand like '%" + brand + "%'";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;



            //SqlParameter[] parameters = { new SqlParameter("@mo_group", mo_group)
            //    ,new SqlParameter("@date_from", date_from), new SqlParameter("@date_to", date_to)
            //    , new SqlParameter("@mo_id", mo_id)
            //    };

            //DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable("usp_so_ordertest_trace", parameters);
            //return dt;
        }


        public string deleteTestInvoice(string invoice_id)
        {

            string result = "";
            SQLHelp sh = new SQLHelp();
            string strSql = "";

            strSql = "Delete From so_ordertest_invoice Where invoice_id='" + invoice_id + "'";
            result = sh.ExecuteSqlUpdate(strSql);
            return result;

        }


    }
}
