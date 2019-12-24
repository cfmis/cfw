using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Leyp.SQLServerDAL;

namespace Leyp.Components
{
    public class Logic
    {
        public StringBuilder GetMenu(string user,string lang_id)
        {


            StringBuilder strb1 = new StringBuilder();


            //DataSet ds = new DataSet();
            //DataSet dsson = new DataSet();
            //ds = GetFatherID(user, connection);
            DataTable dtAuth = GetFatherID(user,lang_id);
            for (int i = 0; i < dtAuth.Rows.Count; i++)
            {
                //if (display == ds.Tables[0].Rows[i]["DisplayName"].ToString())
                //{ strb1.Append(@" <li class=""submenu""> <a href=""#""><i class=""" + ds.Tables[0].Rows[i]["Class"].ToString() + @"""></i> <span>" + ds.Tables[0].Rows[i]["DisplayName"].ToString() + @"</span></a>"); }
                //else { strb1.Append(@" <li class=""submenu""> <a href=""#""><i class=""" + ds.Tables[0].Rows[i]["Class"].ToString() + @"""></i> <span>" + ds.Tables[0].Rows[i]["DisplayName"].ToString() + @"</span></a>"); }

                DataTable dtUserFunc = GetSonID(user, dtAuth.Rows[i]["AuthorityID"].ToString(), lang_id);
                if (dtUserFunc.Rows.Count > 0)
                {

                    strb1.Append(@" <dd>
                               <div class=""title"">
                                 <span><img src=""" + dtAuth.Rows[i]["Class"].ToString() + @""" /></span>" + dtAuth.Rows[i]["DisplayName"].ToString() + @"
                                </div>
                                <ul class=""menuson"">");


                    //dsson = GetSonID(user, dtAuth.Rows[i]["TypeID"].ToString());

                    // <li><cite></cite><a href="right.html" target="rightFrame">个人资料</a><i></i></li>

                    for (int s = 0; s < dtUserFunc.Rows.Count; s++)
                    {
                        strb1.Append(@"<li><cite></cite><a href=""" + dtUserFunc.Rows[s]["WebUrl"].ToString() + @"""  target=""MainFrame"">" + dtUserFunc.Rows[s]["DisplayName"].ToString() + @"</a><i></i></li>");
                    }
                    strb1.Append(@"</ul></dd>");
                }
                
            }
            return strb1;
        }


        public StringBuilder GetMenu_New(string user, string lang_id)
        {


            StringBuilder strb1 = new StringBuilder();


            //DataSet ds = new DataSet();
            //DataSet dsson = new DataSet();
            //ds = GetFatherID(user, connection);
            DataTable dtAuth = GetFatherID(user, lang_id);
            for (int i = 0; i < dtAuth.Rows.Count; i++)
            {
                //if (display == ds.Tables[0].Rows[i]["DisplayName"].ToString())
                //{ strb1.Append(@" <li class=""submenu""> <a href=""#""><i class=""" + ds.Tables[0].Rows[i]["Class"].ToString() + @"""></i> <span>" + ds.Tables[0].Rows[i]["DisplayName"].ToString() + @"</span></a>"); }
                //else { strb1.Append(@" <li class=""submenu""> <a href=""#""><i class=""" + ds.Tables[0].Rows[i]["Class"].ToString() + @"""></i> <span>" + ds.Tables[0].Rows[i]["DisplayName"].ToString() + @"</span></a>"); }

                DataTable dtUserFunc = GetSonID(user, dtAuth.Rows[i]["AuthorityID"].ToString(), lang_id);
                if (dtUserFunc.Rows.Count > 0)
                {

                    strb1.Append(@" <dd>
                               <div class=""title"">
                                 <span><img src=""" + dtAuth.Rows[i]["Class"].ToString().Trim() + @""" /></span>" + dtAuth.Rows[i]["DisplayName"].ToString().Trim() + @"
                                </div>
                                <ul class=""menuson"">");


                    //dsson = GetSonID(user, dtAuth.Rows[i]["TypeID"].ToString());

                    // <li><cite></cite><a href="right.html" target="rightFrame">个人资料</a><i></i></li>
                    
                    for (int s = 0; s < dtUserFunc.Rows.Count; s++)
                    {
                        string DisplayName = dtUserFunc.Rows[s]["DisplayName"].ToString();
                        //TabName是不能有空格的
                        string TabName = DisplayName.Replace(" ", "");// 'T' + dtUserFunc.Rows[s]["AuthorityId"].ToString();
                        //strb1.Append(@"<li><cite></cite><a href=""" + dtUserFunc.Rows[s]["WebUrl"].ToString() + @"""  target=""MainFrame"">" + dtUserFunc.Rows[s]["DisplayName"].ToString() + @"</a><i></i></li>");
                        strb1.Append(@"<li><cite></cite><a href=""" + "#" + @"""  onclick="+"addTab("+"'"+TabName+"'"+","+ "'"+dtUserFunc.Rows[s]["WebUrl"].ToString()+"'" +")>" + DisplayName + @"</a><i></i></li>");
                    }
                    strb1.Append(@"</ul></dd>");
                }

            }
            return strb1;
        }

        private DataTable GetFatherID(string emp,string lang_id)
        {
//            string strSQL = @"select * from Access a,Authority b 
//                                where a.ID2=b.FatherID and a.ID1=b.ProgramID
//                                and b.Name='" + emp + "' and ID2='0'  order by ID1   ";
            string strSql = "SELECT a.uname,a.t_groupid,b.AuthorityID,c.TypeID,c.Class,d.AuthorityName AS DisplayName" +
                " FROM tb_sy_user a" +
                " INNER JOIN t_GroupAuthority b ON a.t_GroupID=b.GroupID" +
                " INNER JOIN t_Authority c ON b.AuthorityID=c.AuthorityID" +
                " INNER JOIN t_AuthorityLang d ON c.AuthorityID=d.AuthorityID" +
                " WHERE a.Uname='" + emp + "' AND c.TypeID='99' AND d.LangID='" + lang_id + "'" +
                " ORDER BY c.OrderSeq";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            
            //DataSet ds = new DataSet();
            //SqlDataAdapter adapter = new SqlDataAdapter(strSQL, Connection);
            //if (Connection.State == System.Data.ConnectionState.Closed)
            //{
            //    Connection.Open();
            //}
            //adapter.Fill(ds);
            //Connection.Close();
            return dt;
        }

        private DataTable GetSonID(string emp, string id2,string lang_id)
        {

            
//            string strSQL = @"select * from Access a,Authority b 
//                                where a.ID2=b.FatherID and a.ID1=b.ProgramID
//                                and b.Name='" + emp + "' and ID2='" + id2 + "'  order by ID1   ";
//            DataSet ds = new DataSet();
//            SqlDataAdapter adapter = new SqlDataAdapter(strSQL, Connection);
//            if (Connection.State == System.Data.ConnectionState.Closed)
//            {
//                Connection.Open();
//            }
//            adapter.Fill(ds);
//            Connection.Close();
//            return ds;


            string strSql = "SELECT a.uname,a.t_groupid,b.AuthorityID,c.TypeID,c.WebUrl,c.Class,d.AuthorityName AS DisplayName" +
                " FROM tb_sy_user a" +
                " INNER JOIN t_GroupAuthority b ON a.t_GroupID=b.GroupID" +
                " INNER JOIN t_Authority c ON b.AuthorityID=c.AuthorityID" +
                " INNER JOIN t_AuthorityLang d ON c.AuthorityID=d.AuthorityID" +
                " WHERE a.Uname='" + emp + "' AND c.TypeID='" + id2 + "' AND d.LangID='"+lang_id+"'" +
                " ORDER BY c.OrderSeq";
            DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);
            return dt;


        }

    }
}
