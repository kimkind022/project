package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.ProductBean;
import mybatis.SqlMapConfig;

public class StoreMainReviewSelectService {
	
	static StoreMainReviewSelectService storeMainReviewSelectService = new StoreMainReviewSelectService();

	public static StoreMainReviewSelectService instance(){
		return storeMainReviewSelectService;
	}
	
	private SqlSessionFactory factory = SqlMapConfig.getSqlSession(); //디비연결부분.
	
	public List<ProductBean> getReviewList(){
		System.out.println("3. 위치: StoreMainReviewSelectService");

		List<ProductBean> list = null;
		SqlSession sqlSession = factory.openSession();
		list = sqlSession.selectList("selectReviewCount");   
//		sqlSession의 selectList의 매개변수로 넣는 selectProduct을 Mapper.xml로 가서 찾아서 id를 selectProduct으로 지어놓은 쿼리태그 수행/
		
		System.out.println(list);
		//excuteupdate하는 애들 
		//insert, delete, update할때는 commit이 필요 
		sqlSession.commit();
		sqlSession.close();
		return list;
	}
	
	
}