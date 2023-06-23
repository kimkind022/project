package svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import action.ProductAction;
import dao.BoardDAO;
import dao.ProductDAO;
import dto.BoardBean;
import dto.ProductBean;

public class ProductService {

  public ProductBean getArticle(int productId) throws Exception {
    System.out.println("3. 위치: getArticle 메소드 속들어옴. 상태: productId로" + productId + "받아서 갖고 있음");

    ProductBean productBean = null;
    Connection con = getConnection();
    ProductDAO productDAO = ProductDAO.getInstance();
    productDAO.setConnection(con);

    productBean = productDAO.selectArticleWhere(productId);

    System.out.println("5. 위치: ProductServiece, 상태: 리턴받아온ArrayList: " + productBean);

    close(con);
    return productBean;
  }


}
