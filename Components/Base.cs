using System;
using System.Collections.Generic;
using System.Text;
//using Leyp.Components.Module;

namespace Leyp.Components
{

    /// <summary>
    /// ��̬����������
    /// </summary>
    public class Base
    {

        public static int Delivery_YT = 1;//Բͨ

        public static int Delivery_PY = 2;//ƽ��

        public static int Delivery_ST = 3;//��ͨ

        //public static string user_id = new BaseLogin().getUserName();//"admin";//���ܶq�Ω�O�s��e�n�J���Τ�ID
        public static string comp_type = "DG";//�]�w���q�N�X
        public static string within_code = "0000";//�]�w���q�N�XGeo
        public static string imageDetaultPath = "Y://Artwork//";
        public static string image_map_path = "/cf_art/artwork/";
        public static string lang_id = "0";
        public static string remote_db = "dgerp2.cferp.dbo.";
        public static string temp_path_images_relative = "../temp_files/images/";//�{�ɲ��͹Ϥ����s����|(�۹���|)
        public static string temp_path_images_report = "/temp_files/images/";//�{�ɲ��͹Ϥ��b�����ϥ�
    }
}
