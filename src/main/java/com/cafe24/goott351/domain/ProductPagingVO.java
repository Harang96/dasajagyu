package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@ToString
public class ProductPagingVO {
	// 1페이지당 출력할 데이터를 끊어내기 위해 필요한 맴버들
		private int totalProductCnt; // 전체 상품의 갯수
		private int pageProductCnt = 60; // 한페이지에 보여줄 상품의 갯수
		private int totalPageCnt; // 총페이지 수
		private int startRowIndex; // 보여주기 시작할 목록의 row index 번호
		private int pageNo; // 유저가 클릭한 페이지의 번호
		
		// pagenation 작업을 위한 맴버
		private int pageBlockCnt = 10; // 한개 블럭에 보여줄 페이지 갯수
		private int totalPagingBlock; // 전체 페이징 블럭 객수
		private int currentPageBlock; // 현재 페이지가 속한 페이징 블럭 번호
		private int startPageNum; // 현재 블럭의 시작 페이지 번호
		private int endPageNum; // 현재 블럭의 마지막 페이지 번호
		
		public void setTotalProductCnt(int totalProductCnt) {
			this.totalProductCnt = totalProductCnt;
		}

		public void setPageProductCnt(int pageProductCnt) {
			this.pageProductCnt = pageProductCnt;
		}

		public void setTotalPageCnt(int totalProductCnt, int pageProductCnt) {
			if ( totalProductCnt % pageProductCnt == 0) {
				this.totalPageCnt = totalProductCnt / pageProductCnt;			
			} else {
				this.totalPageCnt = totalProductCnt / pageProductCnt + 1;						
			}
		}

		public void setStartRowIndex() {
			this.startRowIndex = (this.pageNo - 1) * this.pageProductCnt;
		}
		
		public void setPageNo(int pageNo) {
			this.pageNo = pageNo;
		}

		public void setPageBlockCnt(int pageBlockCnt) {
			this.pageBlockCnt = pageBlockCnt;
		}

		public void setTotalPagingBlock() {
			if (this.totalPageCnt % this.pageBlockCnt  == 0) {
				this.totalPagingBlock = totalPageCnt / pageBlockCnt ;
			} else {
				this.totalPagingBlock = totalPageCnt / pageBlockCnt + 1;
			}
		}

		public void setCurrentPageBlock() {
			if (this.pageNo % this.pageBlockCnt == 0) {
				this.currentPageBlock = this.pageNo / this.pageBlockCnt ;			
			} else {
				this.currentPageBlock = (int)Math.ceil((double)this.pageNo / this.pageBlockCnt);						
//				this.currentPageBlock = this.pageNo / this.pageBlockCnt + 1;						
			}
		}

		public void setStartPageNum() {
			this.startPageNum = (this.currentPageBlock - 1) * this.pageBlockCnt + 1;
		}

		public void setEndPageNum() {
			this.endPageNum = this.currentPageBlock * this.pageBlockCnt;
			if (this.endPageNum > this.totalPageCnt) {
				this.endPageNum = this.totalPageCnt;						
			}
		}

		

}
