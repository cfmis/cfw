using System;
using System.ComponentModel;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;

namespace Controls
{     

     #region 该控件需要用到的枚举类型

    public enum PreViewPosition
    {
        Top,
        Left,
        Right,
        Bottom
    }

    public enum WatermarkType
    {
        None,
        Image,
        Text
    }

    public enum WatermarkPosition
    {
        TopLeft,
        TopCenter,
        TopRight,
        MiddleLeft,
        MiddleCenter,
        MiddleRight,
        BottomLeft,
        BottomCenter,
        BottomRight
    }

    public enum Rename
    {
        NotSet,
        Guid,
        DateTime
    }
    #endregion
    public class ImageUploader : WebControl, INamingContainer, IPostBackDataHandler, IDisposable
    {
        #region 变量

        #region JS

        private const string FILE_UPLOAD_SCRIPT =
@"<script language='javascript'>
function PreView(ImageSelector, PreViewControl, PreviewImageUrl)
{
    if(ImageSelector.value == '')
    {
        PreViewControl.src = PreviewImageUrl;
    }
    else
    {
        PreViewControl.src = ImageSelector.value;
    }
}
</script>";

        private const string FILE_UPLOAD_SCRIPT_ID = "3116a486-11e0-4197-b3aa-b7707cc08129";
        private const string FILE_UPLOAD_HOOK = "PreView({0}, {1}, {2});";

        #endregion

        #region 控件变量
        FileUpload _fileUpload = null;
        Button _btnSave = null;
        HtmlImage _imgPreView = null;
        #endregion

        #region 储值变量

        #endregion

        #region 外观控制变量
        /// <summary>
        /// 上传按钮的文本
        /// </summary>
        private string _strButtonSaveText = "上传";
        /// <summary>
        /// 上传按钮的CSS样式
        /// </summary>
        private string _strButtonSaveCSSClass = string.Empty;
        /// <summary>
        /// 是否显示图片预览
        /// </summary>
        private bool _bIsShowPreView = true;
        /// <summary>
        /// 图片预览的位置
        /// </summary>
        private PreViewPosition _enumPreViewPosition = PreViewPosition.Bottom;
        /// <summary>
        /// 图片预览的CSS样式
        /// </summary>
        private string _strPreViewCSSClass = string.Empty;
        /// <summary>
        /// 默认图片预览位置的占位图片
        /// </summary>
        private string _strPreViewImageUrl = "./ZYT_Client/Styles/Default/Images/PreView.gif";
        #endregion

        #region 其他变量
        string _strPicSavePath = "../UploadFiles/Images/";
        string _strPicSavedName = string.Empty;
        string _strPicSavedPath = string.Empty;

        string _strPicThumbSavePath = "../UploadFiles/Images/Thumb/";
        string _strPicThumbSavedPath = string.Empty;
        string _strPicThumbSavedName = string.Empty;

        string _strAllowType = ".jpg|.gif|.png|.bmp";
        int _iMaxSize = 2048;//单位为KB

        WatermarkType _enumWatermarkType = WatermarkType.None;
        string _strWatermarkText = "";
        System.Drawing.Font _fontWatermarkFont = new System.Drawing.Font("Arial", 12, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Pixel);//水印文字字体
        System.Drawing.Color _fontWatermarkColor = System.Drawing.Color.Black;
        string _strWatermarkImage = "./ZYT_Client/Styles/Default/Images/Watermark.png";
        byte _btWatermarkTransparency = 255;//水印透明度
        WatermarkPosition _enumWatermarkPosition = WatermarkPosition.BottomRight;//水印位置

        bool _bIsGenerateThumb = false;//是否产生缩略图
        int _iThumbMaxWidth = 400;//缩略图的最大宽度
        int _iThumbMaxHeight = 300;//缩略图的最大高度

        bool _bIsRename = true;//是否重命名
        Rename _enumRenameType = Rename.DateTime;//重命名方式

        string _strSuccessfulText = "成功上传一张图片。";
        bool _bIsAllowMulti = true;//是否允许多张上传
        #endregion

        #endregion

        #region 属性
        [Description("保存按钮的文本"), DefaultValue("上传")]
        public string SaveButtonText
        {
            get { return _strButtonSaveText; }
            set { _strButtonSaveText = value; }
        }

        [Description("保存按钮的CSS样式"), DefaultValue("")]
        public string SaveButtonCSSClass
        {
            get { return _strButtonSaveCSSClass; }
            set { _strButtonSaveCSSClass = value; }
        }

        [Description("是否显示预览"), DefaultValue(true)]
        public bool IsShowPreView
        {
            get { return _bIsShowPreView; }
            set { _bIsShowPreView = value; }
        }

        [Description("预览图片的位置"), DefaultValue(PreViewPosition.Bottom)]
        public PreViewPosition PreviewProsition
        {
            get { return _enumPreViewPosition; }
            set { _enumPreViewPosition = value; }
        }

        [Description("图片预览的CSS样式"), DefaultValue("")]
        public string PreViewCSSClass
        {
            set { _strPreViewCSSClass = value; }
            get { return _strPreViewCSSClass; }
        }

        [Description("预览图片的占位图片URL"), DefaultValue("./ZYT_Client/Styles/Default/Images/PreView.gif")]
        public string DefaultPreviewImageURL
        {
            get { return _strPreViewImageUrl; }
            set { _strPreViewImageUrl = value; }
        }

        [Description("图片的保存路径（相对路径，格式：~/UploadFiles/Images/）"), DefaultValue("~/UploadFiles/Images/")]
        public string PicSavePath
        {
            set
            {
                _strPicSavePath = value;
                if (!_strPicSavePath.EndsWith("/"))
                {
                    _strPicSavePath += "/";
                }
            }
            get { return _strPicSavePath; }
        }

        [Description("缩略图的保存路径（相对路径，格式：~/UploadFiles/Images/）"), DefaultValue("~/UploadFiles/Images/Thumb/")]
        public string PicThumbSavePath
        {
            set
            {
                _strPicThumbSavePath = value;
                if (!_strPicThumbSavedName.EndsWith("/"))
                {
                    _strPicThumbSavedPath += "/";
                }
            }
            get { return _strPicThumbSavePath; }
        }
        [Description("只读：原图保存后的名字"), Browsable(false)]
        public string PicSavedName
        {
            get { return _strPicSavedName; }
        }

        [Description("只读：缩略图保存后的名字"), Browsable(false)]
        public string PicThumbSavedName
        {
            get { return _strPicThumbSavedName; }
        }

        [Description("只读：原图的保存路径（返回格式如下：~/UploadFiles/Images/20061007143725222.jpg）"), Browsable(false)]
        public string PicSavedPath
        {
            get { return _strPicSavedPath; }
        }

        [Description("只读：缩略图保存的路径（相对路径，格式：~/UploadFiles/Images/thumb_20061007143725222.jpg）"), Browsable(false)]
        public string PicThumbSavedPath
        {
            get { return _strPicThumbSavedPath; }
        }

        [Description("读取或设置允许上传的图片类型的扩展名（格式：.jpg|.gif|.bmp）"), DefaultValue(".jpg|.gif|.bmp|.png")]
        public string AllowPicType
        {
            set { _strAllowType = value; }
            get { return _strAllowType; }
        }

        [Description("读取或设置允许上传的图片大小(KB)"), DefaultValue(2048)]
        public int MaxSize
        {
            get
            {
                return _iMaxSize;
            }
            set
            {
                if (value <= 0)
                {
                    _iMaxSize = 0;
                }
                else
                {
                    try
                    {
                        _iMaxSize = value;
                    }
                    catch
                    {
                        _iMaxSize = int.MaxValue;
                    }
                }
            }
        }

        [Description("读取或设置水印类型"), DefaultValue(WatermarkType.None)]
        public WatermarkType WatermarkType
        {
            get { return _enumWatermarkType; }
            set { _enumWatermarkType = value; }
        }

        [Description("读取或设置水印文字"), DefaultValue("")]
        public string WatermarkText
        {
            get { return _strWatermarkText; }
            set { _strWatermarkText = value; }
        }

        [Description("读取或设置水印文字的字体")]
        public System.Drawing.Font WatermarkTextFont
        {
            get { return _fontWatermarkFont; }
            set { _fontWatermarkFont = value; }
        }

        [Description("读取或设置水印文字的颜色")]
        public System.Drawing.Color WatermarkTextColor
        {
            get { return _fontWatermarkColor; }
            set { _fontWatermarkColor = value; }
        }

        [Description("读取或设置水印图片地址"), DefaultValue("./ZYT_Client/Styles/Default/Images/Watermark.png")]
        public string WatermarkImage
        {
            get { return _strWatermarkImage; }
            set { _strWatermarkImage = value; }
        }

        [Description("读取或设置水印的透明度"), DefaultValue(255)]
        public byte WatermarkTransparency
        {
            get { return _btWatermarkTransparency; }
            set
            {
                _btWatermarkTransparency = value;
            }
        }

        [Description("读取或设置水印的位置"), DefaultValue(WatermarkPosition.BottomRight)]
        public WatermarkPosition WatermarkPosition
        {
            get { return _enumWatermarkPosition; }
            set { _enumWatermarkPosition = value; }
        }

        [Description("读取或设置是否产生缩略图"), DefaultValue(false)]
        public bool IsGenerateThumb
        {
            get { return _bIsGenerateThumb; }
            set { _bIsGenerateThumb = value; }
        }

        [Description("读取或设置缩略图的最大宽度"), DefaultValue(400)]
        public int ThumbMaxWidth
        {
            get { return _iThumbMaxWidth; }
            set { _iThumbMaxWidth = value; }
        }

        [Description("读取或设置缩略图的最大高度"), DefaultValue(300)]
        public int ThumbMaxHeight
        {
            get { return _iThumbMaxHeight; }
            set { _iThumbMaxHeight = value; }
        }

        [Description("读取或设置是否重命名"), DefaultValue(true)]
        public bool IsRename
        {
            get { return _bIsRename; }
            set { _bIsRename = value; }
        }

        [Description("读取或设置重命名方式"), DefaultValue(Rename.DateTime)]
        public Rename RenameType
        {
            get { return _enumRenameType; }
            set { _enumRenameType = value; }
        }

        [Description("读取或设置上传成功后的提示文本"), DefaultValue("成功上传一张图片。")]
        public string SuccessfulText
        {
            get { return _strSuccessfulText; }
            set { _strSuccessfulText = value; }
        }

        [Description("读取或设置是否允许多张上传"), DefaultValue(false)]
        public bool AllowMulti
        {
            get { return _bIsAllowMulti; }
            set { _bIsAllowMulti = value; }
        }
        #endregion

        #region 定义事件
        public static object uploadEvent = new object();
        public event EventHandler Upload
        {
            add
            {
                Events.AddHandler(uploadEvent, value);
            }
            remove
            {
                Events.RemoveHandler(uploadEvent, value);
            }
        }

        protected override bool OnBubbleEvent(object source, EventArgs args)
        {
            if (source is Button)
            {
                OnUpload(null);
                return true;
            }
            return base.OnBubbleEvent(source, args);
        }

        protected virtual void OnUpload(EventArgs args)
        {
            EventHandler uploadHandler = (EventHandler)Events[uploadEvent];
            if (uploadHandler != null)
                uploadHandler(this, null);
            else
                base.RaiseBubbleEvent(this, args);
        }

        public event EventHandler Uploaded;
        public virtual void OnUploaded(EventArgs e)
        {
            if (Uploaded != null)
            {
                Uploaded(this, e);
            }
        }

        void _btnSave_Click(object sender, EventArgs e)
        {
            SaveOriginalPic();
            if (!_bIsAllowMulti)
            {
                _btnSave.Enabled = false;
            }
            OnUploaded(e);
            _imgPreView.Src = _strPicSavedPath;
        }
        #endregion

        #region 构造函数
        public ImageUploader()
        {
        }
        #endregion

        #region 重写的属性
        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Table;
            }
        }
        #endregion

        #region 重写的方法
        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            Page.RegisterRequiresPostBack(this);
            Page.ClientScript.GetPostBackClientHyperlink(this, "");
            if (!Page.ClientScript.IsClientScriptBlockRegistered(FILE_UPLOAD_SCRIPT_ID))
            {
                Page.ClientScript.RegisterClientScriptBlock(Type.GetType("System.String"), FILE_UPLOAD_SCRIPT_ID, FILE_UPLOAD_SCRIPT);
            }
        }

        protected override void CreateChildControls()
        {
            Controls.Clear();
            ClearChildViewState();
            CreateControlHierarchy();
            PrepareControlHierarchy();
            TrackViewState();
            ChildControlsCreated = true;
        }

        protected override void Render(HtmlTextWriter writer)
        {
            EnsureChildControls();
            base.Render(writer);
        }
        #endregion

        #region 私有方法

        #region 绘制控件
        protected virtual void CreateControlHierarchy()
        {
            _fileUpload = new FileUpload();
            _btnSave = new Button();
            _imgPreView = new HtmlImage();

            _fileUpload.ID = "fileUploadImage";
            _btnSave.ID = "btnSave";
            _imgPreView.ID = "imgPreview";

            //为图片选择控件添加JS事件
            _fileUpload.Attributes.Add("OnChange", string.Format(FILE_UPLOAD_HOOK, this.ClientID + "_fileUploadImage", this.ClientID + "_imgPreview", "\"" + _strPreViewImageUrl + "\""));
            //应用保存按钮的样式
            _btnSave.Attributes.Add("class", _strButtonSaveCSSClass);
            _btnSave.Text = _strButtonSaveText;
            _btnSave.Click += new EventHandler(_btnSave_Click);

            //设置预览图片的默认图片
            _imgPreView.Src = _strPreViewImageUrl;

            if (!_bIsShowPreView)//如果不显示预览图片
            {
                _imgPreView.Visible = false;
            }

            //应用预览图片的样式
            _imgPreView.Attributes.Add("class", _strPreViewCSSClass);

            ChildControlsCreated = true;
        }

        protected virtual void PrepareControlHierarchy()
        {
            switch (_enumPreViewPosition)
            {
                case PreViewPosition.Top:
                    TableRow rowPreview = new TableRow();
                    TableCell cellPreview = new TableCell();
                    cellPreview.ColumnSpan = 2;
                    cellPreview.Controls.Add(_imgPreView);
                    rowPreview.Cells.Add(cellPreview);
                    cellPreview.Dispose();//释放资源
                    Controls.Add(rowPreview);
                    rowPreview.Dispose();//释放资源

                    TableRow rowUpload = new TableRow();
                    TableCell cellUploadSelector = new TableCell();
                    cellUploadSelector.Controls.Add(_fileUpload);
                    rowUpload.Cells.Add(cellUploadSelector);
                    cellUploadSelector.Dispose();//释放资源

                    TableCell cellSaveButton = new TableCell();
                    cellSaveButton.Controls.Add(_btnSave);
                    rowUpload.Cells.Add(cellSaveButton);
                    cellSaveButton.Dispose();//释放资源
                    Controls.Add(rowUpload);

                    rowUpload.Dispose();//释放资源
                    break;
                case PreViewPosition.Right:
                    TableRow rowUpload1 = new TableRow();
                    TableCell cellUploadSelector1 = new TableCell();
                    cellUploadSelector1.Controls.Add(_fileUpload);
                    rowUpload1.Cells.Add(cellUploadSelector1);
                    cellUploadSelector1.Dispose();//释放资源

                    TableCell cellSaveButton1 = new TableCell();
                    cellSaveButton1.Controls.Add(_btnSave);
                    rowUpload1.Cells.Add(cellSaveButton1);
                    cellSaveButton1.Dispose();//释放资源
                    Controls.Add(rowUpload1);

                    TableCell cellPreview1 = new TableCell();
                    cellPreview1.Controls.Add(_imgPreView);
                    rowUpload1.Cells.Add(cellPreview1);
                    cellPreview1.Dispose();//释放资源
                    Controls.Add(rowUpload1);

                    rowUpload1.Dispose();//释放资源
                    break;
                case PreViewPosition.Bottom:
                    TableRow rowUpload2 = new TableRow();
                    TableCell cellUploadSelector2 = new TableCell();
                    cellUploadSelector2.Controls.Add(_fileUpload);
                    rowUpload2.Cells.Add(cellUploadSelector2);
                    cellUploadSelector2.Dispose();//释放资源

                    TableCell cellSaveButton2 = new TableCell();
                    cellSaveButton2.Controls.Add(_btnSave);
                    rowUpload2.Cells.Add(cellSaveButton2);
                    cellSaveButton2.Dispose();//释放资源
                    Controls.Add(rowUpload2);

                    rowUpload2.Dispose();//释放资源

                    TableRow rowPreview2 = new TableRow();
                    TableCell cellPreview2 = new TableCell();
                    cellPreview2.ColumnSpan = 2;
                    cellPreview2.Controls.Add(_imgPreView);
                    rowPreview2.Cells.Add(cellPreview2);
                    cellPreview2.Dispose();//释放资源
                    Controls.Add(rowPreview2);
                    rowPreview2.Dispose();//释放资源
                    break;
                case PreViewPosition.Left:
                    TableRow rowUpload3 = new TableRow();

                    TableCell cellPreview3 = new TableCell();
                    cellPreview3.Controls.Add(_imgPreView);
                    rowUpload3.Cells.Add(cellPreview3);
                    cellPreview3.Dispose();//释放资源
                    Controls.Add(rowUpload3);

                    TableCell cellUploadSelector3 = new TableCell();
                    cellUploadSelector3.Controls.Add(_fileUpload);
                    rowUpload3.Cells.Add(cellUploadSelector3);
                    cellUploadSelector3.Dispose();//释放资源

                    TableCell cellSaveButton3 = new TableCell();
                    cellSaveButton3.Controls.Add(_btnSave);
                    rowUpload3.Cells.Add(cellSaveButton3);
                    cellSaveButton3.Dispose();//释放资源
                    Controls.Add(rowUpload3);

                    rowUpload3.Dispose();//释放资源
                    break;
                default:
                    TableRow rowUpload4 = new TableRow();
                    TableCell cellUploadSelector4 = new TableCell();
                    cellUploadSelector4.Controls.Add(_fileUpload);
                    rowUpload4.Cells.Add(cellUploadSelector4);
                    cellUploadSelector4.Dispose();//释放资源

                    TableCell cellSaveButton4 = new TableCell();
                    cellSaveButton4.Controls.Add(_btnSave);
                    rowUpload4.Cells.Add(cellSaveButton4);
                    cellSaveButton4.Dispose();//释放资源
                    Controls.Add(rowUpload4);

                    TableCell cellPreview4 = new TableCell();
                    cellPreview4.Controls.Add(_imgPreView);
                    rowUpload4.Cells.Add(cellPreview4);
                    cellPreview4.Dispose();//释放资源
                    Controls.Add(rowUpload4);

                    rowUpload4.Dispose();//释放资源
                    break;
            }
        }
        #endregion

        #region 上传图片

        /// <summary>
        /// 保存原图
        /// </summary>
        private void SaveOriginalPic()
        {
            //取得上传的文件
            System.Web.HttpPostedFile hpfImage = _fileUpload.PostedFile;

            string strPicName = hpfImage.FileName;
            string strPicNameWithExtend = strPicName.Substring(strPicName.LastIndexOf('\\') + 1);//取带有扩展名的文件名
            string strPicNameWithoutExtend = strPicNameWithExtend.Substring(0, strPicNameWithExtend.IndexOf('.'));//取没有扩展名的文件名
            string strExtendName = strPicNameWithExtend.Substring(strPicNameWithExtend.IndexOf('.')).ToLower();//取扩展名

            if (!hpfImage.ContentType.ToUpper().StartsWith("IMAGE/"))//如果不是图片类型
            {
                throw new Exception("您上传的不是图片文件！");
            }
            if (_strAllowType.ToLower().IndexOf(strExtendName) == -1)//如果上传图片的扩展名不在允许的行列
            {
                throw new Exception("您上传得图片格式未被允许");
            }
            if ((hpfImage.ContentLength / 1024) > _iMaxSize)//如果超过了规定大小
            {
                throw new Exception("您上传的图片大小超过了限制！");
            }

            if (_bIsRename)//如果重命名
            {
                if (_enumRenameType == Rename.DateTime)//用日期重命名
                {
                    DateTime dtRenameTime = DateTime.Now;
                    StringBuilder sbRenameString = new StringBuilder();
                    sbRenameString.Append(dtRenameTime.Year.ToString());
                    sbRenameString.Append(dtRenameTime.Month.ToString());
                    sbRenameString.Append(dtRenameTime.Day.ToString());
                    sbRenameString.Append(dtRenameTime.Hour.ToString());
                    sbRenameString.Append(dtRenameTime.Minute.ToString());
                    sbRenameString.Append(dtRenameTime.Second.ToString());
                    sbRenameString.Append(dtRenameTime.Millisecond.ToString());

                    strPicNameWithoutExtend = sbRenameString.ToString();
                    sbRenameString = null;
                }
                else//用Guid重命名
                {
                    strPicNameWithoutExtend = Guid.NewGuid().ToString();
                }
            }
            _strPicSavedName = strPicNameWithoutExtend + strExtendName;//图片名称
            _strPicSavedPath = _strPicSavePath + _strPicSavedName;//图片路径

            string strDir = HttpContext.Current.Server.MapPath(_strPicSavePath);//图片的保存目录
            if (!Directory.Exists(strDir))//如果目录不存在
            {
                Directory.CreateDirectory(strDir);//创建目录
            }

            string strSavePath = HttpContext.Current.Server.MapPath(_strPicSavedPath);//取得图片保存的绝对位置
            hpfImage.SaveAs(strSavePath);//保存图片

            if (_enumWatermarkType != WatermarkType.None)//添加版权信息
            {
                AddWatermark(strSavePath);
            }

            if (_bIsGenerateThumb)
            {
                GetThumb(strSavePath, strPicNameWithoutExtend, strExtendName);
            }
        }

        /// <summary>
        /// 添加版权信息
        /// </summary>
        /// <param name="strOraginalPath"></param>
        public void AddWatermark(string strOraginalPath)
        {
            switch (_enumWatermarkType)
            {
                case WatermarkType.None://如果不添加水印
                    break;
                case WatermarkType.Image://图片水印
                    AddImageWatermark(strOraginalPath);
                    break;
                case WatermarkType.Text://文字水印
                    AddTextWatermark(strOraginalPath);
                    break;
                default:
                    break;
            }
        }

        public void AddImageWatermark(string strOraginalPath)
        {
            string strWatermarkImagePath = HttpContext.Current.Server.MapPath(_strWatermarkImage);
            if (!File.Exists(strWatermarkImagePath))//如果水印图片不存在
            {
                return;
            }

            System.Drawing.Image imgOraginal = System.Drawing.Image.FromFile(strOraginalPath);
            int iOraginalWidth = imgOraginal.Width;
            int iOraginalHeight = imgOraginal.Height;
            System.Drawing.Bitmap bitOraginal = new System.Drawing.Bitmap(imgOraginal, iOraginalWidth, iOraginalHeight);
            imgOraginal.Dispose();

            System.Drawing.Graphics gOraginal = System.Drawing.Graphics.FromImage(bitOraginal);
            //System.Drawing.Rectangle rectTextField = new System.Drawing.Rectangle(10, 10, iWidth - 20, iHeight - 20);

            System.Drawing.Image imgWatermark = System.Drawing.Image.FromFile(strWatermarkImagePath);
            int iWatermarkWidth = imgWatermark.Width;
            int iWatermarkHeight = imgWatermark.Height;

            System.Drawing.Rectangle rect;

            int iHCenter = (iOraginalWidth - iWatermarkWidth) / 2;
            int iVCenter = (iOraginalHeight - iWatermarkHeight) / 2;
            int iHRight = (iOraginalWidth - iWatermarkWidth - 10);
            int iVBottom = (iOraginalHeight - iWatermarkHeight - 10);

            //水印的位置
            switch (_enumWatermarkPosition)
            {
                case WatermarkPosition.TopLeft:
                    rect = new System.Drawing.Rectangle(10, 10, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.TopCenter:
                    rect = new System.Drawing.Rectangle(iHCenter, 10, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.TopRight:
                    rect = new System.Drawing.Rectangle(iHRight, 10, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.MiddleLeft:
                    rect = new System.Drawing.Rectangle(10, iVCenter, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.MiddleCenter:
                    rect = new System.Drawing.Rectangle(iHCenter, iVCenter, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.MiddleRight:
                    rect = new System.Drawing.Rectangle(iHRight, iVCenter, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.BottomLeft:
                    rect = new System.Drawing.Rectangle(10, iVBottom, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.BottomCenter:
                    rect = new System.Drawing.Rectangle(iHCenter, iVBottom, iWatermarkWidth, iWatermarkHeight);
                    break;
                case WatermarkPosition.BottomRight:
                    rect = new System.Drawing.Rectangle(iHRight, iVBottom, iWatermarkWidth, iWatermarkHeight);
                    break;
                default:
                    rect = new System.Drawing.Rectangle(10, 10, iWatermarkWidth, iWatermarkHeight);
                    break;
            }
            gOraginal.DrawImage(imgWatermark, rect);

            bitOraginal.Save(strOraginalPath, System.Drawing.Imaging.ImageFormat.Jpeg);

            bitOraginal.Dispose();
            gOraginal.Dispose();
            imgWatermark.Dispose();
        }

        public void AddTextWatermark(string strOraginalPath)
        {
            if (string.IsNullOrEmpty(_strWatermarkText))//如果水印文字为空
            {
                return;
            }

            System.Drawing.Image imgOraginal = System.Drawing.Image.FromFile(strOraginalPath);
            int iWidth = imgOraginal.Width;
            int iHeight = imgOraginal.Height;
            System.Drawing.Bitmap bitOraginal = new System.Drawing.Bitmap(imgOraginal, iWidth, iHeight);
            imgOraginal.Dispose();

            System.Drawing.Graphics gOraginal = System.Drawing.Graphics.FromImage(bitOraginal);

            System.Drawing.Rectangle rectTextField = new System.Drawing.Rectangle(10, 10, iWidth - 20, iHeight - 20);
            System.Drawing.StringFormat sf = GetStringFormat();

            System.Drawing.SolidBrush brush = new System.Drawing.SolidBrush(System.Drawing.Color.FromArgb(_btWatermarkTransparency/*文字的透明度*/, _fontWatermarkColor));
            gOraginal.DrawString(_strWatermarkText, _fontWatermarkFont, brush, rectTextField, sf);

            sf.Dispose();
            brush.Dispose();

            bitOraginal.Save(strOraginalPath, System.Drawing.Imaging.ImageFormat.Jpeg);

            gOraginal.Dispose();
            bitOraginal.Dispose();
        }

        /// <summary>
        /// 处理水印文字位置
        /// </summary>
        /// <returns></returns>
        private System.Drawing.StringFormat GetStringFormat()
        {
            System.Drawing.StringFormat sf = new System.Drawing.StringFormat();
            switch (_enumWatermarkPosition)
            {
                case WatermarkPosition.TopLeft:
                    sf.Alignment = System.Drawing.StringAlignment.Near;
                    sf.LineAlignment = System.Drawing.StringAlignment.Near;
                    break;
                case WatermarkPosition.TopCenter:
                    sf.Alignment = System.Drawing.StringAlignment.Center;
                    sf.LineAlignment = System.Drawing.StringAlignment.Near;
                    break;
                case WatermarkPosition.TopRight:
                    sf.Alignment = System.Drawing.StringAlignment.Far;
                    sf.LineAlignment = System.Drawing.StringAlignment.Near;
                    break;
                case WatermarkPosition.MiddleLeft:
                    sf.Alignment = System.Drawing.StringAlignment.Near;
                    sf.LineAlignment = System.Drawing.StringAlignment.Center;
                    break;
                case WatermarkPosition.MiddleCenter:
                    sf.Alignment = System.Drawing.StringAlignment.Center;
                    sf.LineAlignment = System.Drawing.StringAlignment.Center;
                    break;
                case WatermarkPosition.MiddleRight:
                    sf.Alignment = System.Drawing.StringAlignment.Far;
                    sf.LineAlignment = System.Drawing.StringAlignment.Center;
                    break;
                case WatermarkPosition.BottomLeft:
                    sf.Alignment = System.Drawing.StringAlignment.Near;
                    sf.LineAlignment = System.Drawing.StringAlignment.Far;
                    break;
                case WatermarkPosition.BottomCenter:
                    sf.Alignment = System.Drawing.StringAlignment.Center;
                    sf.LineAlignment = System.Drawing.StringAlignment.Far;
                    break;
                case WatermarkPosition.BottomRight:
                    sf.Alignment = System.Drawing.StringAlignment.Far;
                    sf.LineAlignment = System.Drawing.StringAlignment.Far;
                    break;
                default:
                    sf.Alignment = System.Drawing.StringAlignment.Center;
                    sf.LineAlignment = System.Drawing.StringAlignment.Far;
                    break;
            }
            return sf;
        }

        /// <summary>
        /// 生成缩略图
        /// </summary>
        /// <param name="strOraginalPath"></param>
        public void GetThumb(string strOraginalPath, string strPicNameWithoutExtend, string strExtendName)
        {
            System.Drawing.Image imgOraginal = System.Drawing.Image.FromFile(strOraginalPath);
            int iOraginalWidth = imgOraginal.Width;
            int iOraginalHeight = imgOraginal.Height;

            int toWidth;
            int toHeight;

            //原图的宽高比
            float fWbH = (float)iOraginalWidth / (float)iOraginalHeight;
            //原图的高宽比
            float fHbW = (float)iOraginalHeight / (float)iOraginalWidth;

            //如果宽高比大于4:3，则按照最大宽度来生成缩略图
            if (fWbH >= (4.0f / 3.0f))
            {
                if (_iThumbMaxWidth < iOraginalWidth)
                {
                    toWidth = _iThumbMaxWidth;
                    toHeight = (int)(toWidth * fHbW);
                }
                else//如果指定的缩略图宽度大于原图的宽度，则不生成缩略图
                {
                    toWidth = iOraginalWidth;
                    toHeight = iOraginalHeight;
                }
            }
            else//如果宽高比小雨4:3，则按照最大高度来生成缩略图
            {
                if (_iThumbMaxWidth < iOraginalWidth)
                {
                    toHeight = _iThumbMaxHeight;
                    toWidth = (int)(toHeight * fWbH);
                }
                else//如果指定的缩略图高度小于原图的宽度，则不生成缩略图
                {
                    toWidth = iOraginalWidth;
                    toHeight = iOraginalHeight;
                }
            }

            System.Drawing.Image bitmap = new System.Drawing.Bitmap(toWidth, toHeight);
            System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bitmap);

            //设定缩略图的生成质量
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;

            g.Clear(System.Drawing.Color.Transparent);
            g.DrawImage(imgOraginal, new System.Drawing.Rectangle(0, 0, toWidth, toHeight), new System.Drawing.Rectangle(0, 0, iOraginalWidth, iOraginalHeight), System.Drawing.GraphicsUnit.Pixel);

            //缩略图的图片名称
            _strPicThumbSavedName = strPicNameWithoutExtend + "_thumb" + strExtendName;
            string thumbServerPath = HttpContext.Current.Server.MapPath(_strPicThumbSavePath);
            if (!Directory.Exists(thumbServerPath))
            {
                Directory.CreateDirectory(thumbServerPath);
            }
            try
            {
                bitmap.Save(thumbServerPath + _strPicThumbSavedName, System.Drawing.Imaging.ImageFormat.Jpeg);
                _strPicThumbSavedPath = _strPicThumbSavePath + _strPicThumbSavedName;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                imgOraginal.Dispose();
                bitmap.Dispose();
                g.Dispose();
            }
        }
        #endregion

        #endregion

        #region IDisposable 成员

        void IDisposable.Dispose()
        {
            _strAllowType = null;
            _strButtonSaveCSSClass = null;
            _strButtonSaveText = null;
            _strPicSavedName = null;
            _strPicSavedPath = null;
            _strPicSavePath = null;
            _strSuccessfulText = null;
            _strPicThumbSavedName = null;
            _strPicThumbSavedPath = null;
            _strPicThumbSavePath = null;
            _strWatermarkImage = null;
            _strWatermarkText = null;
            _fileUpload.Dispose();
            _btnSave.Dispose();
            _fontWatermarkFont.Dispose();
        }

        #endregion

        #region 析构函数
        ~ImageUploader()
        {
            Dispose();
        }
        #endregion

        #region IPostBackDataHandler 成员

        public bool LoadPostData(string postDataKey, NameValueCollection postCollection)
        {
            return true;
        }

        public void RaisePostDataChangedEvent()
        {

        }

        #endregion
    }
}
