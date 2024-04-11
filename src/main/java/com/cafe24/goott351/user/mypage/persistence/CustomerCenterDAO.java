/**
 * 
 */
package com.cafe24.goott351.user.mypage.persistence;

import java.util.List;

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
public interface CustomerCenterDAO {

	// service board 테이블에서 리스트 가져오기
	List<ServiceBoardDTO> selectQnaBoardList(ServiceBoardDTO serviceBoardDTO) throws Exception;

	// 글쓰기
	int insertPost(ServiceBoardDTO post) throws Exception;

	// 게시글 가져오기
	ServiceBoardVO selectPost(ServiceBoardDTO post) throws Exception;

	// 게시글 수정하기
	int updatePost(ServiceBoardDTO serviceBoardDTO) throws Exception;

	// ishidden 수정하기
	int updatePostHidden(String yn) throws Exception;

	// 게시글 소프트 삭제하기
	int updatePostSoftDelete(int boardNo) throws Exception;

	// uuid로 관리자인지 확인하기위해 사용자 정보를 가져옴.
	CustomerVO selectUserIsAdmin(String uuid) throws Exception;

	// 답글 게시글 연결
	int updateCommentBoardNo(Integer commentBoardNo, Integer svBoardNo) throws Exception;
}
