/**
 * 
 */
package com.cafe24.goott351.domain;

import java.util.List;

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
public class CustomerCenterBoardDTO {
	private List<ServiceBoardDTO> ServiceBoardLst;
	private String ServiceCenterType;
}
