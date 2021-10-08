using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using Leyp.SQLServerDAL;
using Leyp.Components;
using Leyp.Components.Module;
using BarcodeLib;

namespace WebPortal.Sales
{
    public partial class Sa_Sample_Trace : BasePage//System.Web.UI.Page
    {
        private string comp_type = Base.comp_type;//DBUtility.comp_type;
        private string user_id = "";//DBUtility.user_id;//"leavy_lai";
        private string within_code = Base.within_code;//DBUtility.within_code;
        private SQLHelp sh = new SQLHelp();
        private StrHelper StrHlp = new StrHelper();
        private PublicAppDAL PubApp = new PublicAppDAL();

        protected void Page_Load(object sender, EventArgs e)
        {

            //if (Session["user"] == null)
            //{
            //    Response.Redirect("logout.aspx");
            //}
            //else
            //    user_id = Session["user"].ToString();


            user_id = getUserName();
            if (!Page.IsPostBack)
            {
                InitValue();
            }
            LoadMergeCard(txtDoc_id.Text);


            //GetUserDefaultDep();
            //string doc_id = txtDoc_id.Text;
            //string card_id=txtCard_id.Text;
            //string prd_mo = txtPrd_mo.Text;
            //if (doc_id == "" && card_id == "" && prd_mo == "")
            //    doc_id = "ZZZZZZZZ";
            //BindData(doc_id, card_id, prd_mo);
        }
        protected void InitValue()
        {
            txtDoc_date.Text = System.DateTime.Now.ToString("yyyy/MM/dd");
            string strSql = "";
            strSql = "select flag_id,flag_desc from bs_flag_desc Where doc_type='TR' AND pu_conf_state='Y' order by flag_id ";
            DataTable tbState = sh.ExecuteSqlReturnDataTable(strSql);
            dlAction_type.DataSource = tbState.DefaultView;
            dlAction_type.DataTextField = "flag_desc";
            dlAction_type.DataValueField = "flag_id";
            dlAction_type.DataBind();


            strSql = "select flag_id,flag_desc from bs_flag_desc Where doc_type='TR' AND flag0='Y' order by flag_id ";
            DataTable tbState1 = sh.ExecuteSqlReturnDataTable(strSql);
            dlAction_type1.DataSource = tbState1.DefaultView;
            dlAction_type1.DataTextField = "flag_desc";
            dlAction_type1.DataValueField = "flag_id";
            dlAction_type1.DataBind();

            strSql = "select convert(varchar(1),flag_id) AS flag_id,flag_desc from bs_flag_desc Where doc_type='AL' AND flag0='Y' order by flag_id ";
            DataTable tbA1 = sh.ExecuteSqlReturnDataTable(strSql);
            dlWaitSample.DataSource = tbA1.DefaultView;
            dlWaitSample.DataTextField = "flag_desc";
            dlWaitSample.DataValueField = "flag_id";
            dlWaitSample.DataBind();

            strSql = "select dep_id,dep_cdesc from sample_trace_dep order by sorting,dep_id ";
            DataTable tbDep = sh.ExecuteSqlReturnDataTable(strSql);
            dlDep.DataSource = tbDep.DefaultView;
            dlDep.DataTextField = "dep_cdesc";
            dlDep.DataValueField = "dep_id";
            dlDep.DataBind();

            DataTable tbToDep = new DataTable();
            tbToDep = tbDep.Copy();
            dlToDep.DataSource = tbToDep.DefaultView;
            dlToDep.DataTextField = "dep_cdesc";
            dlToDep.DataValueField = "dep_id";
            dlToDep.DataBind();

            DataTable tbRouteDep = new DataTable();
            tbRouteDep = tbDep.Copy();
            dlRouteDep.DataSource = tbRouteDep.DefaultView;
            dlRouteDep.DataTextField = "dep_cdesc";
            dlRouteDep.DataValueField = "dep_id";
            dlRouteDep.DataBind();

            DataTable tbOwnDep = new DataTable();
            tbOwnDep = tbDep.Copy();
            dlOwnDep.DataSource = tbOwnDep.DefaultView;
            dlOwnDep.DataTextField = "dep_cdesc";
            dlOwnDep.DataValueField = "dep_id";
            dlOwnDep.DataBind();

            DataTable tbOwnType = new DataTable();
            tbOwnType = tbDep.Copy();
            dlOwnType.DataSource = tbOwnType.DefaultView;
            dlOwnType.DataTextField = "dep_cdesc";
            dlOwnType.DataValueField = "dep_id";
            dlOwnType.DataBind();


            strSql = "select * from tb_sy_user_popedom where usr_no='" + user_id + "' AND Window_id='sample_trace'";
            DataTable tbUserAuth = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbUserAuth.Rows.Count > 0)
            {
                btnSave.Enabled = (bool)tbUserAuth.Rows[0]["c1_state"];
                btnDel.Enabled = (bool)tbUserAuth.Rows[0]["c2_state"];
                btnConf.Enabled = (bool)tbUserAuth.Rows[0]["c3_state"];
                btnMerge.Enabled = (bool)tbUserAuth.Rows[0]["c4_state"];
            }

            GetUserDefaultDep();

            //dvMo.Visible = false;
            //dvToDep.Visible = false;
            txtCard_id.Focus();
        }

        protected void GetUserDefaultDep()
        {
            string strSql = "select user_id,dep_id from sample_trace_user Where user_id='" + user_id + "'";

            DataTable tbUserInfo = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbUserInfo.Rows.Count > 0)
            {
                string dep_id = "";
                string user_dep = tbUserInfo.Rows[0]["dep_id"].ToString();
                for (int i = 0; i < dlDep.Items.Count; i++)
                {
                    dep_id = dlDep.Items[i].Value.ToString();
                    if (dep_id == user_dep)
                        dlDep.SelectedIndex = i;
                }
            }
        }

        protected void BindData(string doc_id, string card_id, string prd_mo)
        {
            string strSql = "";
            strSql = "Select a.doc_id,a.doc_date,a.prd_mo,a.prd_item,c.name AS item_cdesc,a.card_id,b.seq,b.dep,d.dep_cdesc" +
                ",b.todep,e.dep_cdesc AS todep_cdesc,b.action_type,f.flag_desc AS action_desc,b.remark,b.crusr,a.remark AS remark_head" +
                ",route_dep,own_type,g.dep_cdesc AS own_type_cdesc,CONVERT(VARCHAR(20),b.crtim,120) AS crtim" +
                ",a.type_sample,a.color_sample,a.draw_sample,a.oth_sample,a.wait_sample,a.color_desc,a.corr_mo,a.data_provide" +
                ",a.custitem,a.custclr,a.card_id_org,a.newmo,b.out_date" +
                " From sample_trace_head a" +
                " INNER JOIN sample_trace_details b ON a.comp_type=b.comp_type AND a.doc_id=b.doc_id" +
                " LEFT JOIN geo_it_goods c ON a.prd_item = c.id" +
                " LEFT JOIN sample_trace_dep d ON b.dep=d.dep_id " +
                " LEFT JOIN sample_trace_dep e ON b.todep=e.dep_id " +
                " LEFT JOIN bs_flag_desc f ON b.action_type=f.flag_id" +
                " LEFT JOIN sample_trace_dep g ON b.dep=g.dep_id " +
                " WHERE a.comp_type='" + comp_type + "'" + " AND f.doc_type='TR'";
            if (doc_id != "")
                strSql += " AND a.doc_id='" + doc_id + "'";
            if (card_id != "")
                strSql += " AND a.card_id='" + card_id + "'";
            if (prd_mo != "")
                strSql += " AND a.prd_mo='" + prd_mo + "'";
            if (doc_id == "" && card_id == "")
                strSql += " AND a.doc_id='ZZZZZZZZ'";
            strSql += " ORDER BY b.seq DESC";
            DataTable tbTrace = sh.ExecuteSqlReturnDataTable(strSql);
            CleanHeadValue();
            ClearBoxDetails();

            if (tbTrace.Rows.Count > 0)
            {
                card_id = tbTrace.Rows[0]["card_id"].ToString();
                BindTree(tbTrace, null, card_id);
                FillValue(tbTrace);
                LoadMergeCard(txtDoc_id.Text);
                GetUserDefaultDep();//設置當前部門
            }
            else
            {
                string new_doc_id = "";
                new_doc_id = FindMergeCardId();//如果沒有找到，再從并單記錄中找，看是否能找出來
                if (new_doc_id != "")//如果在合併的制單中找到，則提取原Card_id，并重新找出數據
                    BindData(new_doc_id, "", "");
                else//設置當前部門
                {
                    LoadMergeCard("ZZZZZZZZ");
                    GetUserDefaultDep();//設置當前部門
                    dlAction_type.SelectedIndex = 1;//沒找到記錄，默認設置為新卡狀態
                    if (string.Compare(txtCard_id.Text.Substring(0, 1), "9") > 0)
                    {
                        txtCorrMo.Text = txtCard_id.Text.ToUpper();
                        BindPrd_tem();
                    }
                    txtDoc_date.Text = System.DateTime.Now.ToString("yyyy/MM/dd");
                    txtPrd_mo.Focus();
                }
            }

        }
        protected void LoadMergeCard(string doc_id)
        {
            string strSql = "";
            strSql = "Select a.card_id,a.own_dep,b.dep_cdesc,a.sign_user,a.sign_tim" +
                " From sample_trace_merge a " +
                " Left Join sample_trace_dep b ON a.own_dep=b.dep_id where doc_id='" + doc_id + "'";
            DataTable tbMerge = sh.ExecuteSqlReturnDataTable(strSql);
            gvMerge.DataSource = tbMerge.DefaultView;
            gvMerge.DataBind();
            //if (tbMerge.Rows.Count > 0)
            //    dvMerge.Visible = true;
            //else
            //    dvMerge.Visible = false;
            //if(dlAction_type.SelectedValue =="06")//如果是已選擇複製ID卡的
            //    dvMerge.Visible = true;
        }
        protected string FindMergeCardId()
        {
            string result = "";
            string strSql = "Select doc_id From sample_trace_merge where card_id='" + txtCard_id.Text + "'";
            DataTable tbMerge = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbMerge.Rows.Count > 0)
                result = tbMerge.Rows[0]["doc_id"].ToString();
            return result;
        }
        private void FillValue(DataTable tbTrace)
        {
            txtDoc_id.Text = tbTrace.Rows[0]["doc_id"].ToString();
            txtCard_id.Text = tbTrace.Rows[0]["card_id"].ToString();
            txtCard_id_print.Value = txtCard_id.Text;
            txtPrd_mo.Text = tbTrace.Rows[0]["prd_mo"].ToString();
            txtDoc_date.Text = tbTrace.Rows[0]["doc_date"].ToString();
            txtPrd_item.Text = tbTrace.Rows[0]["prd_item"].ToString();
            //txtRemark.Text = tbTrace.Rows[0]["remark"].ToString();
            txtRemark_head.Text = tbTrace.Rows[0]["remark_head"].ToString();

            txtCorrMo.Text = tbTrace.Rows[0]["corr_mo"].ToString();
            txtDataProvide.Text = tbTrace.Rows[0]["data_provide"].ToString();
            txtRouteDep.Text = tbTrace.Rows[0]["route_dep"].ToString();
            txtCustitem.Text = tbTrace.Rows[0]["custitem"].ToString();
            txtCustclr.Text = tbTrace.Rows[0]["custclr"].ToString();
            txtCard_id_org.Text = tbTrace.Rows[0]["card_id_org"].ToString();
            txtNewMo.Text = tbTrace.Rows[0]["newmo"].ToString();
            if (tbTrace.Rows[0]["own_type"].ToString() != "")
                dlOwnType.SelectedValue = tbTrace.Rows[0]["own_type"].ToString();
            if (tbTrace.Rows[0]["color_sample"].ToString() == "1")
                chkColorSample.Checked = true;
            if (tbTrace.Rows[0]["draw_sample"].ToString() == "1")
                chkDrawSample.Checked = true;
            if (tbTrace.Rows[0]["oth_sample"].ToString() == "1")
                chkOthSample.Checked = true;
            if (tbTrace.Rows[0]["type_sample"].ToString() == "1")
                chkTypeSample.Checked = true;
            string tx = tbTrace.Rows[0]["wait_sample"].ToString();
            if (tbTrace.Rows[0]["wait_sample"].ToString() != "")
                dlWaitSample.SelectedValue = tbTrace.Rows[0]["wait_sample"].ToString();
            else
                dlWaitSample.SelectedValue = "0";

            BindPrd_tem();
            txtColorDesc.Text = tbTrace.Rows[0]["color_desc"].ToString();
            //txtItem_cdesc.Text = tbTrace.Rows[0]["item_cdesc"].ToString();
            string item = "";
            for (int i = 0; i < dlPrd_item.Items.Count; i++)
            {
                item = dlPrd_item.Items[i].ToString();
                if (item == txtPrd_item.Text)
                    dlPrd_item.SelectedIndex = i;
            }
            dlAction_type.SelectedIndex = 2;//找到記錄，默認設置為改單狀態
        }
        private void BindTree(DataTable dtSource, TreeNode parentNode, string parentID)
        {

            //DataRow[] rows = dtSource.Select(string.Format("card_id={0}", parentID));
            for (int i = 0; i < dtSource.Rows.Count; i++)
            {
                DataRow row = dtSource.Rows[i];
                //foreach (DataRow row in rows)
                //{

                TreeNode node = new TreeNode();
                string node_text = "";
                string node_value = row["seq"].ToString();
                node_text = row["crtim"].ToString();
                if (row["dep"].ToString() != "000")
                    node_text += "    [" + row["dep_cdesc"].ToString().Trim() + "] ";
                if (row["crusr"].ToString() != "")
                    node_text += " " + row["crusr"].ToString();
                if (row["action_type"].ToString() != "")
                    node_text += "  " + row["action_desc"].ToString().Trim();
                if (row["todep"].ToString() != "000")
                    node_text += " / 下一部門: [" + row["todep_cdesc"].ToString().Trim() + "]" + " / 日期: " + row["out_date"].ToString().Trim();
                if (row["remark"].ToString() != "")
                    node_text += " / " + row["remark"].ToString();

                node.Text = node_text;
                node.Value = node_value;
                //node.ImageUrl = "images/y2.gif";
                node.Expanded = true;

                //parentNode.ChildNodes.Add(node);


                //BindTree(dtSource, node, node_value);

                if (parentNode == null)
                {

                    treeTrace.Nodes.Add(node);

                }

                else
                {

                    parentNode.ChildNodes.Add(node);

                }

                //}
            }
        }
        protected void btnFind_Click(object sender, EventArgs e)
        {
            ClearBoxDetails();
            BindData("", txtCard_id.Text, "");
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Save(1);
        }
        protected void btnConf_Click(object sender, EventArgs e)
        {
            Save(2);
        }
        protected bool checkApproveColor()
        {
            bool result = false;
            string strSql = "";
            string window_id = "sample_trace_app_color";
            strSql = "select a.usr_no from tb_sy_user_popedom a " +
                "Inner Join sample_trace_user b On a.usr_no=b.dep_id" +
                " where b.user_id='" + user_id + "' AND a.Window_id='" + window_id + "'";
            DataTable tbUserAuth = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbUserAuth.Rows.Count > 0)
            {
                result = true;
            }
            return result;
        }
        protected void btnAddRoute_Click(object sender, EventArgs e)
        {
            if (dlRouteDep.SelectedIndex > 0)
            {
                if (txtRouteDep.Text != "")
                    txtRouteDep.Text += "-->" + dlRouteDep.SelectedItem.ToString();
                else
                    txtRouteDep.Text = dlRouteDep.SelectedItem.ToString();
            }
        }
        protected void dlPrd_item_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadGoodsDesc();
        }
        protected void ClearBoxDetails()
        {
            txtPrd_item.Text = "";
            txtItem_cdesc.Text = "";
            txtRemark.Text = "";
            txtRemark_head.Text = "";
            txtColorDesc.Text = "";
            txtCorrMo.Text = "";
            txtDataProvide.Text = "";
            txtCard_id_print.Value = "";
            txtRouteDep.Text = "";
            txtMoRemark.Text = "";
            txtSale.Text = "";
            txtCustitem.Text = "";
            txtCustclr.Text = "";
            txtCard_id_org.Text = "";

            chkColorSample.Checked = false;
            chkDrawSample.Checked = false;
            chkOthSample.Checked = false;
            chkTypeSample.Checked = false;
            dlWaitSample.SelectedIndex = 0;
            dlOwnType.SelectedIndex = 0;
            dlDep.SelectedIndex = 0;
            dlToDep.SelectedIndex = 0;
            dlPrd_item.Items.Clear();
            treeTrace.Nodes.Clear();
        }
        protected void txtPrd_mo_TextChanged(object sender, EventArgs e)
        {
            //BindPrd_tem();
        }
        protected void txtCard_id_TextChanged(object sender, EventArgs e)
        {
            //txtDoc_id.Text = "";
            //txtPrd_mo.Text = "";
            //txtDoc_date.Text = "";
            //ClearBoxDetails();
            BindData("", txtCard_id.Text, "");

        }

        protected void Save(int save_type)
        {
            string action_type = "";
            if (save_type == 1 || save_type == 4)//如果是新辦卡或孿生樣板或分發多辦
                action_type = dlAction_type.SelectedValue.ToString();
            else
                action_type = dlAction_type1.SelectedValue.ToString();
            if (save_type == 3)//如果是刪除并單記錄
                action_type = "07";

            if (!validDataHead(save_type, action_type))
                return;
            string strSql = "";
            string result_str = "";
            string doc_id = txtDoc_id.Text;

            if (action_type == "01" || action_type == "05" || action_type == "08")//如果是新增或修改瓣卡
            {
                string card_id = txtCard_id.Text;
                string prd_mo = txtPrd_mo.Text.ToUpper();
                string prd_item = "";
                if (dlPrd_item.SelectedItem != null)
                    prd_item = dlPrd_item.SelectedItem.ToString().ToUpper();
                string doc_date = txtDoc_date.Text;
                string remark_head = txtRemark_head.Text;
                string type_sample = "0";
                string color_sample = "0";
                string draw_sample = "0";
                string oth_sample = "0";
                string wait_sample = "0";
                string color_desc = txtColorDesc.Text;
                string corr_mo = txtCorrMo.Text;
                string data_provide = txtDataProvide.Text;
                string route_dep = txtRouteDep.Text;
                string own_type = dlOwnType.SelectedValue;
                string custitem = txtCustitem.Text;
                string custclr = txtCustclr.Text;
                string card_id_org = txtCard_id_org.Text;
                string newmo = txtNewMo.Text;
                if (chkTypeSample.Checked == true)
                    type_sample = "1";
                if (chkColorSample.Checked == true)
                    color_sample = "1";
                if (chkDrawSample.Checked == true)
                    draw_sample = "1";
                if (chkOthSample.Checked == true)
                    oth_sample = "1";
                if (dlWaitSample.SelectedValue == "1")
                    wait_sample = "1";
                else
                {
                    if (dlWaitSample.SelectedValue == "2")
                        wait_sample = "2";
                    else
                        if (dlWaitSample.SelectedValue == "3")
                            wait_sample = "3";
                }
                if (action_type == "08")//如果是批色辦的，將待批轉為2--已批
                    wait_sample = "2";
                if (action_type == "01")//新增瓣卡
                {
                    doc_id = GetMaxDoc_id();//產生單據編號
                    txtDoc_id.Text = doc_id;

                    strSql += string.Format(@"INSERT INTO sample_trace_head 
                    (comp_type,doc_id,doc_date,card_id,prd_mo,prd_item,type_sample,color_sample,draw_sample
                    ,wait_sample,oth_sample,color_desc,corr_mo,data_provide,crusr,remark,route_dep,own_type
                    ,custitem,custclr,card_id_org,newmo,crtim)
                    VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}','{9}','{10}','{11}','{12}'
                    ,'{13}','{14}','{15}','{16}','{17}','{18}','{19}','{20}','{21}',GETDATE())"
                    , comp_type, doc_id, doc_date, card_id, prd_mo, prd_item, type_sample, color_sample, draw_sample
                    , wait_sample, oth_sample, color_desc, corr_mo, data_provide, user_id, remark_head, route_dep
                    , own_type, custitem, custclr, card_id_org, newmo);
                }
                else//修改瓣卡
                {
                    if (action_type == "05")
                    {
                        strSql += string.Format(@"Update sample_trace_head SET doc_date='{0}',card_id='{1}',prd_mo='{2}',prd_item='{3}'
                        ,type_sample='{4}',color_sample='{5}',draw_sample='{6}',oth_sample='{7}',color_desc='{8}',corr_mo='{9}'
                        ,data_provide='{10}',remark='{11}',crusr='{12}',route_dep='{13}',own_type='{14}',wait_sample='{15}'
                        ,custitem='{16}',custclr='{17}',card_id_org='{18}',newmo='{19}',crtim=GETDATE()
                        Where comp_type='{20}' AND doc_id='{21}'",
                        doc_date, card_id, prd_mo, prd_item, type_sample, color_sample, draw_sample, oth_sample
                        , color_desc, corr_mo, data_provide, remark_head, user_id, route_dep, own_type, wait_sample
                        , custitem, custclr, card_id_org, newmo, comp_type, doc_id);
                    }
                    else
                    {
                        if (action_type == "08")
                        {
                            strSql += string.Format(@"Update sample_trace_head SET wait_sample='{0}',crusr='{1}',crtim=GETDATE()
                            Where comp_type='{2}' AND doc_id='{3}'", wait_sample, user_id, comp_type, doc_id);
                        }
                    }
                }
            }

            //if (action_type != "05")//如果是設置狀態資料
            //{
            string seq = "";
            seq = PubApp.GenSeq("sample_trace_details", doc_id);
            if (seq == "")
            {
                StrHlp.WebMessageBox(this.Page, "提取序號錯誤!");
                return;
            }
            string dep = dlDep.SelectedValue.ToString();
            string todep = dlToDep.SelectedValue.ToString();
            if (action_type != "03")//只有是發出，才有接收部門
                todep = "000";
            string remark = txtRemark.Text;
            string out_date = txtOutDate.Text;
            if (action_type == "06" || action_type == "07")
                remark += ":" + txtCard_id_merge.Text;
            strSql += string.Format(@"INSERT INTO sample_trace_details (comp_type,doc_id,seq,dep,todep,action_type,out_date,remark,crusr,crtim)
                    VALUES ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}','{8}',GETDATE())"
                , comp_type, doc_id, seq, dep, todep, action_type, out_date, remark, user_id);
            //}



            if (strSql != "")
            {
                result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
            }
            if (result_str == "")
            {
                StrHlp.WebMessageBox(this.Page, "儲存瓣卡記錄成功!");
            }
            else
                StrHlp.WebMessageBox(this.Page, result_str);
            BindData(doc_id, "", "");
        }
        protected bool CheckExistDoc(string doc_id)
        {
            string strSql = "";
            bool result = false;
            strSql += string.Format(@"Select doc_id From sample_trace_head Where comp_type='{0}' AND doc_id='{1}'", comp_type, doc_id);
            DataTable tbDoc = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbDoc.Rows.Count > 0)
                result = true;
            return result;
        }
        protected string GetMaxDoc_id()
        {
            string result = "";
            string strSql = "";
            strSql = "Select Max(doc_id) AS doc_id From sample_trace_head";
            DataTable tbCheckGenNo = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbCheckGenNo.Rows[0]["doc_id"].ToString() != "")
            {
                result = (Convert.ToInt32(tbCheckGenNo.Rows[0]["doc_id"].ToString()) + 1).ToString();
                result = result.PadLeft(6, '0');
            }
            else
                result = "000001";
            return result;
        }

        protected bool validDataHead(int save_type, string action_type)
        {
            if (action_type == "00")//如果沒有選擇項
            {
                StrHlp.WebMessageBox(this.Page, "請先選擇操作的方式!");
                dlAction_type.Focus();
                return false;
            }
            if (save_type == 1)
            {
                if (action_type != "01" && action_type != "05")
                {
                    StrHlp.WebMessageBox(this.Page, "非新辦卡或改單狀態,不能儲存!");
                    dlAction_type.Focus();
                    return false;
                }
            }
            if (txtCard_id.Text == "")
            {
                StrHlp.WebMessageBox(this.Page, "ID卡號不能為空!");
                txtCard_id.Focus();
                return false;
            }
            if (string.Compare(txtCard_id.Text.Trim().Substring(0, 1), "9") < 0 && !StrHlp.IsInt(txtCard_id.Text))
            {
                StrHlp.WebMessageBox(this.Page, "ID卡號必須為數字!");
                txtCard_id.Focus();
                return false;
            }
            if (dlDep.SelectedValue == "000")//action_type != "01" && action_type != "05" && 
            {
                StrHlp.WebMessageBox(this.Page, "操作部門不能為空!");
                dlDep.Focus();
                return false;
            }
            if (!CheckUserValid(dlDep.SelectedValue))
            {
                StrHlp.WebMessageBox(this.Page, "非本部門用戶,不能操作!");
                dlDep.Focus();
                return false;
            }
            if (action_type == "01")//如果是新增瓣卡
            {

                if (txtDoc_date.Text.Trim() == "" || StrHlp.CheckDateFormat(txtDoc_date.Text.Trim()) == false)
                {
                    StrHlp.WebMessageBox(this.Page, "日期格式錯誤!");
                    txtDoc_date.Focus();
                    return false;
                }
                if (dlOwnType.SelectedValue == "000")
                {
                    StrHlp.WebMessageBox(this.Page, "請選擇所屬類別!");
                    dlOwnType.Focus();
                    return false;
                }
                if (chkColorSample.Checked == false && chkDrawSample.Checked == false && chkOthSample.Checked == false && chkTypeSample.Checked == false)
                {
                    StrHlp.WebMessageBox(this.Page, "請選擇文件類別!");
                    chkColorSample.Focus();
                    return false;
                }
                //if (txtPrd_mo.Text == "")
                //{
                //    cls.clsPublic.WebMessageBox(this.Page, "制單編號不能為空!");
                //    txtPrd_mo.Focus();
                //    return false;
                //}
                //if (dlPrd_item.SelectedValue == "")
                //{
                //    cls.clsPublic.WebMessageBox(this.Page, "物料編號不能為空!");
                //    dlPrd_item.Focus();
                //    return false;
                //}

            }
            else
            {
                if (txtDoc_id.Text == "")
                {
                    StrHlp.WebMessageBox(this.Page, "單據編號不能為空!");
                    txtDoc_id.Focus();
                    return false;
                }
                if (!CheckExistDoc(txtDoc_id.Text))//檢查是否存在單號資料
                {
                    StrHlp.WebMessageBox(this.Page, "不存在修改的單號!");
                    txtDoc_id.Focus();
                    return false;
                }
                if (action_type == "03")//如果是發出
                {
                    if (dlToDep.SelectedValue == "000")
                    {
                        StrHlp.WebMessageBox(this.Page, "接收部門不能為空!");
                        dlToDep.Focus();
                        return false;
                    }
                }
                else
                {
                    if (action_type == "08")//如果是批色，則要檢查是否有權限
                    {
                        if (!checkApproveColor())
                        {
                            StrHlp.WebMessageBox(this.Page, "這個用戶沒有批色的權限!");
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        protected void dlAction_type_SelectedIndexChanged(object sender, EventArgs e)
        {
            string action_type = dlAction_type.SelectedValue.ToString();
            if (action_type == "01")//新增瓣卡
            {
                txtCard_id.Text = "";
                CleanHeadValue();
                ClearBoxDetails();
                //dvToDep.Visible = false;
                lblDep.Text = "本部門";
                //dvMerge.Visible = false;
                txtCard_id.Focus();
            }
            else
            {
                if (action_type == "06")//複製/分發多卡
                {
                    lblDep.Text = "本部門";
                    //dvToDep.Visible = false;
                    //dvMerge.Visible = true;
                    BindData(txtDoc_id.Text, "", "");
                    txtCard_id_merge.Focus();
                }
            }
            GetUserDefaultDep();
            dlToDep.SelectedIndex = 0;
        }
        private void CleanHeadValue()
        {
            txtDoc_id.Text = "";
            txtPrd_mo.Text = "";
            txtDoc_date.Text = System.DateTime.Now.ToString("yyyy/MM/dd");
        }
        protected void dlAction_type1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string action_type = dlAction_type1.SelectedValue.ToString();
            txtOutDate.Text = "";
            if (action_type == "02")//簽收
            {
                //dvToDep.Visible = false;
                lblDep.Text = "簽收部門";
                dlDep.SelectedIndex = 0;
            }
            else
            {
                if (action_type == "03")//發出
                {
                    //dvToDep.Visible = true;
                    lblDep.Text = "本部門";
                    txtOutDate.Text = System.DateTime.Now.ToString("yyyy/MM/dd");
                }
                else
                {
                    //dvToDep.Visible = false;
                    lblDep.Text = "本部門";
                }
            }
            GetUserDefaultDep();
            dlToDep.SelectedIndex = 0;
        }

        protected void btnMerge_Click(object sender, EventArgs e)
        {
            //dlAction_type.SelectedValue = "06";//默認設定為複製樣辦  分發多卡
            if (!ChkMergeCardId(false))
                return;
            string strSql = "";
            string doc_id = txtDoc_id.Text;
            string card_id = txtCard_id_merge.Text;
            string own_dep = dlOwnDep.SelectedValue;
            string result_str = "";
            strSql = "Select card_id From sample_trace_merge where doc_id='" + doc_id + "' AND card_id='" + card_id + "'";
            DataTable tbMerge = sh.ExecuteSqlReturnDataTable(strSql);
            if (tbMerge.Rows.Count == 0)
            {
                strSql = string.Format(@"INSERT INTO sample_trace_merge (doc_id,card_id,own_dep,crusr,crtim)
                    VALUES ('{0}','{1}','{2}','{3}',GETDATE())"
                    , doc_id, card_id, own_dep, user_id);
                result_str = sh.ExecuteSqlUpdate(strSql);//更新明細記錄
                if (result_str == "")
                {

                    txtCard_id_merge.Text = "";
                    //Save(4);
                    ////cls.clsPublic.WebMessageBox(this.Page, "儲存瓣卡複製記錄成功!");
                }
                else
                    StrHlp.WebMessageBox(this.Page, result_str);
            }

            BindData(doc_id, "", "");
        }
        protected bool ChkMergeCardId(bool delete_flag)
        {
            if (delete_flag == false)
            {
                if (dlAction_type.SelectedValue == "00")//如果沒有選擇項
                {
                    StrHlp.WebMessageBox(this.Page, "請先選擇操作的方式：分發辦卡!");
                    dlAction_type1.Focus();
                    return false;
                }
                if (txtCard_id_merge.Text == "")
                {
                    StrHlp.WebMessageBox(this.Page, "ID卡號不能為空!");
                    txtCard_id_merge.Focus();
                    return false;
                }
                if (!StrHlp.IsInt(txtCard_id_merge.Text))
                {
                    StrHlp.WebMessageBox(this.Page, "ID卡號必須為數字!");
                    txtCard_id_merge.Focus();
                    return false;
                }
                if (txtCard_id.Text == txtCard_id_merge.Text)
                {
                    StrHlp.WebMessageBox(this.Page, "複製的卡號不能和原卡號相同!");
                    txtCard_id_merge.Focus();
                    return false;
                }
                if (dlOwnDep.SelectedValue == "000")//如果沒有選擇項
                {
                    StrHlp.WebMessageBox(this.Page, "請選擇所屬部門!");
                    dlOwnDep.Focus();
                    return false;
                }
            }
            if (dlDep.SelectedValue == "000")
            {
                StrHlp.WebMessageBox(this.Page, "操作部門不能為空!");
                dlDep.Focus();
                return false;
            }
            if (!CheckUserValid(dlDep.SelectedValue))
            {
                StrHlp.WebMessageBox(this.Page, "非本部門用戶,不能操作!");
                dlDep.Focus();
                return false;
            }
            if (!CheckExistDoc(txtDoc_id.Text))//檢查是否存在單號資料
            {
                StrHlp.WebMessageBox(this.Page, "原ID卡號記錄不存在!");
                txtCard_id.Focus();
                return false;
            }
            return true;
        }


        protected void gvDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            if (!ChkMergeCardId(true))
                return;
            int i = e.RowIndex;
            string doc_id = txtDoc_id.Text;
            string card_id = gvMerge.Rows[i].Cells[0].Text;
            txtRemark.Text = card_id;//記錄刪除的ID
            string strSql = "Delete From sample_trace_merge where doc_id='" + doc_id + "' AND card_id = '" + card_id + "'";
            string result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
            {
                Save(3);
                StrHlp.WebMessageBox(this.Page, "刪除記錄成功!");
            }
            else
                StrHlp.WebMessageBox(this.Page, result);
            BindData(doc_id, "", "");
        }

        protected void gvMerge_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int row = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName.ToString() == "Print_old")
            {
                //显示另外的GridView
                //cls.clsPublic.WebMessageBox(this.Page, "列印按鈕!");
                //this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "", "<script>Ceshi();</script>", true);

                //txtCard_id.Text = gvMerge.Rows[i].Cells[0].Text;
                //card_id_print = gvMerge.Rows[i].Cells[0].Text;
                txtCard_id_print.Value = gvMerge.Rows[row].Cells[0].Text;
                txtOwn_dep_print.Value = (gvMerge.Rows[row].Cells[2].Text != "&nbsp;" ? gvMerge.Rows[row].Cells[2].Text : "");

                //this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "", "<script>prn1_preview();</script>", true);
                //Page.ClientScript.RegisterStartupScript(typeof(string), "1", "<script>myfunc('参数1','参数2');</script>");

                Page.ClientScript.RegisterStartupScript(typeof(string), "1", "<script>prn1_preview('2');</script>");
                return;
            }


            if (e.CommandName.ToString() == "Print_new")
            {

                dvTrace.Visible = false;
                dvPrint.Visible = true;
                SetPrintData(row);
                return;
            }
            if (e.CommandName.ToString() == "Sign")
            {
                string dep_id = gvMerge.Rows[row].Cells[1].Text;
                if (!CheckUserValid(dep_id))
                {
                    StrHlp.WebMessageBox(this.Page, "不能簽收非本部門的辦卡!");
                    return;
                }
                Sign(row);
                return;
            }
        }
        protected void Sign(int row)
        {

            string strSql = "";
            string doc_id = txtDoc_id.Text;
            string card_id = gvMerge.Rows[row].Cells[0].Text;
            strSql += string.Format(@"Update sample_trace_merge 
                Set sign_user='{0}',sign_tim=GETDATE() where doc_id='{1}' AND card_id='{2}'", user_id, doc_id, card_id);
            string result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
            {
                StrHlp.WebMessageBox(this.Page, "簽收成功!");
                txtCard_id.Focus();
            }
            else
                StrHlp.WebMessageBox(this.Page, result);
            BindData(doc_id, "", "");
        }
        protected bool CheckUserValid(string dep_id)
        {
            if (user_id == "admin")
                return true;
            bool result = true;
            string strSql = "";
            strSql = "Select user_id From sample_trace_user Where user_id='" + user_id + "' AND dep_id='" + dep_id + "'";
            DataTable dtUser = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtUser.Rows.Count == 0)
                result = false;
            return result;
        }
        protected void btnDel_Click(object sender, EventArgs e)
        {
            if (!CheckUserValid(dlDep.SelectedValue))
            {
                StrHlp.WebMessageBox(this.Page, "非本部門用戶,不能操作!");
                dlDep.Focus();
                return;
            }
            string doc_id = txtDoc_id.Text;

            string strSql = "";
            strSql += string.Format(@"Delete From sample_trace_head where comp_type='{0}' AND doc_id='{1}'", comp_type, doc_id);
            strSql += string.Format(@"Delete From sample_trace_details where comp_type='{0}' AND doc_id='{1}'", comp_type, doc_id);
            strSql += string.Format(@"Delete From sample_trace_merge where doc_id='{0}'", doc_id);
            string result = sh.ExecuteSqlUpdate(strSql);
            if (result == "")
            {
                StrHlp.WebMessageBox(this.Page, "刪除記錄成功!");
                txtCard_id.Focus();
            }
            else
                StrHlp.WebMessageBox(this.Page, result);
            BindData(doc_id, "", "");
        }

        protected void dlOwnType_SelectedIndexChanged(object sender, EventArgs e)
        {
            //if (dlOwnType.SelectedValue == "私用")
            //    dvMerge.Visible = true;
            //else
            //    dvMerge.Visible = false;
        }
        protected void btnShowTrace_Click(object sender, EventArgs e)
        {
            dvTrace.Visible = true;
            dvPrint.Visible = false;
        }
        protected void btnNewPrint_Click(object sender, EventArgs e)
        {
            dvTrace.Visible = false;
            dvPrint.Visible = true;
            SetPrintData(999);
        }
        protected void SetPrintData(int print_rec)
        {
            DataTable dtPrint = new DataTable();
            dtPrint.Columns.Add("card_id", typeof(string));
            dtPrint.Columns.Add("barcode_img", typeof(string));
            dtPrint.Columns.Add("barcode", typeof(string));
            dtPrint.Columns.Add("sample", typeof(string));
            dtPrint.Columns.Add("own_dep", typeof(string));
            dtPrint.Columns.Add("remark", typeof(string));
            dtPrint.Columns.Add("corr_mo", typeof(string));
            dtPrint.Columns.Add("doc_date", typeof(string));
            dtPrint.Columns.Add("data_provide", typeof(string));
            dtPrint.Columns.Add("card_id_merge", typeof(string));
            dtPrint.Columns.Add("route_dep", typeof(string));
            dtPrint.Columns.Add("card_id_org", typeof(string));
            dtPrint.Columns.Add("custitem", typeof(string));
            DataRow dr = null;
            string card_id = "";
            string sample = "";
            string remark = "";
            string card_id_merge = "";
            string own_dep = "";
            if (chkTypeSample.Checked)
                sample = "樣板";
            if (chkColorSample.Checked)
            {
                if (sample != "")
                    sample = sample + "/" + "色板";
                else
                    sample = "色板";
            }
            if (chkDrawSample.Checked)
            {
                if (sample != "")
                    sample = sample + "/" + "圖紙";
                else
                    sample = "圖紙";
            }
            if (dlWaitSample.SelectedIndex > 0)
            {
                if (sample != "")
                    sample = sample + "/" + dlWaitSample.SelectedItem.ToString();
                else
                    sample = dlWaitSample.SelectedItem.ToString();
            }


            if (chkOthSample.Checked)
            {
                if (sample != "")
                    sample = sample + "/" + "其它";
                else
                    sample = "其它";
            }
            remark = txtRemark_head.Text;
            if (txtColorDesc.Text != "")
            {
                if (remark != "")
                    remark = remark + " / " + txtColorDesc.Text;
                else
                    remark = txtColorDesc.Text;
            }
            if (print_rec == 999)//如果是直接列印，全部
            {
                card_id = txtCard_id.Text;
                own_dep = dlOwnType.SelectedItem.ToString();
                card_id_merge = "";
                for (int i = 0; i < gvMerge.Rows.Count; i++)
                {
                    if (i == 0)
                        card_id_merge = gvMerge.Rows[i].Cells[0].Text;
                    else
                        card_id_merge += "/" + gvMerge.Rows[i].Cells[0].Text;
                }
            }
            else//如果是在表格中列印
            {
                card_id = gvMerge.Rows[print_rec].Cells[0].Text;
                own_dep = gvMerge.Rows[print_rec].Cells[2].Text;
                card_id_merge = txtCard_id.Text;
                for (int i = 0; i < gvMerge.Rows.Count; i++)
                {
                    if (card_id != gvMerge.Rows[i].Cells[0].Text)
                        card_id_merge += "/" + gvMerge.Rows[i].Cells[0].Text;
                }
            }



            dr = dtPrint.NewRow();
            dr["card_id"] = card_id;

            dr["barcode"] = PubApp.StringToBarCode(txtCard_id.Text);
            dr["barcode_img"] = GenBarCode(card_id);
            dr["sample"] = sample;
            dr["own_dep"] = own_dep;
            dr["remark"] = remark;
            dr["corr_mo"] = txtCorrMo.Text;
            dr["doc_date"] = txtDoc_date.Text;
            dr["data_provide"] = txtDataProvide.Text;
            dr["card_id_merge"] = card_id_merge;
            dr["route_dep"] = txtRouteDep.Text;
            dr["card_id_org"] = txtCard_id_org.Text;
            dr["custitem"] = txtCustitem.Text + " / " + txtCustclr.Text;
            dtPrint.Rows.Add(dr);
            if (print_rec == 999)//如果是列印所有
            {
                for (int i = 0; i < gvMerge.Rows.Count; i++)
                {
                    dr = dtPrint.NewRow();
                    dr["card_id"] = gvMerge.Rows[i].Cells[0].Text;
                    dr["barcode_img"] = GenBarCode(dr["card_id"].ToString());
                    dr["barcode"] = PubApp.StringToBarCode(gvMerge.Rows[i].Cells[0].Text);//條碼
                    dr["sample"] = sample;//樣辦類型
                    dr["own_dep"] = gvMerge.Rows[i].Cells[2].Text;
                    dr["remark"] = remark;//說明/顏色
                    dr["corr_mo"] = txtCorrMo.Text;//相關制單
                    dr["doc_date"] = txtDoc_date.Text;//日期/提供
                    dr["data_provide"] = txtDataProvide.Text;//日期/提供
                    dr["card_id_org"] = txtCard_id_org.Text;//原辦編號
                    dr["custitem"] = txtCustitem.Text + " / " + txtCustclr.Text;//客人款號
                    card_id_merge = card_id;
                    for (int j = 0; j < gvMerge.Rows.Count; j++)
                    {
                        if (gvMerge.Rows[i].Cells[0].Text != gvMerge.Rows[j].Cells[0].Text)
                            card_id_merge += "/" + gvMerge.Rows[j].Cells[0].Text;
                    }
                    dr["card_id_merge"] = card_id_merge;//孿生樣瓣
                    dr["route_dep"] = txtRouteDep.Text;//交辦流程
                    dtPrint.Rows.Add(dr);
                }
            }
            PrintReport(dtPrint);
        }



        protected void PrintReport(DataTable dtPrint)
        {

            ReportViewer1.LocalReport.ReportPath = AppDomain.CurrentDomain.BaseDirectory + "/Reports/sample_trace.rdlc";//
            ReportViewer1.LocalReport.EnableExternalImages = true;

            // 获取 MyHandler.jxd 的完整路径
            //string barcode_url = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath + "file/image/" + "/MyHandler.jxd?data=";
            string barcode_url = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath + "file/image/";
            //+"file/image"

            //-> "http://localhost:6344/HttpHandlerDemo/MyHandler.jxd?data="



            if (dtPrint != null)
            {

                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(

                new Microsoft.Reporting.WebForms.ReportDataSource("Request_RequestReport", dtPrint));

                ReportViewer1.LocalReport.Refresh();


                string doc_type_to = "相關制單";
                string color = "N001";

                ReportViewer1.LocalReport.ReportPath = "Reports\\sample_trace.rdlc";//Report1.rdlc;
                ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportViewer1.LocalReport.SetParameters(new ReportParameter(doc_type_to));//, Guid.NewGuid().ToString()

                //向報表傳遞單個參數
                //ReportParameter rp = new ReportParameter("doc_type_to", doc_type_to);
                //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });
                //向報表傳遞多個參數
                ReportParameter[] para = new ReportParameter[3];
                para[0] = new ReportParameter("Remark", txtRemark_head.Text);
                para[1] = new ReportParameter("RouteDep", txtRouteDep.Text);
                para[2] = new ReportParameter("barcode_url", barcode_url);
                ReportViewer1.LocalReport.SetParameters(para);
                ReportDataSource rds = new ReportDataSource("DataSet_Trace", dtPrint);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.Refresh();

            }

            ReportViewer1.LocalReport.Refresh();

        }

        protected void PrintReport1(DataTable dtPrint)
        {

            ReportViewer1.LocalReport.ReportPath = AppDomain.CurrentDomain.BaseDirectory + "/Reports/r1.rdlc";//
            ReportViewer1.LocalReport.EnableExternalImages = true;

            // 获取 MyHandler.jxd 的完整路径
            //string barcode_url = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath + "file/image/" + "/MyHandler.jxd?data=";
            string barcode_url = Request.Url.Scheme + "://" + Request.Url.Authority + Request.ApplicationPath + "file/image/";
            //+"file/image"

            //-> "http://localhost:6344/HttpHandlerDemo/MyHandler.jxd?data="



            if (dtPrint != null)
            {

                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(

                new Microsoft.Reporting.WebForms.ReportDataSource("Request_RequestReport", dtPrint));

                ReportViewer1.LocalReport.Refresh();


                string doc_type_to = "相關制單";
                string color = "N001";

                ReportViewer1.LocalReport.ReportPath = "Reports\\r1.rdlc";//Report1.rdlc;
                ReportViewer1.LocalReport.EnableExternalImages = true;
                //ReportViewer1.LocalReport.SetParameters(new ReportParameter(doc_type_to));//, Guid.NewGuid().ToString()


                ReportDataSource rds = new ReportDataSource("DataSet1", dtPrint);
                ReportViewer1.LocalReport.DataSources.Clear();
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.Refresh();

            }

            ReportViewer1.LocalReport.Refresh();

        }


        protected string GenBarCode(string code)
        {
            Random ran = new Random((int)DateTime.Now.Ticks);
            string filename = ran.Next(1, 100000).ToString() + ".bmp";
            BarcodeLib.Barcode b = new BarcodeLib.Barcode();
            b.IncludeLabel = true;
            b.RotateFlipType = 0;
            b.LabelPosition = BarcodeLib.LabelPositions.BOTTOMCENTER;
            var type = BarcodeLib.TYPE.CODE128;
            b.Encode(type, code, 120, 36);
            BarcodeLib.SaveTypes savetype = BarcodeLib.SaveTypes.UNSPECIFIED;
            savetype = BarcodeLib.SaveTypes.BMP;
            string imgAdd_d = "file/image/";
            string filepathname = Server.MapPath(imgAdd_d) + filename;
            b.SaveImage(filepathname, savetype);
            return filename;
        }
        protected void btnMoRemark_Click(object sender, EventArgs e)
        {
            //string strSql = "";
            //string mo_id = "";
            //txtMoRemark.Text = "";
            //txtSale.Text = "";
            //if (txtCorrMo.Text.Trim().Length >=9)
            //    mo_id = txtCorrMo.Text.Trim().Substring(0,9);
            //strSql = "Select a.merchandiser,c.production_remark " +
            //" FROM so_order_manage a " +
            //" Inner Join so_order_details b ON a.within_code=b.within_code AND a.id=b.id AND a.ver=b.ver" +
            //" Inner Join so_order_special_info c ON b.within_code=c.within_code AND b.id=c.id AND b.ver=c.ver AND b.sequence_id=c.upper_sequence" +
            //" Where a.within_code='" + within_code + "' AND b.mo_id='" + mo_id + "'";
            //DataTable dtMo = sh.ExecuteSqlReturnDataTableGeo(strSql);
            //if (dtMo != null)
            //{
            //    txtMoRemark.Text = dtMo.Rows[0]["production_remark"].ToString();
            //    txtSale.Text = dtMo.Rows[0]["merchandiser"].ToString();
            //}


            BindPrd_tem();
        }

        protected void BindPrd_tem()
        {
            if (txtCorrMo.Text.Trim() == "")
                return;
            string strSql = "";
            string prd_mo = txtPrd_mo.Text;
            txtMoRemark.Text = "";
            txtSale.Text = "";
            if (txtCorrMo.Text.Trim().Length >= 9)
                prd_mo = txtCorrMo.Text.Trim().Substring(0, 9);
            if (prd_mo != "" && prd_mo.Substring(0, 1) != "R")
                strSql = "Select a.merchandiser,d.production_remark,b.mo_id,c.goods_id,e.name AS goods_cdesc,c.id,e.do_color,f.name As color_name" +
                    ",b.customer_goods,b.customer_color_id" +
                    " FROM so_order_manage a" +
                    " Inner Join so_order_details b ON a.within_code=b.within_code AND a.id=b.id AND a.ver=b.ver" +
                    " Inner Join so_order_bom c On b.within_code=c.within_code AND b.id=c.id AND b.ver=c.ver  AND b.sequence_id=c.upper_sequence" +
                    " Inner Join so_order_special_info d ON b.within_code=d.within_code AND b.id=d.id AND b.ver=d.ver AND b.sequence_id=d.upper_sequence" +
                    " Inner Join it_goods e On c.within_code=e.within_code AND c.goods_id=e.id" +
                    " Left Join cd_color f On e.within_code=f.within_code AND e.color=f.id" +
                    " Where b.within_code ='" + within_code + "' AND b.mo_id='" + prd_mo + "'";
            else
                strSql = "Select b.charge_dept As merchandiser,a.repair_mo_id As production_remark,a.mo_id,b.goods_id,e.name AS goods_cdesc,a.id,e.do_color,f.name As color_name" +
                ",'' As customer_goods,'' As customer_color_id" +
                " FROM jo_production_repair_mostly a" +
                " Inner Join jo_production_repair_details b ON a.within_code=b.within_code AND a.id=b.id" +
                " Inner Join it_goods e On b.within_code=e.within_code AND b.goods_id=e.id" +
                " Left Join cd_color f On e.within_code=f.within_code AND e.color=f.id" +
                " Where a.within_code ='" + within_code + "' AND a.mo_id='" + prd_mo + "'";
            //strSql += " AND b.primary_key='" + "1" + "'";
            DataTable tbPrd_item = sh.ExecuteSqlReturnDataTableGeo(strSql);
            dlPrd_item.Items.Clear();
            if (tbPrd_item.Rows.Count > 0)
            {
                dlPrd_item.DataSource = tbPrd_item.DefaultView;
                dlPrd_item.DataTextField = "goods_id";
                dlPrd_item.DataValueField = "goods_cdesc";
                dlPrd_item.DataBind();
                txtItem_cdesc.Text = tbPrd_item.Rows[0]["goods_cdesc"].ToString();
                txtMoRemark.Text = tbPrd_item.Rows[0]["production_remark"].ToString();
                txtSale.Text = tbPrd_item.Rows[0]["merchandiser"].ToString();
                txtDoColor.Text = tbPrd_item.Rows[0]["do_color"].ToString();
                txtColorDesc.Text = tbPrd_item.Rows[0]["color_name"].ToString();
                txtCustitem.Text = tbPrd_item.Rows[0]["customer_goods"].ToString();
                txtCustclr.Text = tbPrd_item.Rows[0]["customer_color_id"].ToString();
                //if (dlAction_type.SelectedValue.ToString() == "01")
                //{
                //    txtCustitem.Text = tbPrd_item.Rows[0]["customer_goods"].ToString();
                //    txtCustclr.Text = tbPrd_item.Rows[0]["customer_color_id"].ToString();
                //}
                //else
                //{
                //    if(txtCustitem.Text=="")
                //        txtCustitem.Text = tbPrd_item.Rows[0]["customer_goods"].ToString();
                //    if (txtCustclr.Text == "")
                //        txtCustclr.Text = tbPrd_item.Rows[0]["customer_color_id"].ToString();
                //}
            }

        }

        protected void LoadGoodsDesc()
        {
            string strSql = "";
            string item = dlPrd_item.SelectedItem.ToString();
            //txtItem_cdesc.Text = dlPrd_item.SelectedValue.ToString();//.SelectedItem.ToString();//.SelectedValue;
            strSql = "Select a.name AS goods_cdesc,a.do_color,b.name As color_name" +
                " FROM  it_goods a" +
                " Left Join cd_color b On a.within_code=b.within_code  And a.color=b.id" +
                " Where a.within_code ='" + within_code + "' AND a.id='" + item + "'";
            DataTable tbItem = sh.ExecuteSqlReturnDataTableGeo(strSql);
            if (tbItem.Rows.Count > 0)
            {
                txtItem_cdesc.Text = tbItem.Rows[0]["goods_cdesc"].ToString();
                txtDoColor.Text = tbItem.Rows[0]["do_color"].ToString();
                txtColorDesc.Text = tbItem.Rows[0]["color_name"].ToString();
            }
            else
            {
                txtItem_cdesc.Text = "";
                txtDoColor.Text = "";
                txtColorDesc.Text = "";
            }
        }

    }
}