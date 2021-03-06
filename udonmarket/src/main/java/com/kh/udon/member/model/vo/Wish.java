package com.kh.udon.member.model.vo;

import java.io.Serializable;

import com.kh.udon.product.model.vo.ProductVO;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper = true)
public class Wish extends ProductVO implements Serializable {

	private int wishCode;
	private String userId; //사용자 아이디
	private String sellerAddr; //판매자 주소
	private int pCode;
	private int totalWish; //하트 개수
	
}
