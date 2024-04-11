package com.cafe24.goott351.util;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.cafe24.goott351.domain.ProductVO;
import com.cafe24.goott351.user.product.persistence.ProductDao;

@Component
public class ProductClassUpdateScheduler {

	private static final Timestamp before14 = new Timestamp(System.currentTimeMillis()-(1000*60*60*24*14));

	
	@Autowired
	ProductDao pDao;
	
	/**
	* @Method       : productClassUpdate
	* @PackageName  : com.cafe24.goott351.util
	* @Return       : void
	* @Description  : 20번(신규) 카테고리 상품을 가져오고
	*				  등록일을 확인하여 14일이 지났으면 30번(완료)으로 변경
	* ===========================================================
	* DATE              AUTHOR             Memo
	* -----------------------------------------------------------
	* 2024.02.29        Taeho Cho
	*/
	@Scheduled(cron = "0 0 0 * * *") // 매일 자정에 실시
	public void productClassUpdate() throws Exception {

		List<ProductVO> newList = pDao.selectProductByClass(null, 20);
		if (newList != null) {
			for (ProductVO vo : newList) {
				if (vo.getRegDate().before(before14)) {
					if (pDao.updateClassCode(vo) == 1) {
					};
				}
			}			
		}
	}

	
}