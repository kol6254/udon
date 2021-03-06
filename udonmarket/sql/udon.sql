select * from tabs;

drop table report;
drop table reason_report;
drop table keyword;
drop table notification;
drop table evaluation;
drop table coupon;
drop table location;
drop table evaluate;
drop table authority;
drop table reply;
drop table block;
drop table score;
drop table review;
drop table wish;
drop table message;
drop table chat_user;
drop table chat_room;
drop table product_photo;
drop table product;
drop table board_photo;
drop table board;
drop table hashtag;
drop table category;
drop table member;

drop sequence seq_category;
drop sequence seq_hashtag;
drop sequence seq_board_photo;
drop sequence seq_product;
drop sequence seq_chat_room;
drop sequence seq_message;
drop sequence seq_wish;
drop sequence seq_review;
drop sequence seq_reply;
drop sequence seq_coupon;
drop sequence seq_evaluation;
drop sequence seq_notification;
drop sequence seq_keyword;
drop sequence seq_reason_report;
drop sequence seq_report;

--========================================
--          TABLE & SEQUENCE
--========================================
create table member
(
    user_id varchar2(50),
    password varchar2(50) not null,
    email varchar2(50),
    nickname varchar2(50) default '닉네임',
    address varchar2(100),
    original_filename varchar2(50) default 'default_profile.jpg',
    renamed_filename varchar2(50),
    enabled number default 1 not null,
    reg_date date default sysdate,
    quit_yn char(1) default 'N',
    constraint pk_member_user_id primary key(user_id),
    constraint ck_member_enabled check(enabled in(1, 2)),
    constraint ck_member_quit_yn check(quit_yn in('Y', 'N'))
);

create table category
(
    category_code number,
    category_parent number,
    category_name varchar2(50) not null,
    constraint pk_category primary key(category_code),
    constraint fk_category_category_parent foreign key(category_parent) references category(category_code)
);

create table hashtag
(
    hashtag_code number,
    hashtag_name varchar2(50) not null,
    constraint pk_hashtag primary key(hashtag_code)
);

create table board
(
    b_code number,
    user_id varchar2(50) not null,
    category_code number not null,
    board_title varchar2(100) not null,
    board_content varchar2(500) not null,
    reg_date date default sysdate,
    hashtag_code number,
    like_this number default 0 not null,
    constraint pk_board primary key(b_code),
    constraint fk_board_user_id foreign key(user_id) references member(user_id),
    constraint fk_board_category_code foreign key(category_code) references category(category_code),
    constraint fk_board_hashtag_code foreign key(hashtag_code) references hashtag(hashtag_code)
);

create table board_photo
(  
    photo_code number,
    b_code number not null,
    original_filename varchar2(50) not null,
    renamed_filename varchar2(50) not null,
    constraint pk_board_photo primary key(photo_code),
    constraint fk_board_photo_b_code foreign key(b_code) references board(b_code)
);

create table product
(
    p_code number,
    seller varchar2(50) not null,
    buyer varchar2(50),
    title varchar2(100) not null,
    category number not null,
    content varchar2(500) not null,
    price number not null,
    reg_date date default sysdate not null,
    open_status number default 1 not null,
    trade_status char(1) default 'S' not null,
    coupon number default 1 not null,
    offer number default 1 not null,
    delete_yn char(1) default 'y' not null,
    constraint pk_product primary key(p_code),
    constraint fk_product_seller foreign key(seller) references member(user_id),
    constraint fk_product_buyer foreign key(buyer) references member(user_id),
    constraint fk_product_category foreign key(category) references category(category_code),
    constraint ck_product_open_status check(open_status in (1,0)),
    constraint ck_product_trade_status check(trade_status in('S','R','C')),
    constraint ck_product_coupon check(coupon in(1,0)),
    constraint ck_product_offer check(offer in(1,0)),
    constraint ck_product_delete_yn check(delete_yn in('Y', 'N')
);
create table product_photo
(
    uuid varchar2(100),
    p_code number not null,
    filename varchar2(50) not null,
    uploadpath varchar2(50) not null,
    constraint fk_product_photo_p_code foreign key(p_code) references product(p_code)
);

create table chat_room
(
    room_code number,
    p_code number not null,
    reg_date date default sysdate not null,
    constraint pk_chat_room primary key(room_code),
    constraint fk_chat_room_p_code foreign key(p_code) references product(p_code)
);

create table chat_user
(
    user_id varchar2(50),
    room_code number,
    enabled char(1) default 1 not null,
    constraint pk_chat_user primary key(user_id, room_code),
    constraint fk_chat_user_user_id foreign key(user_id) references member(user_id),
    constraint fk_chat_user_room_code foreign key(room_code) references chat_room(room_code),
    constraint ck_chat_user_enabled check(enabled in(1,0))
);

create table message
(
    msg_code number,
    room_code number not null,
    user_id varchar2(50) not null,
    chat_content varchar2(500),
    chat_date date default sysdate not null,
    original_filename varchar2(50),
    renamed_filename varchar2(50),
    constraint pk_message primary key(msg_code),
    constraint fk_message_room_code foreign key(room_code) references chat_room(room_code),
    constraint fk_message_user_id foreign key(user_id) references member(user_id)
);

create table wish
(
    wish_code number,
    user_id varchar2(50) not null,
    p_code number not null,
    constraint pk_wish primary key(wish_code),
    constraint fk_user_id foreign key(user_id) references member(user_id),
    constraint fk_wish_p_code foreign key(p_code) references product(p_code),
    constraint uq_wish_id_pcode unique(user_id, p_code)
);

create table review
(
    review_code number,
    sender varchar2(50) not null,
    recipient varchar2(50) not null,
    content varchar2(500) not null,
    direct char(1) not null,
    constraint pk_review primary key(review_code),
    constraint fk_review_seller foreign key(seller) references member(user_id),
    constraint fk_review_buyer foreign key(buyer) references member(user_id),
    constraint ck_review_direct check (direct in('S', 'B'))
);

create table score
(
    user_id varchar2(50),
    total_score number default 0 not null,
    count number default 0 not null,
    constraint pk_score primary key(user_id),
    constraint fk_score_user_id foreign key(user_id) references member(user_id)
);

create table block
(
    user_id varchar2(50),
    block_id varchar2(50),
    constraint pk_block primary key(user_id, block_id),
    constraint fk_block_user_id foreign key(user_id) references member(user_id),
    constraint fk_block_block_id foreign key(block_id) references member(user_id)
);

create table reply
(
    reply_code number,
    reply_level number default 1 not null,
    user_id varchar2(50) not null,
    content varchar2(500) not null,
    b_code number,
    reply_ref number,
    reg_date date default sysdate not null,
    constraint pk_reply primary key(reply_code),
    constraint ck_reply_reply_level check(reply_level in(1,2)),
    constraint fk_reply_user_id foreign key(user_id) references member(user_id),
    constraint fk_reply_b_code foreign key(b_code) references board(b_code),
    constraint fk_reply_reply_ref foreign key(reply_ref) references reply(reply_code)
);

create table authority
(
    auth varchar2(5) default 'ROLE_USER',
    user_id varchar2(50),
    constraint pk_authority primary key(auth, user_id),
    constraint fk_authority_user_id foreign key(user_id) references member(user_id)
);

create table evaluate
(
    eva_code number,
    user_id varchar2(50),
    count number default 0 not null,
    constraint pk_evaluate primary key(user_id, eva_code),
    constraint fk_evaluate_user_id foreign key(user_id) references member(user_id)
);

create table location
(
    user_id varchar2(50),
    latitude number(10,6),
    longitude number(10,6),
    radius number,
    constraint pk_location primary key(user_id),
    constraint fk_location_user_id foreign key(user_id) references member(user_id)
);

create table coupon
(
    coupon_code number,
    user_id varchar2(50) not null,
    coupon_name varchar2(50) not null,
    expire_date date default sysdate+7 not null,
    usage_status number default 0 not null,
    constraint pk_coupon primary key(coupon_code),
    constraint fk_coupon_user_id foreign key(user_id) references member(user_id),
    constraint ck_coupon_usage_status check(usage_status in(1,0))
);

create table evaluation
(
    eva_code number,
    content varchar2(100) not null,
    kind number not null,
    member char(1) not null,
    constraint pk_evaluation primary key(eva_code),
    constraint ck_evaluation_kind check(kind in(1, 0)),
    constraint ck_evaluation_member check(member in('S', 'B', 'C'))
);

create table notification
(
    noti_code number,
    user_id varchar2(50) not null,
    noti_kind varchar2(2) not null,
    noti_check number default 0 not null,
    constraint pk_notification primary key(noti_code),
    constraint fk_notification_user_id foreign key(user_id) references member(user_id),
    constraint ck_notification_noti_kind check(noti_kind in('PC', 'K', 'PS')),
    constraint ck_notification_noti_check check(noti_check in(1,0))
);

create table keyword
(
    key_code number,
    user_id varchar2(50) not null,
    key_content varchar2(100) not null,
    constraint pk_keyword primary key(key_code),
    constraint fk_keyword_user_id foreign key(user_id) references member(user_id)
);

create table reason_report
(
    reason_code number,
    reason_content varchar2(100) not null,
    constraint pk_reason_report primary key(reason_code)
);

create table report
(
    report_code number,
    reason_code number not null,
    report_id varchar2(50) not null,
    shooter_id varchar2(50),
    b_code number,
    reply_code number,
    checked number default 0 not null,
    constraint pk_report primary key(report_code),
    constraint fk_report_reason_code foreign key(reason_code) references reason_report(reason_code),
    constraint fk_report_report_id foreign key(report_id) references member(user_id),
    constraint fk_report_shooter_id foreign key(shooter_id) references member(user_id),
    constraint fk_report_b_code foreign key(b_code) references board(b_code),
    constraint fk_report_reply_code foreign key(reply_code) references reply(reply_code),
    constraint fk_report_checked check(checked in(1,0))
);

create sequence seq_category;
create sequence seq_hashtag;
create sequence seq_board_photo;
create sequence seq_product;
create sequence seq_chat_room;
create sequence seq_message;
create sequence seq_wish;
create sequence seq_review;
create sequence seq_reply;
create sequence seq_coupon;
create sequence seq_evaluation;
create sequence seq_notification;
create sequence seq_keyword;
create sequence seq_reason_report;
create sequence seq_report;
create sequence seq_member;
create sequence seq_location;



--========================================
--            DUMMY DATA
--========================================
insert into category values(seq_category.nextval, null, '상품'); -- 1
insert into category values(seq_category.nextval, null, '게시판'); -- 2
insert into category values(seq_category.nextval, null, '관리자'); -- 21
insert into category values(seq_category.nextval, 21, '공지사항');
insert into category values(seq_category.nextval, 21, '자주 묻는 질문');
insert into category values(seq_category.nextval, 1, '디지털/가전');
insert into category values(seq_category.nextval, 1, '가구/인테리어');
insert into category values(seq_category.nextval, 1, '유아동/유아도서');
insert into category values(seq_category.nextval, 1, '생활/가공식품');
insert into category values(seq_category.nextval, 1, '스포츠/레저');
insert into category values(seq_category.nextval, 1, '여성잡화');
insert into category values(seq_category.nextval, 1, '여성의류');
insert into category values(seq_category.nextval, 1, '남성패션/잡화');
insert into category values(seq_category.nextval, 1, '게임/취미');
insert into category values(seq_category.nextval, 1, '뷰티/미용');
insert into category values(seq_category.nextval, 1, '반려동물용품');
insert into category values(seq_category.nextval, 1, '도서/티켓/음반');
insert into category values(seq_category.nextval, 1, '기타 중고물품');
insert into category values(seq_category.nextval, 1, '삽니다');
insert into category values(seq_category.nextval, 2, '동네생활이야기');
insert into category values(seq_category.nextval, 2, '우리동네질문');
insert into category values(seq_category.nextval, 2, '분실/실종센터');
insert into category values(seq_category.nextval, 2, '동네사건사고');

insert into hashtag values(1, '강아지');
insert into hashtag values(2, '고양이');
insert into hashtag values(3, '건강');
insert into hashtag values(4, '동네맛집');
insert into hashtag values(5, '동네카페');
insert into hashtag values(6, '살림/청소/정리');
insert into hashtag values(7, '식물');
insert into hashtag values(8, '임신/출산/육아');
insert into hashtag values(9, '집꾸미기');

insert into member values('test', '1234', 'test@naver.com', null, null, null, null, 1, sysdate, 'N');

insert into board values(SEQ_BOARD_NO.nextval, 'test', 17, '테스트입니다', '안녕하세요 반갑습니다', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 18, '질문입니다', '질문질문', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 19, '분실됐습니다', '찾아주세요', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 20, '사건입니다', '큰일났네요', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 17, '장문 테스트', '안녕 오늘도 같은 자리 버스 창가에 기대 앉은 네게 인사를 해 역시 넌 받아 주지를 않네 인기 많고 잘생긴 넌 내게만 그렇게 쌀쌀하게 굴더라', sysdate, null, 0);
insert into board values(SEQ_BOARD_NO.nextval, 'test', 17, '더 긴 장문 테스트', '중앙방역대책본부는 24일 0시 기준으로 국내 코로나바이러스 감염증(코로나19) 신규 확진자가 125명 늘어 누적 2만3341명이라고 밝혔다. 신규 확진자 수는 전날 110명에 이어 이틀 연속 세 자릿수를 나타냈다. 앞서 국내 신규 확진자는 지난달 14일부터 이달 19일까지 37일 연속 세 자릿수를 기록했었다.', sysdate, null, 0);

insert into coupon values(seq_coupon.nextval, 'test', '강남구 11월 판매왕', to_date(to_char(sysdate + 7, 'yyyy-mm-dd'), 'yyyy-mm-dd'), 0);

insert into evaluation values(seq_evaluation.nextval, '제가 있는 곳 까지 와서 거래했어요', 1, 'S');
insert into evaluation values(seq_evaluation.nextval, '무료로 나눠주셨어요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품상태가 설명한 것과 같아요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품설명이 자세해요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '좋은 상품을 저렴하게 판매해요', 1, 'B');
insert into evaluation values(seq_evaluation.nextval, '시간약속을 잘 지켜요', 1, 'C');
insert into evaluation values(seq_evaluation.nextval, '응답이 빨라요', 1, 'C');
insert into evaluation values(seq_evaluation.nextval, '친절하고 매너가 좋아요', 1, 'C');
insert into evaluation values(seq_evaluation.nextval, '단순 변심으로 환불을 요구해요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '무리하게 가격을 깎아요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '불친절해요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '예약만 해놓고 거래 시간을 명확하게 알려주지 않아요', 0, 'S');
insert into evaluation values(seq_evaluation.nextval, '상품 가치없는 물건을 팔아요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품 상태가 설명과 달라요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '상품 설명에 중요한 정보가 누락됐어요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '구매 가격보다 비싼 가격으로 판매해요', 0, 'B');
insert into evaluation values(seq_evaluation.nextval, '이 분과 다시는 거래하고 싶지 않아요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '너무 늦은 시간이나 새벽에 연락해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '반말을 사용해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '시간약속을 안 지켜요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '차에서 내리지도 않고 창문만 열고 거래하려고 해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '무조건 택배거래만 하려고 해요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '질문해도 답이 없어요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '거래 시간과 장소를 정한 후 연락이 안돼요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '약속 장소에 나타나지 않았어요', 0, 'C');
insert into evaluation values(seq_evaluation.nextval, '거래 시간과 장소를 정한 후 거래 직전 취소했어요', 0, 'C');
--==========================================================================================
select count(p.category) from category c left join product p on(c.category_code = p.category) 
		group by c.category_code order by c.category_code;
    
select * from wish;
select * from category;
select count(p.category) from category c left join product p on(c.category_code = p.category) 
where c.category_parent = 1 group by c.category_code order by c.category_code;