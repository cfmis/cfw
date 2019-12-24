using System;
using System.Collections.Generic;
using System.Text;

namespace Leyp.Model
{
   public class PhotoFlow
    {

        private int _FlowID;

        public int FlowID
        {
            get { return _FlowID; }
            set { _FlowID = value; }
        }
        private string _FlowTitle;

        public string FlowTitle
        {
            get { return _FlowTitle; }
            set { _FlowTitle = value; }
        }
        private string _CreateDate;

        public string CreateDate
        {
            get { return _CreateDate; }
            set { _CreateDate = value; }
        }
        private string _UserName;

        public string UserName
        {
            get { return _UserName; }
            set { _UserName = value; }
        }
        private string _Content;

        public string Content
        {
            get { return _Content; }
            set { _Content = value; }
        }
        private string _Reply;

        public string Reply
        {
            get { return _Reply; }
            set { _Reply = value; }
        }
        private int _State;

        public int State
        {
            get { return _State; }
            set { _State = value; }
        }

        private string _AuditingUser;

        public string AuditingUser
        {
            get { return _AuditingUser; }
            set { _AuditingUser = value; }
        }

    }
}
