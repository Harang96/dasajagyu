package com.cafe24.goott351.user.mypage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.eclipse.core.runtime.Status;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cafe24.goott351.domain.AdminBoardDTO;
import com.cafe24.goott351.domain.CategoryDTO;
import com.cafe24.goott351.domain.CustomerVO;
import com.cafe24.goott351.domain.DeliveryDTO;
import com.cafe24.goott351.domain.EventVo;
import com.cafe24.goott351.domain.LoginCustomerVO;
import com.cafe24.goott351.domain.OrderShippingDTO;
import com.cafe24.goott351.domain.ProductQnAVO;
import com.cafe24.goott351.domain.MyPageReplyVO;
import com.cafe24.goott351.domain.LoginDTO;
import com.cafe24.goott351.domain.ServiceBoardVO;
import com.cafe24.goott351.domain.RegisterDTO;
import com.cafe24.goott351.domain.RegisterDeliveryDTO;
import com.cafe24.goott351.domain.ReplyVO;
import com.cafe24.goott351.user.customer.service.RegisterService;
import com.cafe24.goott351.user.mypage.service.MyPageService;


@Controller
@RequestMapping("/mypage/*")
public class MyPageController {
	
	
	
	@Inject
	MyPageService mpService;
	
	
	@Inject
	RegisterService rService;
	
	
	@RequestMapping("openmypage")
	public String viewmypage(HttpServletRequest req, HttpServletResponse resp, Model model) throws Exception {
		System.out.println("마이페이지로 가기");
		
		HttpSession reqSes = req.getSession();
		String uuid = ""; // 로그인 회원 uuid
		
		// 마이페이지 클릭 시 회원 아니면 로그인 페이지로 이동 -start-
		if(reqSes.getAttribute("loginCustomer") != null) {
			LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
			uuid = customer.getUuid();
		} else if(reqSes.getAttribute("loginCustomer") == null) {
			return "redirect:" + "../customer/loginOpen?path=/mypage/openmypage";
		}
		// 마이페이지 클릭 시 회원 아니면 로그인 페이지로 이동 -end-
		
		
		
		
		// 주문상품 목록, 포인트 로그 가져오기
		Map<String, Object> map = mpService.getMyPageInfo(uuid);
		LoginCustomerVO loginCustomer = mpService.getLoginCustomerInfo(uuid);
		
		model.addAttribute("orderList", map.get("orderList"));
		model.addAttribute("userInfo", loginCustomer);
		
		return "mypage/mypage";
		
	}
	
	@RequestMapping(value="viewPointLog", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> viewPointLog(@RequestParam("uuid") String uuid) throws Exception{
		
		Map<String, Object> map = mpService.getPointLog(uuid);
		
		return map;
	};
	
	@RequestMapping(value="updateUserImg", method=RequestMethod.POST)
	public void updateUserImg(@RequestParam("userImg") String userImg,
							  HttpServletRequest req) throws Exception{
		
		HttpSession reqSes = req.getSession();
		String uuid = ""; // 로그인 회원 uuid
		LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
		uuid = customer.getUuid();
		mpService.updateUserImg(uuid, userImg);
		
	
	};
	
	
	@RequestMapping("addressList")
	public String viewAddrList(HttpServletRequest req, Model model) throws Exception {
		HttpSession reqSes = req.getSession();
		String uuid = ""; // 로그인 회원 uuid
		if(reqSes.getAttribute("loginCustomer") != null) {
			LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
			uuid = customer.getUuid();
		} else if(reqSes.getAttribute("loginCustomer") == null) {
			return "redirect:" + "../customer/loginOpen?path=/mypage/openmypage";
		}
		
		List<DeliveryDTO> addrList = mpService.selectAddr(uuid);
	    model.addAttribute("addrList", addrList);

		
		return "mypage/addressList";
		
	}
	
	
	
	@RequestMapping("wishList")
	public String viewWishList(HttpServletRequest req,HttpServletResponse resp, Model model) throws Exception {
		
		HttpSession reqSes = req.getSession();
		String uuid = ""; // 로그인 회원 uuid
		if(reqSes.getAttribute("loginCustomer") != null) {
			LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
			uuid = customer.getUuid();
		} else if(reqSes.getAttribute("loginCustomer") == null) {
			return "redirect:" + "../customer/loginOpen?path=/mypage/wishList";
		}
		// 찜목록 불러오기 -start-
			Map<String, Object> wishList = null; 
			try {
				wishList = mpService.getWishList(uuid);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			model.addAttribute("wishList", wishList.get("wishProduct"));
			
				
			
			return "mypage/wishList";
			
	}
	
	@RequestMapping(value = "detailOrder", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> detailOrder(@RequestParam("orderNo") String orderNo, 
			@RequestParam(value="phone", required = false, defaultValue="") String phone) throws Exception{
		
		
		
		Map<String, Object> map = mpService.getDetailOrder(orderNo);
		String shippingPhone = ((OrderShippingDTO) map.get("osDto")).getPhone();

		if(!("").equals(phone)) { // 비회원 조회
			if(shippingPhone.equals(phone)) {
				return map;
			} else {
				return null;
			}
		} else { // 회원 조회
			return map;
		}
		
	}
	
	@RequestMapping("mypageAddr")
    public String viewmypageAddr(HttpServletRequest req, HttpServletResponse resp, Model model) throws Exception {

       return "mypage/mypageAddr";
 
    }

	 @RequestMapping(value = "saveAddr", method = RequestMethod.POST)
	 @ResponseBody
     public void saveAddr (DeliveryDTO addr, HttpServletRequest req, Model model, RedirectAttributes rttr) throws Exception {
        
		 
			HttpSession reqSes = req.getSession();
			String uuid = ""; // 로그인 회원 uuid
			if (reqSes.getAttribute("loginCustomer") != null) {
				LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
				uuid = customer.getUuid();				
			}
        
			if(addr.getBasicAddr() == null || addr.getBasicAddr().equals("")) {
				
				addr.setBasicAddr("N");
				
			} 
        
        System.out.println("이것도 찍힙니다." + addr.toString());
       
        
        int deliveryAddr = -1;
        
        if(addr.getBasicAddr() == "N") {
            mpService.deliverySaveAddr(addr);
        	
        } else if (addr.getBasicAddr() != "N") {
        	
        	deliveryAddr = mpService.defaultAddrNupdate(uuid);
        	
        	if(deliveryAddr != 0) {
        		
              mpService.deliverySaveAddr(addr);
        	
           
        	  model.addAttribute("deliveryAddr", deliveryAddr);
         
           //return "redirect:addressList?path=" + preUrl;
          
        	}  else {

        	rttr.addFlashAttribute("status", "fail");
        	
        	}
                     
           
        	  //return "redirect:mypageAddr?path=" + preUrl;
        	  

          }
        
  }
	
	 @RequestMapping("modifyAddr")
     public DeliveryDTO modifyAddr(@RequestParam ("deliveryNo") int deliveryNo, Model model, RedirectAttributes rttr) throws Exception {
        
        
        
        DeliveryDTO deliveryNoInt = null;
        
        
           
        deliveryNoInt = mpService.modifyAddrNo(deliveryNo);
     
           
        model.addAttribute("deliveryNoInt", deliveryNoInt);
           
        
     
        return deliveryNoInt;
     
     
     }
        
     
     
        @RequestMapping(value = "modifyUpdateAddr", method = RequestMethod.POST)
        @ResponseBody
        public void updateAddr(@RequestParam ("deliveryNo") int deliveryNo, DeliveryDTO modifyAddr, Model model, RedirectAttributes rttr, HttpServletRequest req) throws Exception {
           
        	HttpSession reqSes = req.getSession();
    		String uuid = ""; // 로그인 회원 uuid
    		if(reqSes.getAttribute("loginCustomer") != null) {
    			LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
    			uuid = customer.getUuid();
    		}
        	
    		
    		
    		
           System.out.println("modifyAddr" + modifyAddr.toString());
           
           if(modifyAddr.getBasicAddr() == null) {
        	   modifyAddr.setBasicAddr("N");
        	   
        	   
        	   
        	} else if (modifyAddr.getBasicAddr() != "Y") {
        		
        		mpService.defaultAddrNupdate(uuid);
        	} 
        		
        
           
           
           int deliveryNoInt = mpService.modifyDeliveryUpdateAddr(modifyAddr);
           
           if(deliveryNoInt == 1) {
        
           } else {
           
           }
           
           
        }
           

        @RequestMapping(value = "deleteAddr", method = RequestMethod.POST)
        @ResponseBody
        public void deleteAddr(@RequestParam ("deliveryNo") int deliveryNo, DeliveryDTO deleteAddr, Model model, RedirectAttributes rttr ) throws Exception {
           
           
           int deliveryNoInt = mpService.modifyDeliveryDeleteAddr(deleteAddr);
           
           if(deliveryNoInt == 1) {
              
           } else {
      
              
           }
           
           
        }


	
	 
	 @RequestMapping("myActivity") 
	  public void myActivity(Model model ,HttpSession ses) throws Exception {	 
		System.out.println("myActivity 옴");
		
		LoginCustomerVO vo = (LoginCustomerVO) ses.getAttribute("loginCustomer");
		
		String nickname = vo.getNickname();
		String uuid = vo.getUuid();
		
		List<AdminBoardDTO> adboard = new ArrayList<>();
		List<MyPageReplyVO> reply = new ArrayList<>();
		try {
			adboard = mpService.getListAll(nickname, uuid);
			reply = mpService.getreply(uuid);
//			System.out.println("컨트롤러 adboard " + adboard);
			System.out.println("컨트롤러 reply " + reply);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
  		
  		model.addAttribute("reply", reply);
		model.addAttribute("adboard", adboard);
		
	 }

	 

     @RequestMapping(value="updateOrderStatus")
     public void updateOrderStatus(@RequestParam("orderNo") String orderNo) throws Exception {
     	mpService.updateOrderStatus(orderNo);        	
     }
	 

        @RequestMapping("changeMemberInfo") 
        public void changeMemberInfo(Model model, String uuid) throws Exception {    
          System.out.println("changeMemberInfo 옴");
          
          LoginCustomerVO loginCustomer = mpService.getLoginCustomerInfo(uuid);
          model.addAttribute("userInfo", loginCustomer);
     
         
       }
        
        @RequestMapping("changeMemberInfoJoin") 
        public void changeMemberInfoJoin(Model model, String uuid) throws Exception {    
          System.out.println("changeMemberInfoJoin 옴");
     
         
       }
        
        @RequestMapping(value ="duplicatePwd", method= RequestMethod.POST) 
        @ResponseBody
        public int duplicatePwd(@RequestParam ("password") String password, HttpServletRequest req, LoginCustomerVO login) throws Exception {    
           
        	
        	
        	
        	HttpSession reqSes = req.getSession();
            String uuid = ""; // 로그인 회원 uuid
            if (reqSes.getAttribute("loginCustomer") != null) {
              LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
              uuid = customer.getUuid();
              System.out.println("마이페이지 회원 : " + uuid);
      
            }
           
            login.setUuid(uuid);
           
            int result = mpService.duplicatePwd(login);
        	
        	System.out.println("login : " + login);
            
    		return result;
    		
    	}
//     
        @RequestMapping(value = "pwdUpdate", method= RequestMethod.POST)
        public ResponseEntity<String> pwdUpdate(HttpServletRequest req, LoginCustomerVO login) throws Exception {
        	System.out.println("이거 업데이트 되는거 맞지?");
        	
        	ResponseEntity<String> result = null;
        	
        	HttpSession reqSes = req.getSession();
          String uuid = ""; // 로그인 회원 uuid
          if (reqSes.getAttribute("loginCustomer") != null) {
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            System.out.println("마이페이지 회원 : " + uuid);
            result = new ResponseEntity<String>("success", HttpStatus.OK);
          }
          	login.setUuid(uuid);
          
          	
          	System.out.println("로그인" + login);
          	
          	mpService.pwdUpdate(login);

              return result;

            }
        
        @RequestMapping(value = "mobileUpdate", method= RequestMethod.POST)
        public ResponseEntity<String> mobileUpdate(HttpServletRequest req, LoginCustomerVO login) throws Exception {
        	System.out.println("모바일 업데이트 되는거 맞지?");
        	
        	ResponseEntity<String> result = null;
        	
        	HttpSession reqSes = req.getSession();
          String uuid = ""; // 로그인 회원 uuid
          if (reqSes.getAttribute("loginCustomer") != null) {
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            System.out.println("마이페이지 회원 : " + uuid);
            result = new ResponseEntity<String>("success", HttpStatus.OK);
          }

          	mpService.mobileUpdate(login);
          		
          	System.out.println("모바일" + login);
          	
              return result;

            }
        
        @RequestMapping(value = "nicknameUpdate", method= RequestMethod.POST)
        public ResponseEntity<String> nicknameUpdate(HttpServletRequest req, LoginCustomerVO login) throws Exception {
        	
        	ResponseEntity<String> result = null;
        	
        	HttpSession reqSes = req.getSession();
          String uuid = ""; // 로그인 회원 uuid
          if (reqSes.getAttribute("loginCustomer") != null) {
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            System.out.println("마이페이지 회원 : " + uuid);
            result = new ResponseEntity<String>("success", HttpStatus.OK);
          }
         
          
          
           mpService.nicknameUpdate(login);

           System.out.println("닉네임" + login);
          
              return result;

            }
        
        @RequestMapping(value = "bankUpdate", method= RequestMethod.POST)
        public ResponseEntity<String> bankUpdate(@RequestParam ("newBankName") String newBankName, @RequestParam ("newRefundAccount") String newRefundAccount, HttpServletRequest req, LoginCustomerVO login) throws Exception {
        	
        	ResponseEntity<String> result = null;
        	
        	HttpSession reqSes = req.getSession();
          String uuid = ""; // 로그인 회원 uuid
          if (reqSes.getAttribute("loginCustomer") != null) {
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            System.out.println("마이페이지 회원 : " + uuid);
            result = new ResponseEntity<String>("success", HttpStatus.OK);
          }
         
          
          
          login.setBankName(newBankName);
          login.setRefundAccount(newRefundAccount);
          
          System.out.println("login " + login);
          
           mpService.bankUpdate(login);

           System.out.println("환불계좌" + login);
          
              return result;

            }
        
        @RequestMapping(value = "agreeUpdate", method= RequestMethod.POST)
        public ResponseEntity<String> agreeUpdate(@RequestParam ("checkedValue") String checkedValue, HttpServletRequest req, LoginCustomerVO login) throws Exception {
        	
        	ResponseEntity<String> result = null;
        	
        	HttpSession reqSes = req.getSession();
          String uuid = ""; // 로그인 회원 uuid
          if (reqSes.getAttribute("loginCustomer") != null) {
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            System.out.println("마이페이지 회원 : " + uuid);
            result = new ResponseEntity<String>("success", HttpStatus.OK);
          }
         
          
          
          login.setMsgAgree(checkedValue);
          
          System.out.println("login " + checkedValue);
          
           mpService.agreeUpdate(login);

           System.out.println("수신동의" + login);
          
              return result;

            }


        @RequestMapping("duplicateNickname")
    	@ResponseBody
    	public int NicknameChk(RegisterDTO member) throws Exception {

    		System.out.println("닉네임 중복확인");
    		
    		int result = rService.duplicateNickname(member);
    		
    		return result;
    		
    	}
    	
    	@RequestMapping("duplicatePhoneNumber")
    	@ResponseBody
    	public int PhoneNumberChk(RegisterDTO member) throws Exception {

    		System.out.println("핸드폰번호 중복확인");
    		
    		int result = rService.duplicatePhoneNumber(member);
    		
    		return result;
    		
    	}
        
        
    	@RequestMapping("duplicateRefundAccount")
    	@ResponseBody
    	public int RefundAccountChk(RegisterDTO member) throws Exception {

    		System.out.println("계좌번호 중복확인");
    		
    		int result = rService.duplicateRefundAccount(member);
    		
    		return result;
    		
    	}
            	
            	
        
       
        @RequestMapping(value="getAddrToOrder", method=RequestMethod.POST)
        @ResponseBody
        public Map<String, Object> getAddrToOrder(HttpServletRequest req) throws Exception {
        	HttpSession reqSes = req.getSession();
            String uuid = ""; // 로그인 회원 uuid
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            
        	List<DeliveryDTO> addrList = mpService.selectAddr(uuid);
        	
        	Map<String, Object> map = new HashMap<String, Object>();
        	map.put("addrList", addrList);
        	
        	return map;
        };        
        
        @RequestMapping("csList")
        public void viewCsList(HttpServletRequest req,Model model) throws Exception {
        	
        	HttpSession reqSes = req.getSession();
            String uuid = ""; // 로그인 회원 uuid
            LoginCustomerVO customer = (LoginCustomerVO) reqSes.getAttribute("loginCustomer");
            uuid = customer.getUuid();
            
            List<Map<String, Object>> csInfoList = mpService.getCsList(uuid);
            List<ServiceBoardVO> svInfoList = mpService.getSvList(uuid);
            List<ProductQnAVO> pdQnaList = mpService.getPdQnAList(uuid);
            
            model.addAttribute("csInfoList", csInfoList);
            model.addAttribute("svInfoList", svInfoList);
        	model.addAttribute("pdQnAList", pdQnaList);
        }
        
        
        @RequestMapping(value="getDetailCs", method=RequestMethod.POST)
        @ResponseBody
        public Map<String, Object> getDetailCsInfo(@RequestParam("csNo") int csNo ) throws Exception {
        	
            Map<String, Object> map = mpService.getCsDetail(csNo);
            
        	return map;
        }
        
        @RequestMapping(value="delPdQnA", method=RequestMethod.POST)
        @ResponseBody
        public String delPdQnA(@RequestParam("svBNo") int svBNo) throws Exception {
			
        	String result = "fail";
        	
        	
        	result = mpService.delPdQnA(svBNo);
        	
        	return result;
        }
        
        
        
}
