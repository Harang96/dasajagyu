/**
 * 
 */
package com.cafe24.goott351.user.mypage.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.ServiceBoardDTO;
import com.cafe24.goott351.domain.ServiceBoardVO;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 21.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 21.
 */
@Repository
public class CustomerCenterDAOImpl implements CustomerCenterDAO {

	private static String ns = "com.cafe24.goott351.mappers.customerCenterServiceMapper";

	@Inject
	private SqlSession ses;

	/**
	 * @Method : selectQnaBoard
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : ===========================================================
	 *              DATE AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public List<ServiceBoardDTO> selectQnaBoardList(ServiceBoardDTO serviceBoardDTO) throws Exception {
		return ses.selectList(ns + ".selectQnaBoardList", serviceBoardDTO);
	}

	/**
	 * @Method : insertPost
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : 글쓰기 시 객체 및 csType전달
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public int insertPost(ServiceBoardDTO post) throws Exception {
		return ses.insert(ns + ".insertPost", post);
	}

	/**
	 * @Method : selectPost
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : 게시글 정보 가져오기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public ServiceBoardVO selectPost(ServiceBoardDTO post) throws Exception {
		return ses.selectOne(ns + ".selectPost", post);
	}

	/**
	 * @Method : updatePost
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : 게시글 수정하기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public int updatePost(ServiceBoardDTO serviceBoardDTO) throws Exception {
		return ses.update(ns + ".updatePost", serviceBoardDTO);
	}

	/**
	 * @Method : updatePostHidden
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : 게시글 isHidden 수정하기
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.21 su hyeok kim
	 */
	@Override
	public int updatePostHidden(String yn) throws Exception {
		return ses.update(ns + ".updatePostHidden", yn);
	}

	/**
	 * @Method : updatePostSoftDelete
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : ===========================================================
	 *              DATE AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.22 su hyeok kim
	 */
	@Override
	public int updatePostSoftDelete(int svBoardNo) throws Exception {
		return ses.update(ns + ".updatePostSoftDelete", svBoardNo);
	}

	/**
	 * @Method : selectUserIsAdmin
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : 관리자인지 확인하기위해 customer 테이블에서 유저 검색
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.22 su hyeok kim
	 */
	@Override
	public CustomerVO selectUserIsAdmin(String uuid) throws Exception {
		return ses.selectOne(ns + ".selectUserIsAdmin" + uuid);
	}

	/**
	 * @Method : updateCommentBoardNo
	 * @PackageName : com.cafe24.goott351.user.mypage.persistence
	 * @Description : 답글 게시글 연결
	 *              =========================================================== DATE
	 *              AUTHOR Memo
	 *              -----------------------------------------------------------
	 *              2024.03.22 su hyeok kim
	 */
	@Override
	public int updateCommentBoardNo(Integer commentBoardNo, Integer svBoardNo) throws Exception {
		Map<String, Integer> param = new HashMap<>();
		param.put("commentBoardNo", commentBoardNo);
		param.put("svBoardNo", svBoardNo);

		return ses.update(ns + ".updateCommentBoardNo", param);
	}

}
