window.onload = function() {
	let loginInput = document.getElementById("login");
    
   
    if (loginInput) {
        let login = loginInput.value;
        
        if (login == "") {
            location.href = "/customer/loginOpen?path=/admin/sales/openSalesMain";
        } else if (login != "A" && login != "M") {
        	addCookie();
        	
            location.href = "/";
        }
    }
}

function addCookie() {
	let noticeCook = "";
	let now = new Date();
	now.setDate(now.getYear() + 1);
	noticeCook = "adminStatus=fail;expires=" + now.toUTCString() + ";path=/";

	document.cookie = noticeCook;
}