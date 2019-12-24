
namespace Leyp.SQLServerDAL
{
    using Leyp.Model;
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.SqlClient;


    public class PublicAppDAL
    {

        private SQLHelp sh = new SQLHelp();
        
        //字符轉換成條形碼
        public string StringToBarCode(string StrCode)
        {
            string BarCode = "";
            //DataTable dtBarCode = new DataTable();
            //DataSet set = new DataSet();
            //SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@StrCode", SqlDbType.Char) };
            //parameters[0].Value = StrCode;
            //set = SQLHelper.RunProcedure("usp_StringToBarCode", parameters, "dd");
            //dtBarCode = set.Tables["dd"];
            //if (dtBarCode.Rows.Count > 0)
            //{
            //    BarCode = dtBarCode.Rows[0]["StrBarCode"].ToString();
            //}


            string strSql = @"select dbo.StrToCode128B(rtrim(" + StrCode + ")) AS StrBarCode ";
            DataTable dtBarCode = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtBarCode.Rows.Count > 0)
            {
                BarCode = dtBarCode.Rows[0]["StrBarCode"].ToString();
            }
            return BarCode;
        }

        public string GenSeq(string tbName, string doc_id)
        {
            string seq = "";
            
            String user_id = "ADMIN";
            String comp_type = "DG";
            string strSql = "Select MAX(seq) AS max_seq From " + tbName + " Where comp_type='" + comp_type + "' AND doc_id='" + doc_id + "'";
            DataTable dtGenNo = sh.ExecuteSqlReturnDataTable(strSql);
            if (dtGenNo.Rows.Count > 0)
            {
                if (dtGenNo.Rows[0]["max_seq"].ToString() == "")
                    seq = "0001";
                else
                {
                    seq = (Convert.ToInt32(dtGenNo.Rows[0]["max_seq"]) + 1).ToString().PadLeft(4, '0');
                }
            }
            else
                seq = "0001";
            return seq;
        }

        public string GetArtWorkImagePath(string item)
        {
            string strImagePath = "";
            string within_code = "0000";
            string strSql = @"SELECT b.sequence_id AS art_id,b.picture_name
                   FROM  it_goods a
                   INNER JOIN cd_pattern_details b ON a.within_code=b.within_code AND a.blueprint_id=b.id
                   WHERE a.within_code='" + within_code + "' and a.id='" + item + "' ";
            DataTable dtTemp = sh.ExecuteSqlReturnDataTableGeo(strSql);

            if (dtTemp.Rows.Count > 0)
            {
                //strImagePath = dtTemp.Rows[0]["picture_name"].ToString().Trim();
                string str1 = "";
                strImagePath = dtTemp.Rows[0]["picture_name"].ToString().Trim();
                for (int i = 0; i < strImagePath.Length; i++)
                {
                    if (strImagePath.Substring(i, 1) == "\\")
                        str1 += "/";
                    else
                        str1 += strImagePath.Substring(i, 1);
                }
                strImagePath = str1;
            }
            return strImagePath;
        }


        //Geo系統中的解密
        public string GeoEncrypt(string strEncrypt)
        {
            //函數說明：傳入用戶密碼(原碼),返回加密之後的字串
            //參數：as_code(輸入的密碼原碼).
            //返回值：ls_EncryptPass 加密之後的字串
            //ChingFung可以寫一個類似的函數，將加密之後的字串與目前資料庫中保存的密碼去比較,如果相等就表示輸入的密碼正確。
            //定義函數使用到的變數
            string ls_TempString, ls_Work, ls_EncryptPass, ls_DecryptString, ls_EncryptString, as_code;
            int li_Length, li_Position, li_Multiplier, li_Offset, li_Count;
            as_code = strEncrypt;// 輸入的密碼
            //--將輸入的密碼轉化為小寫字元
            ls_TempString = as_code.ToLower();
            //定義加密解密的字串,這一些字元是固定的.不允許修改.
            //以雙引號開始,同樣以雙引號結束，比如："123456",表示123456這幾個字元.

            ls_DecryptString = " !" + "\"" + "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[" + "\\" + "]^_`abcdefghijklmnopqrstuvwxyz{|}~";
            ls_EncryptString = "~{[}u;Ce83KX%:VIm!|gs]_aL-QEOpx<UlzZjBq6#1($" + "\\" + "\"" + "FS5H0'cM&>Po.NGA*Jr)Y" + " " + "Dv/t9kd?^fni,hR2Wy=`+4T@7wb";


            //取得輸入的密碼長度
            li_Length = as_code.Trim().Length;
            //--根據不同的密碼長度得到不同的加密方法的字元長度倍數
            if (1 <= li_Length && li_Length <= 3)
                li_Multiplier = 1;
            else
                if (4 <= li_Length && li_Length <= 6)
                    li_Multiplier = 2;
                else
                    if (7 <= li_Length && li_Length <= 9)
                        li_Multiplier = 3;
                    else
                        li_Multiplier = 4;
            ls_EncryptPass = "";//先將保存加密之後字串清空。

            //以下為迴圈密碼每一位元字元,對每一位元字元進行加密
            for (li_Count = 1; li_Count <= li_Length; li_Count++)
            {
                li_Offset = li_Count * li_Multiplier;
                //取密碼中的第li_count位元的字元，長度為1
                //使用方法：Mid(需要取值的字串,開始位置，長度)
                ls_Work = as_code.Substring(li_Count - 1, 1);//SUBSTR(as_code, li_Count, 1);
                //取到ls_work字元在ls_decryptstring中的第一個位置
                //使用方法：Pos(用來查找的字串，需要查找的字串)
                li_Position = ls_DecryptString.IndexOf(ls_Work) + 1;//substring(ls_Work,ls_DecryptString);
                li_Position = li_Position + li_Offset;
                //Mod是取模函數，即取到Li_positon除以95之後的餘數
                li_Position = li_Position % 95;//Mod(li_Position, 95);
                //將li_position值加1 ，相當於li_postion = li_postion + 1
                li_Position = li_Position + 1;
                //取到ls_EncryptString中第li_Position開始的1位元字元
                ls_Work = ls_EncryptString.Substring(li_Position - 1, 1);//SUBSTR(ls_EncryptString, li_Position, 1);
                //將加密之後的字元相加,得到加密結果字串.
                ls_EncryptPass = ls_EncryptPass + ls_Work;
                //重新設置加密方法的字元長度倍數
                if (1 <= li_Multiplier && li_Multiplier <= 3)
                    li_Multiplier = li_Multiplier + 1;
                else
                    li_Multiplier = 1;
            }
            //--將加密之後的字元返回
            return ls_EncryptPass;
        }


        

    }
}