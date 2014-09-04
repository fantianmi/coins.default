<%@page import="com.mvc.util.FormatUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>
<%
FormatUtil format = new FormatUtil();
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%Map<String,Btc_content> indexmap = (Map<String,Btc_content>)session.getAttribute("indexmap"); 
List<Btc_content> newslist = (List<Btc_content>)session.getAttribute("newslist");%>       	   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title><%=res.getString("host.title")%></title>
<jsp:include page="/include/htmlsrc.jsp" ></jsp:include>
<script type="text/javascript">
  $(document).ready(function() {
      $("#tradecenter").addClass('active');
  });
</script>
<!-- ######################################################## -->
<script type="text/javascript" src="script/ajax/dataload.js"></script>
<%int globalstockid = Integer.parseInt(request.getAttribute("btc_stock_id").toString());
 Btc_stock globalstock = (Btc_stock)request.getAttribute("globalbtc_stock");%>
 
<script type="text/javascript"> 
var XMLHttpReq;
var exstock='<%=request.getAttribute("exstock").toString()%>';
	  //创建XMLHttpRequest对象      
	    function createXMLHttpRequest() {
	  if(window.XMLHttpRequest) { //Mozilla 浏览器
	   XMLHttpReq = new XMLHttpRequest();
	  }
	  else if (window.ActiveXObject) { // IE浏览器
	   try {
	    XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
	   } catch (e) {
	    try {
	     XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
	    } catch (e) {}
	   }
	  }
	 }
	
	//发送请求函数
	
	 function sendRequest() {
	  createXMLHttpRequest();
	        var url = 'autoload.do?refreshstock&stockId=<%=globalstockid%>&exstock='+exstock+'&n='+ Math.random();
  XMLHttpReq.open("GET", url, true);
  XMLHttpReq.onreadystatechange = processResponse;//指定响应函数
  XMLHttpReq.send(null);  // 发送请求
 }
 // 处理返回信息函数
    function processResponse() {
     if (XMLHttpReq.readyState == 4) { // 判断对象状态
         if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
    DisplayHot();
    setTimeout("sendRequest()", 5000);
            } 
        }
    }
		  
</script>
<!-- ####################################################### -->
<script type="text/javascript" src="formcheck/datatype.js"></script>
<!-- ######################################################## -->
<script type="text/javascript" src="scripts/jquery-1.4.1.min.js"></script>
<script type="text/javascript" src="scripts/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="scripts/jquery.timers.1.2.js"></script>
<script type="text/javascript" src="scripts/jquery.galleryview.2.1.1.min.js"></script>
<script type="text/javascript" src="scripts/jquery.galleryview.setup.js"></script>
<script type="text/javascript">
function saveReport() {  
    // jquery 表单提交  
    $("#showDataForm").ajaxSubmit(function(message) {  
          // 对于表单提交成功后处理，message为提交页面saveReport.do的返回内容  
       });  
      
    return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转  
}  
</script>
</head>
  <body>
  <%
String showStockName = request.getAttribute("btc_stock_name").toString(); 
Btc_profit profit = (Btc_profit)request.getAttribute("profit");
BigDecimal tradesxf = globalstock.getTradesxf();
BigDecimal sxf = new BigDecimal(0);
if(request.getAttribute("extradesxf")==null){ sxf=profit.getBtc_profit_trade_poundage();}
else{sxf=new BigDecimal(request.getAttribute("extradesxf").toString());}%>
<script type="text/javascript">
    var stksxf = <%=tradesxf%>;
    var exstksxf = <%=sxf%>;
    function caculateEx_BQ_Pound(x){
    	var buyleft=document.getElementById("buyduihuane").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("exchange").value = ((document.getElementById("buyQuantity").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("poundage").innerHTML = (document.getElementById("buyQuantity").value * stksxf).toFixed(2);
        document.getElementById("canbuyamount").innerHTML=(buyleft/document.getElementById(x).value).toFixed(2);
    }
    
    function caculateEx(x){
    	var buyleft=document.getElementById("buyduihuane").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("exchange").value = ((document.getElementById("buyingRate").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("poundage").innerHTML = (document.getElementById("buyQuantity").value * stksxf).toFixed(2);
        document.getElementById("canbuyamount").innerHTML=(buyleft/document.getElementById("buyingRate").value).toFixed(2);
    }
    function caculateBQ(x){
    	var buyleft=document.getElementById("buyduihuane").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("buyQuantity").value = (document.getElementById("exchange").value / document.getElementById("buyingRate").value).toFixed(2);
        document.getElementById("poundage").innerHTML = (document.getElementById("buyQuantity").value * stksxf).toFixed(2);
        document.getElementById("canbuyamount").innerHTML=(buyleft/document.getElementById("buyingRate").value).toFixed(2);
    }
    
    function scaculateEx_BQ_Pound(x){
    	var sellleft=document.getElementById("sellyue").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
    	document.getElementById("sexchange").value = ((document.getElementById("sellQuantity").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("spoundage").innerHTML = (document.getElementById("sexchange").value * exstksxf).toFixed(2);
        document.getElementById("cansellamount").innerHTML=sellleft.toFixed(2);
    }
    
    function scaculateEx(x){
    	var sellleft=document.getElementById("sellyue").innerHTML;
        fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("sexchange").value = ((document.getElementById("sellingRate").value) * (document.getElementById(x).value)).toFixed(2);
        document.getElementById("spoundage").innerHTML = (document.getElementById("sexchange").value * exstksxf).toFixed(2);
        document.getElementById("cansellamount").innerHTML=sellleft.toFixed(2);
    }
    function scaculateBQ(x){
    	var sellleft=document.getElementById("sellyue").innerHTML;
    	fomatFloatcheck(x,2,0);
    	check(document.getElementById(x));
        document.getElementById("sellQuantity").value = (document.getElementById("sexchange").value / document.getElementById("sellingRate").value).toFixed(2);
        document.getElementById("spoundage").innerHTML = (document.getElementById("sexchange").value * exstksxf).toFixed(2);
        document.getElementById("cansellamount").innerHTML=sellleft.toFixed(2);
    }

</script>
<!-- ################################################################################### -->
		<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
		<script src="script/Hightcharts/highstock.js" charset="utf-8"></script>
		<script src="script/Hightcharts/exporting.js"></script>
		<script src="script/Hightcharts/stockcommon.js"></script>
		<script language=javascript>
		var stockid=<%=globalstock.getBtc_stock_id() %>;
		var exstock='<%=request.getAttribute("exstock").toString()%>';
		function ConfirmDelbid(price)
		{
		   if(confirm("确认撤销该买单？"))
		   {
		        location.href='createOrder.do?cancelorder&price='+price+'&stockid='+stockid+'&exstock='+exstock+'&type=bid';
		   }
		}
		function ConfirmDelsell(price)
		{
		   if(confirm("确认撤销该卖单？"))
		   {
		        location.href='createOrder.do?cancelorder&price='+price+'&stockid='+stockid+'&exstock='+exstock+'&type=sell';
		   }
		}
		
		function Confirmbuy()
		{
		   if(confirm("确兑换买？"))
		   {
		        var latestpricet = document.getElementById("latestprice").innerHTML;
		   		var buyingRate = document.getElementById('buyingRate').value;
		   		var absSub=latestpricet-buyingRate;
		   		absSub=Math.abs(absSub);
		   		if(absSub>10){
		   			alert("平台涨幅控制在10元之内，请重新下单");
		   			return false;
		   		}
		        var buyQuantity = document.getElementById('buyQuantity').value;
				var buyduihuane=document.getElementById('buyduihuane').innerHTML;
		        var exchange = document.getElementById('exchange').value;
		        if(buyingRate<=0||buyQuantity<=0||exchange<=0){
		        	alert('请将表单填写完整');
		        	return false;
		        }
		        
		   		
		        if(buyduihuane-exchange<0){
			       	   alert('您的余额不足，请重新输入');
			       	   return false;
			       } 
		   
		        <%if(request.getAttribute("exstock").equals("CNY")){%>
		       document.getElementById('bufence').action = "form.do?trade";
		   		<%}else{%>
		       document.getElementById('bufence').action = "form.do?stocktrade";
		   		<%}%>
		   	   submitForm('bufence', 'tip');
		   }
		}
		function Confirmsell()
		{
		   if(confirm("确认卖出？"))
		   {
			   	var latestpricet = document.getElementById("latestprice").innerHTML;
		   		var sellingRate = document.getElementById('sellingRate').value;
		   		var absSub=latestpricet-sellingRate;
		   		absSub=Math.abs(absSub);
		   		if(absSub>10){
		   			alert("平台涨幅控制在10元之内，请重新下单");
		   			return false;
		   		}
		        var sellQuantity = document.getElementById('sellQuantity').value;
		        var sexchange = document.getElementById('sexchange').value;
		        if(sellingRate<=0||sellQuantity<=0||sexchange<=0){
		        	alert('买卖单价格数量或兑换额不能为0');
		        	return false;
		        }
		        
		   		var stockyue=document.getElementById('sellyue').innerHTML;
		        var inputsell = document.getElementById('sellQuantity').value;
		        if(inputsell-stockyue>0){
			       	   alert('您的余额不足，请重新输入');
			       	   return false;
			       } 
			       
			   <%if(request.getAttribute("exstock").equals("CNY")){%>
		        document.getElementById('sellfence').action = "form.do?trade";
		   		<%}else{%>
		        document.getElementById('sellfence').action = "form.do?stocktrade";
		   		<%}%>
		   		submitForm('sellfence', 'tip');
			}
		}
		</script>

<jsp:include page="/include/headhtml.jsp"></jsp:include>
<script>
//将form转为AJAX提交
function ajaxSubmit(frm, fn) {
    var dataPara = getFormJson(frm);
    $.ajax({
        url: frm.action,
        type: frm.method,
        data: dataPara,
        success: fn
    });
}

//将form中的值转换为键值对。
function getFormJson(frm) {
    var o = {};
    var a = $(frm).serializeArray();
    $.each(a, function () {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });

    return o;
}
$(document).ready(function(){
    $('#Form1').bind('submit', function(){
        ajaxSubmit(this, function(data){
            alert(data);
        });
        return false;
    });
});
</script>
<script src="script/Hightcharts/stockcommon.js"></script>
<script type="text/javascript">
	var ajaxObj6 = null;
	var ajaxObj7 = null;
	var ajaxObj8 = null;
	$(document).ready(function() {
		getTimeLine();
	});

	function getDayLine() {
		$("#highstock_tab a").removeClass("cur");
		$("#highstock_tab a:eq(2)").addClass("cur");
		if (window.XMLHttpRequest) {
			ajaxObj7 = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			ajaxObj7 = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (ajaxObj7 != null) {
			var url = 'ajax.do?hicharts&stockId=<%=globalstock.getBtc_stock_id()%>&exstock=cny&type=day&n='+ Math.random();
			ajaxObj7.onreadystatechange = displayDayLine;
			ajaxObj7.open("GET", url, true);
			ajaxObj7.send(null);
		}
	}

	function getTimeLine() {
		$("#highstock_tab a").removeClass("cur");
		$("#highstock_tab a:eq(1)").addClass("cur");
		if (window.XMLHttpRequest) {
			ajaxObj6 = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			ajaxObj6 = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (ajaxObj6 != null) {
			var url = 'ajax.do?hicharts&stockId=<%=globalstock.getBtc_stock_id()%>&exstock=cny&type=hours&n='+Math.random();
			ajaxObj6.onreadystatechange = displayTimeLine;
			ajaxObj6.open("GET", url, true);
			ajaxObj6.send(null);
		}
	}

	function get5minLine() {
		$("#highstock_tab a").removeClass("cur");
		$("#highstock_tab a:eq(0)").addClass("cur");
		if (window.XMLHttpRequest) {
			ajaxObj8 = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			ajaxObj8 = new ActiveXObject("Microsoft.XMLHTTP");
		}

		if (ajaxObj8 != null) {
			var url = 'ajax.do?hicharts&stockId=<%=globalstock.getBtc_stock_id()%>&exstock=cny&type=min&n='+Math.random();
			ajaxObj8.onreadystatechange = display5minLine;
			ajaxObj8.open("GET", url, true);
			ajaxObj8.send(null);
		}
	}
</script>
<!-- ############################################################## -->
<!-- content -->

<div class="wrapper row3" style="padding-top:0px;background-color: #F1F1F1">
  <div id="container" style="padding-top:30px">
  <jsp:include page="/include/navigator2.jsp"></jsp:include>
  </div>
  <div id="container" style="padding-top:30px">
  <h1 style="color:#0171C7"><%=globalstock.getBtc_stock_name() %><%=globalstock.getBtc_stock_Eng_name()%>对<%=request.getAttribute("exstock").toString()%>实时行情&nbsp;&nbsp;涨跌幅(<b id="zhangdiefu"></b>)</h1>
    <table style="margin-bottom: 0px; border: none">
	<tr style="margin-bottom: 0px; border: none">
	<td width="75%" style="margin-bottom: 0px; border: none;padding: 0px;background-color: #fff">
    <div id="portfolio">
     <div class="fencetitle" style="border-width:0px">
      <span><button href="#" class="button small blue" onclick="JavaScript:get5minLine();">分钟</button></span>
      <span><button href="#" class="button small blue" onclick="JavaScript:getTimeLine();">小时</button></span>
      <span><button href="#" class="button small blue" onclick="JavaScript:getDayLine();">日线</button></span>          
     </div>
    <div class="tradefence" style="margin-bottom:10px;">
    	<div id="k-line" style="height: 100%; min-width:100%"></div>
    </div>
    <!-- price center -->
    <div class="wrapper row3" style="">
	<div id="market_list">
	<span>
	<ul class="list-inline" style="height:63px">
	<li class="live-ticker">最新成交价	<p><span style="" id="latestprice">0</span><%=request.getAttribute("exstock").toString() %></p></li>
	<li class="live-ticker">价格范围<p>
			<span id="top_todayRate">0</span><%=request.getAttribute("exstock").toString() %> -
			<span id="low_todayRate">0</span><%=request.getAttribute("exstock").toString() %>
		</p>
	</li>
	<li class="live-ticker">成交量<p><span style="" id="amount_today">0</span><%=globalstock.getBtc_stock_Eng_name() %></p></li>
	<li class="live-ticker">成交额<p><span style="" id="amount_today_cny">0</span><%=request.getAttribute("exstock").toString() %></p></li>
	</ul>
	</span>
	</div>
</div>
    <!-- price center -->
    <!--#############################################-->
      <ul class="clear">
      <li class="one_half first">
        <header style="margin-bottom:10px">
        	 <div class="fencetitle">
                <span class="fencetitlefont" style="color:#3D7A3E;border-left:5px solid #3D7A3E">&nbsp;买入</span>
             </div>
          </header>
          <div class="tradefence market-buy market-deal" style="border: none;">
			 <!-- tradefence -->
			     <%
				BigDecimal bestBid = new BigDecimal(0);
				if(request.getAttribute("sellOders")!=null){
					ArrayList<Btc_order> toGetBestOffer = (ArrayList<Btc_order>)request.getAttribute("sellOders");
					bestBid = toGetBestOffer.get(0).getBtc_order_price();
				}else{
					Btc_stock btc_stock=(Btc_stock)request.getAttribute("btc_stock");
					bestBid = btc_stock.getBtc_stock_price();
				} %>
			 <table cellspacing="1px" style="border: none">
			 <tbody>
			 <tr>
			 <th colspan="3" style="text-align:left;">您的<%=request.getAttribute("exstock").toString()%>余额<span class="key"  id="buyduihuane"></span>元 &nbsp;&nbsp;<span><a href="index.do?recharge2local" class="cblue">充值</a></span></th></tr>
			 <tr><th class="key" width="110"> 最佳买价：</th>
              <td class="key" width="20"  id="buyfenceshowbestbid"></td><td width="80"><%=request.getAttribute("exstock").toString()%>/<%=globalstock.getBtc_stock_Eng_name() %>
              </td>
              </tr>
              <tr style="border: none">
              <th class="key">可买入量：</th>
              <td class="key" id="canbuyamount">0</td><td><%=globalstock.getBtc_stock_Eng_name() %></td>
              </tr>
              <form id="bufence" style="height:28px">
			    <input type="hidden" name="exstock" value="<%=request.getAttribute("exstock").toString() %>"/>
			    <input type="hidden" name="stock_id" value="<%=request.getAttribute("btc_stock_id").toString() %>">
			    <input type="hidden" name="order_type" value="bid">
              <tr>
              <th>买入单价：</th>
              <td><input name="order_price" id="buyingRate" onpaste="check2(this)" value="<%=format.trans(bestBid) %>" onkeyup="caculateEx_BQ_Pound(this.id);" size="10" type="text"></td><td><%=request.getAttribute("exstock").toString()%>/<%=globalstock.getBtc_stock_Eng_name() %></td></tr>
              <tr style="border: none">
              <th>买入数量：</th>
              <td><input name="order_amount" id="buyQuantity" onpaste="check2(this)" value="0" onkeyup="caculateEx(this.id);" size="10" type="text"></td><td> &nbsp;
              </td>
              </tr>
              <tr>
              <th>买入总额：</th>
              <td><input name="exchange" id="exchange" onpaste="check2(this)" value="0" onkeyup="caculateBQ(this.id);" size="10" type="text"></td><td><%=request.getAttribute("exstock").toString()%></td>
              </tr>
              </form>
              <tr>
              <th> 手续费：</th>
              <td colspan="2"><span id="poundage">0.00</span><%=globalstock.getBtc_stock_Eng_name() %>手续费 (<%=tradesxf.multiply(new BigDecimal(100)).setScale(2,BigDecimal.ROUND_HALF_UP) %>%)</td>
              </tr>
              </tbody>
              </table>
              <div style="text-align: center"><button onclick="Confirmbuy();" class="button large green">买入（<%=request.getAttribute("exstock").toString()%> - <%=globalstock.getBtc_stock_Eng_name() %>）</button></div>
            <!-- tradefence -->           
          </div>
        </li>
        <li class="one_half">
            <header style="margin-bottom:10px">
             <div class="fencetitle">
                <span class="fencetitlefont" style="color:#D02C2B;border-left:5px solid #D02C2B">&nbsp;卖出</span>
             </div>
            </header>
            <div class="tradefence market-sell market-deal" style="border: none; border-left: 1px solid #ccc">
            <!-- tradefence -->
            <%
			BigDecimal bestOffer = null;
			if(request.getAttribute("buyingOders")!=null){
				ArrayList<Btc_order> toGetBestBid = (ArrayList<Btc_order>)request.getAttribute("buyingOders");
				bestOffer = toGetBestBid.get(0).getBtc_order_price();
			}else{
				Btc_stock btc_stock=(Btc_stock)request.getAttribute("btc_stock");
				bestOffer = btc_stock.getBtc_stock_price();
				bestOffer.setScale(2,BigDecimal.ROUND_HALF_UP);
			}%>
            <table cellspacing="1px" style="border: none">
            <tbody><tr><th colspan="3" style="text-align:left;">您的<%=globalstock.getBtc_stock_Eng_name() %>余额<span class="key" id="sellyue"></span>个 &nbsp;&nbsp;</th>
           <form id="sellfence" action="" style="height:28px">
		  <input type="hidden" name="exstock" value="<%=request.getAttribute("exstock").toString() %>"/>
		  <input type="hidden" name="stock_id" value="<%=request.getAttribute("btc_stock_id").toString() %>">
		  <input type="hidden" name="order_type" value="sell">
            </tr>
            <tr>
            <th class="key" width="110">最佳卖价：</th><td class="key" width="110" id="sellfenceshowbestsell"></td><td width="80"><%=request.getAttribute("exstock").toString()%>/<%=globalstock.getBtc_stock_Eng_name() %></td></tr>
            <tr>
            <th class="key">可卖出量：</th><td class="key" id="cansellamount">0.00</td><td><%=globalstock.getBtc_stock_Eng_name() %></td>
            </tr>
            <tr>
            <th>卖出单价：</th><td><input name="order_price" id="sellingRate" onpaste="check2(this)" value="<%=format.trans(bestOffer) %>" onkeyup="scaculateEx_BQ_Pound(this.id);" size="10" type="text"></td><td><%=request.getAttribute("exstock").toString()%>/<%=globalstock.getBtc_stock_Eng_name() %></td>
            </tr>
            <tr><th>卖出数量：</th><td><input name="order_amount" id="sellQuantity" onpaste="check2(this)" value="0" onkeyup="scaculateEx(this.id);" size="10" type="text"></td><td>&nbsp;</td>
            </tr><tr><th>卖出总额：</th><td><input name="exchange" id="sexchange" onpaste="check2(this)" value="0" onkeyup="scaculateBQ(this.id);" type="text" ></td><td><%=request.getAttribute("exstock").toString()%></td>
            </tr>
            </form>
            <tr><th>手续费：</th><td colspan="2"><span id="spoundage">0.00</span><%=request.getAttribute("exstock").toString()%> 手续费 (<%=format.num2percent(sxf)%>%)</td>
            </tr>
            </tbody></table>
            <div style="text-align: center"><button onclick="Confirmsell()" class="button large red">卖出（<%=globalstock.getBtc_stock_Eng_name() %> - <%=request.getAttribute("exstock").toString()%>）</button></div>
            <!-- tradefence -->
          	  </div>
        </li>
        <!-- trade fence -->
        <li class="one_half first">
        <header>
        	 <div class="fencetitle">
                <span class="icon-list-alt icon-large"></span>
                <span class="fencetitlefont" style="color:#3D7A3E">买单</span>
             </div>
          </header>
          <div class="tradefence">
          <!--################################-->
          <div class="tradefencetitle">
            <table>
              <tr style="background-color: #3B464A; color:#ffffff">
                <td style="width:25%">序列</td>
                <td style="width:25%">买入单价</td>
                <td style="width:25%">买入数量</td>
                <td style="width:25%">总额<%=request.getAttribute("exstock").toString()%></td>
               </tr>
            </table>
          </div>
           <!--######################################################-->
           <div style="height:260px;">
      		<table summary='Summary Here' cellpadding='0' cellspacing='0'>
      		<tbody id="globalbidorder">
      		</tbody>
      		</table>
           </div>
       
          <!--################################-->
           
          </div>
        </li>
        <li class="one_half">
            <header>
             <div class="fencetitle">
                <span class="icon-list-alt icon-large"></span>
                <span class="fencetitlefont" style="color:#D02C2B">卖单</span>
             </div>
            </header>
            <div class="tradefence">
                <div class="tradefencetitle">
                <table>
                  <tr style="background-color: #3B464A; color:#ffffff">
                    <td style="width:25%">序列</td>
                    <td style="width:25%">卖出单价</td>
                    <td style="width:25%">卖出数量</td>
                    <td style="width:25%">总额<%=request.getAttribute("exstock").toString()%></td>
                   </tr>
                </table>
              </div>
               <!--######################################################-->
               <div style="height:260px;">
          		<table summary='Summary Here' cellpadding='0' cellspacing='0'>
	      		<tbody id="globalsellorder">
	      		</tbody>
	      		</table>
               </div>
           <!--######################################################-->
          	  </div>
        </li>
        <li class="one_half first">
        <header>
        	 <div class="fencetitle">
                <span class="icon-list-alt icon-large"></span>
                <span class="fencetitlefont" style="color:#3D7A3E">我的买委托</span>
             </div>
          </header>
          <div class="tradefence">
          <!--################################-->
          <div class="tradefencetitle">
            <table>
              <tr style="background-color: #3B464A;color:#fff">
               <td style="width:25%">买入单价</td>
                <td style="width:25%">买入数量</td>
                <td style="width:25%">总额<%=request.getAttribute("exstock").toString() %></td>
                <td style="width:25%">操作</td>
               </tr>
            </table>
          </div>
           <!--######################################################-->
           <div style="height:312px; overflow:auto;background-color:#3B464A">
      		<table summary='Summary Here' cellpadding='0' cellspacing='0'>
      		<tbody id="userbuyorder">
      		</tbody>
      		</table>
           </div>
       
          <!--################################-->
          </div>
        </li>
        <li class="one_half">
        <header>
        	 <div class="fencetitle">
                <span class="icon-list-alt icon-large"></span>
                <span class="fencetitlefont" style="color:#D02C2B">我的卖委托</span>
             </div>
          </header>
          <div class="tradefence">
          <!--################################-->
          <div class="tradefencetitle">
            <table>
              <tr style="background-color: #3B464A ">
                <td style="width:25%">卖出单价</td>
                <td style="width:25%">卖出数量</td>
                <td style="width:25%">总额<%=request.getAttribute("exstock").toString() %></td>
                <td style="width:25%">操作</td>
               </tr>
            </table>
          </div>
           <!--######################################################-->
           <div style="height:312px; overflow:auto;background-color:#3B464A ">
      		<table summary='Summary Here' cellpadding='0' cellspacing='0'>
      		<tbody id="usersellorder">
      		</tbody>
      		</table>
           </div>
       
          <!--################################-->
           
          </div>
        </li>
      </ul>
      <!-- ##################################################################################### -->  
      <div class="fencetitle">
          <span class="icon-list-alt icon-large"></span>
          <span class="fencetitlefont" style="color:#51A551">最近成交记录</span>
      </div>
      <div class="tradefence">
       <!--################################-->
          <div class="tradefencetitle" >
            <table >
              <tr style="background-color: #3B464A">
                <td style="width:20%">成交时间</td>
                <td style="width:20%">成交类型</td>
                <td style="width:20%">成交单价</td>
                <td style="width:20%">成交数量</td>
                <td style="width:20%">成交总额<%=request.getAttribute("exstock").toString()%></td>
               </tr>
            </table>
          </div>
           <!--######################################################-->
           <div style="height:312px; overflow:auto; background-color:#F6F6F6;">
      		<table summary='Summary Here' cellpadding='0' cellspacing='0'>
      		<tbody id="dealorderlist">
      		</tbody>
      		</table>
           </div>
       
      </div>
    </div>
    </td>
    <td width="25%" style="border: none;padding: 0px;margin:0px;background-color:#3B464A;">
    <div id="sidebar_1" class="sidebar" style="margin-left:5px">
      <aside>
      <!-- zdf panel -->
      <div class="sub-chart">
			<h3 class="chart-hd" id="chart-hd"></h3>
			<div class="dash-circle">
				<div class="percentage">
					<span id="zhangdiefu2" bind="current_data|html ohchange"  style="color:#fff">0</span><i>%</i>
				</div>
			</div>
			<div class="market-cap">
				<div class="marketvalue">现估流通总市值: <em class="special-font">￥</em><span bind="current_data|html zcb_count" id="liutongzhi"></span></div>
			</div>
		</div>
      <!-- zdf panel -->
        <!-- /nav -->
        <h1 style="color:#ffffff">最新动态</h1>
        <ul class="list none newslist">
        <%for(int i=0;i<newslist.size();i++){
	      	Btc_content news = newslist.get(i);
	      	int newsid = news.getBtc_content_id();
	      	String title = news.getBtc_content_title();
	      	String content = news.getBtc_content_msg();
	      	%>
	      <a href="index.do?newsdetail&contentid=<%=news.getBtc_content_id()%>"><li><p class="title"><%=title %></p><p class="rtime"><%=news.getBtc_content_time() %></p></li></a>
	      <%} %>
        </ul>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <h1 style="color:#ffffff;text-align: center">微信公众账号</h1>
        <div style="text-align: center;"><img src="resource_new/img/weixin.png"/></div>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <h1 style="color:#ffffff;text-align: center;margin-bottom: 0px">官方QQ群</h1>
        <div style="width:50%;margin:0 auto;color:#fff">
       <ul class="list tagcloud rnd8">
          <li><a href="#"><%=res.getString("host.qq.group1") %></a></li>
          <li><a href="#"><%=res.getString("host.qq.group2") %></a></li>
        </ul>
        </div>
        <div style="color:#fff;background-color:#4A5557;padding: 10px 25px; ">
        	<p>本站仅提供一个供网友交易的平台，比特币等山寨币交易有极高的风险，当前任何虚拟币极容易受到庄家的控制。入市须谨慎，一定注意控制好风险！</p>
        </div>
      </aside>
    </div>
    </td></tr>
</table>
    <div class="clear"></div>
  </div>
</div>

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
