package com.kh.udon.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.udon.member.model.dao.MemberDao;

@Service
public class MemberServiceImpl implements MemberService
{
    @Autowired
    private MemberDao dao;
}
