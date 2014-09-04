<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>  
<%--! String username;
username=getStr(request.getParameter("uesr"));
--%>
<%if(request.getAttribute("msg")==null){
}else{
String msg = request.getAttribute("msg").toString();
String href = null;
%>
<script type="text/javascript">
 alert("<%=msg%>");
 <%if(request.getAttribute("href")!=null&&request.getAttribute("href").equals("back")==false){ href = request.getAttribute("href").toString();%>
	 location.href="<%=request.getContextPath() %>/<%=href%>";
 <%}else if(request.getAttribute("href").equals("back")==true){%>
	 location.href="javascript:history.go(-1);";
 <%}%>
</script>
<%} %>

<div class="wrapper rowhead" style="border-bottom:1px solid #333">
  <header id="header" class="full_width clear">
   <SPAN id="topfont" style="margin-left:20px; line-height:28px">
   当前<span id="stock_top_name"></span>成交最高价<span id="topn_latestprice"></span>CNY，24小时成交量 <span id="topn_amount_today"></span><span id="stock_top_name2"></span> 
   今日最高价<span id="topn_top_todayRate"></span> CNY 今日最低价 <span  id="topn_low_todayRate"></span> CNY
   </SPAN>
    <%if(session.getAttribute("globaluser")==null){%>
   <span style="float:right"><a href="index.do" style="line-height: 25px;font-size: 14px;color:#fff">登陆/注册</a></span>
   <%}else{ %>
    <%
    Btc_user user = (Btc_user)session.getAttribute("globaluser");
    String name = user.getUusername();
     if(name.length()>14){
     	name = name.substring(0,14)+"..";
     }%>
  <span style="float:right"> 欢迎回来:<a href="index.do?userdetail"><%=name%></a>
  <a href="index.do?logout" class="button small blue">安全退出</a></span>
   <%} %>
  </header>
</div>

<!-- ################################################################################################ -->
<div class="wrapper row2" style="z-index: 9999999;position:relative; margin:0px">
  	<ul id="btc_nav" class="first-menu">
    <li><img src='resource_new/images/logo.png' onclick="javascript:window.location.href='index.do'"/>&nbsp;&nbsp;&nbsp;&nbsp;</li>
	  <li id="shouye"><a class="navtitle" href="index.do" title="首页">首页</a></li>
	  <li id="tradecenter"><a href="index.do?stock&stockId=<%=stockres.getString("stock.default.stockid")%>" target="_self" class="navtitle">实时行情</a></li>
	  <li id="yonghuzhongxin"><a href="index.do?usercenter" target="_self" class="navtitle">用户中心</a></li>
	  <li id="subscribe"><a href="index.do?rengou" target="_self" class="navtitle">兑换中心</a></li> <!-- -->
	  <li id="tfactory"><a href="index.do?factory" target="_self" class="navtitle">银行</a></li>
	  <li id="tshop"><a href="phonecard.do"  target="_self" class="navtitle">商城SHOP</a></li>
	  <li id="tluckwheel"><a href="luckwheel.do" target="_self" class="navtitle">游戏应用</a></li>
	   <li id="zuixindongtai"><a href="index.do?newslist" target="_self" class="navtitle">最新动态</a></li>
	  
	</ul>
</div>

<script type="text/javascript"> 
var stockids=new Array();
var name = new Array();
<%if(session.getAttribute("stock_map_navigation")!=null){
Map<String, NaviStockModel> stock_map_navigation = (Map<String, NaviStockModel>) session.getAttribute("stock_map_navigation");
Iterator it_stock_map_navigation = stock_map_navigation.keySet().iterator();
int i=0;
while(it_stock_map_navigation.hasNext()){
	String key = (String) it_stock_map_navigation.next();
	NaviStockModel btc_stock = (NaviStockModel)stock_map_navigation.get(key);
	%>
	stockids[<%=i%>]=<%=btc_stock.getId()%>;
<%
	i++;	
	}
}
%>
//创建XMLHttpReqtoptopuest对象     
var XMLHttpReqtop;
function createXMLHttpReqtopuest() {
  if(window.XMLHttpRequest) { //Mozilla 浏览器
   XMLHttpReqtop = new XMLHttpRequest();
  }
  else if (window.ActiveXObject) { // IE浏览器
   try {
    XMLHttpReqtop = new ActiveXObject("Msxml2.XMLHTTP");
   } catch (e) {
    try {
     XMLHttpReqtop = new ActiveXObject("Microsoft.XMLHTTP");
    } catch (e) {}
   }
  }
}
	
//发送请求函数
function getTopData(id) {
    a=a+1;
    if(a==count_top){a=0;}
    createXMLHttpReqtopuest();
    var url = 'topautoload.do?refreshstock&stockId='+id+'&exstock=CNY&n='+ Math.random();
    XMLHttpReqtop.onreadystatechange = processResponseTop;
	XMLHttpReqtop.open("GET", url, true);
    XMLHttpReqtop.send(null);  // 发送请求
}
function processResponseTop() {
 if (XMLHttpReqtop.readyState == 4) { // 判断对象状态
     if (XMLHttpReqtop.status == 200) { // 信息已经成功返回，开始处理信息
		DisplayHot_top();
		setTimeout('getTopData('+stockids[a]+')', 20000);
        } 
    }
}
function DisplayHot_top() {
 var topn_latestprice = XMLHttpReqtop.responseXML.getElementsByTagName("topn_latestprice")[0].firstChild.nodeValue;
 var topn_top_todayRate = XMLHttpReqtop.responseXML.getElementsByTagName("topn_top_todayRate")[0].firstChild.nodeValue;
 var topn_low_todayRate = XMLHttpReqtop.responseXML.getElementsByTagName("topn_low_todayRate")[0].firstChild.nodeValue;
 var topn_amount_today = XMLHttpReqtop.responseXML.getElementsByTagName("topn_amount_today")[0].firstChild.nodeValue;
 var topn_stockname = XMLHttpReqtop.responseXML.getElementsByTagName("topn_stockname")[0].firstChild.nodeValue;

 document.getElementById("topn_latestprice").innerHTML = "￥"+topn_latestprice;
 document.getElementById("topn_top_todayRate").innerHTML = topn_top_todayRate;
 document.getElementById("topn_low_todayRate").innerHTML = topn_low_todayRate;
 document.getElementById("topn_amount_today").innerHTML = topn_amount_today;
 document.getElementById("stock_top_name").innerHTML = topn_stockname;
 document.getElementById("stock_top_name2").innerHTML = topn_stockname;
 }
var a=0; 
var count_top = 0; 
</script>

<%
	String url = request.getRequestURI();
	if (request.getQueryString() != null)
		url += "?" + request.getQueryString();
%>

<script>
window.onload=function(){
	<%if(url.indexOf("stock")!=-1){%>
	sendRequest(); 
	<%}%>
	<%if(url.indexOf("factory")!=-1){%>
	check(); 
	<%}%>
	count_top=stockids.length;
	getTopData(stockids[0]);
}
</script>
<link href='styles/style.css' type='text/css' rel='stylesheet' />
