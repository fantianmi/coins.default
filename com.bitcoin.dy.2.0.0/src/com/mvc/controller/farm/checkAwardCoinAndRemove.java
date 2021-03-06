package com.mvc.controller.farm;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.mvc.entity.Btc_holding;
import com.mvc.service.HoldingService;
import com.mvc.util.DESUtil;
import com.mvc.util.HoldingUtil;
import com.mvc.util.JsonUtils;
@Controller
@RequestMapping("/checkAwardCoinAndRemove.do")
public class checkAwardCoinAndRemove {
	ResourceBundle res = ResourceBundle.getBundle("farm"); 
	@Autowired
	private HoldingService holds;
	@Autowired
	private HoldingUtil holdutil;
	protected final transient Log log = LogFactory.getLog(checkAwardCoinAndRemove.class);

	@RequestMapping
	public void load(
			@RequestParam("data")String data,
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		data = DESUtil.decrypt(data);
		String s[]=data.split("#");
		int tuid=Integer.parseInt(s[0]);
		BigDecimal amount=new BigDecimal(s[1]);
		JSONObject obj = new JSONObject();
		Btc_holding hold = new Btc_holding();
		hold=holds.getBtc_holding(tuid, Integer.parseInt(res.getString("zzstockid")));
		if(hold==null){
			obj.put("flag", 1);
			obj.put("msg", "hold not enough");
			response.getWriter().write(JsonUtils.object2json(obj));
		    response.getWriter().flush();
		    response.getWriter().close();
		    return;
		}
		if(hold.getBtc_stock_amount().compareTo(amount)<0){
			obj.put("flag", 1);
			obj.put("msg", "hold not enough");
			response.getWriter().write(JsonUtils.object2json(obj));
		    response.getWriter().flush();
		    response.getWriter().close();
		    return;
		}
		holdutil.subStock(tuid, Integer.parseInt(res.getString("zzstockid")), amount);
		
		obj.put("flag", 0);
		obj.put("msg", "success");
		response.getWriter().write(JsonUtils.object2json(obj));
	    response.getWriter().flush();
	    response.getWriter().close();
	}
}
