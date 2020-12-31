DROP DATABASE IF EXISTS HOSPITAL;
CREATE DATABASE IF NOT EXISTS HOSPITAL;
USE HOSPITAL;

-- THUOC TINH MANH
CREATE TABLE NHANVIEN
(
    MA_NV 			VARCHAR(20) PRIMARY KEY,
    HO 				NVARCHAR(20),
    TEN 			NVARCHAR(20),
    LUONG			DECIMAL(15, 2)
);
CREATE TABLE BACSY
(
    MA_BS 			VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (MA_BS) REFERENCES NHANVIEN (MA_NV) ON UPDATE CASCADE ON DELETE CASCADE,
    CHUYEN_KHOA		NVARCHAR(20),
    EXPYEAR			INT
);
CREATE TABLE BS_QUANLY
(
    MA_QL 			VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (MA_QL) REFERENCES NHANVIEN (MA_NV) ON UPDATE CASCADE ON DELETE CASCADE,
    NAM_QUAN_LY		INT
);

CREATE TABLE BENHNHAN
(
    MA_BN 			VARCHAR(20) PRIMARY KEY,
    HO 				NVARCHAR(20),
    TEN 			NVARCHAR(20),
    TUOI			INT,
    DAN_TOC			NVARCHAR(20),
    NGHE_NGHIEP		NVARCHAR(30)
);
CREATE TABLE NOITRU
(
    MA_BN 			VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (MA_BN) REFERENCES BENHNHAN (MA_BN) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE NGOAITRU
(
    MA_BN 			VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (MA_BN) REFERENCES BENHNHAN (MA_BN) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE KHOADIEUTRI
(
    MA_KHOA 		VARCHAR(20) PRIMARY KEY,
    TEN_KHOA		NVARCHAR(20),
    BUILD_YEAR		INT,
    CHUYEN_MON		NVARCHAR(30)
);
CREATE TABLE BHYT
(
    MA_THE 			VARCHAR(20) PRIMARY KEY,
    THOI_HAN		DATE,
    NOI_DANG_KY		NVARCHAR(30)
);
CREATE TABLE BENH
(
    MA_BENH 		VARCHAR(20) PRIMARY KEY,
    TEN_BENH		NVARCHAR(20),
    MO_TA			NVARCHAR(100)
);
CREATE TABLE CDDD
(
    MA_CDDD 		VARCHAR(20) PRIMARY KEY,
    NOI_DUNG		NVARCHAR(100),
    HUONG_DAN		NVARCHAR(100)
);
CREATE TABLE THUOC
(
    MA_THUOC 		VARCHAR(20) PRIMARY KEY,
    TEN_THUOC		NVARCHAR(30),
    LOAI_THUOC		NVARCHAR(30)
);

CREATE TABLE CHISOXN
(
    MA_CHISOXN 		VARCHAR(20) PRIMARY KEY,
    UPPERBOUND		DOUBLE,
    LOWERBOUND		DOUBLE DEFAULT 0
);

-- THUC THE YEU
CREATE TABLE BENHANNOITRU
(
    THOIGIANNHAPVIEN 	DATETIME,
    MA_KHOA     		VARCHAR(20),
    MA_BS       		VARCHAR(20),
    MA_BN       		VARCHAR(20),
    PRIMARY KEY (THOIGIANNHAPVIEN, MA_KHOA, MA_BS, MA_BN),
    FOREIGN KEY (MA_KHOA) REFERENCES KHOADIEUTRI (MA_KHOA) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BS) REFERENCES BACSY (MA_BS) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BN) REFERENCES NOITRU (MA_BN) ON UPDATE CASCADE ON DELETE CASCADE,
    
    SO_GIUONG			INT,
    SO_BUONG			INT
);
CREATE TABLE KHAMBENH
(
    MA_KHAM 			VARCHAR(20) PRIMARY KEY,
    THOI_GIAN_KHAM		DATETIME NOT NULL,
    CA_KHAM				INT NOT NULL
);
CREATE TABLE KBNGOAITRU
(
    MA_KHAM 			VARCHAR(20),
    MA_BN   			VARCHAR(20),
    MA_BS   			VARCHAR(20),
    PRIMARY KEY (MA_KHAM, MA_BN, MA_BS),
    FOREIGN KEY (MA_KHAM) REFERENCES KHAMBENH (MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BN) REFERENCES NGOAITRU (MA_BN) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BS) REFERENCES BACSY (MA_BS) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE KBNOITRU
(
    MA_KHAM 			VARCHAR(20),
    MA_BN   			VARCHAR(20),
    MA_BS   			VARCHAR(20),
    PRIMARY KEY (MA_KHAM, MA_BN, MA_BS),
    FOREIGN KEY (MA_KHAM) REFERENCES KHAMBENH (MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BN) REFERENCES NOITRU (MA_BN) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BS) REFERENCES BACSY (MA_BS) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE PHIM
(
    MA_PHIM 			VARCHAR(20),
    MA_KHAM 			VARCHAR(20),
    PRIMARY KEY (MA_PHIM, MA_KHAM),
    FOREIGN KEY (MA_KHAM) REFERENCES KHAMBENH (MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    LOAI_PHIM			NVARCHAR(20),
    THOI_GIAN_CHUP		DATETIME NOT NULL
);
CREATE TABLE XN
(
    MA_XN   			VARCHAR(20),
    MA_KHAM 			VARCHAR(20),
    PRIMARY KEY (MA_XN, MA_KHAM),
    FOREIGN KEY (MA_KHAM) REFERENCES KHAMBENH (MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    THOIGIANXN			DATETIME NOT NULL,
    TEN_XN				NVARCHAR(20),
    NHAN_XET			NVARCHAR(100)
);
CREATE TABLE CHISO
(
    MA_CHISO   			VARCHAR(20),
    MA_XN      			VARCHAR(20),
    MA_KHAM    			VARCHAR(20),
    PRIMARY KEY (MA_CHISO, MA_XN, MA_KHAM),
    FOREIGN KEY (MA_XN, MA_KHAM) REFERENCES XN (MA_XN, MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    
    GIA_TRI				DOUBLE,
    KET_QUA				VARCHAR(10)
);
CREATE TABLE KQCHANDOAN
(
    MA_CHANDOAN 		VARCHAR(20),
    MA_BENH     		VARCHAR(20),
    MA_KHAM     		VARCHAR(20),
    PRIMARY KEY (MA_CHANDOAN, MA_BENH, MA_KHAM),
    FOREIGN KEY (MA_BENH) REFERENCES BENH (MA_BENH) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_KHAM) REFERENCES KHAMBENH (MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    
    NOI_DUNG			NVARCHAR(100),
    GHI_CHU				NVARCHAR(50)
);

-- LIEN KET 1:1
-- ALTER TABLE BHYT
-- 	ADD BN				VARCHAR(20) NOT NULL,
--     ADD CONSTRAINT FKBHYT
--     FOREIGN KEY (BN) REFERENCES BENHNHAN (MA_BN) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE BENHNHAN
	ADD BHYT			VARCHAR(20),
		ADD CONSTRAINT FKBHYT
        FOREIGN KEY (BHYT) REFERENCES BHYT (MA_THE) ON UPDATE CASCADE ON DELETE SET NULL;

    
ALTER TABLE KHOADIEUTRI
	ADD MA_QL   		VARCHAR(20) NOT NULL,
	ADD CONSTRAINT FKQL
    FOREIGN KEY (MA_QL) REFERENCES BS_QUANLY (MA_QL) ON UPDATE CASCADE ON DELETE CASCADE;


-- LIEN KET 1:N
ALTER TABLE NHANVIEN
	ADD MA_KHOA			VARCHAR(20) NOT NULL,
    ADD CA_LAM_VIEC		INT NOT NULL,
    ADD CONSTRAINT FKMAKHOA
	FOREIGN KEY (MA_KHOA) REFERENCES KHOADIEUTRI (MA_KHOA) ON UPDATE CASCADE ON DELETE CASCADE;
    
ALTER TABLE BACSY
	ADD MA_BSQL			VARCHAR(20),
    ADD CONSTRAINT FKBSQL
	FOREIGN KEY (MA_BSQL) REFERENCES BS_QUANLY (MA_QL) ON UPDATE CASCADE ON DELETE SET NULL; 

ALTER TABLE BENHANNOITRU
	ADD MABS_CHIDINH_XUATVIEN VARCHAR(20),
    ADD TINHTRANG_XV	NVARCHAR(100),
    ADD TG_XV			DATETIME,
    ADD GHI_CHU_XV		NVARCHAR(50),
    ADD CONSTRAINT FK_XV
	FOREIGN KEY (MABS_CHIDINH_XUATVIEN) REFERENCES BACSY (MA_BS) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE PHIM
	ADD MA_BS 			VARCHAR(20) NOT NULL,
    ADD NHAN_XET		NVARCHAR(100),
    ADD CONSTRAINT FK_BS_PHIM
	FOREIGN KEY (MA_BS) REFERENCES BACSY (MA_BS) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE CHISO
	ADD MA_CHISOXN 		VARCHAR(20) NOT NULL,
    ADD CONSTRAINT FK_CHISO
	FOREIGN KEY (MA_CHISOXN) REFERENCES CHISOXN (MA_CHISOXN) ON UPDATE CASCADE ON DELETE CASCADE;

-- LIEN KET M:N
CREATE TABLE NHIEUBENH
(
	MA_BENH_DAU			VARCHAR(20),
    MA_BENH_CUOI		VARCHAR(20),
    PRIMARY KEY (MA_BENH_DAU, MA_BENH_CUOI),
    FOREIGN KEY (MA_BENH_DAU) REFERENCES BENH (MA_BENH) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_BENH_CUOI) REFERENCES BENH (MA_BENH) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE DINHDUONG
(
    MA_CHANDOAN 		VARCHAR(20),
    MA_BENH     		VARCHAR(20),
    MA_KHAM     		VARCHAR(20),
    MA_CDDD     		VARCHAR(20),
    PRIMARY KEY (MA_CHANDOAN, MA_BENH, MA_KHAM, MA_CDDD),
    FOREIGN KEY (MA_CHANDOAN, MA_BENH, MA_KHAM) REFERENCES KQCHANDOAN (MA_CHANDOAN, MA_BENH, MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_CDDD) REFERENCES CDDD (MA_CDDD) ON UPDATE CASCADE ON DELETE CASCADE,
    
    CHI_DINH			NVARCHAR(100),
    GHI_CHU				NVARCHAR(50)
);
CREATE TABLE CHEDOTHUOC
(
    MA_CHANDOAN			VARCHAR(20),
    MA_BENH     		VARCHAR(20), 
    MA_KHAM     		VARCHAR(20),
    MA_THUOC    		VARCHAR(20),
    FOREIGN KEY (MA_CHANDOAN, MA_BENH, MA_KHAM) REFERENCES KQCHANDOAN (MA_CHANDOAN, MA_BENH, MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (MA_THUOC) REFERENCES THUOC (MA_THUOC) ON UPDATE CASCADE ON DELETE CASCADE,
    
    LIEU_DUNG			INT,
    THOI_GIAN_DUNG		DATETIME,
    PRIMARY KEY (MA_CHANDOAN, MA_BENH, MA_KHAM, MA_THUOC, LIEU_DUNG, THOI_GIAN_DUNG)
);

-- MULTIVALUE
CREATE TABLE TRIEUCHUNG
(
    TENTRIEUCHUNG  		NVARCHAR(30),
    MO_TA				NVARCHAR(50),
    MUC_DO				NVARCHAR(20),
    MA_CHANDOAN 		VARCHAR(20),
    MA_BENH     		VARCHAR(20),
    MA_KHAM     		VARCHAR(20),
    PRIMARY KEY (TENTRIEUCHUNG, MO_TA, MUC_DO, MA_CHANDOAN, MA_BENH, MA_KHAM),
    FOREIGN KEY (MA_CHANDOAN, MA_BENH, MA_KHAM) REFERENCES KQCHANDOAN (MA_CHANDOAN, MA_BENH, MA_KHAM) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TGLAMVIEC
(
	MA_NV				VARCHAR(20),
    CA_LAM_VIEC			INT,
    NGAY_LAM_VIEC		DATE,
    PRIMARY KEY (MA_NV, CA_LAM_VIEC, NGAY_LAM_VIEC),
    FOREIGN KEY (MA_NV) REFERENCES NHANVIEN(MA_NV) ON UPDATE CASCADE ON DELETE CASCADE
);