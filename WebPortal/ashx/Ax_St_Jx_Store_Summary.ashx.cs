using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using Leyp.Components;
using Leyp.SQLServerDAL;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Leyp.Components.Module;//獲取登錄的用戶名

namespace WebPortal.ashx
{
    /// <summary>
    /// Summary description for Ax_St_Jx_Store_Summary
    /// </summary>
    public class Ax_St_Jx_Store_Summary : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {
        private SQLHelp sh = new SQLHelp();
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            //context.Response.Write("Hello World");
            string type = context.Request["paraa"].ToString();
            if (type == "update")
                UpdateProcessNew(context);
            else if (type == "get_prd_item")
                GetPrdItem(context);
            else if (type == "get_store_transfer")
                GetStoreTransfer(context);
            else if (type == "delete")
                deleteProcess(context);
            else if (type == "get_mat_request")
                GetMatRequest(context);
            else if (type == "store_request_add")
                StoreRequestAdd(context);
            else if (type == "get_store_request_details")
                GetStoreRequestDetails(context);
            else if (type == "delete_store_request_details")
                DeleteStoreRequestDetails(context);
            else if (type == "update_store_request_details")
                UpdateStoreRequestDetails(context);
            else
                GetItem(context);
        }
        
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public void GetItem(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Loc_no = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "", Prd_cdesc = "";
            string Zero_flag = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Loc_no = ja[0]["Loc_no"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Prd_cdesc = ja[0]["Prd_cdesc"].ToString().Trim();
                Zero_flag = ja[0]["Zero_flag"].ToString().Trim();
            }
            else
            {
                Loc_no = context.Request["Loc_no"] != null ? context.Request["Loc_no"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Prd_cdesc = context.Request["Prd_cdesc"] != null ? context.Request["Prd_cdesc"] : "";
                Zero_flag = context.Request["Zero_flag"] != null ? context.Request["Zero_flag"] : "";
            }
            //if (Loc_no == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Prd_cdesc == "")
            //{

            //}
            //else
            //{
                string strSql = "usp_st_jx_store_summary";
                SqlParameter[] parameters = {new SqlParameter("@Loc_no", Loc_no)
                                        ,new SqlParameter("@Prd_mo_from", Prd_mo_from), new SqlParameter("@Prd_mo_to", Prd_mo_to)
                                        ,new SqlParameter("@Prd_item_from", Prd_item_from), new SqlParameter("@Prd_cdesc", Prd_cdesc)
                                        , new SqlParameter("@zero_flag", Zero_flag)
                                        };

                DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);


                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            //}
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        public void GetMatRequest(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Loc_no = "";
            string Date_from = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "", Prd_item_to = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Loc_no = ja[0]["Loc_no"].ToString().Trim();
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Prd_item_to = ja[0]["Prd_item_to"].ToString().Trim();
            }
            else
            {
                Loc_no = context.Request["Loc_no"] != null ? context.Request["Loc_no"] : "";
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Prd_item_to = context.Request["Prd_item_to"] != null ? context.Request["Prd_item_to"] : "";
            }
            if (Loc_no == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Prd_item_to == "")
            {
                //Loc_no = "ZZZ";
            }
            else
            {
                string strSql = "usp_st_jx_store_request";
                SqlParameter[] parameters = {new SqlParameter("@Loc_no", Loc_no)
                    ,new SqlParameter("@Date_from", Date_from)
                    ,new SqlParameter("@Prd_mo_from", Prd_mo_from), new SqlParameter("@Prd_mo_to", Prd_mo_to)
                    ,new SqlParameter("@Prd_item_from", Prd_item_from), new SqlParameter("@Prd_item_to", Prd_item_to)
                    };

                DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);


                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }
        public void GetStoreTransfer(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            BasePage bp = new BasePage();
            string ReturnValue = string.Empty;
            string Loc_no = "";
            string Date_from = "", Date_to = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "", Prd_item_to = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Loc_no = ja[0]["Loc_no"].ToString().Trim();
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Prd_item_to = ja[0]["Prd_item_to"].ToString().Trim();
            }
            else
            {
                Loc_no = context.Request["Loc_no"] != null ? context.Request["Loc_no"] : "";
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Prd_item_to = context.Request["Prd_item_to"] != null ? context.Request["Prd_item_to"] : "";
            }
            if (Loc_no == "" && Date_from == "" && Date_to == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Prd_item_to == "")
            {

            }
            else
            {
                string strSql = "usp_st_jx_store_transfer";
                SqlParameter[] parameters = {new SqlParameter("@Loc_no", Loc_no)
                    ,new SqlParameter("@Date_from", Date_from), new SqlParameter("@Date_to", Date_to)
                    ,new SqlParameter("@Prd_mo_from", Prd_mo_from), new SqlParameter("@Prd_mo_to", Prd_mo_to)
                    ,new SqlParameter("@Prd_item_from", Prd_item_from), new SqlParameter("@Prd_item_to", Prd_item_to)
                    };

                DataTable dt = SQLHelper.ExecuteProcedureRetrunDataTable(strSql, parameters);


                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }

        protected void UpdateProcessNew(HttpContext context)
        {
            BasePage bp = new BasePage();
            string para = context.Request["param"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string result = "";
            string Flag_id = ja[0]["Flag_id"].ToString().Trim();
            string Transfer_date = ja[0]["Transfer_date"].ToString().Trim();
            string Prd_mo = ja[0]["Prd_mo"].ToString().Trim();
            string Prd_item = ja[0]["Prd_item"].ToString().Trim();
            string Lot_no = ja[0]["Lot_no"].ToString().Trim();
            string Loc_no = ja[0]["Loc_no"].ToString().Trim();
            string Wip_id = ja[0]["Wip_id"].ToString().Trim();
            decimal Qty = ja[0]["Qty"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Qty"].ToString().Trim()) : 0;
            decimal Weg = ja[0]["Weg"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Weg"].ToString().Trim()) : 0;
            string Use_item = ja[0]["Use_item"].ToString().Trim();
            string RequestNo = ja[0]["RequestNo"].ToString().Trim();
            string crusr = bp.getUserName();
            string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:ss:mm");
            DataTable dtFlag = GetFlag(Flag_id);
            string flag1 = dtFlag.Rows[0]["flag1"].ToString().Trim();
            string flag2= dtFlag.Rows[0]["flag2"].ToString().Trim();

            bool valid_flag = true;
            result = chkDataValid(Loc_no, Prd_item, Prd_mo, Lot_no, flag1, Weg, Qty);
            if (result != "")
                valid_flag = false;
            else
            {
                if (flag2 == "TO")
                {
                    result = chkDataValid(Wip_id, Prd_item, Prd_mo, Lot_no, "+", Weg, Qty);
                    if (result != "")
                        valid_flag = false;
                }
            }
            if (Flag_id == "01" && RequestNo != "")
            {
                result = chkRequestNoValid(RequestNo);
                if (result != "")
                    valid_flag = false;
            }
            if (valid_flag == true)
            {
                string strSql = "";
                string id = GenID(Loc_no, Flag_id, Transfer_date);
                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");
                strSql += string.Format(@"Insert Into st_jx_store_transfer (id,flag_id,transfer_date,Loc_no,prd_item,prd_mo,lot_no,wip_id,use_item,transfer_qty,transfer_weg,request_no,crusr,crtim) Values " +
                    "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}','{13}')"
                    , id, Flag_id, Transfer_date, Loc_no, Prd_item, Prd_mo, Lot_no, Wip_id, Use_item, Qty, Weg, RequestNo, crusr, crtim);
                strSql += string.Format(joinUpdateStr(Loc_no, Prd_item, Prd_mo, Lot_no, flag1, Weg, Qty, crusr, crtim));
                if (flag2 == "TO")
                    strSql += string.Format(joinUpdateStr(Wip_id, Prd_item, Prd_mo, Lot_no, "+", Weg, Qty, crusr, crtim));
                if (Flag_id == "01" && RequestNo != "")//如果是From DG收貨，則更新申請單的收貨數量
                    strSql += string.Format(joinUpdateRequestStr("+",RequestNo, Weg, Qty, crusr, crtim));

                strSql += string.Format(@" COMMIT TRANSACTION ");

                result = sh.ExecuteSqlUpdate(strSql);
            }
            if (result == "")
                result = "記錄更新成功!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }
        

        protected string chkDataValid(string Loc_no, string Prd_item, string Prd_mo, string Lot_no, string flag1, decimal Weg, decimal Qty)
        {
            string result = "";
            decimal wh_rec_qty = 0, wh_rec_weg = 0, wh_out_qty = 0, wh_out_weg = 0;
            DataTable dtStore1 = CehckStore(Loc_no, Prd_item, Prd_mo, Lot_no);
            if (dtStore1.Rows.Count > 0)
            {

                wh_rec_weg = dtStore1.Rows[0]["wh_rec_weg"].ToString() != "" ? Convert.ToDecimal(dtStore1.Rows[0]["wh_rec_weg"].ToString()) : 0;
                wh_rec_qty = dtStore1.Rows[0]["wh_rec_qty"].ToString() != "" ? Convert.ToDecimal(dtStore1.Rows[0]["wh_rec_qty"].ToString()) : 0;
                wh_out_weg = dtStore1.Rows[0]["wh_out_weg"].ToString() != "" ? Convert.ToDecimal(dtStore1.Rows[0]["wh_out_weg"].ToString()) : 0;
                wh_out_qty = dtStore1.Rows[0]["wh_out_qty"].ToString() != "" ? Convert.ToDecimal(dtStore1.Rows[0]["wh_out_qty"].ToString()) : 0;
            }
            if (flag1 == "+")
            {
                if (wh_rec_weg + Weg < wh_out_weg || wh_rec_weg + Weg < 0)
                {
                    result = "倉庫發貨重量已大於收貨重量，操作無效!";
                }
                else if (wh_rec_qty + Qty < wh_out_qty || wh_rec_qty + Qty < 0)
                {
                    result = "倉庫發貨數量已大於收貨數量，操作無效!";
                }
            }
            else
            {
                if (dtStore1.Rows.Count == 0)
                    result = "沒有倉存記錄!";
                {
                    if (wh_out_weg + Weg > wh_rec_weg || wh_out_weg + Weg < 0)
                    {
                        result = "發貨重量已大於倉存重量!";
                    }
                    else if (wh_out_qty + Qty > wh_rec_qty || wh_out_qty + Qty < 0)
                    {
                        result = "發貨數量已大於倉存數量!";
                    }
                }
            }
            return result;
        }


        //檢查是否存在來料申請記錄
        protected string chkRequestNoValid(string RequestNo)
        {
            string result = "";
            string strSql = "Select id From st_jx_store_request Where id='" + RequestNo + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count == 0)
                result = "來料申請單號不存在!";
            return result;
        }

        protected string joinUpdateStr(string Loc_no, string Prd_item, string Prd_mo, string Lot_no, string flag1, decimal Weg, decimal Qty,string crusr,string crtim)
        {
            string strSql = "";
            DataTable dtStore = CehckStore(Loc_no, Prd_item, Prd_mo, Lot_no);
            decimal wh_rec_qty = 0, wh_rec_weg = 0, wh_out_qty = 0, wh_out_weg = 0;
            if (dtStore.Rows.Count > 0)
            {

                wh_rec_weg = dtStore.Rows[0]["wh_rec_weg"].ToString() != "" ? Convert.ToDecimal(dtStore.Rows[0]["wh_rec_weg"].ToString()) : 0;
                wh_rec_qty = dtStore.Rows[0]["wh_rec_qty"].ToString() != "" ? Convert.ToDecimal(dtStore.Rows[0]["wh_rec_qty"].ToString()) : 0;
                wh_out_weg = dtStore.Rows[0]["wh_out_weg"].ToString() != "" ? Convert.ToDecimal(dtStore.Rows[0]["wh_out_weg"].ToString()) : 0;
                wh_out_qty = dtStore.Rows[0]["wh_out_qty"].ToString() != "" ? Convert.ToDecimal(dtStore.Rows[0]["wh_out_qty"].ToString()) : 0;
            }
            if(flag1=="+")
            {
                wh_rec_weg = wh_rec_weg + Weg;
                wh_rec_qty = wh_rec_qty + Qty;
            }
            else
            {
                wh_out_weg = wh_out_weg + Weg;
                wh_out_qty = wh_out_qty + Qty;
            }
            if (dtStore.Rows.Count == 0)
                strSql += string.Format(@"Insert Into st_jx_store_summary (Loc_no,Prd_item,Prd_mo,Lot_no,wh_rec_qty,wh_rec_weg,wh_out_qty,wh_out_weg,crusr,crtim) Values " +
                "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}')"
                , Loc_no, Prd_item, Prd_mo, Lot_no, wh_rec_qty, wh_rec_weg, wh_out_qty, wh_out_weg, crusr, crtim);
            else
                strSql += string.Format(@"Update st_jx_store_summary Set wh_rec_qty='{0}',wh_rec_weg='{1}',wh_out_qty='{2}',wh_out_weg='{3}'" +
                    ",crusr='{4}',crtim='{5}'" +
                " Where Loc_no='{6}' And Prd_item='{7}' And Prd_mo='{8}' And Lot_no='{9}'"
                , wh_rec_qty, wh_rec_weg, wh_out_qty, wh_out_weg, crusr, crtim, Loc_no, Prd_item, Prd_mo, Lot_no);

            return strSql;
        }

        //更新來料申請數量字符串
        protected string joinUpdateRequestStr(string flag1,string RequestNo, decimal Weg, decimal Qty, string crusr, string crtim)
        {
            decimal rec_qty = Qty;
            decimal rec_weg = Weg;
            if(flag1=="-")
            {
                rec_qty = 0 - Qty;
                rec_weg = 0 - Weg;
            }
            string strSql = "";
            strSql += string.Format(@"Update st_jx_store_request Set rec_qty=rec_qty+'{0}',rec_weg=rec_weg+'{1}',crusr='{2}',crtim='{3}'" +
            " Where id='{4}'"
            , Qty, Weg, crusr, crtim, RequestNo);

            return strSql;
        }

        protected void deleteProcess(HttpContext context)
        {
            BasePage bp = new BasePage();
            string ID = context.Request["ID"];
            DataTable dtTransfer = FindDataByID(ID);
            DataRow dr = dtTransfer.Rows[0];
            string result = "";
            string Flag_id = dr["Flag_id"].ToString().Trim();
            string Prd_mo = dr["Prd_mo"].ToString().Trim();
            string Prd_item = dr["Prd_item"].ToString().Trim();
            string Lot_no = dr["Lot_no"].ToString().Trim();
            string Loc_no = dr["Loc_no"].ToString().Trim();
            string Wip_id = dr["Wip_id"].ToString().Trim();
            decimal Weg = 0 - (dr["Transfer_weg"].ToString().Trim() != "" ? Convert.ToDecimal(dr["Transfer_weg"].ToString().Trim()) : 0);
            decimal Qty = 0 - (dr["Transfer_qty"].ToString().Trim() != "" ? Convert.ToDecimal(dr["Transfer_qty"].ToString().Trim()) : 0);
            string RequestNo = dr["request_no"].ToString().Trim();
            string crusr = bp.getUserName();
            string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:ss:mm");
            DataTable dtFlag = GetFlag(Flag_id);
            string flag1 = dtFlag.Rows[0]["flag1"].ToString().Trim();
            string flag2 = dtFlag.Rows[0]["flag2"].ToString().Trim();
            bool valid_flag = true;
            result = chkDataValid(Loc_no, Prd_item, Prd_mo, Lot_no, flag1, Weg, Qty);
            if (result != "")
                valid_flag = false;
            else
            {
                if (flag2 == "TO")
                {
                    result = chkDataValid(Wip_id, Prd_item, Prd_mo, Lot_no, "+", Weg, Qty);
                    if (result != "")
                        valid_flag = false;
                }
            }

            if (valid_flag == true)
            {
                string strSql = "";
                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");
                strSql += string.Format(@"Delete From st_jx_store_transfer Where ID='{0}'", ID);
                strSql += string.Format(joinUpdateStr(Loc_no, Prd_item, Prd_mo, Lot_no, flag1, Weg, Qty, crusr, crtim));
                if (flag2 == "TO")
                    strSql += string.Format(joinUpdateStr(Wip_id, Prd_item, Prd_mo, Lot_no, "+", Weg, Qty, crusr, crtim));
                if (Flag_id == "01" && RequestNo != "")//如果是From DG收貨，則更新申請單的收貨數量
                    strSql += string.Format(joinUpdateRequestStr("-", RequestNo, Weg, Qty, crusr, crtim));
                //strSql += string.Format(@" IF @@error <> 0 ");
                //strSql += string.Format(@" ROLLBACK TRANSACTION ");
                //strSql += string.Format(@" ELSE ");
                strSql += string.Format(@" COMMIT TRANSACTION ");

                result = sh.ExecuteSqlUpdate(strSql);
            }
            if (result == "")
                result = "記錄已刪除!";
            //return result;
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }



        //產生ID編號
        protected string GenID(string Loc_no,string Flag_id,string Transfer_date)
        {
            string result = "";
            //產生自動單號
            string ID1, ID2;
            ID1 = Loc_no + Flag_id;
            ID2 = ID1 + "-" + Transfer_date.Substring(2, 2) + Transfer_date.Substring(5, 2) + Transfer_date.Substring(8, 2) + "9999";
            string Seq = "";
            string strSql = "Select MAX(ID) AS max_id From st_jx_store_transfer Where ID>='" + ID1 + "' And ID<='" + ID2 + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count > 0)
                Seq = dt.Rows[0]["max_id"].ToString() != "" ? (Convert.ToInt32(dt.Rows[0]["max_id"].ToString().Substring(12, 4)) + 1).ToString().PadLeft(4, '0') : "0001";
            else
                Seq = "0001";
            result = Loc_no + Flag_id + "-" + Transfer_date.Substring(2, 2) + Transfer_date.Substring(5, 2) + Transfer_date.Substring(8, 2) + Seq;
            return result;
        }
        protected DataTable FindDataByID(string ID)
        {
            string strSql = "";
            strSql = "Select * From st_jx_store_transfer Where ID='" + ID + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }

        protected DataTable GetFlag(string Flag_id)
        {
            string strSql = "";
            strSql = "Select flag_id,flag_cdesc,flag0,flag1,flag2,fields1,fields2 From bs_flag_desc Where doc_type='" + "st_jx_stransfer_flag" + "' And flag_id='" + Flag_id + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        protected DataTable CehckStore(string Loc_no, string Prd_item,string  Prd_mo, string Lot_no)
        {
            string strSql = "";
            strSql = "Select * From st_jx_store_summary Where Loc_no='" + Loc_no + "' And Prd_item='" + Prd_item + "' And Prd_mo='" + Prd_mo + "' And Lot_no='" + Lot_no + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            return dt;
        }
        public void GetPrdItem(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string Prd_item = context.Request["Prd_item"] != null ? context.Request["Prd_item"] : "";
            string strSql = "Select id,name As goods_name From geo_it_goods Where id='" + Prd_item + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格

            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }


        protected void StoreRequestAdd(HttpContext context)
        {
            BasePage bp = new BasePage();
            string para = context.Request["param"];
            JArray ja = (JArray)JsonConvert.DeserializeObject(para);
            string result = "";
            string Request_date = ja[0]["Request_date"].ToString().Trim();
            string Prd_mo = ja[0]["Prd_mo"].ToString().Trim();
            string Prd_item = ja[0]["Prd_item"].ToString().Trim();
            string Lot_no = ja[0]["Lot_no"].ToString().Trim();
            string Loc_no = ja[0]["Loc_no"].ToString().Trim();
            decimal Qty = ja[0]["Qty"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Qty"].ToString().Trim()) : 0;
            decimal Weg = ja[0]["Weg"].ToString().Trim() != "" ? Convert.ToDecimal(ja[0]["Weg"].ToString().Trim()) : 0;
            string crusr = bp.getUserName();
            string crtim = System.DateTime.Now.ToString("yyyy/MM/dd HH:ss:mm");
            string strSql = "";
            string id = GenRequestID(Loc_no, Request_date);
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            strSql += string.Format(@"Insert Into st_jx_store_request (id,request_date,Loc_no,prd_item,prd_mo,lot_no,request_qty,request_weg,crusr,crtim) Values " +
                "('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}')"
                , id, Request_date, Loc_no, Prd_item, Prd_mo, Lot_no, Qty, Weg, crusr, crtim);

            strSql += string.Format(@" COMMIT TRANSACTION ");

            result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
                result = "記錄更新成功!";
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        //產生ID編號
        protected string GenRequestID(string Loc_no, string Request_date)
        {
            string result = "";
            //產生自動單號
            string ID1, ID2;
            ID1 = Loc_no;
            ID2 = ID1 + "-" + Request_date.Substring(2, 2) + Request_date.Substring(5, 2) + Request_date.Substring(8, 2) + "9999";
            string Seq = "";
            string strSql = "Select MAX(ID) AS max_id From st_jx_store_request Where ID>='" + ID1 + "' And ID<='" + ID2 + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count > 0)
                Seq = dt.Rows[0]["max_id"].ToString() != "" ? (Convert.ToInt32(dt.Rows[0]["max_id"].ToString().Substring(10, 4)) + 1).ToString().PadLeft(4, '0') : "0001";
            else
                Seq = "0001";
            result = Loc_no + "-" + Request_date.Substring(2, 2) + Request_date.Substring(5, 2) + Request_date.Substring(8, 2) + Seq;
            return result;
        }

        public void GetStoreRequestDetails(HttpContext context)
        {
            clsPublic cls = new clsPublic();
            string ReturnValue = string.Empty;
            string Loc_no = "";
            string Date_from = "", Date_to = "";
            string Prd_mo_from = "", Prd_mo_to = "";
            string Prd_item_from = "", Prd_item_to = "";
            string Cpl_flag = "";
            string para = context.Request["param"];
            if (para != null)
            {
                JArray ja = (JArray)JsonConvert.DeserializeObject(para);
                Loc_no = ja[0]["Loc_no"].ToString().Trim();
                Date_from = ja[0]["Date_from"].ToString().Trim();
                Date_to = ja[0]["Date_to"].ToString().Trim();
                Prd_mo_from = ja[0]["Prd_mo_from"].ToString().Trim();
                Prd_mo_to = ja[0]["Prd_mo_to"].ToString().Trim();
                Prd_item_from = ja[0]["Prd_item_from"].ToString().Trim();
                Prd_item_to = ja[0]["Prd_item_to"].ToString().Trim();
                Cpl_flag = ja[0]["Cpl_flag"].ToString().Trim();
            }
            else
            {
                Loc_no = context.Request["Loc_no"] != null ? context.Request["Loc_no"] : "";
                Date_from = context.Request["Date_from"] != null ? context.Request["Date_from"] : "";
                Date_to = context.Request["Date_to"] != null ? context.Request["Date_to"] : "";
                Prd_mo_from = context.Request["Prd_mo_from"] != null ? context.Request["Prd_mo_from"] : "";
                Prd_mo_to = context.Request["Prd_mo_to"] != null ? context.Request["Prd_mo_to"] : "";
                Prd_item_from = context.Request["Prd_item_from"] != null ? context.Request["Prd_item_from"] : "";
                Prd_item_to = context.Request["Prd_item_to"] != null ? context.Request["Prd_item_to"] : "";
                Cpl_flag = context.Request["Cpl_flag"] != null ? context.Request["Cpl_flag"] : "";
            }
            if (Loc_no == "" && Date_from == "" && Date_to == "" && Prd_mo_from == "" && Prd_mo_to == "" && Prd_item_from == "" && Prd_item_to == "")
            {

            }
            else
            {
                string strSql = "Select a.*,b.name AS prd_item_cdesc" +
                    " From st_jx_store_request a " +
                    " Left Join geo_it_goods b ON a.prd_item=b.id" +
                    " Where a.id>=''";
                if (Loc_no != "")
                    strSql += " And a.Loc_no='" + Loc_no + "'";
                if (Date_from != "" && Date_to != "")
                    strSql += " And a.request_date>='" + Date_from + "' And a.request_date<='" + Date_to + "'";
                if (Prd_mo_from != "" && Prd_mo_to != "")
                    strSql += " And a.prd_mo>='" + Prd_mo_from + "' And a.prd_mo<='" + Prd_mo_to + "'";
                if (Prd_item_from != "" && Prd_item_to != "")
                    strSql += " And a.prd_item>='" + Prd_item_from + "' And a.prd_item<='" + Prd_item_to + "'";
                if (Cpl_flag == "0")
                    strSql += " And a.cpl_flag='" + Cpl_flag + "'";
                strSql += " Order By a.request_date Desc,a.id";
                DataTable dt = SQLHelper.ExecuteSqlReturnDataTable(strSql);


                ReturnValue = cls.DataTableJsonReturnExcel(dt);//提取記錄，返回給表格
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(ReturnValue);
            context.Response.End();
        }


        protected void DeleteStoreRequestDetails(HttpContext context)
        {
            string result = "";
            string id = context.Request["id"];
            result = FindRequestNoFromTransfer(id);
            if (result == "")
            {
                string strSql = "";
                strSql += string.Format(@" SET XACT_ABORT  ON ");
                strSql += string.Format(@" BEGIN TRANSACTION ");
                strSql += string.Format(@"Delete From st_jx_store_request Where ID='{0}'", id);
                strSql += string.Format(@" COMMIT TRANSACTION ");

                result = sh.ExecuteSqlUpdate(strSql);

                if (result == "")
                    result = "記錄已刪除!";
            }
            //return result;
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        protected void UpdateStoreRequestDetails(HttpContext context)
        {
            string result = "";
            string ID = context.Request["id"];

            string strSql = "";
            strSql += string.Format(@" SET XACT_ABORT  ON ");
            strSql += string.Format(@" BEGIN TRANSACTION ");
            strSql += string.Format(@"Update st_jx_store_request Set cpl_flag='{0}' Where ID='{1}'", "1", ID);
            strSql += string.Format(@" COMMIT TRANSACTION ");

            result = sh.ExecuteSqlUpdate(strSql);

            if (result == "")
                result = "記錄已更新!";
            //return result;
            context.Response.ContentType = "text/plain";
            context.Response.Write(result);
            context.Response.End();
        }

        //刪除來料申請時，檢查是否存在收貨記錄，若存在則不能刪除
        protected string FindRequestNoFromTransfer(string id)
        {
            string result = "";
            string strSql = "";
            strSql = "Select id,request_no From st_jx_store_transfer Where request_no='" + id + "'";
            DataTable dt = sh.ExecuteSqlReturnDataTable(strSql);
            if (dt.Rows.Count > 0)
                result = "存在收貨記錄，不能刪除!" + dt.Rows[0]["id"].ToString().Trim();
            return result;
        }

    }
}