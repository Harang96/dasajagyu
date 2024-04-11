/**
 * Dashboard eCommerce
 */

'use strict';

let cardColor, labelColor, headingColor, borderColor, legendColor;

    cardColor = config.colors.cardColor;
    labelColor = config.colors.textMuted;
    legendColor = config.colors.bodyColor;
    headingColor = config.colors.headingColor;
    borderColor = config.colors.borderColor;

  // Donut Chart Colors
  const chartColors = {
    donut: {
      series1: config.colors.success,
      series2: '#28c76fb3',
      series3: '#28c76f80',
      series4: config.colors_label.success
    }
  };
  
// 온로드
(function () {
  
	getSalesGraphInfo();

	eraseDivIcon();
	
	setDateToNow();
	
	setWeekSelect();
	
	setFormatNum();
	
	$(".close").on("click", function() {
		$("#orderCsModal").hide();
	});
	
	setPerOfGender();
	
	setPerOfMonthSignUp();

	setPerOfWithDrawCus();
})();
// 온로드의 끝

function setPerOfWithDrawCus() {
	let total = parseInt($("#totalCus").html());
	let withDrawCus = parseInt($("#withDrawCus").html());
	
	let result = "전체 대비 " + (Math.round(withDrawCus / total * 1000) / 10) + "%";
	
	$("#perOfWithDrawCus").html(result);
}

function setPerOfMonthSignUp() {
	let total = parseInt($("#totalCus").html());
	let monthSignUp = parseInt($("#monthSignUp").html());
	
	let result = "전체 대비 " + (Math.round(monthSignUp / total * 1000) / 10) + "%";
	
	$("#perOfMonthSignUp").html(result);
}

function setPerOfGender() {
	let male = parseInt($("#malePop").html());
	let female = parseInt($("#femalePop").html());
	let total = male + female;
	
	let malePer = Math.round(male / total * 1000) / 10;
	let femalePer = 100 - malePer;
	
	let result = malePer + "% / " + femalePer + "%";
	
	$("#perOfGender").html(result);
}

function setFormatNum() {
	let classes = $(".formatNum");
	
	$.each(classes, function(i, item) {
		let val = $(item).html();
		
		let format = formatNum(val);
		
		$(item).html(format);
	});
}

function showWeekNetProfit(obj) {
	let day = $("#weekSelect").val();
	
	$.ajax({
        url: "getWeekNetProfit",
        type: "get",
        data: {
        	"day" : day
        	},
        dataType: "text",
        async: false,
        success: function(data) {
			$("#weekValue").html(formatNum(data));
			$(obj).attr("onclick", "showWeekSales(this);");
			$("#weekKind").val("netProfit");
			$("#weekTitle").html("주간 순이익");
			$(obj).html("매출 보기");
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function showWeekSales(obj) {
	let day = $("#weekSelect").val();
	
	$.ajax({
        url: "getWeekSales",
        type: "get",
        data: {
        	"day" : day
        	},
        dataType: "text",
        async: false,
        success: function(data) {
			$("#weekValue").html(formatNum(data));
			$(obj).attr("onclick", "showWeekNetProfit(this);");
			$("#weekKind").val("sales");
			$("#weekTitle").html("주간 매출");
			$(obj).html("순이익 보기");
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function changeWeekSelect(obj) {
	let val = $("#weekKind").val();
	let day = obj.value;
	
	if (val == "sales") {
		$.ajax({
	        url: "getWeekSales",
	        type: "get",
	        data: {
	        	"day" : day
	        	},
	        dataType: "text",
	        async: false,
	        success: function(data) {
				$("#weekValue").html(formatNum(data));
	        },
	        error: function() {
	
	        },
	        complete: function() {
			
	        }
	   	});
	} else {
		$.ajax({
	        url: "getWeekNetProfit",
	        type: "get",
	        data: {
	        	"day" : day
	        	},
	        dataType: "text",
	        async: false,
	        success: function(data) {
				$("#weekValue").html(formatNum(data));
	        },
	        error: function() {
	
	        },
	        complete: function() {
			
	        }
	   	});
	}
}

function setWeekSelect() {
	let result = "";
	
	for (let i = 0; i < 11; i++) {
		let today = new Date();
		today.setDate(today.getDate() - (7 * i));
		
		let year = today.getFullYear();
		let month = String(today.getMonth() + 1).padStart(2, '0');
		let day = String(today.getDate()).padStart(2, '0');
		let optDay = year + "-" + month + "-" + day;
		
		if (i == 0) {
			result += `<option value='${optDay}'>이번 주</option>`;
		} else {
			result += `<option value='${optDay}'>${i}주 전</option>`;
		}
	}

	$("#weekSelect").html(result);
}

function changeDaySales(obj) {
	let day = obj.value;
	
	$.ajax({
        url: "getDaySales",
        type: "get",
        data: {
        	"day" : day
        	},
        dataType: "json",
        async: false,
        success: function(data) {
			$("#daySalesOutput").html(formatNum(data));			
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function changeDayNetProfit(obj) {
	let day = obj.value;
	
	$.ajax({
        url: "getDayNetProfit",
        type: "get",
        data: {
        	"day" : day
        	},
        dataType: "json",
        async: false,
        success: function(data) {
			$("#dayNetProfitOutput").html(formatNum(data));			
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function setDateToNow() {
	let today = new Date();
	let year = today.getFullYear();
	let month = String(today.getMonth() + 1).padStart(2, '0');
	let day = String(today.getDate()).padStart(2, '0');
	
	let formattedDate = year + '-' + month + '-' + day;

	$("#daySalesDate").val(formattedDate);
	$("#dayNetProfitDate").val(formattedDate);
}

function showNetProfit() {
	$("#TotalSalesDiv").attr("style", "display: none !important");
	$("#TotalNetProfitsDiv").attr("style", "display: block");
}

function showSales() {
	$("#TotalNetProfitsDiv").attr("style", "display: none !important");
	$("#TotalSalesDiv").attr("style", "display: block");
}

function showNetProfitInfo() {
	$("#salesInfo").attr("style", "display: none !important");
	$("#netProfitInfo").attr("style", "display: block; padding-top: 0px;");
	$("#infoH5").html("최근 순이익");
	$("#changeInfoBtn").html("매출 보기").attr("onclick", "showSalesInfo();");
}

function showSalesInfo() {
	$("#netProfitInfo").attr("style", "display: none !important");
	$("#salesInfo").attr("style", "display: block; padding-top: 0px;");
	$("#infoH5").html("최근 매출");
	$("#changeInfoBtn").html("순이익 보기").attr("onclick", "showNetProfitInfo();");
}

function eraseDivIcon() {

	$.each($(".mainSalesH5"), function(i, item) {
		let str = $(item).html();
		let cleanStr = str.replace(/[^\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F\uA960-\uA97F\uAC00-\uD7AF]/g, '');
		$(item).html(cleanStr);
	});
}

function getSalesGraphInfo(year=2024) {
	
	$.ajax({
        url: "getSalesGraphInfo",
        type: "get",
        data: {
        	"year" : year
        	},
        dataType: "json",
        async: false,
        success: function(data) {
        	$("#graphTotalSales").html(formatNum(data.sales));
        	$("#graphTotalNetProfits").html(formatNum(data.netProfits));
        	getSalesGraph(data);
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
   	
}

function getNetProfitsMin(list) {
	let min = list[0];
	
	for (let i of list) {
		if (min > i) {
			min = i;
		}
	}
	
	let result = (Math.floor(min / 1000000)) * 1000000;
	
	// return result;
}

function getSalesMax(list) {
	let max = list[0];
	
	for (let i of list) {
		if (max < i) {
			max = i;
		}
	}
	
	let result = (Math.ceil(max / 1000000)) * 1000000;
	
	// return result;
}

function changeYear() {
	let year = $("#graphYear").val();
	$("#totalRevenueChart").html("");
	getSalesGraphInfo(year);
}

function getSalesGraph(data) {

  
  // Total Revenue Report Chart - Bar Chart
  // 매출과 순이익
  // --------------------------------------------------------------------
  const totalRevenueChartEl = document.querySelector('#totalRevenueChart'),
    totalRevenueChartOptions = {
      series: [
        {
          name: '매출',
          data: data.salesList
        },
        {
          name: '순이익',
          data: data.netProfitsList
        }
      ],
      chart: {
        height: 413,
        parentHeightOffset: 0,
        stacked: true,
        type: 'bar',
        toolbar: { show: false }
      },
      tooltip: {
        enabled: false
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '40%',
          borderRadius: 9,
          startingShape: 'rounded',
          endingShape: 'rounded'
        }
      },
      colors: [config.colors.primary, config.colors.warning],
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'smooth',
        width: 6,
        lineCap: 'round',
        colors: [cardColor]
      },
      legend: {
        show: true,
        horizontalAlign: 'right',
        position: 'top',
        fontFamily: 'Public Sans',
        markers: {
          height: 12,
          width: 12,
          radius: 12,
          offsetX: -3,
          offsetY: 2
        },
        labels: {
          colors: legendColor
        },
        itemMargin: {
          horizontal: 10,
          vertical: 2
        }
      },
      grid: {
        show: false,
        padding: {
          bottom: -8,
          top: 20
        }
      },
      xaxis: {
        categories: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        labels: {
          style: {
            fontSize: '13px',
            colors: labelColor,
            fontFamily: 'Public Sans'
          }
        },
        axisTicks: {
          show: false
        },
        axisBorder: {
          show: false
        }
      },
      yaxis: {
        labels: {
          offsetX: -16,
          style: {
            fontSize: '13px',
            colors: labelColor,
            fontFamily: 'Public Sans'
          }
        },
        min: getNetProfitsMin(data.netProfitsList), // 순이익 최대값
        max: getSalesMax(data.salesList), // 매출 최대값
        tickAmount: 7
      },
      responsive: [
        {
          breakpoint: 1700,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '43%'
              }
            }
          }
        },
        {
          breakpoint: 1441,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '50%'
              }
            },
            chart: {
              height: 422
            }
          }
        },
        {
          breakpoint: 1300,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '50%'
              }
            }
          }
        },
        {
          breakpoint: 1025,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '50%'
              }
            },
            chart: {
              height: 390
            }
          }
        },
        {
          breakpoint: 991,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '38%'
              }
            }
          }
        },
        {
          breakpoint: 850,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '50%'
              }
            }
          }
        },
        {
          breakpoint: 449,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '73%'
              }
            },
            chart: {
              height: 360
            },
            xaxis: {
              labels: {
                offsetY: -5
              }
            },
            legend: {
              show: true,
              horizontalAlign: 'right',
              position: 'top',
              itemMargin: {
                horizontal: 10,
                vertical: 0
              }
            }
          }
        },
        {
          breakpoint: 394,
          options: {
            plotOptions: {
              bar: {
                columnWidth: '88%'
              }
            },
            legend: {
              show: true,
              horizontalAlign: 'center',
              position: 'bottom',
              markers: {
                offsetX: -3,
                offsetY: 0
              },
              itemMargin: {
                horizontal: 10,
                vertical: 5
              }
            }
          }
        }
      ],
      states: {
        hover: {
          filter: {
            type: 'none'
          }
        },
        active: {
          filter: {
            type: 'none'
          }
        }
      }
    };
  if (typeof totalRevenueChartEl !== undefined && totalRevenueChartEl !== null) {
    const totalRevenueChart = new ApexCharts(totalRevenueChartEl, totalRevenueChartOptions);
    totalRevenueChart.render();
  }

  // Filter form control to default size
  // ? setTimeout used for multilingual table initialization
  setTimeout(() => {
    $('.dataTables_filter .form-control').removeClass('form-control-sm');
    $('.dataTables_length .form-select').removeClass('form-select-sm');
  }, 300);
}

function formatNum(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function showOrderCsModal() {
	getOrderCsList(1);
	$("#orderCsModal").show();
}

function getOrderCsList(pageNo) {
	$.ajax({
        url: "getOrderCsListByPageNo",
        type: "get",
        data: {
        	"pageNo" : pageNo,
        },
        dataType: "json",
        async: false,
        success: function(data) {
			printOrderCsList(data);
        },
        error: function() {

        },
        complete: function() {
		
        }
   	});
}

function printOrderCsList(data) {
	let result = "";
	
	result +=  `<table class="table datatable-invoice border-top">
					<thead>
	                  <tr>
	                    <th></th>
	                    <th>구분</th>
	                    <th>주문번호</th>
	                    <th>상품명</th>
	                    <th>수량</th>
	                    <th>주문자</th>
	                    <th>사유</th>
	                    <th>결제수단</th>
	                    <th>일자</th>
	                  </tr>
	                </thead>
	                <tbody>`;
	                
	$.each(data.orderCs, function(i, item) {
		if (i >= data.orderCsPi.startRowIndex && i < data.orderCsPi.startRowIndex + 15) {
			
			
			result += `<tr>`;
		    result += `<th class='csNo'>${item.csNo}</th>`;
		    result += `<th class='csType'>${item.csType}</th>`;
		    result += `<th class='orderNo'><a href="/admin/order/detail?no=${item.orderNo}">${item.orderNo}</th>`;
		    result += `<th class='productName'>${item.productName}</th>`;
		    result += `<th class='productQuantity'>${item.productQuantity}</th>`;
		    result += `<th class='nickname'>${item.nickname}</th>`;
		    result += `<th class='reason'>${item.reason}</th>`;
		    result += `<th class='payMethod'>${item.payMethod}</th>`;
		    result += `<th class='csDate'>` + formatDate(item.csDate) + `</th>`;
		    result += `</tr>`;
	    }
	});				 	  
				 	  
	result += `</tbody></table><ul id="pagingBox">`;
	
	result += orderCsPaging(data.orderCsPi) + "</ul>";
	
	$("#modalCsBody").html(result);
}

function orderCsPaging(pi) {
	let begin = pi.startNumOfCurrentPagingBlock;
	let end = pi.startNumOfCurrentPagingBlock + 10;
	let result = "";
	
	result += `<li class="page-item">`;
    
	if (pi.pageNo == 1 || pi.pageNo == null || pi.pageNo == '') {
  		result += `<a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">처음으로</a>`;
	} else {
        result += `<a class="page-link page-link-prev ml-0 mr-0" href="#" onclick="return getOrderCsList(1);" aria-label="Previous" tabindex="-1" aria-disabled="true">처음으로</a>`;
    }
    
	result += `</li>`;
	result += `<li class="page-item">`;
	  
	if (pi.pageNo == 1 || pi.pageNo == null || pi.pageNo == '') {
        result += `<a class="page-link page-link-prev ml-0 mr-0 disabled" href="#" aria-label="Previous" tabindex="-1" aria-disabled="true" onclick="return false;">이전</a>`;
	} else {
        result += `<a class="page-link page-link-prev ml-0 mr-0" href="#" onclick="return getOrderCsList(${pi.pageNo - 1 });" aria-label="Previous" tabindex="-1" aria-disabled="true">이전</a>`;
	}
	
    result += `</li>`;
    
	for (let page = begin; page < end; page++) {
        if (page <= pi.totalPageCnt) {
    		if (pi.pageNo == page || (pi.pageNo == null && page == 1) || (pi.pageNo == '' && page == 1)) {
    			result += `<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" id="nowPage" href="#" style="color: #7367F0;" onclick="return false;">${page }</a></li>`;
			} else {
    			result += `<li class="page-item ml-0 mr-0" aria-current="page"><a class="page-link" href="#" onclick="return getOrderCsList(${page });">${page }</a></li>`;
			}
		}
	}
	
    result += `<li class="page-item">`;
    
	if (pi.pageNo == pi.totalPageCnt || pi.totalPageCnt == 1) {
		result += `<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">다음</a>`;
	} else {
		result += `<a class="page-link page-link-next ml-0 mr-0" href="#" onclick="return getOrderCsList(${pi.pageNo + 1 });" aria-label="Next">다음</a>`;
	}        
	
	result += `</li>`;
	result += `<li class="page-item">`;
	
    if (pi.pageNo == pi.totalPageCnt || pi.totalPageCnt == 1) {
		result += `<a class="page-link page-link-next ml-0 mr-0 disabled" href="#" aria-label="Next" onclick="return false;">끝으로</a>`;
    } else {
		result += `<a class="page-link page-link-next ml-0 mr-0" href="#" onclick="return getOrderCsList(${pi.totalPageCnt });" aria-label="Next">끝으로</a>`;
    }
    
    result += `</li>`;
    
    return result;
}

function formatDate(writeTimeStamp) {
	let writeTime = new Date(writeTimeStamp);
	let formattedDate = writeTime.getFullYear() + '-' + 
    ('0' + (writeTime.getMonth() + 1)).slice(-2) + '-' + 
    ('0' + writeTime.getDate()).slice(-2);
        
    return formattedDate;
}