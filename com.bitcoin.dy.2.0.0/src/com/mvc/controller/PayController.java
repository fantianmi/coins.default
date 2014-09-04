package com.mvc.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mvc.entity.Btc_profit;
import com.mvc.entity.Btc_rechargeCNY_order;
import com.mvc.entity.Btc_user;
import com.mvc.service.ProfitService;
import com.mvc.service.RechargeService;
import com.mvc.util.DataUtil;
import com.mvc.util.MD5Util;
import com.mvc.vo.pay.Yeepay;
import com.mvc.vo.pay.Zhifu;

@Controller
@RequestMapping("/pay.do")
public class PayController {
	@Autowired
	private RechargeService rs = new RechargeService();
	@Autowired
	private ProfitService profitService = new ProfitService();
	@Autowired
	private MD5Util md5util;
	@Autowired
	private DataUtil datautil;
	
	ResourceBundle payres = ResourceBundle.getBundle("zhifu");
	ResourceBundle msgres = ResourceBundle.getBundle("msg");
	
	protected final transient Log log = LogFactory
			.getLog(RechargeController.class);

	@RequestMapping
	public String load(ModelMap modelMap, HttpServletRequest request) {
		return "index";
	}

	@RequestMapping(params = "CNY")
	public String rechargeCNY
	(ModelMap modelMap, HttpServletRequest request,HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		String code = (String) session
				.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		if (session.getAttribute("globaluser") == null) {
			request.setAttribute("msg", "登陆后才能进行此操作！");
			request.setAttribute("href", "index.do?recharge2bank");
			return "redirect";
		}
		Btc_user user = (Btc_user)session.getAttribute("globaluser");
		if (user.getUstatus().equals("frozen")) {
			request.setAttribute("msg", "您的账户已被冻结，无法进行任何操作，请尽快联系客服人员解冻");
			request.setAttribute("href", "index.do?recharge2bank");
			return "redirect";
		}
		if (!user.getUstatus().equals("active")) {
			request.setAttribute("msg", "您的账户未激活，请查看您的注册邮箱点击链接激活，或者联系客服进行人工激活");
			request.setAttribute("href", "index.do?userdetail");
			return "redirect";
		}
		Btc_profit btc_profit = profitService.getConfig();
		BigDecimal bro_recharge_acount = new BigDecimal(request.getParameter("order_amount").toString());
		BigDecimal rechargeCNY_limit = btc_profit.getBtc_profit_rechargeCNY_limit();
		if (bro_recharge_acount.compareTo(rechargeCNY_limit) == -1) {
			request.setAttribute("msg", "充值金额少于最低限制，系统不予受理，请重新输入");
			request.setAttribute("href", "index.do?recharge2bank");
			return "redirect";
		}
		//以前充值功能参数
		String bro_recharge_way = request.getParameter("bro_recharge_way");
		//save order
		String bro_recharge_time=datautil.getTimeNow("second");
		BigDecimal bro_factorage = bro_recharge_acount.multiply(btc_profit.getBtc_profit_rechargeCNY_poundage());
		bro_factorage.setScale(2, BigDecimal.ROUND_HALF_UP);
		String billNo= String.valueOf(System.currentTimeMillis());
		
		Btc_rechargeCNY_order bro = new Btc_rechargeCNY_order();
		bro.setBro_recharge_acount(bro_recharge_acount);
		bro.setBro_recharge_time(bro_recharge_time);
		bro.setBro_sname(user.getUname());
		bro.setBro_rname(payres.getString("payway"));
		bro.setBro_recharge_way(bro_recharge_way);
		bro.setUid(user.getUid());
		bro.setBro_remark("等待支付");
		bro.setBro_factorage(bro_factorage);
		bro.setBillNo(billNo);
		rs.rechargeCNY(bro);
		
		Zhifu zhifu = new Zhifu(bro_recharge_acount, billNo);
		request.setAttribute("zhifu", zhifu);
		
		return "gotopay4"+payres.getString("payway")+"";
	}
}
