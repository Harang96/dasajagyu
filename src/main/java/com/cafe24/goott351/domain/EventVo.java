package com.cafe24.goott351.domain;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString


public class EventVo {
	
	
		private int eventNo;
		private LocalDateTime startDate;
		private LocalDateTime endDate;
		private String title;
		private String content;
		private String newImgname;
		private String imgUrl;
		
		
}
