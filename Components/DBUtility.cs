using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
//using System.Xml.Linq;
using System.Security.Cryptography;
using System.Text;
//using Leyp.Components.Module;

namespace Leyp.Components
{
    public class DBUtility// abstract
    {
        //public static string user_id = new BaseLogin().getUserName();//"admin";//此變量用於保存當前登入的用戶ID
        public static string comp_type = "DG";//設定公司代碼
        public static string within_code = "0000";//設定公司代碼Geo
        public static string imageDetaultPath = "Y://Artwork//";
        public static string image_map_path = "/cf_art/artwork/";
        public static string lang_id = "0";
        public static string remote_db = "dgerp2.cferp.dbo.";
        public static string lnsql1_dgcf_pad = "lnsql1.dgcf_pad.dbo.";
    }
}