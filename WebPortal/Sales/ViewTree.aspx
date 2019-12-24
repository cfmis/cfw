<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
	<link href="../js/uploadify/uploadify.css" rel="stylesheet" />
    <script type="text/jscript" src="../js/uploadify/jquery-1.11.3.min.js"></script>
    <script type="text/jscript" src="../js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/jscript" src="../js/jquery.jqprint-0.3.js"></script>
    <style type="text/css">
        .ttable {border-collapse:collapse;border:none;width:90%}
        .ttd {border:solid #000 1px;}
    </style>
    <script type="text/javascript">
        $(function () {
            $("#file_upload").uploadify({
                auto: false,
                fileTypeDesc: 'Image Files',
                fileTypeExts: '*.jpg; *.png;*.gif;*.*',
                height: 30,
                buttonText: '请选择图片...',
                swf: '/js/uploadify/uploadify.swf',
                uploader: 'UploadFile.ashx',
                width: 120,
                fileSizeLimit: '4MB',
                onUploadSuccess: function (file, data, response) {
                    $("#imgBox").html(data);
                },
                onUploadError: function (file, errorCode, errorMsg, errorString) {
                    alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
                }
            });

        });  
    </script>

    <script type="text/javascript">
        function  Print(){
        $("#setFormLayout").jqprint();
    }
    </script>

	</head>
	<body>

	<input id="file_upload" name="file_upload" type="file" multiple="true"/>
   <input type="button" value="上传" onclick="javascript:$('#file_upload').uploadify('upload','*')" />
   <div id="imgBox" style=" overflow:hidden; width:200px; height:200px; "></div>
    <div id="setFormLayout" style="width:500px;height:300px">
        <div style="text-align:center;width:90%">
            Reports
        </div>
        <table style="border-collapse:collapse;width:90%" border="1">
            <tr>
                <td colspan="3" style="text-align:center">Tittle</td>
            </tr>
            <tr>
                <td class="ttd1">
                    Column1
                </td>
                <td>
                    Column2
                </td>
                <td>
                    Column3
                </td>
            </tr>
        </table>
        <div style="text-align:right;width:90%">
            Reports
        </div>
    </div>
    <a href="#" onclick="Print()">print</a>

</body></html>