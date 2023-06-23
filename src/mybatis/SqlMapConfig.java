package mybatis;

import java.io.Reader;



import org.apache.ibatis.io.Resources;

import org.apache.ibatis.session.SqlSessionFactory;

import org.apache.ibatis.session.SqlSessionFactoryBuilder;



public class SqlMapConfig {
  private static SqlSessionFactory sqlSession;

  public static SqlSessionFactory getSqlSession() {
    return sqlSession;
  }

  static {
    try {
      String resource = "mybatis/Configuration.xml"; //디비연결하는 부분
		//패키지명/Configuration.xml
      Reader reader = Resources.getResourceAsReader(resource);
      SqlSessionFactoryBuilder factory = new SqlSessionFactoryBuilder();
      sqlSession = factory.build(reader);
    } catch (Exception e) {
      System.out.println(e);
    }
  }
}


