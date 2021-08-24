using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Leyp.Model;
using Leyp.Model.View;
using Leyp.Components.Module;

public partial class Desk : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            init();
        }
    }
    protected void init()
    {
        List<Notice> list0 = new List<Notice>();
        List<Notice> list1 = new List<Notice>();
        List<Notice> list2 = new List<Notice>();

       
        Leyp.SQLServerDAL.NoticeDAL dl = Leyp.SQLServerDAL.Factory.getNoticeDAL();

        List<VServiceInfo> list3 = null;
        List<VServiceInfo> list30 = new List<VServiceInfo>();
        list3 = Leyp.SQLServerDAL.Factory.getServiceInfoDAL().getMyTopic(getUserName());
        for (int i = 0; i < list3.Count; i++)
        {
            VServiceInfo s = list3[i];
            list30.Add(s);
            if (i == 4)
              break;
        
        }

        list0 = dl.getNewsByType(0);//通知
        list1=dl.getNewsByType(1);//热销活动
        list2 = dl.getNewsByType(2);//会议

        Noticelist.DataSource = list0;
        Noticelist.DataBind();

        NewsSales.DataSource = list1;
        NewsSales.DataBind();

        MeetingRepeater.DataSource = list2;
        MeetingRepeater.DataBind();

        VServiceInfoList.DataSource = list30;
        VServiceInfoList.DataBind();

    
    }

    public  string setToString(string str)
    {

        if (str == "0")
        {
            return "未受理";
        }
        else if (str == "1")
        {

            return "受理中";
        }
        else if (str == "2")
        {

            return "已解决";
        }
        else
        {

            return "过期";
        }
     
    }

}
