// JScript 文件

      
      //     
 function createXmlHttp() {
        var xmlHttp = null;
        //window.XMLHttpRequestǷʹòͬĴʽ
        if (window.XMLHttpRequest) {
           xmlHttp = new XMLHttpRequest();                  //FireFoxOperaֵ֧Ĵʽ
        } else {
           xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");//IEֵ֧Ĵʽ
        }
        return xmlHttp;
    }
    
    
/*
onreadystatechange
 每个状态改变时都会触发这个事件处理器，通常会调用一个JavaScript函数
 
readyState
 请求的状态。有5个可取值：0 = 未初始化，1 = 正在加载，2 = 已加载，3 = 交互中，4 = 完成
 
responseText
 服务器的响应，表示为一个串
 
responseXML
 服务器的响应，表示为XML。这个对象可以解析为一个DOM对象
 
status
 服务器的HTTP状态码（200对应OK，404对应Not Found（未找到），等等）
 
statusText
 HTTP状态码的相应文本（OK或Not Found（未找到）等等）
 
 
   */ 
    
    
    
    
    
    
 function fPopUpCalendarDlg(ctrlobj)
			{
				var showx,showy,newWINwidth,retval;
				showx = event.screenX - event.offsetX - 4 - 210 ; // + deltaX;
				showy = event.screenY - event.offsetY + 18; // + deltaY;
				newWINwidth = 210 + 4 + 18;

				retval = window.showModalDialog("../CalendarDlg.htm", "", "dialogWidth:197px; dialogHeight:210px; dialogLeft:"+showx+"px; dialogTop:"+showy+"px; status:no; directories:yes;scrollbars:no;Resizable=no; "  );
				if( retval != null )
				{
					ctrlobj.value = retval;
					
				}
				else
				{
					//alert("canceled");
				}
			}
