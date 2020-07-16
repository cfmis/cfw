using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using Leyp.Model;

namespace Leyp.SQLServerDAL
{
    public class BaseDataDAL
    {
        private string remote_db = "dgerp2.cferp.dbo.";
        public DataTable getUnit()
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "";
            strSql = "Select unit_id,unit_desc,unit_cdesc " +
                    " From bs_unit Where unit_flag='A' Or unit_flag='0' Order By unit_id ";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;

        }
        public DataTable getSeason()
        {
            SQLHelp sh = new SQLHelp();
            string strSql = "";
            strSql = "Select id,edesc,cdesc " +
                    " From bs_season Order By id ";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;

        }
        public DataTable getMoGroup()
        {
            string strSql;
            strSql = "select mo_group From bs_group group by mo_group";
            DataTable dtMoGroup = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtMoGroup;
        }
        public DataTable getOcMoGroup()
        {
            string strSql;
            strSql = "select group_id,group_desc from bs_mo_group order by group_id ";
            DataTable dtMoGroup = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtMoGroup;
        }
        public DataTable getMoGroup_para(string id)
        {
            string strSql;
            strSql = "select mo_group From bs_group where mo_group='" + id + "'" + " group by mo_group";
            DataTable dtMoGroup = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtMoGroup;
        }
        public DataTable getCurr()
        {
            string strSql;
            strSql = "select curr_id,curr_cdesc,curr_desc From bs_curr order by curr_id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        public DataTable getOcTest()
        {
            string strSql;
            strSql = "select id,edesc,cdesc From so_ordertest_trace_test order by id";
            DataTable dtOcTest = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtOcTest;
        }
        public DataTable getOcLab()
        {
            string strSql;
            strSql = "select id,edesc,cdesc From so_ordertest_trace_lab order by id";
            DataTable dtOcLab = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtOcLab;
        }
        
        public DataTable getOrderCustByLoginUser(string uname)
        {
            string strSql;
            strSql = "select a.custcode,b.custname,b.custcname" +
                " From so_cust_user a " +
                " Inner Join bs_customer b On a.custcode=b.custcode" +
                " Where a.uname='" + uname + "'";
            DataTable dtUser = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtUser;
        }
        public DataTable getSa_Oc_NoCompleteOc()
        {
            string strSql;
            strSql = "select flag_id,flag_desc From bs_flag_desc where doc_type='Sa_Oc_NoCompleteOc' order by flag_id";
            DataTable dtOcLab = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtOcLab;
        }

        public DataTable get_season()
        {
            string strSql;
            strSql = "select id from " + remote_db + "cd_season order by id ";
            DataTable dtSeason = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtSeason;
        }
        public DataTable get_MatData(string val)
        {
            string strSql = "Select id,name As mat_cdesc,english_name As mat_desc,datum From " + remote_db + "cd_datum" +
                " Where id>='' ";
            if (val != "")
                strSql += " And ( "
                    + " id Like " + "'%" + val + "%'"
                    + " Or name Like " + "'%" + val + "%'"
                    + " Or english_name Like " + "'%" + val + "%'"
                    + " )";
            //else
            //    strSql += " And id='" + val + "'";
            strSql += "Order By id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        public DataTable get_PrdType(string val)
        {
            string strSql = "Select id,name As prd_type_cdesc,english_name As prd_type_desc From " + remote_db + "cd_goods_class" +
                " Where id>='' ";
            if (val != "")
                strSql += " And ( "
                    + " id Like " + "'%" + val + "%'"
                    + " Or name Like " + "'%" + val + "%'"
                    + " Or english_name Like " + "'%" + val + "%'"
                    + " )";
            else
                strSql += " And id='" + val + "'";
            strSql += "Order By id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        public DataTable get_unit()
        {
            string strSql;
            strSql = "select id from " + remote_db + "cd_units where kind='05' order by id ";
            DataTable dtSeason = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dtSeason;
        }
        public DataTable get_funcgroup()
        {
            string strSql;
            strSql = "select groupid,Convert(Varchar(10),groupid)+'--'+groupname AS groupname from t_group Where rst='1' order by groupid ";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        //營業員組別
        public DataTable get_salesgroup()
        {
            string strSql;
            strSql = "select grp_code,grp_cdesc from bs_group order by grp_code ";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        //語言選擇
        public DataTable get_lang(string doc_type)
        {
            string strSql;
            strSql = "select flag_id,flag_id+'--'+flag_desc AS flag_desc from bs_flag_desc where doc_type='" + doc_type + "'" + " order by flag_id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }

        //Geo系統用戶組
        public DataTable get_geousergroup()
        {
            string strSql;
            strSql = "select group_id from " + remote_db + "sys_user" +
                " where group_id<>'**' And group_id<>'DG_ALL' And group_id<>'ADMIN'" +
                " group by group_id order by group_id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }

        //提取單據的標識
        public DataTable get_docflag(string doc_type)
        {
            string strSql;
            strSql = "select flag_id,flag_id+'--'+flag_desc AS flag_desc from bs_flag_desc where doc_type='" + doc_type + "'" + " order by flag_id";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        //獲取訂單的完成標識
        public DataTable getMoStatusFlag()
        {
            string strSql;
            strSql = "select flag_id,flag_desc from bs_flag_desc Where doc_type='CP' AND flag0='Y' order by flag_id ";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
    }
}
