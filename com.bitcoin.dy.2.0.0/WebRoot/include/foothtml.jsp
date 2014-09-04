<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<!-- Footer -->
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
<%ResourceBundle stockres = ResourceBundle.getBundle("stock"); %>  
<%List<Btc_content> newslist = (List<Btc_content>)session.getAttribute("newslist");%>    
<div class="wrapper row4">
<!-- footone -->
<div class="footer fontcolor2">
	<div class="footer-box control-boxn2n">
		<div class="f-part1">
			<h2>关于我们</h2>
			<ul class="list circle">
				<li><a target="_blank"  href="index.do?aboutus">新虚拟币证券网</a></li>
				<li><a target="_blank"  href="index.do?aboutus">联系我们</a></li>
				<li><a target="_blank"  href="index.do?newsdetail&contentid=84">隐私政策</a></li>
				<li><a target="_blank"  href="index.do?newsdetail&contentid=86">服务协议</a></li>
				<li><a target="_blank"  href="index.do?newsdetail&contentid=85">法律声明</a></li>
				<li><a target="_blank"  href="index.do?newsdetail&contentid=87">知识产权</a></li>
				<li><a target="_blank"  href="index.do?aboutus">招贤纳士</a></li>
			</ul>
		</div>
		<div class="f-part2">
			<h2>最新消息</h2>
			<ul class="list roman">
		 <%for(int i=0;i<newslist.size();i++){
	      	Btc_content news = newslist.get(i);
	      	int newsid = news.getBtc_content_id();
	      	String title = news.getBtc_content_title();
	      	String content = news.getBtc_content_msg();
	      	%>
	      	<li><a target="_blank" href="index.do?newsdetail&contentid=<%=news.getBtc_content_id()%>"><%=title %></a></li>
	      <%} %>
		</ul>

		</div>
		<div class="f-part3">
			<h2>联系我们</h2>
			<p><%=res.getString("host.jianjie") %></p>
			<p>
</p><p class="footerinfoimg footerinfoimg_contact"></p>
<p class="contact-us1">客服电话: <%=res.getString("host.tel") %></p>
<p class="contact-us2">商务电话: <%=res.getString("host.shangwudianhua") %></p>
<p class="contact-us3">商务合作: <%=res.getString("host.shangwuhezuo") %></p>
<p class="contact-us4">客户服务: <%=res.getString("host.kefufuwu") %></p>
<p class="contact-us5">企业QQ : <%=res.getString("host.qiyejiaotan") %></p>
	<p></p>
		</div>
		<div class="f-part4">
			<h2>风险提示</h2>
			<p><span class="important">重要</span>虚拟币的交易有极高的风险，它没有像中国股市那样的涨跌停限制，同时交易是24小时开放的。比特币由于筹码较少，价格易受到庄家控制，有可能出现一天价格涨几倍的情况，同时也可能出现一天内价格跌去一半的情况！入市须谨慎，一定注意控制好风险！</p>
			<div class="footer_followus">
				<h2>关注我们</h2>
				<p><%=res.getString("host.weixin") %></p>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</div>
</div>
<!-- footone -->
<div class="wrapper row4"  style="background-color: #44464A">
  <div id="copyright" class="clear">
      <p class="fl_left">
        <!-- <ul class="list tagcloud rnd8">
         <li><a href="#">比特币交易中心</a></li><li><a href="#">莱特币交易中心</a></li><li><a href="#">山寨币交易中心</a></li>
         <li><a href="#">SZB123山寨币导航</a></li><li><a href="#">比特币侦察兵</a></li><li><a href="#">比特潮</a></li><li><a href="#">BTC12</a></li>
        </ul>  -->
      </p>
       <p class="fl_left">官方QQ群： 1群<%=res.getString("host.qq.group1") %>   2群<%=res.getString("host.qq.group2") %></p>
    <br>
    <p class="fl_left">版权所有  Copyright (C) 2013-2014  - 
    <a href="#">
    <span class="fl_leftf"><%=res.getString("host.beian")%></span></a>&nbsp;&nbsp;7X24小时服务电话 <%=res.getString("host.tel")%></p>
  </div>
</div>
<!-- Scripts -->
<script src="js/jquery-latest.min.js"></script>
<script src="js/jquery-ui.min.js"></script>
<script>window.jQuery || document.write('<script src="resource_new/layout/scripts/jquery-latest.min.js"><\/script>\
<script src="resource_new/layout/scripts/jquery-ui.min.js"><\/script>')</script>
<script>jQuery(document).ready(function($){ $('img').removeAttr('width height'); });</script>
<script src="resource_new/layout/scripts/jquery-mobilemenu.min.js"></script>
<script src="resource_new/layout/scripts/custom.js"></script>


