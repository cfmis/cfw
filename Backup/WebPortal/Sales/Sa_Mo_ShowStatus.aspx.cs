using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Leyp.SQLServerDAL;
using Leyp.Components;
using Leyp.Components.Module;

namespace WebPortal.Sales
{
    public partial class Sa_Mo_ShowStatus : BasePage//System.Web.UI.Page//
    {
        private string within_code = Base.within_code;
        private SQLHelp sh = new SQLHelp();
        private string get_mo_id = "";
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if (Request.QueryString["to_mo_id"] != null)
                {
                    get_mo_id = Request.QueryString["to_mo_id"];
                    txtMo.Text = get_mo_id;
                }
            }
            DataBind();
        }
        protected void txtMo_TextChanged(object sender, EventArgs e)
        {
            
        }
        protected void DataBind()
        {
            FindMoOc();
            FindByMoWip();
            MoOutgoingStatus();
            FindMoReturn();
            FindMoInv();
            FindMoStore();
            FindMoRedo();
        }
        protected void FindMoOc()
        {
            //imgZp.ImageUrl = "";
            string strSql = "Select a.id,a.it_customer,c.name AS cust_name,a.seller_id,a.merchandiser,e.name AS sales_name"+
                ",(b.order_qty*f.rate) AS order_qty" +
                ",b.goods_unit,b.goods_id,b.remark,b.plate_remark,d.production_remark" +
                " FROM dbo.so_order_manage a" +
                " INNER JOIN dbo.so_order_details b ON a.within_code=b.within_code AND a.id=b.id AND a.ver=b.ver"+
                " LEFT JOIN dbo.it_customer c ON a.within_code=c.within_code AND a.it_customer=c.id" +
                " LEFT JOIN dbo.So_order_special_info d ON b.within_code=d.within_code AND b.id=d.id AND b.ver=d.ver AND b.sequence_id=d.upper_sequence" +
                " LEFT JOIN dbo.cd_personnel e ON a.within_code=e.within_code AND a.merchandiser=e.id" +
                " INNER JOIN it_coding f ON b.within_code=f.within_code AND b.goods_unit=f.unit_code"+
                " WHERE b.within_code='" + within_code + "' AND f.id='" + "*" + "' AND b.mo_id='" + txtMo.Text.ToUpper() + "'";
            DataTable tbOc = sh.ExecuteSqlReturnDataTableGeo(strSql);
            if (tbOc.Rows.Count > 0)
            {
                txtOcNo.Text = tbOc.Rows[0]["id"].ToString();
                txtSales.Text = tbOc.Rows[0]["sales_name"].ToString();
                txtCustCode.Text = tbOc.Rows[0]["it_customer"].ToString();
                txtCustDesc.Text = tbOc.Rows[0]["cust_name"].ToString();
                txtOrder_qty.Text = (tbOc.Rows[0]["order_qty"].ToString() != "" ? Convert.ToInt32(tbOc.Rows[0]["order_qty"]).ToString() : "");
                txtGoods_unit.Text = "PCS";// tbOc.Rows[0]["goods_unit"].ToString();
                txtRemark.Text = tbOc.Rows[0]["remark"].ToString();
                txtProd_Remark.Text = tbOc.Rows[0]["production_remark"].ToString();
                txtPlate_Remark.Text = tbOc.Rows[0]["plate_remark"].ToString();
                //string strImagePath = DBUtility.imageDetaultPath + cls.clsPublic.GetImagePath(tbOc.Rows[0]["goods_id"].ToString());
                //strImagePath = "Y://Artwork//AAAAA//A888001.bmp";
                //imgZp.ImageUrl = strImagePath;
            }
            else
            {
                txtRemark.Text = "";
                txtProd_Remark.Text = "";
                txtPlate_Remark.Text = "";
            }
        }
        protected void FindByMoWip()
        {
            string mo_id = txtMo.Text.Trim().ToUpper();
            //string strSql = "SELECT a.mo_id, b.flag,b.goods_state,b.transfers_state,b.goods_id" +
            //    ",CONVERT(VARCHAR(20),b.f_complete_date,120) AS f_complete_date,CONVERT(VARCHAR(20),b.t_complete_date,111) AS t_complete_date" +
            //    ",b.prod_qty, b.c_qty_ok,b.wp_id,d.name AS wp_name, b.next_wp_id" +
            //    ",e.name AS next_wp_name,b.state, b.hold,c.name AS goods_name" +
            //    " FROM dbo.jo_bill_mostly a " +
            //    " INNER JOIN dbo.jo_bill_goods_details b " +
            //    " ON  a.within_code = b.within_code AND  a.id = b.id AND  a.ver = b.ver" +
            //    " LEFT JOIN dbo.it_goods c ON b.within_code=c.within_code AND b.goods_id=c.id" +
            //    " LEFT JOIN dbo.cd_department d ON b.within_code=d.within_code AND b.wp_id=d.id" +
            //    " LEFT JOIN dbo.cd_department e ON b.within_code=e.within_code AND b.next_wp_id=e.id" +
            //    " WHERE  a.within_code = '" + within_code + "' AND  a.mo_id = '" + mo_id + "'";
            string sqlstr = "usp_ShowMoStatus";
            int tb_type = 1;
            SqlParameter[] parameters = { new SqlParameter("@tb_type", tb_type), new SqlParameter("@mo_id", mo_id), new SqlParameter("@goods_id", "") };
            DataTable tbWip = sh.ExecuteProcedure(sqlstr, parameters);
            if (tbWip.Rows.Count > 0)
            {
                string state = "";
                int prod_qty, c_qty_ok;
                for (int i = 0; i < tbWip.Rows.Count; i++)
                {
                    prod_qty = (tbWip.Rows[i]["prod_qty"].ToString() != "" ? Convert.ToInt32(tbWip.Rows[i]["prod_qty"]) : 0);
                    c_qty_ok = (tbWip.Rows[i]["c_qty_ok"].ToString() != "" ? Convert.ToInt32(tbWip.Rows[i]["c_qty_ok"]) : 0);
                    state = tbWip.Rows[i]["mo_state"].ToString();
                    if (state == "G")
                        tbWip.Rows[i]["mo_state"] = "強制完成";
                    else
                        if (c_qty_ok >= prod_qty && prod_qty != 0)
                            tbWip.Rows[i]["mo_state"] = "完成";
                        else
                            if (prod_qty > c_qty_ok && prod_qty != 0)
                                tbWip.Rows[i]["mo_state"] = "未完成";
                            else
                                tbWip.Rows[i]["mo_state"] = "";
                    tbWip.Rows[i]["prod_qty"] = prod_qty.ToString();
                    tbWip.Rows[i]["c_qty_ok"] = c_qty_ok.ToString();

                }
                txtBill_date.Text = tbWip.Rows[0]["bill_date"].ToString();
                txtRec_hk_date.Text = tbWip.Rows[0]["rec_hk_date"].ToString();
                txtCust_req_date.Text = tbWip.Rows[0]["cust_req_date"].ToString();
            }
            else
            {
                tbWip.Rows.Add();
                txtBill_date.Text = "";
                txtRec_hk_date.Text = "";
                txtCust_req_date.Text = "";
            }
            gvDetails.DataSource = tbWip.DefaultView;
            gvDetails.DataBind();
            for (int i = 0; i < gvDetails.Rows.Count; i++)
            {
                if (gvDetails.Rows[i].Cells[2].Text == "Y")
                    gvDetails.Rows[i].BackColor = System.Drawing.Color.FromArgb(0xFF, 0x33, 0x00);
            }
            if (gvDetails.Rows.Count > 1)
                ShowImage(gvDetails.Rows[0].Cells[7].Text);
        }


        protected void MoOutgoingStatus()
        {
            string sqlstr = "usp_ShowMoStatus";
            int tb_type = 2;
            string mo_id = txtMo.Text.Trim().ToUpper();
            string goods_id = txtItem.Text.Trim();
            SqlParameter[] parameters = { new SqlParameter("@tb_type", tb_type), new SqlParameter("@mo_id", mo_id), new SqlParameter("@goods_id", goods_id) };
            DataSet dsOut = sh.ExecutePrdReturnDataSet(sqlstr, parameters);
            DataTable tbOut = dsOut.Tables[0];
            if (tbOut.Rows.Count == 0)
                tbOut.Rows.Add();
            gvMoOut.DataSource = tbOut.DefaultView;
            gvMoOut.DataBind();
            for (int i = 0; i < gvMoOut.Rows.Count; i++)
            {
                if (gvMoOut.Rows[i].Cells[2].Text == "收貨")
                    gvMoOut.Rows[i].BackColor = System.Drawing.Color.Yellow;
                else
                    if (gvMoOut.Rows[i].Cells[2].Text == "返電")
                        gvMoOut.Rows[i].BackColor = System.Drawing.Color.FromArgb(0xCC, 0x00, 0x00);
            }

            DataTable tbMoQc = dsOut.Tables[1];
            if (tbMoQc.Rows.Count == 0)
                tbMoQc.Rows.Add();
            gvMoQc.DataSource = tbMoQc.DefaultView;
            gvMoQc.DataBind();
        }



        protected void FindMoReturn()
        {
            string strSql = "";
            string mo_id = txtMo.Text.Trim().ToUpper();
            strSql = "Select a.id,CONVERT(VARCHAR(20),a.transfer_date,111) AS doc_date,a.state,CONVERT(VARCHAR(20),a.check_date,120) AS check_date" +
                ",b.sequence_id AS seq,b.mo_id,b.goods_id,c.name AS goods_name,b.transfer_amount AS prod_qty,b.sec_qty,b.location_id"+
                ",CASE a.type WHEN '0' THEN '出貨' WHEN '1' THEN '收貨' ELSE '未識別' END AS type" +
                " From dbo.st_transfer_mostly a" +
                " INNER JOIN dbo.st_transfer_detail b ON a.within_code=b.within_code AND a.id=b.id" +
                " LEFT JOIN dbo.it_goods c ON b.within_code=c.within_code AND b.goods_id=c.id" +
                " WHERE  b.within_code = '" + within_code + "' AND  b.mo_id = '" + mo_id + "'";
            strSql += " ORDER BY a.type,a.id";
            DataTable tbReturn = sh.ExecuteSqlReturnDataTableGeo(strSql);
            if (tbReturn.Rows.Count > 0)
            {
                string state = "";
                for (int i = 0; i < tbReturn.Rows.Count; i++)
                {
                    state = tbReturn.Rows[i]["state"].ToString();
                    if (state == "G")
                        tbReturn.Rows[i]["state"] = "強制完成";
                }
            }
            else
                tbReturn.Rows.Add();
            gvMoReturn.DataSource = tbReturn.DefaultView;
            gvMoReturn.DataBind();

        }
        protected void FindMoInv()
        {
            string sqlstr = "usp_ShowMoStatus";
            int tb_type = 3;
            string mo_id = txtMo.Text.Trim().ToUpper();
            string goods_id = "";
            if (mo_id == "")
                mo_id = "ZZZZZZZZZ";
            SqlParameter[] parameters = { new SqlParameter("@tb_type", tb_type), new SqlParameter("@mo_id", mo_id), new SqlParameter("@goods_id", goods_id) };
            DataTable tbInv = sh.ExecuteProcedure(sqlstr, parameters);
            if (tbInv.Rows.Count == 0)
                tbInv.Rows.Add();
            gvMoInv.DataSource = tbInv.DefaultView;
            gvMoInv.DataBind();
        }

        protected void FindMoStore()
        {
            string strSql = "";
            string mo_id = txtMo.Text.Trim().ToUpper();
            if (mo_id == "")
                mo_id = "ZZZZZZZZ";
            strSql = "Select a.mo_id,a.location_id,a.lot_no,a.goods_id,b.name AS goods_name,a.qty,a.sec_qty " +
                " From dbo.st_details_lot a" +
                " LEFT JOIN dbo.it_goods b ON a.within_code=b.within_code AND a.goods_id=b.id" +
                " WHERE  a.within_code = '" + within_code + "' AND  a.mo_id = '" + mo_id + "'" +
                " AND a.qty > 0";
                //" ' AND a.location_id>='Y' AND a.location_id<='YZZ' ";
            strSql += " ORDER BY a.goods_id,a.location_id,a.lot_no";
            DataTable tbSt = sh.ExecuteSqlReturnDataTableGeo(strSql);
            if (tbSt.Rows.Count == 0)
                tbSt.Rows.Add();
            gvSt.DataSource = tbSt.DefaultView;
            gvSt.DataBind();
        }
        protected void FindMoRedo()
        {
            string strSql = "";
            string mo_id = txtMo.Text.Trim().ToUpper();
            if (mo_id == "")
                mo_id = "ZZZZZZZZ";
            strSql = "Select b.sequence_id AS seq,CONVERT(VARCHAR(20),a.create_date,111) AS create_date,a.mo_id,a.repair_mo_id,b.goods_id,b.goods_name,b.order_qty,b.goods_unit" +
                " From jo_production_repair_mostly a" +
                " INNER JOIN jo_production_repair_details b ON a.within_code=b.within_code AND a.id=b.id AND a.ver=b.ver" +
                " WHERE  a.within_code = '" + within_code + "'";
            if (mo_id.Substring(0, 1) != "R")
                strSql += " AND  a.repair_mo_id = '" + mo_id + "'";
            else
                strSql += " AND  a.mo_id = '" + mo_id + "'";
            DataTable tbRedo = sh.ExecuteSqlReturnDataTableGeo(strSql);
            if (tbRedo.Rows.Count == 0)
                tbRedo.Rows.Add();
            else
            {
                lblShowRedo.Text = "存在補單頁數:" + tbRedo.Rows[0]["mo_id"];
                lblShowRedo.Visible = true;
            }
            gvMoRedo.DataSource = tbRedo.DefaultView;
            gvMoRedo.DataBind();
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            ClearTextBox();
            DataBind();
        }
        protected void gvDetails_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //加以下這段為選擇行
            PostBackOptions myPostBackOptions = new PostBackOptions(this);
            myPostBackOptions.AutoPostBack = false;
            myPostBackOptions.RequiresJavaScriptProtocol = true;
            myPostBackOptions.PerformValidation = false;
            String evt = Page.ClientScript.GetPostBackClientHyperlink(sender as GridView, "Select$" + e.Row.RowIndex.ToString());
            e.Row.Attributes.Add("onclick", evt);

            e.Row.Attributes.Add("onMouseOver", "Color=this.style.backgroundColor;this.style.backgroundColor='lightBlue'");
            e.Row.Attributes.Add("onMouseOut", "this.style.backgroundColor=Color;");
        }
        protected void gvMoOut_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            e.Row.Attributes.Add("onMouseOver", "Color=this.style.backgroundColor;this.style.backgroundColor='lightBlue'");
            e.Row.Attributes.Add("onMouseOut", "this.style.backgroundColor=Color;");
        }
        protected void gvDetails_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillTextBox();
        }
        protected void FillTextBox()
        {
            if (gvDetails.Rows.Count > 1)
            {
                txtWipSeq.Text = gvDetails.SelectedRow.Cells[0].Text;
                txtItem.Text = gvDetails.SelectedRow.Cells[7].Text;
                txtItem_desc.Text = gvDetails.SelectedRow.Cells[8].Text;
                ShowImage(gvDetails.SelectedRow.Cells[7].Text);
                //string strImagePath = DBUtility.imageDetaultPath + cls.clsPublic.GetImagePath(txtItem.Text);
                //this.imgZp.ImageUrl = strImagePath;
                //MoOutgoingStatus();
            }
            //dlPrd_item.SelectedIndex = 0;
        }
        protected void ClearTextBox()
        {
            txtCustCode.Text = "";
            txtCustDesc.Text = "";
            txtWipSeq.Text = "";
            txtItem.Text = "";
            txtItem_desc.Text = "";
            txtOrder_qty.Text = "";
            txtGoods_unit.Text = "";
            imgZp.ImageUrl = "";
            lblShowRedo.Text = "";
            lblShowRedo.Visible = false;

        }

        protected void btnShowPic_Click(object sender, EventArgs e)
        {

            

        }
        protected void ShowImage(string item)
        {
            if (item.Length < 18)
                return;
            PublicAppDAL paADL = new PublicAppDAL();
            clsPublic cpb = new clsPublic();
            string imgAdd_s = "/cf_art/artwork/AAAA/A588001.bmp";//源文件
            string art_file = paADL.GetArtWorkImagePath(item);//獲取ArtWork源文件
            imgAdd_s = DBUtility.image_map_path + art_file;//獲取源文件完整文件路徑
            int str_start = art_file.IndexOf("/");
            string imgAdd_d = "file/image/" + art_file.Substring(str_start + 1, art_file.Length - (str_start + 1));//"xls/A588001.bmp";
            FileInfo file_s = new FileInfo(Server.MapPath(imgAdd_s));//指定源文件路径
            FileInfo file_d = new FileInfo(Server.MapPath(imgAdd_d));//指定目的文件路徑
            if (file_s.Exists)//判断源文件是否存在
            {
                //cls.clsPublic.WebMessageBox(this.Page, "找到源文件!");
                if (!file_d.Exists)//判断目的文件是否存在
                {
                    cpb.FileCopy(file_s.ToString(), file_d.ToString());
                }
            }
            else
            {
                //cls.clsPublic.WebMessageBox(this.Page, "沒找到ArtWork圖片!");
            }



            imgZp.ImageUrl = imgAdd_d;
        }


    }
}