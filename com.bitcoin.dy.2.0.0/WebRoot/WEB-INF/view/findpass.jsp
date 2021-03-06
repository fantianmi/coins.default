<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.math.BigDecimal"%>
<%@ page import="com.mvc.entity.*" %>
<%@ page import="com.mvc.vo.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.*"%>
<%ResourceBundle res = ResourceBundle.getBundle("host"); %>  
 <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="EN" lang="EN" dir="ltr">
<head profile="http://gmpg.org/xfn/11">
    <title>安全中心，找回密码&nbsp;<%=res.getString("host.title")%></title>
	<jsp:include page="/include/htmlsrc.jsp"/>
</head>
  
 <body>
<jsp:include page="/include/headhtml.jsp"></jsp:include>
<!-- content -->
<div class="wrapper row3">
  <div id="container">
    <div id="contact" class="clear">
      <div class="one_half first">
        <h1><%=res.getString("host.small.title") %>安全中心</h1>
        <p>首先请验证您的身份信息才能找回密码，请输入您要找回的用户名，然后点击确认，我们会把验证信息发到您的邮箱或者手机中，请注意查收</p>
        <div id="respond">
          <h2>找回您的<%if(request.getParameter("type").equals("utpass")){%>交易<%} %>密码
          </h2>
          <form class="rnd5" action="#" method="post">
            <div class="form-input clear">
              <label class="one_half first" for="usernameinput">用户名 <span class="required">*</span><br>
                <input type="text" name="username" id="usernameinput" size="22" placeholder="您注册的用户名"/>
              </label>
            </div>
            <div class="form-input clear">
              <span class="one_half first">
                <input type="button"  onclick="" class="button small black rnd8" value="确认" id="checkbtn"/>
              </span>
            </div>
          </form>
        </div>
      </div>
      <div class="one_half">
        <section class="contact_details clear">
          <h2>温馨提示</h2>
          <p>请按照提示找回您的密码，验证码会发送到您的注册邮箱中，请注意查收您的邮箱，获得验证码。</p>
          <p>其他问题请及时联系平台客服人员，我们会全力为您解答！</p>
           <jsp:include page="/include/address.jsp" />
        </section>
      </div>
    </div>
    <div class="clear"></div>
  </div>
</div>

<script type="text/javascript">
document.getElementById("checkbtn").onclick=function(){
	var type = '<%=request.getAttribute("type")%>';
	var username = document.getElementById('usernameinput').value;
	var url = 'register.do?findpass&username='+username+'&type='+type+'&n='+Math.random();
	buttondo(url);
}
</script>	

<jsp:include page="/include/foothtml.jsp"></jsp:include>
</div>
</body>
</html>
