package com.kh.udon.member.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.udon.member.model.dao.MemberDao;
import com.kh.udon.member.model.vo.Evaluate;
import com.kh.udon.member.model.vo.Keyword;
import com.kh.udon.member.model.vo.Location;
import com.kh.udon.member.model.vo.Member;
import com.kh.udon.member.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService
{
    @Autowired
    private MemberDao memberDao;

	@Override
	public int insertKeyword(Map<String, Object> map) {
		return memberDao.insertKeyword(map);
	}

	@Override
	public List<Keyword> selectKeywordList(String userId) {
		return memberDao.selectKeywordList(userId);
	}

	@Override
	public int selectTotalKeywordContent(String userId) {
		return memberDao.selectTotalKeywordContent(userId);
	}

	@Override
	public int deleteKeyword(int keyCode) {
		return memberDao.deleteKeyword(keyCode);
	}

	@Override
	public Member selectOneMember(String userId) {
		return memberDao.selectOneMember(userId);
	}

	@Override
	public int selectRadius(String userId) {
		return memberDao.selectRadius(userId);
	}

	@Override
	public int updateRadius(Map<String, Object> map) {
		return memberDao.updateRadius(map);
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int updateAddrAndLoc(Map<String, Object> map) {
		int result = 0;
		
		result = memberDao.updateLocation(map);		
		if(result > 0) { 
			result = memberDao.updateAddr(map);
		}else {
//			throw new MemberException("주소 변경 오류!");
		}
		
		return result;
	}

	@Override
	public int selectKeyword(Map<String, Object> key) {
		return memberDao.selectKeyword(key);
	}

	@Override
	public List<Evaluate> selectAllEva(String userId) {
		return memberDao.selectAllEva(userId);
	}

	@Override
	public int selectTotalReview(String userId) {
		return memberDao.selectTotalReview(userId);
	}

	@Override
	public List<Review> selectAllReview(String userId) {
		return memberDao.selectAllReview(userId);
	}

	@Transactional(rollbackFor = { Exception.class })
	@Override
	public int insertMemberLoc(Member member) {
		
		int result = 0;
		
		result = memberDao.insertMember(member);
		log.debug("result = {}", result);
		log.debug("member = {}", member);

		
		if(result > 0) {
			result = memberDao.insertLocation(member.getUserId());
			log.debug("result = {}", result);

		}
		
		return result;
	}

}
