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

public partial class Supplier_SupplierDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            init();
        }

    }


    /// <summary>
    /// 
    /// </summary>
    protected void init()
    {
        string SupplierID = Request.QueryString["SupplierID"].ToString();
        Supplier sp = new Supplier();
        sp = Leyp.SQLServerDAL.Factory.getSupplierDAL().getBySupplierID(int.Parse(SupplierID));

        if (sp != null)
        {

            SupplierName.Text = sp.SupplierName;
            Area.Text = sp.Area;
            Postcode.Text = sp.Postcode;
            Address.Text = sp.Address;
            Linkman.Text = sp.Linkman;
            Tel.Text = sp.Tel;
            WebUrl.Text = sp.WebUrl;
            Email.Text = sp.Email;
           // Bankname.Text = sp.Bankname;
           // BankAccount.Text = sp.BankAccount;
            TaxNum.Text = sp.TaxNum;
            CreateDate.Text = sp.CreateDate;

            Description.Text = sp.Description;



        }
        else
        {
            Response.Write("没有您要的数据");

            Response.End();


        }
    
    }
}
