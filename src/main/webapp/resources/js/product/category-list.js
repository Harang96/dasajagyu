/**
 * App eCommerce Category List
 */

'use strict';

// Comment editor

        let originals; // 변수 이름을 원래대로 변경
    $(function () {

        // AJAX 요청을 통해 제조사 데이터를 가져옴
        $.ajax({
            url: '/admin/product/jsonCategory',
            type: 'GET',
            success: function(data) {
                // 가져온 데이터를 변수에 저장
                originals = data.originalList;
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
                    data: originals,
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
                            let $originalClass = full['originalClass'];
                            return '<div class="text-sm-end">' + $originalClass + '</div>';
                          }
                        },
                        {
                          // 제조사명
                          targets: 1,
                          responsivePriority: 3,
                          render: function (data, type, full, meta) {
                            let $className = full['className'];
                            return '<div class="text-sm-end">' + $className + '</div>';
                          }
                        },
                        {
                          // Actions
                          targets: -1,
                          render: function (data, type, full, meta) {
 	                        let $originalClass = full['originalClass']; 
                            return (
				              '<div class="d-flex align-items-sm-center justify-content-sm-center">' +
				              '<button class="btn btn-sm btn-icon delete-record me-2" id=' + $originalClass + ' onclick="deleteCategory(this);"><i class="ti ti-trash"></i></button>' +
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
    
	function checkOriginalClass(id) {
	    let addOriginalClass = '#' + id; // 제조사 이름을 선택하는 jQuery 선택자
	    let valueForOriginal = $(addOriginalClass).val();
	    let regex = /^[A-L]+[0-9]{3}$/;
	
	    if (valueForOriginal != null && valueForOriginal != '') {
	        if (regex.test(valueForOriginal)) {
	            for (let i = 0; i < originals.length; i++) {
	                if (valueForOriginal == originals[i].originalClass) {
	                    printErrMsg(addOriginalClass, "이미 등록된 카테고리 코드입니다.");
	                    return false;
	                } else {
	                	return true;
	                }
	            }
	        } else {
	            printErrMsg(addOriginalClass, "코드 양식에 맞지 않습니다.");
	            return false;
	        }
	    } else {
	        printErrMsg(addOriginalClass, "내용을 기입(선택)해 주세요.");
	        return false;
	    }
	}

	function checkOriginalClassName(id) {
	    let addOriginalClass = '#' + id; // 제조사 이름을 선택하는 jQuery 선택자
	    let valueForOriginal = $(addOriginalClass).val();
		let regex = /^[ㄱ-ㅎ]{1}[~]?[ㄱ-ㅎ]?[ ]>[ ]+/g;
	
	    if (valueForOriginal != null && valueForOriginal) {
	        if (regex.test(valueForOriginal)) {
	            for (let i = 0; i < originals.length; i++) {
	                if (valueForOriginal == originals[i].className) {
	                    printErrMsg(addOriginalClass, "이미 등록된 카테고리 이름입니다.");
	                    return false;
	                } else {
	                	return true;
	                }
	            }
	        } else {
	            printErrMsg(addOriginalClass, "양식에 맞지 않습니다.");
	            return false;
	        }
	    } else {
	        printErrMsg(addOriginalClass, "내용을 기입해 주세요.");
	        return false;
	    }
	}
	
	function valicateData(c, n) {
		if (checkOriginalClass(c) && checkOriginalClassName(n)) {
		return true;
		} else {
			return false;
		}
		
	}

	function checkClassName(id) {
	    let addOriginalClass = '#' + id; // 제조사 이름을 선택하는 jQuery 선택자
	    let valueForOriginal = $(addOriginalClass).val();
	    let regex = /^[ㄱ-ㅎ]+[ ]+[>]+[ ]+/g
	
	    if (valueForOriginal != null && valueForOriginal) {
	        if (regex.test(valueForOriginal)) {
	            for (let i = 0; i < originals.length; i++) {
	                if (valueForOriginal == originals[i].className) {
	                    printErrMsg(addOriginalClass, "이미 등록된 카테고리 이름입니다.");
	                    return false;
	                } else {
	                	return true;
	                }
	            }
	        } else {
	            printErrMsg(addOriginalClass, "양식에 맞지 않습니다.");
	            return false;
	        }
	    } else {
	        printErrMsg(addOriginalClass, "내용을 기입해 주세요.");
	        return false;
	    }
	}
	
	function valicateAddCata(c, n) {
		if (checkOriginalClass(c) && checkOriginalClassName(n)) {
			return true;
		} else {
			return false;
		}
		
	}
	
	function valicateUpdateCata(c, n) {
		if (c != "" && checkClassName(n)) {
			return true;
		} else {
			return false;
		}
		
	}
	
	function deleteCategory(i) {
		let originalClass = i.id;	
		$.ajax({
		        url: "/admin/product/deleteCategory", 
		        data : {"originalClass" : originalClass},
		        type: "GET", 
		        contentType : "text",
		        success: function(data) {		            
		            location.href="/admin/product/category";

		        },
		        error: function() {
		        },
		    });                              
	
	}
	
	function printErrMsg(id, msg) {
	    let $errMsg = $(`${id}`).next('.errMsg');
	
	    if (msg) {
	        if ($errMsg.length) {
	            $errMsg.text(msg).fadeIn();
	        } else {
	            $errMsg = $('<div class="errMsg" style="color : red"></div>').insertAfter(`${id}`).text(msg).show();
	        }
	        
	    	// 3초 후에 에러 메시지 숨기고 제거
	        setTimeout(function() {
	            $errMsg.fadeOut(function() {
	                $(this).remove();
	            });
	        }, 3000);
		
	    } else {
	        $errMsg.hide().remove();
	    }
	}