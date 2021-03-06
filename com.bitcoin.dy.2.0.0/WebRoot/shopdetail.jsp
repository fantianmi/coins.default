<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle shopres = ResourceBundle.getBundle("shop"); %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
<title><%=res.getString("host.title")%></title>
<script type="text/javascript" src="js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="form/ajaxsubmit.js"></script>
<script type="text/javascript" src="form/check.js"></script>
<script type="text/javascript"> 
$(document).ready(function() {
	loadshop();
});
var XMLHttpReq;
function createXMLHttpRequest() {
  if (window.XMLHttpRequest) { //Mozilla 浏览器
    XMLHttpReq = new XMLHttpRequest();
  } else if (window.ActiveXObject) { // IE浏览器
    try {
      XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");
    } catch(e) {
      try {
        XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
      } catch(e) {}
    }
  }
}
function loadshop() {
  createXMLHttpRequest();
  var url = 'loadshop.do?getcard&n=' + Math.random();
  XMLHttpReq.open("GET", url, true);
  XMLHttpReq.onreadystatechange = processResponse; //指定响应函数
  XMLHttpReq.send(null); // 发送请求
}
function processResponse() {
  if (XMLHttpReq.readyState == 4) { // 判断对象状态
    if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息
      showdata();
    }
  }
}	
function showdata() {
  var dayamount = XMLHttpReq.responseXML.getElementsByTagName("dayamount")[0].firstChild.nodeValue;
  var amount = XMLHttpReq.responseXML.getElementsByTagName("amount")[0].firstChild.nodeValue;
  var kucun = XMLHttpReq.responseXML.getElementsByTagName("kucun")[0].firstChild.nodeValue;
  var  isopenstr = XMLHttpReq.responseXML.getElementsByTagName("isopenstr")[0].firstChild.nodeValue;
  document.getElementById("dayamount").innerHTML = dayamount;
  document.getElementById("amountn").innerHTML = amount;
  document.getElementById("kucun").innerHTML = kucun;
  document.getElementById("isopenstr").innerHTML=isopenstr;
}	
function doBuySubmit(){
	submitForm2("buyform");
}
</script>
</head>
  <body>
  <form action="phonecard.do?buycard" id="buyform">
<input type="hidden" name="price" id="price" value="<%=shopres.getString("product.price")%>"/>
<input type="hidden" name="amount" id="amount" value="<%=shopres.getString("product.price")%>"/>
<input type="hidden" name="stockid" id="stockid" value="<%=shopres.getString("shop.stock.id")%>"/>
</form>
  
<!-- shop res -->
<link rel="stylesheet" href="styles/shop/a_009.css">
<link rel="stylesheet" href="styles/shop/a_006.css">
<link rel="stylesheet" href="styles/shop/a_008.css">
<link rel="stylesheet" href="styles/shop/a_002.css" charset="utf-8">


<!-- shop res -->
<div id="detail">
     <div id="J_DetailMeta" class="tm-detail-meta tm-clear">
         <div class="tm-clear">
             <div class="tb-property">
                 <div class="tb-wrap">
                     <div class="tb-detail-hd"><h1 data-spm="1000983"><span style="color:#DE3A33" id="isopenstr"></span>-<%=shopres.getString("product.name")%></h1></div>
                     <!--引入normalBasic-->
                     <ul class="tm-fcs-panel">
                         <li style="display: none;" class="tm-promo-panel" id="J_PromoPrice" data-label="促销"></li>
                         <li class="tm-price-panel tm-price-cur" id="J_StrPriceModBox">
                             <em class="tm-yen"><%=shopres.getString("product.price")%></em>
                             <span class="tm-price">
                                 <%=shopres.getString("shop.stock.eng")%>
                             </span>
                         </li>
                         <li class="tm-delivery-panel tm-clear" id="J_RSPostageCont">
                             <div class="tb-postAge">
                                 <span id="J_deliveryAdd" class="tb-deliveryAdd"><%=shopres.getString("send.address")%></span>
                                 <div id="J_PostageToggleCont" class="tb-postAge-info"><p><span> 快递: 0.00</span></p></div>
                             </div>
                         </li>
                         <li class="tm-fcs-label">价格</li>
                     </ul>
                     <ul class="tb-meta">
                     </ul>
                     <ul class="tm-ind-panel">
                         <li class="tm-ind-item tm-ind-sellCount canClick" data-label="月销量">
                             <p class="tm-count" id="dayamount"></p><p class="tm-label"> 日销量 </p>
                         </li>
                         <li class="tm-ind-item tm-ind-reviewCount canClick tm-line3" id="J_ItemRates">
                             <p class="tm-count"><span id="amountn"></span></p><p class="tm-label">总销量</p>
                         </li>
                     </ul>
                     <div class="tb-key"><div class="tb-skin"><div class="tb-sku">
                     				<dl class="tb-amount tm-clear">
                                     <dt class="tb-metatit">数量 </dt>
                                     <dd id="J_Amount">
                                         <select><option selected="selected" value="1"> 1</option></select>
                                         <em style="display: inline;" id="J_EmStock" class="tb-hidden">库存<span id="kucun"></span>件</em>
                                         <span id="J_StockTips"></span>
                                     </dd>
                                 </dl>
                                 <div class="tb-action tm-clear">
                                     <div class="tb-btn-dfill tb-btn-sku">
                                         <a id="J_LinkBuy" href="javascript:doBuySubmit();" rel="nofollow" data-addfastbuy="true" title="点击确认购买">
                                             立刻购买
                                         </a>
                                     </div>
                                     <div class="tm-buytip">
                                     <%=shopres.getString("card.use.address")%>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                     <div class="tm-ser tm-clear">
                         <dl class="tm-clear">
                             <dt class="tb-metatit">服务承诺</dt><dd class="tm-laysku-dd">请把购买到的充值码和需要充值的手机号发给运营客服qq 88253482 等候充值，预防因各种原因卡密实效</dd>
                         </dl>
                     </div>
                 </div>
             </div>
        	<!-- pic area -->
        	<div data-spm-max-idx="6" data-spm="1997427645" class="tb-gallery"><div class="tm-brand"><em><a data-spm-anchor-id="a220o.1000855.1997427645.d4918085" data-spm="d4918085" target="_blank" href="http://brand.tmall.com/brandInfo.do?spm=a220o.1000855.1997427645.d4918085.oRjY2p&amp;brandId=&amp;scm=1048.1.1.14"></a></em></div>
        		<div class="tb-booth tb-pic tb-s360"><a data-spm-anchor-id="a220o.1000855.1997427645.2" href="#" rel="nofollow" ><img id="J_ImgBooth" src="img/shop/card.png" width=350px data-haszoom="700"></a></div>
				<ul id="J_UlThumb" class="tb-thumb tm-clear"><li class="tb-pic tb-s60 tb-selected"><a data-spm-anchor-id="a220o.1000855.1997427645.3" href="#"><img src="img/shop/card.png" height=60px></a></li></ul>
			</div>
        	<!-- pic area -->
         </div>
     </div>
 </div>
<!-- shop area -->
</body>
</html>
