package util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Dateutil {

  public static final int SEC = 60;
  public static final int MIN = 60;
  public static final int HOUR = 24;
  public static final int DAY = 30;
  public static final int MONTH = 12;

  /**
   * x초전, x분전, x시간 전m, x일 전, x개월전, x년전
   * 
   * @param 날짜
   * @return 분 표시
   *
   */
  public static String txtDate(Date tempDate) {
    long curTime = System.currentTimeMillis();
    long regTime = tempDate.getTime();
    String msg = null;

    if (curTime >= regTime) {
      long diffTime = (curTime - regTime) / 1000;

      if (diffTime < SEC) {
        msg = diffTime + "초 전";
      } else if ((diffTime /= SEC) < MIN) {
        msg = diffTime + "분 전";
      } else if ((diffTime /= MIN) < HOUR) {
        msg = (diffTime) + "시간 전";
      } else if ((diffTime /= HOUR) < DAY) {
        msg = (diffTime) + "일 전";
      } else if ((diffTime /= DAY) < MONTH) {
        msg = (diffTime) + "개월 전";
      } else {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        String curYear = sdf.format(curTime);
        String passYear = sdf.format(tempDate);
        int diffYear = Integer.parseInt(curYear) - Integer.parseInt(passYear);
        msg = diffYear + "년 전";
      }

    } else {
      long diffTime = (regTime - curTime) / 1000;

      if (diffTime < SEC) {
        msg = diffTime + "초 후";
      } else if ((diffTime /= SEC) < MIN) {
        msg = diffTime + "분 후";
      } else if ((diffTime /= MIN) < HOUR) {
        msg = (diffTime) + "시간 후";
      } else if ((diffTime /= HOUR) < DAY) {
        msg = (diffTime) + "일 후";
      } else if ((diffTime /= DAY) < MONTH) {
        msg = (diffTime) + "개월 후";
      } else {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        String curYear = sdf.format(curTime);
        String passYear = sdf.format(tempDate);
        int diffYear = Integer.parseInt(curYear) - Integer.parseInt(passYear);
        msg = diffYear + "년 후";
      }
    }

    return msg;

  }


}
