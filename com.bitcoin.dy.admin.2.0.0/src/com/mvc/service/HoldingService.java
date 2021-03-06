package com.mvc.service;


import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mvc.dao.EntityDao;
import com.mvc.entity.Btc_holding;
/**
 * 操作持仓库
 * @author jack
 *
 */
@Service
public class HoldingService {
	@Autowired
	private EntityDao entityDao;
	
  /**
   * 查询账户持有信息
   * @param uid
   * @param btc_stock_id
   * @return
   */
	public Btc_holding getBtc_holding(int uid, int btc_stock_id){
		Btc_holding btc_holding = new Btc_holding();
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.uid='" + uid + "' and btc_holding.btc_stock_id="+btc_stock_id+"");
		if (list.size() != 0) {
			btc_holding = (Btc_holding)list.get(0);
			return btc_holding;
		}else{
			return btc_holding = null;
		}	
	}
	
	public Btc_holding getBtc_holdingByBhid(int btc_holding_id){
		Btc_holding btc_holding = new Btc_holding();
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.btc_holding_id='" + btc_holding_id + "'");
		if (list.size() != 0) {
			btc_holding = (Btc_holding)list.get(0);
			return btc_holding;
		}else{
			return btc_holding = null;
		}	
	}
	
	/**
	 * 查询账户持有信息
	 * @param uid
	 * @param btc_stock_id
	 * @return
	 */
	public List<Object> getBtc_holding(int uid){
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.uid=" + uid + "");
		return list;
	}
	
	public Map<Integer,Btc_holding> getUserholdMap(int uid){
		Map<Integer,Btc_holding> map = new HashMap<Integer, Btc_holding>();
		Btc_holding hold = new Btc_holding();
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.uid=" + uid + "");
		if(list.size()!=0){
			for(int i=0;i<list.size();i++){
				hold = (Btc_holding)list.get(i);
				map.put(hold.getBtc_stock_id(),hold);
			}
			return map;
		}
		return null;
	}
	public Map<Integer,BigDecimal> getHoldMapByUIDandAMOUNT(int stockid){
		Map<Integer,BigDecimal> map = new HashMap<Integer, BigDecimal>();
		Btc_holding hold = new Btc_holding();
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.btc_stock_id=" + stockid + "");
		if(list.size()!=0){
			for(int i=0;i<list.size();i++){
				hold = (Btc_holding)list.get(i);
				map.put(hold.getUid(),hold.getBtc_stock_amount());
			}
			return map;
		}
		return null;
	}
	
	/**
	 * 查询账户持有信息
	 * @param uid
	 * @param btc_stock_id
	 * @return
	 */
	public Map<Integer,Object> getBtc_holdingToMapByUid(int uid){
		Map<Integer,Object> map = new HashMap<Integer,Object>();
		Btc_holding hold = new Btc_holding();
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.uid=" + uid + "");
		if(list.size()!=0){
			for(int i=0;i<list.size();i++){
				hold = (Btc_holding)list.get(i);
				map.put(hold.getBtc_stock_id(), hold);
			}
		}
		return map;
	}
	
	public BigDecimal getCountStockHoldAmount(int btc_stock_id){
		BigDecimal amount = new BigDecimal(0);
		List<Object> list = entityDao.createQuery("select sum(btc_holding.btc_stock_amount) from Btc_holding btc_holding where btc_holding.btc_stock_id=" + btc_stock_id + "");
		if(list.size()!=0){
			if(list.get(0)!=null){
				amount = new BigDecimal(list.get(0).toString());
			}
		}
		return amount;
	}
	
 /**
 * 更新账户持有信息
 * @param btc_holding
 */
	public void updateBtc_holding(Btc_holding btc_holding) {
		entityDao.update(btc_holding);
	}
	
	/**
	 * 保存账户持有信息
	 * @param btc_holding
	 */
	public void saveBtc_holding(Btc_holding btc_holding) {
		entityDao.save(btc_holding);
	}
	
	/**
	 * 删除账户持有信息
	 * @param btc_holding
	 */
	public void deleteBtc_holding(Btc_holding btc_holding) {
		entityDao.delete(btc_holding);
	}
	
	public List<Object> getAll(int stockid,int start,int count){
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.btc_stock_id=" + stockid + " order by btc_holding.btc_stock_amount desc",start,count);
		if(list.size()!=0)return list;
		return null;
	}
	public List<Object> getAll(int stockid){
		List<Object> list = entityDao.createQuery("select btc_holding from Btc_holding btc_holding where btc_holding.btc_stock_id=" + stockid + " order by btc_holding.btc_stock_amount desc");
		if(list.size()!=0)return list;
		return null;
	}
}
