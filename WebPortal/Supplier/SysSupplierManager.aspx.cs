using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model;
using Leyp.Components;
using Leyp.Components.Module;

public partial class Supplier_SysSupplierManager : SysSupplierManager
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBand();
        }
    }
    protected void AddButton_Click(object sender, EventArgs e)
    {
            string strSupplierName = SupplierName.Text.ToString();
            string strArea = Area.Text.ToString();
            string strPostcode = Postcode.Text.ToString();
            string strAddress = Address.Text.ToString();
            string strLinkman = Linkman.Text.ToString();
            string strTel = Tel.Text.ToString();
            string strWebUrl = WebUrl.Text.ToString();
            string strEmail = Email.Text.ToString();
            //string strBankname = Bankname.Text.ToString();
           // string strBankAccount = BankAccount.Text.ToString();
            string strTaxNum = TaxNum.Text.ToString();
            string strCreateDate = CreateDate.Text.ToString();
            string strState = State.Text.ToString();
            string strDescription = Description.Text.ToString();

            Supplier sp = new Supplier();
                                
                    sp.SupplierName	=strSupplierName;
                    sp.Area	=strArea;
                    sp.Postcode =strPostcode;
                    sp.Address	=strAddress;
                    sp.Linkman	=strLinkman;
                    sp.Tel	=strTel;
                    sp.WebUrl	=strWebUrl;
                    sp.Email	=strEmail;
                    sp.Bankname	="停用";
                    sp.BankAccount	="无";
                    sp.TaxNum=strTaxNum;
                    sp.CreateDate=strCreateDate;
                    sp.State=strState;
                    sp.Description = strDescription;
                    if (act.Text.ToString().Equals("edit"))
                    {

                        sp.SupplierID = int.Parse(SupplierIDs.Text.ToString());
                        if (Leyp.SQLServerDAL.Factory.getSupplierDAL().updateSupplier(sp))
                        {
                            addSystemLog("成功修改供应商：" + strSupplierName);
                            HyperLink1.Visible = true;
                            addPanel.Visible = false;
                          
                        }
                        else
                        {
                            HyperLink1.Visible = true;
                            HyperLink1.Text = "操作失败！";
                            addPanel.Visible = false;
                        }
                    }
                    else
                    {
                        if (Leyp.SQLServerDAL.Factory.getSupplierDAL().insertNewSupplier(sp))
                        {

                            addSystemLog("新添供应商：" + strSupplierName);
                            HyperLink1.Visible = true;
                            addPanel.Visible = false;

                        }
                        else
                        {
                            HyperLink1.Visible = true;
                            HyperLink1.Text = "操作失败！";

                            addPanel.Visible = false;

                        }
                    
                    
                    }

          
    }


    protected void DataBand()
    {   
        object action=Request.QueryString["action"];
        if (action==null)
        {
            addPanel.Visible = false;
            DataGridViewBand();
           
        }
        else if (action.ToString().Equals("add"))
        {
            ViewPanel.Visible = false;
        }
        else if (action.ToString().Equals("edit"))
        {
            //try
            //{
                string supplierID = Request.QueryString["SupplierID"].ToString();
                Supplier sp = new Supplier();
                sp = Leyp.SQLServerDAL.Factory.getSupplierDAL().getBySupplierID(int.Parse(supplierID));

                SupplierName.Text = sp.SupplierName;
                Area.Text = sp.Area;
                Postcode.Text = sp.Postcode;
                Address.Text = sp.Address;
                Linkman.Text = sp.Linkman;
                Tel.Text = sp.Tel;
                WebUrl.Text = sp.WebUrl;
                Email.Text = sp.Email;
               // Bankname.Text = sp.Bankname;
                //BankAccount.Text = sp.BankAccount;
                TaxNum.Text = sp.TaxNum;
                CreateDate.Text = sp.CreateDate;

                Description.Text = sp.Description;
                
                act.Text = "edit";
                SupplierIDs.Text = supplierID;
                ViewPanel.Visible = false;


                //}
                //catch
                //{
                //    Response.Write("输入有误！");
                //    Response.End();
                //}
        }
        else if (action.ToString().Equals("del"))
        {
            string supplierID = Request.QueryString["SupplierID"].ToString();

            Jscript.AjaxAlert(this, "有待解决");
            DataGridViewBand();

        
        }


       
    }

       
    /// <summary>
    /// GridView 绑定
    /// </summary>
      protected void DataGridViewBand()
      {
        CollectionPager1.DataSource = Leyp.SQLServerDAL.Factory.getSupplierDAL().getAllSupplier();//List数据源
        CollectionPager1.BindToControl = SupplierList;
        SupplierList.DataSource = CollectionPager1.DataSourcePaged;
      
      }


    protected void SupplierList_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string SupplierID=SupplierList.DataKeys[e.RowIndex]["SupplierID"].ToString();
        Jscript.OpenWebFormSize("SupplierDetail.aspx?SupplierID=" + SupplierID + "", 600, 500, 10, 100);
        return;
    } 
}
