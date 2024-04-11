/**
 * 
 */
package com.cafe24.goott351.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * @author : su hyeok kim
 * @date : 2024. 3. 21.
 * @description :
 * @change name date detail
 *         ----------------------------------------------------------------------------------
 *         su hyeok kim 2024. 3. 21.
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class CustomerWriterDTO {
	private int boardNo;
	private String title;
	private String content;
	private String writer;

	private String csType;

}
