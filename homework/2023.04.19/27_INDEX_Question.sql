--1) 어제 만든 SCORE_STGR 테이블의 SNO 컬럼에 INDEX를 추가하세요.
CREATE INDEX SCORE_STGR
ON STUDENT(SNO);

--2) 어제 만든 ST_COURSEPF 테이블의 SNO, CNO, PNO 다중 컬럼에 INDEX를 추가하세요.
CREATE INDEX ST_COURSEPF_SNO_SNO_PNO_INDEX
ON ST_COURSEPF(SNO,CNO,PNO);

