/**
 * App eCommerce Category List
 */

'use strict';

// Comment editor
    let manufacturers; // 변수 이름을 원래대로 변경

    $(function () {

        // AJAX 요청을 통해 제조사 데이터를 가져옴
        $.ajax({
            url: '/admin/product/jsonCategory',
            type: 'GET',
            success: function(data) {
                // 가져온 데이터를 변수에 저장
                manufacturers = data.manufacturerList;
                // DataTable 초기화
                initDataTable();
            }
        });

        // DataTable 초기화 함수
        function initDataTable() {
            // DataTable을 초기화하는 코드
            let dt_category_list_table = $('.datatables-category-list');
            if (dt_category_list_table.length) {
                let dt_category = dt_category_list_table.dataTable({
                    data: manufacturers,
                    columns: [
                        { data: 0 },
                        { data: 1 },
                        { data: '' } // 마지막 컬럼도 빈 값으로 남겨둡니다.
                    ],
                    columnDefs: [
                        {
                          // 제조사번호
                          targets: 0,
                          responsivePriority: 2,
                          render: function (data, type, full, meta) {
                            let $manufacturerNo = full['manufacturerNo'];
                            return '<div class="text-sm-end">' + $manufacturerNo + '</div>';
                          }
                        },
                        {
                          // 제조사명
                          targets: 1,
                          responsivePriority: 3,
                          render: function (data, type, full, meta) {
                            let $manufacturerName = full['manufacturerName'];
                            return '<div class="text-sm-end">' + $manufacturerName + '</div>';
                          }
                        },
                        {
                          // Actions
                          targets: -1,
                          render: function (data, type, full, meta) {
 	                        let $manufacturerNo = full['manufacturerNo']; 
                            return (
				              '<div class="d-flex align-items-sm-center justify-content-sm-center">' +
				              '<button class="btn btn-sm btn-icon delete-record me-2" id=' + $manufacturerNo + ' onclick="deleteManufacturer(this);"><i class="ti ti-trash"></i></button>' +
				              '</div>'
                            );
                          }
                        }
                      ],
                    order: [2, 'desc'], //set any columns order asc/desc
                    dom:
                        '<"card-header d-flex flex-wrap pb-2"' +
                        '<f>' +
                        '<"d-flex justify-content-center justify-content-md-end align-items-baseline"<"dt-action-buttons d-flex justify-content-center flex-md-row mb-3 mb-md-0 ps-1 ms-1 align-items-baseline"lB>>' +
                        '>t' +
                        '<"row mx-2"' +
                        '<"col-sm-12 col-md-6"i>' +
                        '<"col-sm-12 col-md-6"p>' +
                        '>',
                    language: {
                        sLengthMenu: '_MENU_',
                        search: '',
                        searchPlaceholder: 'Search Category'
                    },
                    lengthMenu: [20, 50, 100], //for length of menu
                    // Button for offcanvas
                    buttons: [

                    ],
                    // For responsive popup
                    responsive: {
                        details: {
                            display: $.fn.dataTable.Responsive.display.modal({
                                header: function (row) {
                                    let data = row.data();
                                    return 'Details of ' + data['categories'];
                                }
                            }),
                            type: 'column',
                            renderer: function (api, rowIdx, columns) {
                                let data = $.map(columns, function (col, i) {
                                    return col.title !== '' // ? Do not show row in modal popup if title is blank (for check box)
                                        ? '<tr data-dt-row="' +
                                            col.rowIndex +
                                            '" data-dt-column="' +
                                            col.columnIndex +
                                            '">' +
                                            '<td> ' +
                                            col.title +
                                            ':' +
                                            '</td> ' +
                                            '<td class="ps-0">' +
                                            col.data +
                                            '</td>' +
                                            '</tr>'
                                        : '';
                                }).join('');

                                return data ? $('<table class="table"/><tbody />').append(data) : false;
                            }
                        }
                    }
                });
                $('.dt-action-buttons').addClass('pt-0');
                $('.dataTables_filter').addClass('me-3 ps-0');
            }
        }

        // Delete Record
        $('.datatables-category-list tbody').on('click', '.delete-record', function () {
            dt_category.row($(this).parents('tr')).remove().draw();
        });

        // Filter form control to default size
        // ? setTimeout used for multilingual table initialization
        setTimeout(() => {
            $('.dataTables_filter .form-control').removeClass('form-control-sm');
            $('.dataTables_length .form-select').removeClass('form-select-sm');
        }, 300);    
        
    }); // onload End
    
	function checkManufacturer(id) {

	    let idForManufacture = '#' + id; // 제조사 이름을 선택하는 jQuery 선택자
	    let valueForManufacture = $(idForManufacture).val();

	    if (valueForManufacture != null && valueForManufacture != '') {
	        // 서버측에서 받은 제조사 목록을 JavaScript 배열로 변환
	        for (let i = 0; i < manufacturers.length; i++) {
	            if (valueForManufacture == manufacturers[i].manufacturerName) {
	                printErrMsg(idForManufacture, "이미 등록된 제조사입니다.");
	                return false;
	            }
	        }
	        // 제조사 이름이 중복되지 않으면 true 반환
	        return true;
	    } else {
	        printErrMsg(idForManufacture, "내용을 기입해 주세요.");
	        return false;
	    }
	}

	function checkManufacturerNo(id) {

	    let idForManufactureNo = '#' + id; // 제조사 이름을 선택하는 jQuery 선택자
	    let valueForManufacture = $(idForManufactureNo).val();

	    if (valueForManufacture != null && valueForManufacture != '') {
	  	  return true;
	    } else {		    
	        printErrMsg(idForManufactureNo, "제조사를 선택해 주세요.");
	        return false;
        }
	}
	
	function valicateUpdateManu(no, name) {
		if (checkManufacturerNo(no) && checkManufacturer(name)) {
			return true;
		} else {
			return false;
		}
		
	}

	function deleteManufacturer(i) {
		let manufacturerNo = i.id;	
		$.ajax({
		        url: "/admin/product/deleteManufacturer", 
		        data : {"manufacturerNo" : manufacturerNo},
		        type: "GET", 
		        contentType : "text",
		        success: function(data) {		            
		            location.href="/admin/product/manufacturer";

		        },
		        error: function() {
		        },
		    });                              
	
	}
		
	    
    function printErrMsg(id, msg) {
	    let $errMsg = $(`${id}`).next('.errMsg');
	    
	    // 새로운 에러 메시지 생성 또는 업데이트
	    if (msg) {
	        // 기존에 에러 메시지가 있으면 업데이트하고, 없으면 새로 생성
	        if ($errMsg.length) {
	            $errMsg.text(msg).fadeIn(); // 메시지 업데이트하고 보이도록 설정
	        } else {
	            $errMsg = $('<div class="errMsg" style="color : red"></div>').insertAfter(`${id}`).text(msg).show(); // 새로운 메시지 생성하고 보이도록 설정
	        }
	        
	        // 3초 후에 에러 메시지 숨기고 제거
	        setTimeout(function() {
	            $errMsg.fadeOut(function() {
	                $(this).remove();
	            });
	        }, 3000);
		        
	    } else { // 메시지가 없으면 에러 메시지 삭제
	        $errMsg.hide().remove(); // 숨기고 삭제
	    }
	}
		
		
    
    
    