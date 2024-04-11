/**
 * App eCommerce Add Product Script
 */
'use strict';

    $(function (){
		$(".dropzone").on("dragenter dragover", function (e) {
			e.preventDefault();
		});
		
		$(".dropzone").on("click", function () {
		    $("input[class='detailImage']").click();
		});
		
		$(".dropzone").on("drop", function (e) {
		    e.preventDefault();
		    handleFiles(e.originalEvent.dataTransfer.files);
		});

		$("input[class='detailImage']").on("change", function (e) {
		    handleFiles(e.target.files);
		});
		
		$(".dropzone").on("click", ".dz-remove", function (e) {
		    e.stopPropagation(); // 이벤트 전파 중지
		});
				
		$("#upload").on("change", function(e){
        // 파일이 선택되었는지 확인
   			e.preventDefault();
   		    let files = e.target.files;

            for (let file of files) {
	            let reader = new FileReader();
	            reader.onload = function(event) {
	                let base64String = event.target.result;
	                $('#uploadedThumbnail').attr('src', base64String); // 이미지 엘리먼트의 src 속성을 설정
	                $('#thumbnailImg').val(base64String); // Base64를 전송하기 위해 저장
	            };
		        // 파일을 읽기 시작
		        reader.readAsDataURL(file);				
            }
		});
		
		$(".cancelThumbnail").on("click", function(){
          $('#uploadedThumbnail').attr('src', '/resources/productImg/thumb.png'); // 이미지 엘리먼트의 src 속성을 설정
          
		});		
	 });			


	 function handleFiles(files) {
		    for (let file of files) {
		        let form = new FormData();
		        form.append("uploadFile", file);
		        // 위 문장에서 "uploadFile" 파일의 이름은 컨트롤러 단의 multipartFile 매개변수 명과 일치시킨다.

		        $.ajax({
		            url: "uploadFile",
		            type: "POST",
		            data: form,
		            dataType: "json",
		            processData: false, // text 데이터에 대해서 쿼리 스트링 처리를 하지 않음
		            contentType: false, // form 전송 시 기본타입(application/x-www-form-un을 사용하지 않음
		            success: function(data) {
		                if (data != null) {
		                    displayUploadedFile(data);
		                }
		            },
		            error: function() {},
		            complete: function() {},
		        });
		    }
		}





    function displayUploadedFile(json){
    	let output = "";
    	$.each(json, function(i, elem) {
    		let name = elem.newFilename.replaceAll("\\", "/");
    		
    		output += '<div class="dz-preview dz-processing dz-image-preview dz-success dz-complete"><div class="dz-details">'
   			output += '<div class="dz-thumbnail"><img alt="/resources/productImg/null.png" src="/resources/productImg/' + name + '"><div class="dz-success-mark"></div>'
   			output += '<div class="dz-error-mark"></div><div class="dz-error-message"></div><div class="progress">'
			output += '<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: 100%;"></div></div></div></div>'
			output += '<a class="dz-remove" id="' + name + '" onclick="removeFile(this)"">삭제</a></div>'
    		
    	});
    	$(".dropzone").html(output);
    	
    }


    function removeFile(fileId) {
    	let removeFile = $(fileId).attr('id');
    	removeFile = removeFile.replaceAll("/", "\\");
    				
    	$.ajax ({
    		url : "removeFile",
    		type : "get",
    		data : {
    			"removeFile" : removeFile
    		},
    		dataType : "text",
    		success: function(data) {
    			if (data == 'success') {
    				$(fileId).prev().remove();
    				$(fileId).remove();
    				
	   				if ($(".dropzone").text() == "") {
	   					let output = "Drag and Drop Files";
	   					$(".dropzone").html(output);
	   				}			
    			}
    		},
    		error : function() {},
    		complete : function() {},
    	});
    	
    }
    
    
    function btnCancel() {
    	// 취소 버튼 클릭 시 드래그 드랍한 모든 파일 삭제
    	
    	$.ajax ({
    		url : "removeAllFile",
    		type : "GET",
    		dataType : "text",
    		success: function(data) {
    			if (data == 'success') {
    				location.href = `productList`;
    			}
    		},
    		error : function() {},
    		complete : function() {},
    	});
    }
    
	function validateData() {
	    let thumbnailImgValid = isThumbnailImgValid($("#upload").val());
	    let productNameValid = isProductNameValid($("#productName").val());
	    let originalNameValid = isOriginalNameValid($("#originalName").val());
	    let purchaseCostValid = isPurchaseCostValid($("#purchaseCost").val());
	    let salesCostValid = isSalesCostValid($("#salesCost").val());
	    let classNoValid = isClassNoValid($("#classNo").val());
	    let manufacturerNoValid = isManufacturerNoValid($("#manufacturerNo").val());
	    let originalClassValid = isOriginalClassValid($("#originalClass").val());
	    
	    if (thumbnailImgValid && productNameValid && originalNameValid && 
	        purchaseCostValid && salesCostValid &&
	        classNoValid && manufacturerNoValid && originalClassValid) {
	        return true;
	    }
	    return false;
	}
	
	function isThumbnailImgValid(val) {
	    // 파일 확장자가 jpg, jpeg, png, gif 중 하나인지 확인
	    let allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
	    let extension = val.split('.').pop().toLowerCase();
	    return allowedExtensions.includes(extension);
	}
	
	function isProductNameValid(val) {
	    // 제품명은 최소 2글자 이상이어야 함
	    if (val.trim().length < 2) {
	        printErrMsg('#productName', "제품명을 2글자 이상 기입해 주세요.");
	        return false;
	    }
	    return true;
	}
	
	function isOriginalNameValid(val) {
	    // 원작명은 최소 1글자 이상이어야 함
	    if (val.trim().length < 1) {
	        printErrMsg('#originalName', "원작명을 기입해 주세요.");
	        return false;
	    }
	    return true;
	}
	
	function isPurchaseCostValid(val) {
	    // 구매 가격은 숫자이고 0보다 커야 함
	    if (isNaN(val) || parseFloat(val) <= 0 || val == '') {
	        printErrMsg('#purchaseCost', "구매 가격은 숫자이고 0보다 커야 합니다.");
	        return false;
	    }
	    return true;
	}
	
	function isSalesCostValid(val) {
	    // 판매 가격은 숫자이고 구매 가격보다 커야 함
	    if (isNaN(val) || parseFloat(val) <= $("#purchaseCost").val()) {
	        printErrMsg('#salesCost', "판매 가격은 숫자이고 구매가격보다 커야 합니다.");
	        return false;
	    }
	    return true;
	}
	
	function isClassNoValid(val) {
	    // 카테고리 번호가 선택 되었는지 확인
	    if (val === '' || val === null) {
	        printErrMsg('#classNo', "상품 카테고리를 선택해 주세요");
	        return false;
	    }
	    return true;
	}
	
	function isManufacturerNoValid(val) {
	    if (val === '' || val === null) {
	        printErrMsg('#manufacturerNo', "제조사를 선택해 주세요");
	        return false;
	    }
	    return true;
	}
	
	function isOriginalClassValid(val) {
	    // 작품 카테고리가 선택되었는지 확인
	    if (val === '' || val === null) {
	        printErrMsg('#originalClass', "작품 카테고리를 선택해주세요.");
	        return false;
	    }
	    return true;
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
    
    