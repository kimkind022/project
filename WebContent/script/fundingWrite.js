let endDate = document.getElementsByName('endDate')[0];
let date = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000)
date.setDate(date.getDate() + 7);
date = date.toISOString().slice(0, 16);
endDate.value = date;
endDate.setAttribute("min", date);

$(document).ready(function() {
  
      $('.appendButton').click(
          function() {
            $('.optionsTable').append(
                "<tr>" + "<td><label>옵션명</label><input type=text name=options></td>"
                    + "<td><label>가격</label><input type=text name=price>원</td>"
                    + "<td><label>펀딩 가능 최대 수량</label><input type=text name=limit>EA</td>"
                    + "<td><input type=button value=삭제 class=deleteButton></td>" + "</tr>");
          });

      $(document).on('click', '.deleteButton', function() {
        $(this).closest('tr').remove();
      });
    });

function submitCheck() {
  if (!isLogin()) {
    alert("로그인이 필요합니다.");
    return false;
  } else if (condition) {

  }
}

function isLogin() {
  let login = $('input[name=isLogin]').attr('value');
  if (login != 'true') {
    return false;
  }
  return true;
}