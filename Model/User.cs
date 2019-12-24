using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
    public class User
    {
        private string _UserName;
        private string _Password;
        private int _TypeID;
        private int _SubClassID;

      
        private string _RealName;
        private string _Sex;
        private int _GroupID;
        private string _Dept;
        private string _Tel;
        private string _Email;
        private string _QQ;
        private string _WangWang;
        private string _Description;
        private string _State;
        private string _Lang;


        private string _Character="";

        public string Character
        {
            get { return _Character; }
            set { _Character = value; }
        }
        private string _Address="";

        public string Address
        {
            get { return _Address; }
            set { _Address = value; }
        }
        private string _CompanyName="";

        public string CompanyName
        {
            get { return _CompanyName; }
            set { _CompanyName = value; }
        }
        private string _CompanyInfo="";

        public string CompanyInfo
        {
            get { return _CompanyInfo; }
            set { _CompanyInfo = value; }
        }
        private string _Bankname="";

        public string Bankname
        {
            get { return _Bankname; }
            set { _Bankname = value; }
        }
        private string _BankAccount="";

        public string BankAccount
        {
            get { return _BankAccount; }
            set { _BankAccount = value; }
        }
        private string _LatelyLogin="";

        public string LatelyLogin
        {
            get { return _LatelyLogin; }
            set { _LatelyLogin = value; }
        }



        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Password
        {
            get { return _Password; }
            set { _Password = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int TypeID
        {
            get { return _TypeID; }
            set { _TypeID = value; }
        
        }
        /// <summary>
        /// 
        /// </summary>
        public int SubClassID
        {
            get { return _SubClassID; }
            set { _SubClassID = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string RealName
        {
            get { return _RealName; }
            set { _RealName = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Sex
        {
            get { return _Sex; }
            set { _Sex = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public int GroupID
        {
            get { return _GroupID; }
            set { _GroupID = value; }
        }

         /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string  Dept
        {
            get { return _Dept; }
            set { _Dept = value; }
        }
        

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Tel
        {
            get { return _Tel; }
            set { _Tel = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Email
        {
            get { return _Email; }
            set { _Email = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string QQ
        {
            get { return _QQ; }
            set { _QQ = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string WangWang
        {
            get { return _WangWang; }
            set { _WangWang = value; }
        }
        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Description
        {
            get { return _Description; }
            set { _Description = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string State
        {
            get { return _State; }
            set { _State = value; }
        }

        /// <summary>
        /// 对应数据库表字段 一样名称
        /// </summary>
        public string Lang
        {
            get { return _Lang; }
            set { _Lang = value; }
        }
    }
}
