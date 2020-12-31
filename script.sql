create table BENH
(
    MA_BENH  varchar(20)               not null
        primary key,
    TEN_BENH varchar(20) charset utf8  null,
    MO_TA    varchar(100) charset utf8 null
)
    charset = latin1;

create table BHYT
(
    MA_THE      varchar(20)              not null
        primary key,
    THOI_HAN    date                     null,
    NOI_DANG_KY varchar(30) charset utf8 null
)
    charset = latin1;

create table BENHNHAN
(
    MA_BN       varchar(20)              not null
        primary key,
    HO          varchar(20) charset utf8 null,
    TEN         varchar(20) charset utf8 null,
    TUOI        int                      null,
    DAN_TOC     varchar(20) charset utf8 null,
    NGHE_NGHIEP varchar(30) charset utf8 null,
    BHYT        varchar(20)              null,
    constraint FKBHYT
        foreign key (BHYT) references BHYT (MA_THE)
            on update cascade on delete set null
)
    charset = latin1;

create table BS_QUANLY
(
    MA_QL       varchar(20) not null
        primary key,
    NAM_QUAN_LY int         null
)
    charset = latin1;

create table CDDD
(
    MA_CDDD   varchar(20)               not null
        primary key,
    NOI_DUNG  varchar(100) charset utf8 null,
    HUONG_DAN varchar(100) charset utf8 null
)
    charset = latin1;

create table CHISOXN
(
    MA_CHISOXN varchar(20)      not null
        primary key,
    UPPERBOUND double           null,
    LOWERBOUND double default 0 null
)
    charset = latin1;

create table KHAMBENH
(
    MA_KHAM        varchar(20) not null
        primary key,
    THOI_GIAN_KHAM datetime    not null,
    CA_KHAM        int         not null
)
    charset = latin1;

create table KHOADIEUTRI
(
    MA_KHOA    varchar(20)              not null
        primary key,
    TEN_KHOA   varchar(20) charset utf8 null,
    BUILD_YEAR int                      null,
    CHUYEN_MON varchar(30) charset utf8 null,
    MA_QL      varchar(20)              not null,
    constraint FKQL
        foreign key (MA_QL) references BS_QUANLY (MA_QL)
            on update cascade on delete cascade
)
    charset = latin1;

create table KQCHANDOAN
(
    MA_CHANDOAN varchar(20)               not null,
    MA_BENH     varchar(20)               not null,
    MA_KHAM     varchar(20)               not null,
    NOI_DUNG    varchar(100) charset utf8 null,
    GHI_CHU     varchar(50) charset utf8  null,
    primary key (MA_CHANDOAN, MA_BENH, MA_KHAM),
    constraint KQCHANDOAN_ibfk_1
        foreign key (MA_BENH) references BENH (MA_BENH)
            on update cascade on delete cascade,
    constraint KQCHANDOAN_ibfk_2
        foreign key (MA_KHAM) references KHAMBENH (MA_KHAM)
            on update cascade on delete cascade
)
    charset = latin1;

create table DINHDUONG
(
    MA_CHANDOAN varchar(20)               not null,
    MA_BENH     varchar(20)               not null,
    MA_KHAM     varchar(20)               not null,
    MA_CDDD     varchar(20)               not null,
    CHI_DINH    varchar(100) charset utf8 null,
    GHI_CHU     varchar(50) charset utf8  null,
    primary key (MA_CHANDOAN, MA_BENH, MA_KHAM, MA_CDDD),
    constraint DINHDUONG_ibfk_1
        foreign key (MA_CHANDOAN, MA_BENH, MA_KHAM) references KQCHANDOAN (MA_CHANDOAN, MA_BENH, MA_KHAM)
            on update cascade on delete cascade,
    constraint DINHDUONG_ibfk_2
        foreign key (MA_CDDD) references CDDD (MA_CDDD)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_CDDD
    on DINHDUONG (MA_CDDD);

create index MA_BENH
    on KQCHANDOAN (MA_BENH);

create index MA_KHAM
    on KQCHANDOAN (MA_KHAM);

create table NGOAITRU
(
    MA_BN varchar(20) not null
        primary key,
    constraint NGOAITRU_ibfk_1
        foreign key (MA_BN) references BENHNHAN (MA_BN)
            on update cascade on delete cascade
)
    charset = latin1;

create table NHANVIEN
(
    MA_NV       varchar(20)              not null
        primary key,
    HO          varchar(20) charset utf8 null,
    TEN         varchar(20) charset utf8 null,
    LUONG       decimal(15, 2)           null,
    MA_KHOA     varchar(20)              not null,
    CA_LAM_VIEC int                      not null,
    constraint FKMAKHOA
        foreign key (MA_KHOA) references KHOADIEUTRI (MA_KHOA)
            on update cascade on delete cascade
)
    charset = latin1;

create table BACSY
(
    MA_BS       varchar(20)              not null
        primary key,
    CHUYEN_KHOA varchar(20) charset utf8 null,
    EXPYEAR     int                      null,
    MA_BSQL     varchar(20)              null,
    constraint BACSY_ibfk_1
        foreign key (MA_BS) references NHANVIEN (MA_NV)
            on update cascade on delete cascade,
    constraint FKBSQL
        foreign key (MA_BSQL) references BS_QUANLY (MA_QL)
            on update cascade on delete set null
)
    charset = latin1;

alter table BS_QUANLY
    add constraint BS_QUANLY_ibfk_1
        foreign key (MA_QL) references NHANVIEN (MA_NV)
            on update cascade on delete cascade;

create table KBNGOAITRU
(
    MA_KHAM varchar(20) not null,
    MA_BN   varchar(20) not null,
    MA_BS   varchar(20) not null,
    primary key (MA_KHAM, MA_BN, MA_BS),
    constraint KBNGOAITRU_ibfk_1
        foreign key (MA_KHAM) references KHAMBENH (MA_KHAM)
            on update cascade on delete cascade,
    constraint KBNGOAITRU_ibfk_2
        foreign key (MA_BN) references NGOAITRU (MA_BN)
            on update cascade on delete cascade,
    constraint KBNGOAITRU_ibfk_3
        foreign key (MA_BS) references BACSY (MA_BS)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_BN
    on KBNGOAITRU (MA_BN);

create index MA_BS
    on KBNGOAITRU (MA_BS);

create table NHIEUBENH
(
    MA_BENH_DAU  varchar(20) not null,
    MA_BENH_CUOI varchar(20) not null,
    primary key (MA_BENH_DAU, MA_BENH_CUOI),
    constraint NHIEUBENH_ibfk_1
        foreign key (MA_BENH_DAU) references BENH (MA_BENH)
            on update cascade on delete cascade,
    constraint NHIEUBENH_ibfk_2
        foreign key (MA_BENH_CUOI) references BENH (MA_BENH)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_BENH_CUOI
    on NHIEUBENH (MA_BENH_CUOI);

create table NOITRU
(
    MA_BN varchar(20) not null
        primary key,
    constraint NOITRU_ibfk_1
        foreign key (MA_BN) references BENHNHAN (MA_BN)
            on update cascade on delete cascade
)
    charset = latin1;

create table BENHANNOITRU
(
    THOIGIANNHAPVIEN      datetime                  not null,
    MA_KHOA               varchar(20)               not null,
    MA_BS                 varchar(20)               not null,
    MA_BN                 varchar(20)               not null,
    SO_GIUONG             int                       null,
    SO_BUONG              int                       null,
    MABS_CHIDINH_XUATVIEN varchar(20)               null,
    TINHTRANG_XV          varchar(100) charset utf8 null,
    TG_XV                 datetime                  null,
    GHI_CHU_XV            varchar(50) charset utf8  null,
    primary key (THOIGIANNHAPVIEN, MA_KHOA, MA_BS, MA_BN),
    constraint BENHANNOITRU_ibfk_1
        foreign key (MA_KHOA) references KHOADIEUTRI (MA_KHOA)
            on update cascade on delete cascade,
    constraint BENHANNOITRU_ibfk_2
        foreign key (MA_BS) references BACSY (MA_BS)
            on update cascade on delete cascade,
    constraint BENHANNOITRU_ibfk_3
        foreign key (MA_BN) references NOITRU (MA_BN)
            on update cascade on delete cascade,
    constraint FK_XV
        foreign key (MABS_CHIDINH_XUATVIEN) references BACSY (MA_BS)
            on update cascade on delete set null
)
    charset = latin1;

create index MA_BN
    on BENHANNOITRU (MA_BN);

create index MA_BS
    on BENHANNOITRU (MA_BS);

create index MA_KHOA
    on BENHANNOITRU (MA_KHOA);

create table KBNOITRU
(
    MA_KHAM varchar(20) not null,
    MA_BN   varchar(20) not null,
    MA_BS   varchar(20) not null,
    primary key (MA_KHAM, MA_BN, MA_BS),
    constraint KBNOITRU_ibfk_1
        foreign key (MA_KHAM) references KHAMBENH (MA_KHAM)
            on update cascade on delete cascade,
    constraint KBNOITRU_ibfk_2
        foreign key (MA_BN) references NOITRU (MA_BN)
            on update cascade on delete cascade,
    constraint KBNOITRU_ibfk_3
        foreign key (MA_BS) references BACSY (MA_BS)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_BN
    on KBNOITRU (MA_BN);

create index MA_BS
    on KBNOITRU (MA_BS);

create table PHIM
(
    MA_PHIM        varchar(20)               not null,
    MA_KHAM        varchar(20)               not null,
    LOAI_PHIM      varchar(20) charset utf8  null,
    THOI_GIAN_CHUP datetime                  not null,
    MA_BS          varchar(20)               not null,
    NHAN_XET       varchar(100) charset utf8 null,
    primary key (MA_PHIM, MA_KHAM),
    constraint FK_BS_PHIM
        foreign key (MA_BS) references BACSY (MA_BS)
            on update cascade on delete cascade,
    constraint PHIM_ibfk_1
        foreign key (MA_KHAM) references KHAMBENH (MA_KHAM)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_KHAM
    on PHIM (MA_KHAM);

create table TGLAMVIEC
(
    MA_NV         varchar(20) not null,
    CA_LAM_VIEC   int         not null,
    NGAY_LAM_VIEC date        not null,
    primary key (MA_NV, CA_LAM_VIEC, NGAY_LAM_VIEC),
    constraint TGLAMVIEC_ibfk_1
        foreign key (MA_NV) references NHANVIEN (MA_NV)
            on update cascade on delete cascade
)
    charset = latin1;

create table THUOC
(
    MA_THUOC   varchar(20)              not null
        primary key,
    TEN_THUOC  varchar(30) charset utf8 null,
    LOAI_THUOC varchar(30) charset utf8 null
)
    charset = latin1;

create table CHEDOTHUOC
(
    MA_CHANDOAN    varchar(20) not null,
    MA_BENH        varchar(20) not null,
    MA_KHAM        varchar(20) not null,
    MA_THUOC       varchar(20) not null,
    LIEU_DUNG      int         not null,
    THOI_GIAN_DUNG datetime    not null,
    primary key (MA_CHANDOAN, MA_BENH, MA_KHAM, MA_THUOC, LIEU_DUNG, THOI_GIAN_DUNG),
    constraint CHEDOTHUOC_ibfk_1
        foreign key (MA_CHANDOAN, MA_BENH, MA_KHAM) references KQCHANDOAN (MA_CHANDOAN, MA_BENH, MA_KHAM)
            on update cascade on delete cascade,
    constraint CHEDOTHUOC_ibfk_2
        foreign key (MA_THUOC) references THUOC (MA_THUOC)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_THUOC
    on CHEDOTHUOC (MA_THUOC);

create table TRIEUCHUNG
(
    TENTRIEUCHUNG varchar(30) charset utf8 not null,
    MO_TA         varchar(50) charset utf8 not null,
    MUC_DO        varchar(20) charset utf8 not null,
    MA_CHANDOAN   varchar(20)              not null,
    MA_BENH       varchar(20)              not null,
    MA_KHAM       varchar(20)              not null,
    primary key (TENTRIEUCHUNG, MO_TA, MUC_DO, MA_CHANDOAN, MA_BENH, MA_KHAM),
    constraint TRIEUCHUNG_ibfk_1
        foreign key (MA_CHANDOAN, MA_BENH, MA_KHAM) references KQCHANDOAN (MA_CHANDOAN, MA_BENH, MA_KHAM)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_CHANDOAN
    on TRIEUCHUNG (MA_CHANDOAN, MA_BENH, MA_KHAM);

create table XN
(
    MA_XN      varchar(20)               not null,
    MA_KHAM    varchar(20)               not null,
    THOIGIANXN datetime                  not null,
    TEN_XN     varchar(20) charset utf8  null,
    NHAN_XET   varchar(100) charset utf8 null,
    primary key (MA_XN, MA_KHAM),
    constraint XN_ibfk_1
        foreign key (MA_KHAM) references KHAMBENH (MA_KHAM)
            on update cascade on delete cascade
)
    charset = latin1;

create table CHISO
(
    MA_CHISO   varchar(20) not null,
    MA_XN      varchar(20) not null,
    MA_KHAM    varchar(20) not null,
    GIA_TRI    double      null,
    KET_QUA    varchar(10) null,
    MA_CHISOXN varchar(20) not null,
    primary key (MA_CHISO, MA_XN, MA_KHAM),
    constraint CHISO_ibfk_1
        foreign key (MA_XN, MA_KHAM) references XN (MA_XN, MA_KHAM)
            on update cascade on delete cascade,
    constraint FK_CHISO
        foreign key (MA_CHISOXN) references CHISOXN (MA_CHISOXN)
            on update cascade on delete cascade
)
    charset = latin1;

create index MA_XN
    on CHISO (MA_XN, MA_KHAM);

create definer = longhuynh@localhost trigger TRIGGER_INSERT_CHISO
    before insert
    on CHISO
    for each row
BEGIN
    DECLARE UPPER DOUBLE DEFAULT 0;
    DECLARE LOWER DOUBLE DEFAULT 0;

    IF (NEW.GIA_TRI IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phai co gia tri!';
    END IF;

    IF (NEW.MA_CHISOXN IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Can co id chi so!';
    ELSE
        IF NOT EXISTS(SELECT * FROM CHISOXN X WHERE X.MA_CHISOXN = NEW.MA_CHISOXN) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chi so khong ton tai!';
        END IF;

        SELECT IFNULL(X.UPPERBOUND, 0), IFNULL(X.LOWERBOUND, 0)
        INTO UPPER, LOWER
        FROM CHISOXN X
        WHERE X.MA_CHISOXN = NEW.MA_CHISOXN;

        IF (UPPER >= NEW.GIA_TRI AND NEW.GIA_TRI >= LOWER) THEN
            SET NEW.KET_QUA = 'binhthuong';
        ELSE
            SET NEW.KET_QUA = 'batthuong';
        END IF;
    END IF;
END;

create definer = longhuynh@localhost trigger TRIGGER_UPDATE_CHISO
    before update
    on CHISO
    for each row
BEGIN
    DECLARE UPPER DOUBLE DEFAULT 0;
    DECLARE LOWER DOUBLE DEFAULT 0;
    DECLARE STRI VARCHAR(100);

    IF (NEW.MA_CHISOXN IS NULL) THEN
        SELECT IFNULL(X.UPPERBOUND, 0), IFNULL(X.LOWERBOUND, 0)
        INTO UPPER, LOWER
        FROM CHISOXN X
        WHERE X.MA_CHISOXN = OLD.MA_CHISOXN;
    ELSE
        IF NOT EXISTS(SELECT * FROM CHISOXN X WHERE X.MA_CHISOXN = NEW.MA_CHISOXN) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Chi so moi khong ton tai!';
        END IF;

        SELECT IFNULL(X.UPPERBOUND, 0), IFNULL(X.LOWERBOUND, 0)
        INTO UPPER, LOWER
        FROM CHISOXN X
        WHERE X.MA_CHISOXN = NEW.MA_CHISOXN;
    END IF;

    IF (NEW.GIA_TRI IS NULL) THEN
        IF (UPPER >= OLD.GIA_TRI AND OLD.GIA_TRI >= LOWER) THEN
            SET NEW.KET_QUA = 'binhthuong';
        ELSE
            SET NEW.KET_QUA = 'batthuong';
        END IF;
    ELSE
        IF (UPPER >= NEW.GIA_TRI AND NEW.GIA_TRI >= LOWER) THEN
            SET NEW.KET_QUA = 'binhthuong';
        ELSE
            SET NEW.KET_QUA = 'batthuong';
        END IF;
    END IF;
END;

create index MA_KHAM
    on XN (MA_KHAM);

create definer = longhuynh@localhost view CACMAKHAMBENH as
select distinct `B`.`MA_BN`                            AS `MA_BN`,
                `HOSPITAL`.`KHAMBENH`.`MA_KHAM`        AS `MA_KHAM`,
                `B`.`HOVATEN`                          AS `HOVATEN`,
                `HOSPITAL`.`KHAMBENH`.`THOI_GIAN_KHAM` AS `THOI_GIAN_KHAM`
from (`HOSPITAL`.`KHAMBENH`
         join ((select `HOSPITAL`.`KBNOITRU`.`MA_KHAM` AS `MA_KHAM`,
                       `HOSPITAL`.`KBNOITRU`.`MA_BN`   AS `MA_BN`,
                       concat(`N`.`HO`, `N`.`TEN`)     AS `HOVATEN`
                from ((`HOSPITAL`.`KBNOITRU` join `HOSPITAL`.`BACSY` `B2` on ((`HOSPITAL`.`KBNOITRU`.`MA_BS` = `B2`.`MA_BS`)))
                         join `HOSPITAL`.`NHANVIEN` `N` on ((`B2`.`MA_BS` = `N`.`MA_NV`))))
               union
               (select `HOSPITAL`.`KBNGOAITRU`.`MA_KHAM` AS `MA_KHAM`,
                       `HOSPITAL`.`KBNGOAITRU`.`MA_BN`   AS `MA_BN`,
                       concat(`N`.`HO`, `N`.`TEN`)       AS `HOVATEN`
                from ((`HOSPITAL`.`KBNGOAITRU` join `HOSPITAL`.`BACSY` `B2` on ((`HOSPITAL`.`KBNGOAITRU`.`MA_BS` = `B2`.`MA_BS`)))
                         join `HOSPITAL`.`NHANVIEN` `N` on ((`B2`.`MA_BS` = `N`.`MA_NV`))))) `B`
              on ((`HOSPITAL`.`KHAMBENH`.`MA_KHAM` = `B`.`MA_KHAM`)))
order by `HOSPITAL`.`KHAMBENH`.`THOI_GIAN_KHAM` desc;

create definer = longhuynh@localhost view DANHSACHKHAMBENH as
select `B`.`MA_BN`                            AS `MA_BN`,
       `HOSPITAL`.`KHAMBENH`.`MA_KHAM`        AS `MA_KHAM`,
       `B`.`HOVATEN`                          AS `HOVATEN`,
       `HOSPITAL`.`KHAMBENH`.`THOI_GIAN_KHAM` AS `THOI_GIAN_KHAM`
from (`HOSPITAL`.`KHAMBENH`
         join ((select `HOSPITAL`.`KBNOITRU`.`MA_KHAM` AS `MA_KHAM`,
                       `HOSPITAL`.`KBNOITRU`.`MA_BN`   AS `MA_BN`,
                       concat(`N`.`HO`, `N`.`TEN`)     AS `HOVATEN`
                from ((`HOSPITAL`.`KBNOITRU` join `HOSPITAL`.`BACSY` `B2` on ((`HOSPITAL`.`KBNOITRU`.`MA_BS` = `B2`.`MA_BS`)))
                         join `HOSPITAL`.`NHANVIEN` `N` on ((`B2`.`MA_BS` = `N`.`MA_NV`))))
               union
               (select `HOSPITAL`.`KBNGOAITRU`.`MA_KHAM` AS `MA_KHAM`,
                       `HOSPITAL`.`KBNGOAITRU`.`MA_BN`   AS `MA_BN`,
                       concat(`N`.`HO`, `N`.`TEN`)       AS `HOVATEN`
                from ((`HOSPITAL`.`KBNGOAITRU` join `HOSPITAL`.`BACSY` `B2` on ((`HOSPITAL`.`KBNGOAITRU`.`MA_BS` = `B2`.`MA_BS`)))
                         join `HOSPITAL`.`NHANVIEN` `N` on ((`B2`.`MA_BS` = `N`.`MA_NV`))))) `B`
              on ((`HOSPITAL`.`KHAMBENH`.`MA_KHAM` = `B`.`MA_KHAM`)))
order by `B`.`MA_BN`, `HOSPITAL`.`KHAMBENH`.`THOI_GIAN_KHAM` desc;

create definer = longhuynh@localhost view KET_QUA_XET_NGHIEM as
select `KB`.`MA_BN`                 AS `MA_BN`,
       `KB`.`MA_BS`                 AS `MA_BS`,
       `HOSPITAL`.`XN`.`MA_XN`      AS `MA_XN`,
       `HOSPITAL`.`XN`.`THOIGIANXN` AS `THOIGIANXN`,
       `CS`.`GIA_TRI`               AS `GIA_TRI`,
       `C`.`MA_BENH`                AS `MA_BENH`,
       if(((`CS`.`GIA_TRI` > `CXN`.`UPPERBOUND`) or (`CS`.`GIA_TRI` < `CXN`.`LOWERBOUND`)), 'bat thuong',
          'binh thuong')            AS `DANH_GIA`
from ((((((`HOSPITAL`.`KHAM_BENH_NOI_NGOAI` `KB` join `HOSPITAL`.`BENHNHAN` `B` on ((`B`.`MA_BN` = `KB`.`MA_BN`))) join `HOSPITAL`.`KHAMBENH` `K` on ((`K`.`MA_KHAM` = `KB`.`MA_KHAM`))) join `HOSPITAL`.`KQCHANDOAN` `C` on ((`K`.`MA_KHAM` = `C`.`MA_KHAM`))) join `HOSPITAL`.`XN` on ((`HOSPITAL`.`XN`.`MA_KHAM` = `KB`.`MA_KHAM`))) join `HOSPITAL`.`CHISO` `CS` on ((`CS`.`MA_XN` = `HOSPITAL`.`XN`.`MA_XN`)))
         join `HOSPITAL`.`CHISOXN` `CXN` on ((`CXN`.`MA_CHISOXN` = `CS`.`MA_CHISOXN`)));

create definer = longhuynh@localhost view KHAMBENHGANNHAT as
select `O`.`MA_BN`          AS `MA_BN`,
       `O`.`MA_KHAM`        AS `MA_KHAM`,
       `O`.`HOVATEN`        AS `HOVATEN`,
       `O`.`THOI_GIAN_KHAM` AS `THOI_GIAN_KHAM`
from (`HOSPITAL`.`DANHSACHKHAMBENH` `O`
         left join `HOSPITAL`.`DANHSACHKHAMBENH` `B`
                   on (((`O`.`MA_BN` = `B`.`MA_BN`) and (`O`.`THOI_GIAN_KHAM` < `B`.`THOI_GIAN_KHAM`))))
where isnull(`B`.`THOI_GIAN_KHAM`);

create definer = longhuynh@localhost view KHAMNGOAI as
select `K`.`MA_KHAM`        AS `MA_KHAM`,
       `K`.`CA_KHAM`        AS `CA_KHAM`,
       `K`.`THOI_GIAN_KHAM` AS `THOI_GIAN_KHAM`,
       `K2`.`TEN_KHOA`      AS `TEN_KHOA`,
       `B3`.`MA_BN`         AS `MA_BN`,
       `B3`.`HO`            AS `HO`,
       `B3`.`TEN`           AS `TEN`,
       `B3`.`TUOI`          AS `TUOI`,
       `B3`.`DAN_TOC`       AS `DAN_TOC`,
       `B3`.`NGHE_NGHIEP`   AS `NGHE_NGHIEP`,
       `B3`.`BHYT`          AS `BHYT`
from (((((`HOSPITAL`.`KBNGOAITRU` join `HOSPITAL`.`KHAMBENH` `K` on ((`HOSPITAL`.`KBNGOAITRU`.`MA_KHAM` = `K`.`MA_KHAM`))) join `HOSPITAL`.`BACSY` `B` on ((`B`.`MA_BS` = `HOSPITAL`.`KBNGOAITRU`.`MA_BS`))) join `HOSPITAL`.`NHANVIEN` `N` on ((`B`.`MA_BS` = `N`.`MA_NV`))) join `HOSPITAL`.`KHOADIEUTRI` `K2` on ((`N`.`MA_KHOA` = `K2`.`MA_KHOA`)))
         join `HOSPITAL`.`BENHNHAN` `B3` on ((`HOSPITAL`.`KBNGOAITRU`.`MA_BN` = `B3`.`MA_BN`)));

create definer = longhuynh@localhost view KHAMNOI as
select `K`.`MA_KHAM`        AS `MA_KHAM`,
       `K`.`CA_KHAM`        AS `CA_KHAM`,
       `K`.`THOI_GIAN_KHAM` AS `THOI_GIAN_KHAM`,
       `K2`.`TEN_KHOA`      AS `TEN_KHOA`,
       `B2`.`MA_BN`         AS `MA_BN`,
       `B2`.`HO`            AS `HO`,
       `B2`.`TEN`           AS `TEN`,
       `B2`.`TUOI`          AS `TUOI`,
       `B2`.`DAN_TOC`       AS `DAN_TOC`,
       `B2`.`NGHE_NGHIEP`   AS `NGHE_NGHIEP`,
       `B2`.`BHYT`          AS `BHYT`
from (((((`HOSPITAL`.`KBNOITRU` join `HOSPITAL`.`KHAMBENH` `K` on ((`HOSPITAL`.`KBNOITRU`.`MA_KHAM` = `K`.`MA_KHAM`))) join `HOSPITAL`.`BACSY` `B` on ((`B`.`MA_BS` = `HOSPITAL`.`KBNOITRU`.`MA_BS`))) join `HOSPITAL`.`NHANVIEN` `N` on ((`B`.`MA_BS` = `N`.`MA_NV`))) join `HOSPITAL`.`KHOADIEUTRI` `K2` on ((`N`.`MA_KHOA` = `K2`.`MA_KHOA`)))
         join `HOSPITAL`.`BENHNHAN` `B2` on ((`HOSPITAL`.`KBNOITRU`.`MA_BN` = `B2`.`MA_BN`)));

create definer = longhuynh@localhost view KHAM_BENH_NOI_NGOAI as
select `K`.`MA_KHAM` AS `MA_KHAM`, `K`.`MA_BN` AS `MA_BN`, `K`.`MA_BS` AS `MA_BS`
from (select `HOSPITAL`.`KBNGOAITRU`.`MA_KHAM` AS `MA_KHAM`,
             `HOSPITAL`.`KBNGOAITRU`.`MA_BN`   AS `MA_BN`,
             `HOSPITAL`.`KBNGOAITRU`.`MA_BS`   AS `MA_BS`
      from `HOSPITAL`.`KBNGOAITRU`
      union
      select `HOSPITAL`.`KBNOITRU`.`MA_KHAM` AS `MA_KHAM`,
             `HOSPITAL`.`KBNOITRU`.`MA_BN`   AS `MA_BN`,
             `HOSPITAL`.`KBNOITRU`.`MA_BS`   AS `MA_BS`
      from `HOSPITAL`.`KBNOITRU`) `K`;

create definer = longhuynh@localhost view NGOAIXN as
select `HOSPITAL`.`XN`.`MA_XN` AS `MA_XN`, `K3`.`TEN_KHOA` AS `TEN_KHOA`, `HOSPITAL`.`XN`.`THOIGIANXN` AS `THOIGIANXN`
from (((((`HOSPITAL`.`XN` join `HOSPITAL`.`KHAMBENH` `K` on ((`HOSPITAL`.`XN`.`MA_KHAM` = `K`.`MA_KHAM`))) join `HOSPITAL`.`KBNGOAITRU` `K2` on ((`K`.`MA_KHAM` = `K2`.`MA_KHAM`))) join `HOSPITAL`.`BACSY` `B` on ((`B`.`MA_BS` = `K2`.`MA_BS`))) join `HOSPITAL`.`NHANVIEN` `N` on ((`B`.`MA_BS` = `N`.`MA_NV`)))
         join `HOSPITAL`.`KHOADIEUTRI` `K3` on ((`N`.`MA_KHOA` = `K3`.`MA_KHOA`)));

create definer = longhuynh@localhost view NOIXN as
select `HOSPITAL`.`XN`.`MA_XN` AS `MA_XN`, `K3`.`TEN_KHOA` AS `TEN_KHOA`, `HOSPITAL`.`XN`.`THOIGIANXN` AS `THOIGIANXN`
from (((((`HOSPITAL`.`XN` join `HOSPITAL`.`KHAMBENH` `K` on ((`HOSPITAL`.`XN`.`MA_KHAM` = `K`.`MA_KHAM`))) join `HOSPITAL`.`KBNOITRU` `K2` on ((`K`.`MA_KHAM` = `K2`.`MA_KHAM`))) join `HOSPITAL`.`BACSY` `B` on ((`B`.`MA_BS` = `K2`.`MA_BS`))) join `HOSPITAL`.`NHANVIEN` `N` on ((`B`.`MA_BS` = `N`.`MA_NV`)))
         join `HOSPITAL`.`KHOADIEUTRI` `K3` on ((`N`.`MA_KHOA` = `K3`.`MA_KHOA`)));

create
    definer = longhuynh@localhost procedure BACSI_INFO(IN MABS_IN varchar(20))
BEGIN
    select MA_BS, concat(HO, ' ', TEN) as TEN, TEN_KHOA, CHUYEN_KHOA, LUONG, CA_LAM_VIEC, EXPYEAR
    from BACSY
             join NHANVIEN N
                  on N.MA_NV = BACSY.MA_BS
             join KHOADIEUTRI K on K.MA_KHOA = N.MA_KHOA
    where MA_BS = MABS_IN;
END;

create
    definer = longhuynh@localhost procedure BENHNHAN_CAPNHAT(IN MABN_IN varchar(20), IN HO_IN varchar(20),
                                                             IN TEN_IN varchar(20), IN TUOI_IN int,
                                                             IN DAN_TOC_IN varchar(20), IN NGHE_NGHIEP_IN varchar(30),
                                                             IN MATHE_IN varchar(20), IN THOI_HAN_IN date,
                                                             IN NOI_DANG_KY_IN varchar(30))
BEGIN
    DECLARE X VARCHAR(20);
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat cap nhat!';
        END;

    START TRANSACTION;

    SET X = (SELECT BHYT FROM BENHNHAN WHERE MA_BN = MABN_IN);

    IF (X IS NULL) THEN
        IF (MATHE_IN IS NOT NULL) THEN
            INSERT INTO BHYT (MA_THE, THOI_HAN, NOI_DANG_KY)
            VALUES (MATHE_IN, THOI_HAN_IN, NOI_DANG_KY_IN);
        END IF;
    ELSE
        IF (MATHE_IN IS NULL) THEN
            DELETE FROM BHYT WHERE MA_THE = X;
        ELSE
            UPDATE BHYT B
            SET B.MA_THE      = MATHE_IN,
                B.THOI_HAN    = THOI_HAN_IN,
                B.NOI_DANG_KY = NOI_DANG_KY_IN
            WHERE B.MA_THE = X;
        END IF;
    END IF;

    -- 	IF (MATHE IS NOT NULL) THEN
-- 		IF NOT EXISTS (SELECT * FROM BHYT WHERE MA_THE = MATHE) THEN
-- 			INSERT INTO BHYT (MA_THE, THOI_HAN, NOI_DANG_KY)
-- 			VALUES (MATHE, THOI_HAN, NOI_DANG_KY);

-- 		ELSEIF (SELECT MA_THE FROM BHYT WHERE BN = MABN) != MATHE THEN
-- 			DELETE FROM BHYT B WHERE B.BN = MABN;

-- 			INSERT INTO BHYT (MA_THE, THOI_HAN, NOI_DANG_KY, BN)
-- 			VALUES (MATHE, THOI_HAN, NOI_DANG_KY, MABN);
-- 		ELSE
-- 			UPDATE BHYT B
-- 			SET B.MA_THE      = MA_THE,
-- 				B.THOI_HAN    = THOI_HAN,
-- 				B.NOI_DANG_KY = NOI_DANG_KY
-- 			WHERE B.BN = MABN;
-- 		END IF;
--     END IF;

    -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'GOES HERE';
    UPDATE BENHNHAN B
    SET B.HO          = HO_IN,
        B.TEN         = TEN_IN,
        B.TUOI        = TUOI_IN,
        B.DAN_TOC     = DAN_TOC_IN,
        B.NGHE_NGHIEP = NGHE_NGHIEP_IN,
        B.BHYT        = MATHE_IN
    WHERE MA_BN = MABN_IN;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure BENHNHAN_DANGKY(IN MABN_IN varchar(20), IN HO_IN varchar(20),
                                                            IN TEN_IN varchar(20), IN TUOI_IN int,
                                                            IN DAN_TOC_IN varchar(20), IN NGHE_NGHIEP_IN varchar(30),
                                                            IN MATHE_IN varchar(20), IN THOI_HAN_IN date,
                                                            IN NOI_DANG_KY_IN varchar(30))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat dang ky!';
        END;

    START TRANSACTION;

    IF (MATHE_IN IS NOT NULL) THEN
        INSERT INTO BHYT (MA_THE, THOI_HAN, NOI_DANG_KY)
        VALUES (MATHE_IN, THOI_HAN_IN, NOI_DANG_KY_IN)
        ON DUPLICATE KEY UPDATE BHYT.THOI_HAN    = THOI_HAN_IN,
                                BHYT.NOI_DANG_KY = NOI_DANG_KY_IN;
    END IF;

    INSERT INTO BENHNHAN (MA_BN, HO, TEN, TUOI, DAN_TOC, NGHE_NGHIEP, BHYT)
    VALUES (MABN_IN, HO_IN, TEN_IN, TUOI_IN, DAN_TOC_IN, NGHE_NGHIEP_IN, MATHE_IN);
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure BN1(IN MABN varchar(20), IN HO varchar(20), IN TEN varchar(20), IN TUOI int,
                                                IN DAN_TOC varchar(20), IN NGHE_NGHIEP varchar(30),
                                                IN MA_THE varchar(20), IN THOI_HAN date, IN NOI_DANG_KY varchar(30))
BEGIN
    UPDATE BENHNHAN B
    SET B.HO          = IFNULL(NULL, HO),
        B.TEN         = IFNULL(NULL, TEN),
        B.TUOI        = IFNULL(NULL, TUOI),
        B.DAN_TOC     = IFNULL(NULL, DAN_TOC),
        B.NGHE_NGHIEP = IFNULL(NULL, NGHE_NGHIEP)
    WHERE MA_BN = MABN;

    UPDATE BHYT B
    SET B.MA_THE      = MA_THE,
        B.THOI_HAN    = IFNULL(NULL, THOI_HAN),
        B.NOI_DANG_KY = IFNULL(NULL, NOI_DANG_KY)
    WHERE B.BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BN10(IN MABN varchar(20))
BEGIN
    SELECT DINHDUONG.MA_KHAM, C.NOI_DUNG, C.HUONG_DAN, DINHDUONG.CHI_DINH, DINHDUONG.GHI_CHU
    FROM DINHDUONG
             JOIN CDDD C on C.MA_CDDD = DINHDUONG.MA_CDDD
             JOIN KQCHANDOAN K on DINHDUONG.MA_CHANDOAN = K.MA_CHANDOAN and DINHDUONG.MA_BENH = K.MA_BENH and
                                  DINHDUONG.MA_KHAM = K.MA_KHAM
             JOIN CACMAKHAMBENH K2 on DINHDUONG.MA_KHAM = K2.MA_KHAM AND MA_BN = MABN
    order by K2.THOI_GIAN_KHAM desc;
END;

create
    definer = longhuynh@localhost procedure BN1_BAOHIEM(IN MABN varchar(20), IN MA_THE varchar(20), IN THOI_HAN date,
                                                        IN NOI_DANG_KY varchar(30))
BEGIN
    UPDATE BHYT B
    SET B.MA_THE      = MA_THE,
        B.THOI_HAN    = IFNULL(NULL, THOI_HAN),
        B.NOI_DANG_KY = IFNULL(NULL, NOI_DANG_KY)
    WHERE B.MA_THE in (select BHYT from BENHNHAN where MA_BN = MABN);
END;

create
    definer = longhuynh@localhost procedure BN1_NHANKHAU(IN MABN varchar(20), IN HO varchar(20), IN TEN varchar(20),
                                                         IN TUOI int, IN DAN_TOC varchar(20),
                                                         IN NGHE_NGHIEP varchar(30))
BEGIN
    UPDATE BENHNHAN B
    SET B.HO          = IFNULL(NULL, HO),
        B.TEN         = IFNULL(NULL, TEN),
        B.TUOI        = IFNULL(NULL, TUOI),
        B.DAN_TOC     = IFNULL(NULL, DAN_TOC),
        B.NGHE_NGHIEP = IFNULL(NULL, NGHE_NGHIEP)
    WHERE MA_BN = MABN;

    #     UPDATE BHYT B
#     SET B.MA_THE      = MA_THE,
#         B.THOI_HAN    = IFNULL(NULL, THOI_HAN),
#         B.NOI_DANG_KY = IFNULL(NULL, NOI_DANG_KY)
#     WHERE B.BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BN2(IN MABN varchar(20))
BEGIN
    SELECT *
    FROM CHEDOTHUOC
             JOIN KQCHANDOAN K on CHEDOTHUOC.MA_CHANDOAN = K.MA_CHANDOAN and CHEDOTHUOC.MA_BENH = K.MA_BENH and
                                  CHEDOTHUOC.MA_KHAM = K.MA_KHAM
             JOIN THUOC T on CHEDOTHUOC.MA_THUOC = T.MA_THUOC
             JOIN KHAMBENHGANNHAT K2 on CHEDOTHUOC.MA_KHAM = K2.MA_KHAM AND K2.MA_BN = MABN
    LIMIT 1;
END;

create
    definer = longhuynh@localhost procedure BN3(IN MABN varchar(20))
BEGIN

    SELECT CHEDOTHUOC.MA_KHAM, T.TEN_THUOC, CHEDOTHUOC.LIEU_DUNG, CHEDOTHUOC.THOI_GIAN_DUNG
    FROM CHEDOTHUOC
             JOIN KQCHANDOAN K on CHEDOTHUOC.MA_CHANDOAN = K.MA_CHANDOAN and CHEDOTHUOC.MA_BENH = K.MA_BENH and
                                  CHEDOTHUOC.MA_KHAM = K.MA_KHAM
             JOIN THUOC T on CHEDOTHUOC.MA_THUOC = T.MA_THUOC
             JOIN CACMAKHAMBENH K2 on CHEDOTHUOC.MA_KHAM = K2.MA_KHAM AND K2.MA_BN = MABN
    order by K2.THOI_GIAN_KHAM desc;
END;

create
    definer = longhuynh@localhost procedure BN4(IN MABN varchar(20))
BEGIN
    SELECT GIA_TRI
    FROM CHISO
             JOIN XN X on CHISO.MA_XN = X.MA_XN and CHISO.MA_KHAM = X.MA_KHAM
             JOIN KHAMBENHGANNHAT K on CHISO.MA_KHAM = K.MA_KHAM AND K.MA_BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BN5(IN MABN varchar(20))
BEGIN
    SELECT C.MA_KHAM, XN.MA_XN, XN.TEN_XN, XN.THOIGIANXN, XN.NHAN_XET
    FROM XN
             JOIN CACMAKHAMBENH C on XN.MA_KHAM = C.MA_KHAM AND MA_BN = MABN
    order by XN.THOIGIANXN desc;
END;

create
    definer = longhuynh@localhost procedure BN6(IN MABN varchar(20))
BEGIN
    SELECT GHI_CHU
    FROM CHISO
             JOIN CACMAKHAMBENH C on CHISO.MA_KHAM = C.MA_KHAM AND MA_BN = MABN
    WHERE GHI_CHU = 'BAT THUONG';
END;

create
    definer = longhuynh@localhost procedure BN7(IN MABN varchar(20))
BEGIN
    SELECT HOVATEN
    FROM KHAMBENHGANNHAT
    WHERE MA_BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BN8(IN MABN varchar(20))
BEGIN
    SELECT *
    FROM CACMAKHAMBENH
    WHERE MA_BN = MABN
    order by THOI_GIAN_KHAM desc;
END;

create
    definer = longhuynh@localhost procedure BN9(IN MABN varchar(20))
BEGIN
    SELECT C.NOI_DUNG
    FROM DINHDUONG
             JOIN CDDD C on C.MA_CDDD = DINHDUONG.MA_CDDD
             JOIN KQCHANDOAN K on DINHDUONG.MA_CHANDOAN = K.MA_CHANDOAN and DINHDUONG.MA_BENH = K.MA_BENH and
                                  DINHDUONG.MA_KHAM = K.MA_KHAM
             JOIN KHAMBENHGANNHAT K2 on DINHDUONG.MA_KHAM = K2.MA_KHAM AND MA_BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BN_BAOHIEM_INFO(IN MABN varchar(20))
BEGIN
    select MA_THE, THOI_HAN, NOI_DANG_KY
    from BHYT
             join BENHNHAN B on B.BHYT = BHYT.MA_THE
    where B.MA_BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BN_NHANKHAU_INFO(IN MABN varchar(20))
BEGIN
    select MA_BN, concat(HO, ' ', TEN) as TEN, TUOI, DAN_TOC, NGHE_NGHIEP
    from BENHNHAN
    where MA_BN = MABN;
END;

create
    definer = longhuynh@localhost procedure BS1(IN MAKHAM varchar(20), IN TGKHAM datetime, IN CAKHAM int,
                                                IN MABN varchar(20), IN MABS varchar(20))
BEGIN
    INSERT INTO KHAMBENH (MA_KHAM, THOI_GIAN_KHAM, CA_KHAM)
    VALUES (MAKHAM, TGKHAM, CAKHAM)
    ON DUPLICATE KEY UPDATE THOI_GIAN_KHAM = TGKHAM,
                            CA_KHAM        = CAKHAM;

    INSERT INTO KBNGOAITRU (MA_KHAM, MA_BS, MA_BN)
    SELECT *
    FROM (SELECT MAKHAM, MABS, MABN) AS TMP
    WHERE NOT EXISTS(SELECT MA_KHAM FROM KBNGOAITRU WHERE MA_KHAM = MAKHAM);
END;

create
    definer = longhuynh@localhost procedure BS10(IN MABS varchar(20))
BEGIN
    SELECT *
    FROM BENHNHAN
    WHERE MA_BN IN (SELECT MA_BN
                    FROM BACSY B
                             JOIN BENHANNOITRU A ON B.MA_BS = A.MA_BS
                    WHERE TG_XV IS NOT NULL
                      AND A.MA_BS = MABS);
END;

create
    definer = longhuynh@localhost procedure BS2(IN MAKHAM varchar(20), IN TGKHAM datetime, IN CAKHAM int,
                                                IN MABN varchar(20), IN MABS varchar(20))
BEGIN
    INSERT INTO KHAMBENH (MA_KHAM, THOI_GIAN_KHAM, CA_KHAM)
    VALUES (MAKHAM, TGKHAM, CAKHAM)
    ON DUPLICATE KEY UPDATE THOI_GIAN_KHAM = TGKHAM,
                            CA_KHAM        = CAKHAM;

    INSERT INTO KBNOITRU (MA_KHAM, MA_BS, MA_BN)
    SELECT *
    FROM (SELECT MAKHAM, MABS, MABN) AS TMP
    WHERE NOT EXISTS(SELECT MA_KHAM FROM KBNOITRU WHERE MA_KHAM = MAKHAM);
END;

create
    definer = longhuynh@localhost procedure BS3(IN NGAYKHAM date, IN MABS varchar(20))
BEGIN
    SELECT *
    FROM BENHNHAN
             join KHAM_BENH_NOI_NGOAI KBNN on BENHNHAN.MA_BN = KBNN.MA_BN
             join KHAMBENH K on KBNN.MA_KHAM = K.MA_KHAM
    WHERE KBNN.MA_BS = MABS
      and BENHNHAN.MA_BN = KBNN.MA_BN
      and DATE(K.THOI_GIAN_KHAM) = NGAYKHAM;


    #               IN (SELECT T.MA_BN
#                              FROM KHAM_BENH_NOI_NGOAI AS T
#                                       JOIN KHAMBENH KB ON T.MA_KHAM = KB.MA_KHAM
#                              WHERE (T.MA_BS = MABS AND DATE(KB.THOI_GIAN_KHAM) = NGAYKHAM));
END;

create
    definer = longhuynh@localhost procedure BS4(IN MABN varchar(20), IN MABS varchar(20), IN MA_KHAM_IN varchar(20))
BEGIN
    SELECT *
    FROM KHAMBENH K
             JOIN KQCHANDOAN C ON K.MA_KHAM = C.MA_KHAM
    WHERE K.MA_KHAM IN (SELECT T.MA_KHAM
                        FROM KHAM_BENH_NOI_NGOAI T
                        WHERE T.MA_BN = MABN
                          AND T.MA_BS = MABS)
      and K.MA_KHAM = MA_KHAM_IN;
END;

create
    definer = longhuynh@localhost procedure BS5(IN MABN varchar(20), IN MABS varchar(20), IN MA_KHAM_IN varchar(20))
BEGIN
    SELECT K.MA_KHAM, TEN_THUOC, THOI_GIAN_DUNG
    FROM THUOC T
             JOIN CHEDOTHUOC C ON T.MA_THUOC = C.MA_THUOC
             JOIN KQCHANDOAN KQ ON KQ.MA_CHANDOAN = C.MA_CHANDOAN
             JOIN KHAMBENH K ON KQ.MA_KHAM = K.MA_KHAM
    WHERE K.MA_KHAM IN (SELECT T.MA_KHAM
                        FROM KHAM_BENH_NOI_NGOAI T
                        WHERE T.MA_BN = MABN
                          AND T.MA_BS = MABS)
      and K.MA_KHAM = MA_KHAM_IN;
END;

create
    definer = longhuynh@localhost procedure BS6(IN MABN varchar(20), IN MABS varchar(20), IN MA_KHAM_IN varchar(20))
BEGIN
    SELECT XN.MA_KHAM, XN.MA_XN, XN.TEN_XN, THOIGIANXN, NHAN_XET
    FROM XN
             JOIN KHAMBENH K ON XN.MA_KHAM = K.MA_KHAM
    WHERE K.MA_KHAM IN (SELECT T.MA_KHAM
                        FROM KBNOITRU T
                        WHERE T.MA_BN = MABN
                          AND T.MA_BS = MABS)
      and XN.MA_KHAM = MA_KHAM_IN;
END;

create
    definer = longhuynh@localhost procedure BS7(IN MABN varchar(20), IN MABS varchar(20), IN MA_KHAM_IN varchar(20))
BEGIN
    SELECT MA_PHIM, LOAI_PHIM, THOI_GIAN_CHUP, MA_BS, NHAN_XET
    FROM PHIM P
             JOIN KHAMBENH K ON P.MA_KHAM = K.MA_KHAM
    WHERE K.MA_KHAM IN (SELECT K.MA_KHAM
                        FROM KBNOITRU T
                        WHERE T.MA_BN = MABN
                          AND T.MA_BS = MABS)
      and P.MA_KHAM = MA_KHAM_IN;
END;

create
    definer = longhuynh@localhost procedure BS8(IN MABENH varchar(20), IN MABS varchar(20))
BEGIN
    SELECT MABENH, BENHNHAN.*
    FROM BENHNHAN
    WHERE MA_BN IN (SELECT T.MA_BN
                    FROM KHAM_BENH_NOI_NGOAI T
                             JOIN BENHNHAN B ON B.MA_BN = T.MA_BN
                             JOIN KHAMBENH K ON K.MA_KHAM = T.MA_KHAM
                             JOIN KQCHANDOAN C ON K.MA_KHAM = C.MA_KHAM
                    WHERE T.MA_BS = MABS
                      AND MA_BENH = MABENH);
END;

create
    definer = longhuynh@localhost procedure BS9(IN MABENH varchar(20), IN MABS varchar(20))
BEGIN
    SELECT MABENH, BENHNHAN.*
    FROM BENHNHAN
    WHERE MA_BN IN (SELECT MA_BN
                    FROM KET_QUA_XET_NGHIEM
                    WHERE MA_BENH = MABENH
                      AND MA_BS = MABS
                      AND DANH_GIA = "bat thuong");
END;

create
    definer = longhuynh@localhost procedure CAU1(IN CA int, IN NGAY date, IN KHOA varchar(30))
BEGIN
    SELECT BACSY.MA_BS, CONCAT(HO, TEN) AS HOVATEN, BACSY.CHUYEN_KHOA, BACSY.EXPYEAR
    FROM BACSY
             JOIN NHANVIEN N on BACSY.MA_BS = N.MA_NV
             JOIN TGLAMVIEC T on N.MA_NV = T.MA_NV
             JOIN KHOADIEUTRI K on N.MA_KHOA = K.MA_KHOA
    WHERE T.CA_LAM_VIEC = CA
      AND T.NGAY_LAM_VIEC = NGAY
      AND TEN_KHOA = KHOA;
end;

create
    definer = longhuynh@localhost procedure CAU10(IN CAKHAM int, IN THOIGIANKHAM date)
BEGIN
    (SELECT MA_KHAM, CA_KHAM, THOI_GIAN_KHAM, MA_BN, HO, TEN
     FROM KHAMNGOAI
     WHERE CA_KHAM = CAKHAM
       AND convert(THOI_GIAN_KHAM, date) = THOIGIANKHAM);
END;

create
    definer = longhuynh@localhost procedure CAU11(IN NGAYXN date, IN KHOA varchar(30))
BEGIN
    (SELECT * FROM NGOAIXN WHERE TEN_KHOA = KHOA AND convert(THOIGIANXN, date) = NGAYXN)
    UNION
    (SELECT * FROM NOIXN WHERE TEN_KHOA = KHOA AND convert(THOIGIANXN, date) = NGAYXN);
END;

create
    definer = longhuynh@localhost procedure CAU12(IN NGAYXN date)
BEGIN
        (SELECT * FROM NGOAIXN WHERE convert(THOIGIANXN, date) = NGAYXN)
        UNION
        (SELECT * FROM NOIXN WHERE convert(THOIGIANXN, date) = NGAYXN);
END;

create
    definer = longhuynh@localhost procedure CAU2(IN NGAYLAMVIEC date, IN KHOA varchar(30))
BEGIN
    SELECT BACSY.MA_BS, CONCAT(HO, TEN) AS HOVATEN, BACSY.CHUYEN_KHOA, BACSY.EXPYEAR
    FROM BACSY
             JOIN NHANVIEN N on BACSY.MA_BS = N.MA_NV
             JOIN TGLAMVIEC T on N.MA_NV = T.MA_NV
             JOIN KHOADIEUTRI K on N.MA_KHOA = K.MA_KHOA
    WHERE T.NGAY_LAM_VIEC = NGAYLAMVIEC
      AND TEN_KHOA = KHOA;
END;

create
    definer = longhuynh@localhost procedure CAU3(IN CALAMVIEC int, IN NGAY date)
BEGIN
    SELECT BACSY.MA_BS, CONCAT(HO, TEN) AS HOVATEN, BACSY.CHUYEN_KHOA, BACSY.EXPYEAR
    FROM BACSY
             JOIN NHANVIEN N on BACSY.MA_BS = N.MA_NV
             JOIN TGLAMVIEC T on N.MA_NV = T.MA_NV
    WHERE T.CA_LAM_VIEC = CALAMVIEC
      and T.NGAY_LAM_VIEC = NGAY;
END;

create
    definer = longhuynh@localhost procedure CAU4(IN NGAYLAMVIEC date)
BEGIN
    SELECT BACSY.MA_BS, CONCAT(HO, TEN) AS HOVATEN, BACSY.CHUYEN_KHOA, BACSY.EXPYEAR
    FROM BACSY
             JOIN NHANVIEN N on BACSY.MA_BS = N.MA_NV
             JOIN TGLAMVIEC T on N.MA_NV = T.MA_NV
    WHERE T.NGAY_LAM_VIEC = NGAYLAMVIEC;
END;

create
    definer = longhuynh@localhost procedure CAU5(IN CAKHAM int, IN THOIGIANKHAM date, IN KHOA varchar(30))
BEGIN
    (SELECT MA_KHAM, CA_KHAM, THOI_GIAN_KHAM, MA_BN, HO, TEN
     FROM KHAMNGOAI
     WHERE CA_KHAM = CAKHAM
       AND convert(THOI_GIAN_KHAM, date) = THOIGIANKHAM
       AND TEN_KHOA = KHOA)
    union
    (SELECT MA_KHAM, CA_KHAM, THOI_GIAN_KHAM, MA_BN, HO, TEN
     FROM KHAMNOI
     WHERE CA_KHAM = CAKHAM
       AND convert(THOI_GIAN_KHAM, date) = THOIGIANKHAM
       AND TEN_KHOA = KHOA);
END;

create
    definer = longhuynh@localhost procedure CAU6(IN CALAMVIEC int, IN _THOIGIANNHAPVIEN date, IN KHOA varchar(30))
BEGIN
    (SELECT MA_KHAM, CA_KHAM, THOI_GIAN_KHAM, MA_BN, HO, TEN
     FROM KHAMNOI
     WHERE CA_KHAM = CALAMVIEC
       AND convert(THOI_GIAN_KHAM, date) = _THOIGIANNHAPVIEN
       AND TEN_KHOA = KHOA);
END;

create
    definer = longhuynh@localhost procedure CAU7(IN CAKHAM int, IN THOIGIANKHAM date, IN KHOA varchar(30))
BEGIN
    (SELECT MA_KHAM, CA_KHAM, THOI_GIAN_KHAM, MA_BN, HO, TEN
     FROM KHAMNGOAI
     WHERE CA_KHAM = CAKHAM
       AND convert(THOI_GIAN_KHAM, date) = THOIGIANKHAM
       AND TEN_KHOA = KHOA);
END;

create
    definer = longhuynh@localhost procedure CAU9(IN CALAMVIEC int, IN _THOIGIANNHAPVIEN date)
BEGIN
    (SELECT MA_KHAM, CA_KHAM, THOI_GIAN_KHAM, MA_BN, HO, TEN
     FROM KHAMNOI
     WHERE CA_KHAM = CALAMVIEC
       AND convert(THOI_GIAN_KHAM, date) = _THOIGIANNHAPVIEN);
END;

create
    definer = longhuynh@localhost procedure CHECK_NOITRU(IN MABN varchar(20))
BEGIN
    select *
    from BENHNHAN
             join NOITRU N on BENHNHAN.MA_BN = N.MA_BN
    where N.MA_BN = MABN;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_BANT_NV(IN THOIGIANNHAPVIEN_IN datetime, IN MA_KHOA_IN varchar(20),
                                                             IN MA_BS_IN varchar(20), IN MA_BN_IN varchar(20),
                                                             IN SO_GIUONG_IN int, IN SO_BUONG_IN int)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    INSERT INTO BENHANNOITRU (THOIGIANNHAPVIEN, MA_KHOA, MA_BS, MA_BN, SO_GIUONG, SO_BUONG)
    VALUES (THOIGIANNHAPVIEN_IN, MA_KHOA_IN, MA_BS_IN, MA_BN_IN, SO_GIUONG_IN, SO_BUONG_IN)
    ON DUPLICATE KEY UPDATE BENHANNOITRU.SO_GIUONG = SO_GIUONG_IN,
                            BENHANNOITRU.SO_BUONG  = SO_BUONG_IN;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_BANT_XV(IN MA_KHOA_IN varchar(20), IN MA_BS_IN varchar(20),
                                                             IN MA_BN_IN varchar(20),
                                                             IN MABS_CHIDINH_XUATVIEN_IN varchar(20),
                                                             IN TG_XV_IN datetime, IN TINHTRANG_XV_IN varchar(100),
                                                             IN GHI_CHU_XV_IN varchar(50))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT *
                  FROM BENHANNOITRU B
                  WHERE B.MA_KHOA = MA_KHOA_IN
                    AND B.MA_BS = MA_BS_IN
                    AND B.MA_BN = MA_BN_IN) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong tim thay benh an!';
    ELSEIF (MABS_CHIDINH_XUATVIEN_IN IS NULL OR TG_XV_IN IS NULL) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Thieu ma bs xuat vien hoac thoi gian xuat vien!';
    ELSE
        UPDATE BENHANNOITRU B
        SET B.MABS_CHIDINH_XUATVIEN = MABS_CHIDINH_XUATVIEN_IN,
            B.TINHTRANG_XV          = TINHTRANG_XV_IN,
            B.TG_XV                 = TG_XV_IN,
            B.GHI_CHU_XV            = GHI_CHU_XV_IN
        WHERE B.MA_KHOA = MA_KHOA_IN
          AND B.MA_BS = MA_BS_IN
          AND B.MA_BN = MA_BN_IN;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_CDDD(IN MA_CHANDOAN_IN varchar(20), IN MA_BENH_IN varchar(20),
                                                          IN MA_KHAM_IN varchar(20), IN MA_CDDD_IN varchar(20),
                                                          IN CHI_DINH_IN varchar(100), IN GHI_CHU_IN varchar(50))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    INSERT INTO DINHDUONG
    VALUES (MA_CHANDOAN_IN, MA_BENH_IN, MA_KHAM_IN, MA_CDDD_IN, CHI_DINH_IN, GHI_CHU_IN)
    ON DUPLICATE KEY UPDATE DINHDUONG.CHI_DINH = CHI_DINH_IN,
                            DINHDUONG.GHI_CHU  = GHI_CHU_IN;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_CHISO(IN MA_CHISO_IN varchar(20), IN MA_XN_IN varchar(20),
                                                           IN MA_KHAM_IN varchar(20), IN GIA_TRI_IN double,
                                                           IN MA_CHISOXN_IN varchar(20))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF (MA_KHAM_IN IS NULL OR MA_XN_IN IS NULL) THEN
        UPDATE CHISO
        SET CHISO.GIA_TRI    = GIA_TRI_IN,
            CHISO.MA_CHISOXN = MA_CHISOXN_IN
        WHERE CHISO.MA_CHISO = MA_CHISO_IN;
    ELSE
        INSERT INTO CHISO (MA_CHISO, MA_XN, MA_KHAM, GIA_TRI, MA_CHISOXN)
        VALUES (MA_CHISO_IN, MA_XN_IN, MA_KHAM_IN, GIA_TRI_IN, MA_CHISOXN_IN)
        ON DUPLICATE KEY UPDATE CHISO.GIA_TRI    = GIA_TRI_IN,
                                CHISO.MA_CHISOXN = MA_CHISOXN_IN;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_KQCHANDOAN(IN MA_CHANDOAN_IN varchar(20),
                                                                IN MA_BENH_IN varchar(20), IN MA_KHAM_IN varchar(20),
                                                                IN NOI_DUNG_IN varchar(100), IN GHI_CHU_IN varchar(50))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF (MA_KHAM_IN IS NULL OR MA_BENH_IN IS NULL) THEN
        UPDATE KQCHANDOAN
        SET KQCHANDOAN.NOI_DUNG = NOI_DUNG_IN,
            KQCHANDOAN.GHI_CHU  = GHI_CHU_IN
        WHERE KQCHANDOAN.MA_CHANDOAN = MA_CHANDOAN_IN;
    ELSE
        INSERT INTO KQCHANDOAN
        VALUES (MA_CHANDOAN_IN, MA_BENH_IN, MA_KHAM_IN, NOI_DUNG_IN, GHI_CHU_IN)
        ON DUPLICATE KEY UPDATE KQCHANDOAN.NOI_DUNG = NOI_DUNG_IN,
                                KQCHANDOAN.GHI_CHU  = GHI_CHU_IN;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_PHIM(IN MA_PHIM_IN varchar(20), IN THOI_GIAN_CHUP_IN datetime,
                                                          IN MA_BS_IN varchar(20), IN MA_KHAM_IN varchar(20),
                                                          IN LOAI_PHIM_IN varchar(20), IN NHAN_XET_IN varchar(100))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF (MA_BS_IN IS NULL OR THOI_GIAN_CHUP_IN IS NULL OR MA_KHAM_IN IS NULL) THEN
        UPDATE PHIM P
        SET P.LOAI_PHIM = LOAI_PHIM_IN,
            P.NHAN_XET  = NHAN_XET_IN
        WHERE P.MA_PHIM = MA_PHIM_IN;
    ELSE
        INSERT INTO PHIM
        VALUES (MA_PHIM_IN, MA_KHAM_IN, LOAI_PHIM_IN, THOI_GIAN_CHUP_IN, MA_BS_IN, NHAN_XET_IN)
        ON DUPLICATE KEY UPDATE PHIM.LOAI_PHIM = LOAI_PHIM_IN,
                                PHIM.NHAN_XET  = NHAN_XET_IN;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure CHINHSUA_XN(IN MA_XN_IN varchar(20), IN MA_KHAM_IN varchar(20),
                                                        IN THOIGIANXN_IN datetime, IN TEN_XN_IN varchar(20),
                                                        IN NHAN_XET_IN varchar(100))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF (MA_KHAM_IN IS NULL) THEN
        UPDATE XN
        SET XN.THOIGIANXN = THOIGIANXN_IN,
            XN.TEN_XN     = TEN_XN_IN,
            XN.NHAN_XET   = NHAN_XET_IN
        WHERE XN.MA_XN = MA_XN_IN;
    ELSE
        INSERT INTO XN
        VALUES (MA_XN_IN, MA_KHAM_IN, THOIGIANXN_IN, TEN_XN_IN, NHAN_XET_IN)
        ON DUPLICATE KEY UPDATE XN.THOIGIANXN = THOIGIANXN_IN,
                                XN.TEN_XN     = TEN_XN_IN,
                                XN.NHAN_XET   = NHAN_XET_IN;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure DANHSACHBENHNHAN(IN MABS varchar(20))
BEGIN
    SELECT *
    FROM BENHNHAN
             join KHAM_BENH_NOI_NGOAI KBNN on BENHNHAN.MA_BN = KBNN.MA_BN
             join KHAMBENH K on KBNN.MA_KHAM = K.MA_KHAM
    WHERE KBNN.MA_BS = MABS
      and BENHNHAN.MA_BN = KBNN.MA_BN;
END;

create
    definer = longhuynh@localhost procedure LIST_BENH()
BEGIN
    SELECT *
    FROM BENH;
END;

create
    definer = longhuynh@localhost procedure LIST_THUOC()
BEGIN
    SELECT *
    FROM THUOC;
END;

create
    definer = longhuynh@localhost procedure QL_INFO(IN MAQL varchar(20))
BEGIN
    select BS_QUANLY.MA_QL, concat(HO, ' ', TEN) as TEN, NAM_QUAN_LY, LUONG, TEN_KHOA, CA_LAM_VIEC
    from BS_QUANLY
             join NHANVIEN N on BS_QUANLY.MA_QL = N.MA_NV
             join KHOADIEUTRI K on K.MA_KHOA = N.MA_KHOA
    where BS_QUANLY.MA_QL = MAQL;
END;

create
    definer = longhuynh@localhost procedure THEM_BENH(IN MABENH_IN varchar(20), IN TENBENH_IN varchar(20),
                                                      IN MOTA_IN varchar(100))
BEGIN
    insert into BENH values (MABENH_IN, TENBENH_IN, MOTA_IN);
END;

create
    definer = longhuynh@localhost procedure THEM_BENHNHAN_NGOAITRU(IN MAKHAM_IN varchar(20), IN TGKHAM_IN datetime,
                                                                   IN CAKHAM_IN int, IN MABN_IN varchar(20),
                                                                   IN MABS_IN varchar(20))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT * FROM NGOAITRU WHERE MA_BN = MABN_IN) THEN
        INSERT INTO NGOAITRU VALUES (MABN_IN);
    END IF;

    IF NOT EXISTS(SELECT * FROM KHAMBENH WHERE MA_KHAM = MAKHAM_IN) THEN
        INSERT INTO KHAMBENH (MA_KHAM, THOI_GIAN_KHAM, CA_KHAM)
        VALUES (MAKHAM_IN, TGKHAM_IN, CAKHAM_IN);

        INSERT INTO KBNGOAITRU (MA_KHAM, MA_BS, MA_BN)
        VALUES (MAKHAM_IN, MABS_IN, MABN_IN);
    ELSE
        UPDATE KHAMBENH
        SET THOI_GIAN_KHAM = TGKHAM_IN,
            CA_KHAM        = CAKHAM_IN
        WHERE MA_KHAM = MAKHAM_IN;

        -- JUST MAKE SURE
        IF NOT EXISTS(SELECT * FROM KBNGOAITRU WHERE MA_KHAM = MAKHAM_IN) THEN
            INSERT INTO KBNGOAITRU (MA_KHAM, MA_BS, MA_BN)
            VALUES (MAKHAM_IN, MABS_IN, MABN_IN);
        END IF;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure THEM_BENHNHAN_NOITRU(IN MAKHAM_IN varchar(20), IN TGKHAM_IN datetime,
                                                                 IN CAKHAM_IN int, IN MABN_IN varchar(20),
                                                                 IN MABS_IN varchar(20))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF NOT EXISTS(SELECT * FROM NOITRU WHERE MA_BN = MABN_IN) THEN
        INSERT INTO NOITRU VALUES (MABN_IN);
    END IF;

    IF NOT EXISTS(SELECT * FROM KHAMBENH WHERE MA_KHAM = MAKHAM_IN) THEN
        INSERT INTO KHAMBENH (MA_KHAM, THOI_GIAN_KHAM, CA_KHAM)
        VALUES (MAKHAM_IN, TGKHAM_IN, CAKHAM_IN);

        INSERT INTO KBNOITRU (MA_KHAM, MA_BS, MA_BN)
        VALUES (MAKHAM_IN, MABS_IN, MABN_IN);
    ELSE
        UPDATE KHAMBENH
        SET THOI_GIAN_KHAM = TGKHAM_IN,
            CA_KHAM        = CAKHAM_IN
        WHERE MA_KHAM = MAKHAM_IN;

        -- JUST MAKE SURE
        IF NOT EXISTS(SELECT * FROM KBNOITRU WHERE MA_KHAM = MAKHAM_IN) THEN
            INSERT INTO KBNOITRU (MA_KHAM, MA_BS, MA_BN)
            VALUES (MAKHAM_IN, MABS_IN, MABN_IN);
        END IF;
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure THEM_CHEDOTHUOC(IN XOA tinyint(1), IN MA_CHANDOAN_IN varchar(20),
                                                            IN MA_BENH_IN varchar(20), IN MA_KHAM_IN varchar(20),
                                                            IN MA_THUOC_IN varchar(20), IN LIEU_DUNG_IN int,
                                                            IN THOI_GIAN_DUNG_IN datetime)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF XOA THEN
        DELETE
        FROM CHEDOTHUOC
        WHERE MA_CHANDOAN = MA_CHANDOAN_IN
          AND MA_BENH = MA_BENH_IN
          AND MA_KHAM = MA_KHAM_IN
          AND MA_THUOC = MA_THUOC_IN
          AND LIEU_DUNG = LIEU_DUNG_IN
          AND THOI_GIAN_DUNG = THOI_GIAN_DUNG_IN;
    ELSE
        INSERT INTO CHEDOTHUOC
        VALUES (MA_CHANDOAN_IN, MA_BENH_IN, MA_KHAM_IN, MA_THUOC_IN, LIEU_DUNG_IN, THOI_GIAN_DUNG_IN);
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure THEM_THUOC(IN MATHUOC_IN varchar(20), IN TENTHUOC_IN varchar(30),
                                                       IN LOAITHUOC_IN varchar(30))
BEGIN
    insert into THUOC values (MATHUOC_IN, TENTHUOC_IN, LOAITHUOC_IN);
END;

create
    definer = longhuynh@localhost procedure THEM_TRIEUCHUNG(IN XOA tinyint(1), IN MA_CHANDOAN_IN varchar(20),
                                                            IN MA_BENH_IN varchar(20), IN MA_KHAM_IN varchar(20),
                                                            IN TENTRIEUCHUNG_IN varchar(20), IN MO_TA_IN varchar(30),
                                                            IN MUC_DO_IN varchar(30))
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
            -- SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khong the hoan tat them ho so kham benh!';
        END;

    START TRANSACTION;

    IF XOA THEN
        DELETE
        FROM TRIEUCHUNG
        WHERE TENTRIEUCHUNG = TENTRIEUCHUNG_IN
          AND MO_TA = MO_TA_IN
          AND MUC_DO = MUC_DO_IN
          AND MA_CHANDOAN = MA_CHANDOAN_IN
          AND MA_BENH = MA_BENH_IN
          AND MA_KHAM = MA_KHAM_IN;
    ELSE
        INSERT INTO TRIEUCHUNG
        VALUES (TENTRIEUCHUNG_IN, MO_TA_IN, MUC_DO_IN, MA_CHANDOAN_IN, MA_BENH_IN, MA_KHAM_IN);
    END IF;
    COMMIT;
END;

create
    definer = longhuynh@localhost procedure XEM_CDDD(IN MAKHAM_IN varchar(20))
BEGIN
    SELECT *
    FROM CDDD T
             JOIN DINHDUONG C ON T.MA_CDDD = C.MA_CDDD
    WHERE C.MA_KHAM = MAKHAM_IN;
END;

create
    definer = longhuynh@localhost procedure XEM_PHIM_MABS(IN MABS_IN varchar(20))
BEGIN
    SELECT *
    FROM PHIM
    WHERE MA_KHAM IN (SELECT MA_KHAM
                      FROM (SELECT * FROM KBNOITRU UNION SELECT * FROM KBNGOAITRU) AS T
                      WHERE MA_BS = MABS_IN);
END;

create
    definer = longhuynh@localhost procedure XEM_PHIM_MAKHAM(IN MAKHAM_IN varchar(20))
BEGIN
    SELECT * FROM PHIM WHERE MA_KHAM = MAKHAM_IN;
END;

create
    definer = longhuynh@localhost procedure XEM_THUOC(IN MAKHAM_IN varchar(20))
BEGIN
    SELECT *
    FROM THUOC T
             JOIN CHEDOTHUOC C ON T.MA_THUOC = C.MA_THUOC
    WHERE C.MA_KHAM = MAKHAM_IN;
END;

create
    definer = longhuynh@localhost procedure XEM_XN_MABS(IN MABS_IN varchar(20))
BEGIN
    SELECT *
    FROM XN X
             LEFT JOIN CHISO C ON X.MA_XN = C.MA_XN
    WHERE X.MA_KHAM IN (SELECT MA_KHAM
                        FROM (SELECT * FROM KBNOITRU UNION SELECT * FROM KBNGOAITRU) AS T
                        WHERE MA_BS = MABS_IN);
END;

create
    definer = longhuynh@localhost procedure XEM_XN_MAKHAM(IN MAKHAM_IN varchar(20))
BEGIN
    SELECT *
    FROM XN X
             LEFT JOIN CHISO C ON X.MA_XN = C.MA_XN
    WHERE X.MA_KHAM = MAKHAM_IN;
END;

create
    definer = longhuynh@localhost procedure XEM_XN_MAKHAM_MAXN(IN MAKHAM_IN varchar(20), IN MAXN_IN varchar(20))
BEGIN
    SELECT C.*
    FROM XN X
             LEFT JOIN CHISO C ON X.MA_XN = C.MA_XN
    WHERE X.MA_KHAM = MAKHAM_IN
      AND X.MA_XN = MAXN_IN;
END;


