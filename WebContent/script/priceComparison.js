let itemGroup = new Map();
let priceGroup;

$(document).ready(function() {
      itemGroupSetting();
      dateSetting();

      $(document).on('change','select[name=p_itemcategorycode]', function() {
            let category = $(this).find('option:selected').val();

            $('select[name=p_itemcode]').html("<option value=all>선택</option>");

            itemGroup.forEach(function(item, index) {
              if (category == item.p_itemcategorycode) {
                $('select[name=p_itemcode]').append(
                    "<option value=" + item.p_itemcode + ">" + item.p_itemname + "</option>");
              }
            });

          });

      $('.dateButton').click(function() {
        $('.dateButton').css('border','1px solid #EAEAEA');
        $(this).css('border','2px solid rgb(240, 93, 35)');
        let endDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
        endDate = endDate.toISOString().slice(0, 10);
        $('input[name=p_endday]').val(endDate);

        let startDate = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
        if ($(this).attr('name') == 'oneMonth') {
          startDate.setMonth(startDate.getMonth() - 1);
        } else if ($(this).attr('name') == 'threeMonth') {
          startDate.setMonth(startDate.getMonth() - 3);
        } else if ($(this).attr('name') == 'sixMonth') {
          startDate.setMonth(startDate.getMonth() - 6);
        } else if ($(this).attr('name') == 'oneYear') {
          startDate.setFullYear(startDate.getFullYear() - 1);
        }
        startDate = startDate.toISOString().slice(0, 10);
        $('input[name=p_startday]').val(startDate);

      });

      $(document).on('change', 'input[name=p_endday]', function() {
        let startday = new Date($('input[name=p_startday]').val());
        let endDate = new Date($('input[name=p_endday]').val());

        if (startday > endDate) {
          $('input[name=p_startday]').val($(this).val());
        }
        $('input[name=p_startday]').attr("max", $(this).val());
      });

      $(document).on('click','input[name=priceSearch]',function() {
            let p_itemcode = $('select[name=p_itemcode]').val();

            if (itemGroup.get(p_itemcode) == null) {
              alert("검색 할 상품을 확인해주세요");
            } else {
              let items = itemGroup.get(p_itemcode);
              let startDay = $('input[name=p_startday]').val();
              let endday = $('input[name=p_endday]').val();

              $.ajax({
                    url : "selectPeriodproduct.fd",
                    data : {
                      "p_itemcategorycode" : items.p_itemcategorycode,
                      "p_itemcode" : items.p_itemcode,
                      "p_kindcode" : items.p_kindcode,
                      "p_startday" : startDay,
                      "p_endday" : endday
                    },
                    dataType : 'json',
                    success : function(data) {
                      if (data == "[\"error\"]") {
                        $('.excelContents').css('display','none');
                        $('.excelChart').css('display','none');
                        $('.excelTitle').html("조회된 결과가 없습니다");
                      } else {
                        priceGroup = new Map();
                        $('.excelChart').html("<table><tr>" +
                            "<td>조회일자</td>" +
                            "<td>금액</td>" +
                            "<td>전일대비등락가</td>" +
                            "<td>전일대비등락율</td>" +
                            "</tr></table>");
                        let price = 0;
                        let prePrice = 0;
                        let changePrice;
                        let changePricePercent;
                        $.each(data, function(index, item) {
                          if (item.countyname == '평균') {
                            let key = item.yyyy + "/" + item.regday;
                            if (!priceGroup.has(key)) {
                              priceGroup.set(key, item);
                              price = parseInt(minusComma(item.price) || 0);
                              if (prePrice == 0) {
                                prePrice = parseInt(minusComma(item.price) || 0);
                              }
                              changePrice = prePrice - price;
                              changePricePercent = (changePrice/prePrice).toFixed(2);
                              if (changePrice < 0) {
                                changePrice = "<font color=red>▲ "+addComma((-1)*changePrice)+"</font>";
                                changePricePercent = "<font color=red>▲ "+(-1)*changePricePercent+"</font>";
                              } else if (changePrice == 0) {
                                changePrice = "<font color=black>"+addComma(changePrice)+"</font>";
                                changePricePercent = "<font color=black>"+changePricePercent+"</font>";
                              } else {
                                changePrice = "<font color=blue>▼ "+addComma(changePrice)+"</font>";
                                changePricePercent = "<font color=blue>▼ "+changePricePercent+"</font>";
                              }
                              
                              $('.excelChart tr').eq(0).after(
                                  "<tr>" +
                                  "<td>"+key+"</td>" +
                                  "<td>"+addComma(price)+" 원</td>" +
                                  "<td>"+changePrice+" 원</td>" +
                                  "<td>"+changePricePercent+"</td>" +
                                  "</tr>");
                              
                              prePrice = parseInt(minusComma(item.price) || 0);
                            }
                          }
                        });

                        if (priceGroup.size <= 0) {
                          $('.excelContents').css('display','none');
                          $('.excelChart').css('display','none');
                          $('.excelTitle').html("조회된 결과가 없습니다");
                        } else {
                          $('.excelContents').css('display','block');
                          $('.excelChart').css('display','block');
                          $('.excelTitle').html(startDay+" 부터 "+endday+" 까지의 "+items.p_itemname+" 의 가격 동향 입니다");
                          
                          
                          chartAdd();
                          
                        }
                      }

                    },
                    error : function(jqXHR, textStatus, errorThrown) {
                      alert(jqXHR.status);
                      alert(jqXHR.statusText);
                      alert(jqXHR.responseText);
                      alert(jqXHR.readyState);
                    },
                    beforeSend : function() {
                      var width = 0;
                      var height = 0;
                      var left = 0;
                      var top = 0;

                      width = 100;
                      height = 100;

                      top = ($(window).height() - height) / 2 + $(window).scrollTop();
                      left = ($(window).width() - width) / 2 + $(window).scrollLeft();

                      if ($("#div_ajax_load_image").length != 0) {
                        $("#div_ajax_load_image").css({
                          "top" : top + "px",
                          "left" : left + "px"
                        });
                        $("#div_ajax_load_image").show();
                      } else {
                        $('body').append(
                            "<div id='div_ajax_load_image' " + "style='position:absolute; top:" + top + "px; "
                                + "left:" + left + "px; " + "width:" + width + "px; " + "height:" + height + "px; "
                                + "z-index:9999; " + "background:#f0f0f0; " + "filter:alpha(opacity=50); "
                                + "opacity:alpha*0.5; " + "margin:auto; " + "padding:0;' >"
                                + "<img src='images/common/loading.gif' " + "style=width:100px; height:100px;>"
                                + "</div>");
                      }

                    },
                    complete : function() {
                      $("#div_ajax_load_image").hide();
                    }

                  });
            }
          });

    });

function itemGroupSetting() {
  $.ajax({
    url : "selectItemCodeList.fd",
    type : 'post',
    dataType : 'json',
    success : function(data) {
      $.each(data, function(index, item) {
        itemGroup.set(item.p_itemcode, item);
      });
    },
    error : function() {
      alert("error");
    }
  });
}

function dateSetting() {
  let minDateValue = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
  minDateValue.setFullYear(minDateValue.getFullYear() - 1);
  minDateValue = minDateValue.toISOString().slice(0, 10);

  let maxDateValue = new Date(new Date().getTime() - new Date().getTimezoneOffset() * 60000);
  maxDateValue = maxDateValue.toISOString().slice(0, 10);

  $('input[type=date]').val(maxDateValue);
  $('input[type=date]').attr("max", maxDateValue);
  $('input[type=date]').attr("min", minDateValue);

}

function chartAdd() {
  google.charts.load('current', {
    'packages' : [ 'corechart' ]
  });
  google.charts.setOnLoadCallback(drawChart);

  function drawChart() {
    var data = new google.visualization.DataTable();
    data.addColumn('date', '날짜');
    data.addColumn('number', '가격(원/kg)');
    data.addRows(priceGroup.size);
    let i = 0;
    priceGroup.forEach(function(item, index) {
      let dayValue = item.regday.split('/');
      data.setCell(i, 0, new Date(item.yyyy, dayValue[0], dayValue[1]));
      data.setCell(i, 1, minusComma(item.price));
      i++;
    });

    var options = {
      curveType : 'function',
      legend : {
        position : 'top'
      },
      hAxis : {
        format : 'yy-MM-dd'
      },
    };

    var chart = new google.visualization.LineChart(document.getElementsByClassName('excelContents')[0]);

    chart.draw(data, options);
  }

}

function addComma(value) {
  value = String(value);
  return value.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function minusComma(value) {
  value = String(value);
  return value.replace(/[^\d]+/g, '');
}
