package com.kh.udon.product.model.vo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductVO implements Serializable
{
    int pCode;
    String seller;
    String buyer;
    String title;
    int category;
    String content;
    int price;
    int regDate;
    boolean openStatus;
    String tradeStatus;
    boolean coupon;
    boolean offer;
    
}
