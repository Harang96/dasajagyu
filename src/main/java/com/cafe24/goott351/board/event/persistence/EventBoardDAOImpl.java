package com.cafe24.goott351.board.event.persistence;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.EventImgVo;
import com.cafe24.goott351.domain.EventVo;

@Repository
public class EventBoardDAOImpl implements EventBoardDAO {
	
	private static String ns = "com.cafe24.goott351.mappers.eventBoardMapper";
	
	@Inject
	private SqlSession ses;
	
	@Autowired
    public EventBoardDAOImpl(SqlSession sqlSession) {
        this.ses = sqlSession;
    }
	
	@Override
	public int saveBoard(EventVo event) throws Exception {
		
		return ses.insert(ns + ".insertNewBoard", event);
		
	}

	@Override
	public int saveEventImage(int eventNo ,EventImgVo ei) throws Exception {
		
		return ses.insert(ns + ".saveEventImage", ei);
		
	}

	@Override
	public int selectEventNo() throws Exception {
		
		return ses.selectOne(ns + ".getEventNo");
	}

	@Override
	public List<EventVo> selectMainEvent() throws Exception {
		
		return ses.selectList(ns + ".getMainEvent");
		
	}
	
	
	@Override
	public List<EventVo> selectDetailEvent() throws Exception {
		
		return ses.selectList(ns + ".getDetailEvent");
		
	}

	@Override
	public EventVo selectEventDetail(int no) throws Exception {
		
		return ses.selectOne(ns + ".getEventDetail", no);
	}

	@Override
	public List<EventImgVo> selectImgList(int no) {
		
		return ses.selectList(ns + ".getImgList", no);
	}

	@Override
	public int updateEvent(EventVo event) throws Exception {
		
		
	    return ses.update(ns + ".updateEvent", event);
	    
	}

	@Override
	public int deleteEvent(int eventNo) throws Exception {
		
		return ses.delete(ns + ".deleteEvent", eventNo);
		
	}

	@Override
	public void updateFileList(List<EventImgVo> fileList) throws Exception {
		ses.update(ns + "saveEventImage", fileList);
	}

	@Override
	public void deleteImgEvent(int eventNo) throws Exception {
		ses.delete(ns + ".deleteImgEvent", eventNo);
		
	}

	@Override
	public List<CustomerVO> selectEventDetail(String admin) {
		return ses.selectList(ns + ".selectListAll", admin);
	}

	
	
}
