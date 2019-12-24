using System;
using System.Collections.Generic;
using System.Text;
//using Leyp.Components.Module;

namespace Leyp.Components
{

    /// <summary>
    /// 噙怓曹講扢离濬
    /// </summary>
    public class Base
    {

        public static int Delivery_YT = 1;//埴籵

        public static int Delivery_PY = 2;//す蚘

        public static int Delivery_ST = 3;//扠籵

        //public static string user_id = new BaseLogin().getUserName();//"admin";//此變量用於保存當前登入的用戶ID
        public static string comp_type = "DG";//設定公司代碼
        public static string within_code = "0000";//設定公司代碼Geo
        public static string imageDetaultPath = "Y://Artwork//";
        public static string image_map_path = "/cf_art/artwork/";
        public static string lang_id = "0";
        public static string remote_db = "dgerp2.cferp.dbo.";
        public static string temp_path_images_relative = "../temp_files/images/";//臨時產生圖片的存放路徑(相對路徑)
        public static string temp_path_images_report = "/temp_files/images/";//臨時產生圖片在報表中使用
    }
}
