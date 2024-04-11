/**
 * 
 */
package com.cafe24.goott351.user.mypage.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.ServiceBoardDTO;
import com.cafe24.goott351.domain.ServiceBoardVO;
import com.cafe24.goott351.user.mypage.persistence.CustomerCenterDAO;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 21.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 21.
 */
@Service
public class CustomerCenterServiceImpl implements CustomerCenterService {

	@Inject
	private CustomerCenterDAO dao;

	/**
	 * @Method : qnaBoard
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : ===========================================================
	 *              DATE AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public List<ServiceBoardVO> qnaBoard(ServiceBoardDTO serviceBoardDTO) throws Exception {
		return null;
	}

	/**
	 * @Method : selectQnaBoard
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : QnA게시판 리스트 불러오기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public List<ServiceBoardDTO> selectQnaBoardList(ServiceBoardDTO serviceBoardDTO) throws Exception {
		return dao.selectQnaBoardList(serviceBoardDTO);
	}

	/**
	 * @Method : savePost
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : 게시판 글쓰기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public int insertNewPost(ServiceBoardDTO post) throws Exception {
//		String title = post.getSvBoardTitle();
//		String content = post.getSvBoardContent();
//		String csType = post.getCsType();
//		String writer = post.getUuid();
//		String hiddenYn = post.getSvIsHidden();
//		Integer productNo = post.getProductNo();
//		String orderNo = post.getOrderNo();
//		String nickname = post.getNickname();
//
//		if (validationChk(title) && validationChk(content) && validationChk(csType) && validationChk(writer)
//				&& validationChk(hiddenYn) && validationChk(orderNo) && validationChk(nickname)) {
		return dao.insertPost(post);
//		} else {
//			return -1;
//		}
	}

	/**
	 * @Method : savePost
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : 글번호로 게시글 정보 가져오기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public ServiceBoardVO selectQnaBoard(ServiceBoardDTO post) throws Exception {
		return dao.selectPost(post);
	}

	/**
	 * @Method : savePost
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : 게시글 수정하기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public int updatePost(ServiceBoardDTO post) throws Exception {
		return dao.updatePost(post);
	}

	/**
	 * @Method : savePost
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : 게시글 수정하기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public int updatePostHidden(String yn) throws Exception {
		return dao.updatePostHidden(yn);
	}

	public boolean validationChk(String str) {
		boolean result = false;

		if (str.equals("")) {
			result = false;
		} else {
			result = true;
		}

		return result;

	}

	/**
	 * @Method : updatePostSoftDelete
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : ===========================================================
	 *              DATE AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.22 su hyeok kim
	 */
	@Override
	public int updatePostSoftDelete(int boardNo) throws Exception {
		return dao.updatePostSoftDelete(boardNo);
	}

	/**
	 * @Method : selectUserIsAdmin
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : 관리자인지 확인하기위해 customer 테이블에서 유저 검색
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.22 su hyeok kim
	 */
	@Override
	public CustomerVO selectUserIsAdmin(String uuid) throws Exception {
		return dao.selectUserIsAdmin(uuid);
	}

	/**
	 * @Method : insertNewPostAdmin
	 * @PackageName : com.cafe24.goott351.user.mypage.service
	 * @Description : 답글 작성 후 타겟 게시글에 연결시키기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.22 su hyeok kim
	 */
	@Override
	public ServiceBoardDTO insertNewPostAdmin(ServiceBoardDTO post) throws Exception {
		ServiceBoardDTO result = null;

		// 답글을 단 후 그 답글을 해당 게시글에 연결시키기
		if (dao.insertPost(post) == 1) {
			if (dao.updateCommentBoardNo(post.getCommentBoardNo(), post.getSvBoardNo()) == 1) {
				result = post;
			}
		}

		return result;
	}

}
