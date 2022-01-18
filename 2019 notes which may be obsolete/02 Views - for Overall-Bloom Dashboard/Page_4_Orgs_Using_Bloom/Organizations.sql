REVOKE SELECT ON bloomapp.organization_users2 FROM bloomappuser;
DROP VIEW bloomapp.organization_users2;

CREATE VIEW bloomapp.organization_users2 AS
  SELECT a.id, a.received_at, a.context_ip as raw_ip,
    CASE
      WHEN position('<' in a.context_ip) > 0 then ''
      WHEN position(':' in a.context_ip) > 0 then ''
      WHEN position('SCRIPT' in a.context_ip) > 0 then ''
      ELSE a.context_ip
      END as ip,
	CASE
      WHEN position('<' in a.context_ip) > 0 then ''
      WHEN position(':' in a.context_ip) > 0 then ''
	  WHEN position(',' in a.context_ip) > 0 then ''
      WHEN position('SCRIPT' in a.context_ip) > 0 then ''
      ELSE 
	  	(SELECT public.ip2country_name (a.context_ip)) 
      END AS Country,  
    a.organization as organization_raw,
    CASE
      WHEN position('SIL LEAD' in upper(a.organization)) > 0 THEN 'SIL LEAD'
      WHEN position('SIL' in upper(a.organization)) > 0 THEN 'SIL'
	  WHEN position('ADPP' in upper(a.organization)) > 0 THEN 'ADPP'
	  WHEN position('BIBLE SO' in upper(a.organization)) > 0 THEN 'Bible Society'
	  WHEN position('COLLEGE' in upper(a.organization)) > 0 THEN 'College/University'
	  WHEN position('UNIVERSI' in upper(a.organization)) > 0 THEN 'College/University'
	  WHEN position('CHURCH' in upper(a.organization)) > 0 THEN 'Church'
	  WHEN position('GLISE' in upper(a.organization)) > 0 THEN 'Church'
      WHEN position('DEPED' in upper(a.organization)) > 0 THEN 'Ministry of Education'
      WHEN position('DEP.ED' in upper(a.organization)) > 0 THEN 'Ministry of Education'
	  WHEN position('DEPARTMENT OF ED' in upper(a.organization)) > 0 THEN 'Ministry of Education'
	  WHEN position('DEP. ED' in upper(a.organization)) > 0 THEN 'Ministry of Education'
      WHEN position('DEP ED' in upper(a.organization)) > 0 THEN 'Ministry of Education'
      WHEN position('DEP-ED' in upper(a.organization)) > 0 THEN 'Ministry of Education'
	  WHEN position('MINISTÈRE' in upper(a.organization)) > 0 THEN 'Ministry of Education'
	  WHEN position('DPE' in upper(a.organization)) > 0 THEN 'Ministry of Education'
	  WHEN position('EDUC' in upper(a.organization)) > 0 THEN 'Education'
	  WHEN position('ETHNOS360' in upper(a.organization)) > 0 THEN 'Ethnos360'
	  WHEN position('FHI' in upper(a.organization)) > 0 THEN 'FHI360'
	  WHEN position('GOV' in upper(a.organization)) > 0 THEN 'Government'
	  WHEN position('OFFICER' in upper(a.organization)) > 0 THEN 'Government'
	  WHEN position('NTM' in upper(a.organization)) > 0 THEN 'Ethnos360'
	  WHEN position('NEW TRIBES' in upper(a.organization)) > 0 THEN 'Ethnos360'
	  WHEN position('TEACHER' in upper(a.organization)) > 0 THEN 'Education-Teacher'
	  WHEN position('FACULTY' in upper(a.organization)) > 0 THEN 'Education-Teacher'
      WHEN position('PRIMARY' in upper(a.organization)) > 0 THEN 'Education-Primary'
	  WHEN position('SCHOOL' in upper(a.organization)) > 0 THEN 'Education-School'
	  WHEN position('ACADEMY' in upper(a.organization)) > 0 THEN 'Education-School'
	  WHEN position('G.I.A.L' in upper(a.organization)) > 0 THEN 'GIAL'
	  WHEN position('GIAL' in upper(a.organization)) > 0 THEN 'GIAL'
	  WHEN position('GPS' in upper(a.organization)) > 0 THEN 'GPS'
	  WHEN position('G P S' in upper(a.organization)) > 0 THEN 'GPS'
	  WHEN position('LIBRARY' in upper(a.organization)) > 0 THEN 'Library'
	  WHEN position('LIBRARIES' in upper(a.organization)) > 0 THEN 'Library'
	  WHEN position('LITERACY' in upper(a.organization)) > 0 THEN 'Literacy Organization'
	  WHEN position('LINGUISTIC' in upper(a.organization)) > 0 THEN 'Linguistics Organization'
	  WHEN position('LBT' in upper(a.organization)) > 0 THEN 'Lutheran Bible Translators'
	  WHEN position('LUTHERAN BIBLE TRANSLATORS' in upper(a.organization)) > 0 THEN 'Lutheran Bible Translators'
	  WHEN position('PBT' in upper(a.organization)) > 0 THEN 'Pioneer Bible Translators'
	  WHEN position('PIONEER BIBLE TRANSLATORS' in upper(a.organization)) > 0 THEN 'Pioneer Bible Translators'
	  WHEN position('SOEURS' in upper(a.organization)) > 0 THEN 'Three Sisters: Trois Soeurs'
	  WHEN position('TRADUC' in upper(a.organization)) > 0 THEN 'Translation Organization'
	  WHEN position('USAID' in upper(a.organization)) > 0 THEN 'USAID'
	  WHEN position('UNESCO' in upper(a.organization)) > 0 THEN 'UNESCO'
      WHEN position('WVI' in upper(a.organization)) > 0 THEN 'World Vision'
      WHEN position('W.V.I.' in upper(a.organization)) > 0 THEN 'World Vision'
      WHEN position('WV' in upper(a.organization)) > 0 THEN 'World Vision'
	  WHEN position('WAHANA VISI' in upper(a.organization)) > 0 THEN 'World Vision'
      WHEN position('WORLD V' in upper(a.organization)) > 0 THEN 'World Vision'
      WHEN position('WORLDVISION' in upper(a.organization)) > 0 THEN 'World Vision'
      WHEN position('WYCLIFFE' in upper(a.organization)) > 0 THEN 'Wycliffe'
      WHEN position('WBT' in upper(a.organization)) > 0 THEN 'Wycliffe'
      WHEN position('SEED' in upper(a.organization)) > 0 THEN 'The Seed Co.'
	  WHEN position('SDO' in upper(a.organization)) > 0 THEN 'SDO'
	  WHEN position('SAVE' in upper(a.organization)) > 0 THEN 'Save the Children'
      WHEN position('SAMUNNAT' in upper(a.organization)) > 0 THEN 'Samunnat'
      WHEN position('PEACE C' in upper(a.organization)) > 0 THEN 'Peace Corps'
	  WHEN position('PERSONAL' in upper(a.organization)) > 0 THEN 'Personal'
	  WHEN position('HOME' in upper(a.organization)) > 0 THEN 'Personal'
	  WHEN position('SELF' in upper(a.organization)) > 0 THEN 'Personal'
	  WHEN position('OWN' in upper(a.organization)) > 0 THEN 'Personal'
	  WHEN position('PRIVATE' in upper(a.organization)) > 0 THEN 'Personal'
	  WHEN position('FREELANCE' in upper(a.organization)) > 0 THEN 'Personal'
	  WHEN position('PTI' in upper(a.organization)) > 0 THEN 'PTI (Bangladesh)'
	  WHEN position('P T I' in upper(a.organization)) > 0 THEN 'PTI (Bangladesh)'
	  WHEN position('P.T.I.' in upper(a.organization)) > 0 THEN 'PTI (Bangladesh)'
	  WHEN position('URC' in upper(a.organization)) > 0 THEN 'URC'
/*	  WHEN position('পি' in upper(a.organization)) > 0 THEN 'পি টি আই'
	  WHEN position('আ' in upper(a.organization)) > 0 THEN 'আ'
	  WHEN position('উত্তর' in upper(a.organization)) > 0 THEN 'উত্তর'
	  WHEN position('উপজেলা' in upper(a.organization)) > 0 THEN 'উপজেলা'
	  WHEN position('কা' in upper(a.organization)) > 0 THEN 'কা'
	  WHEN position('দক্ষিণ' in upper(a.organization)) > 0 THEN 'দক্ষিণ'
	  WHEN position('বিদ্যাল' in a.organization) > 0 THEN 'প্রাথমিক বিদ্যালয়'
	  WHEN position('স্কুল' in a.organization) > 0 THEN 'স্কুল'
*/	  
	  WHEN position('SDF' in upper(a.organization)) > 0 THEN 'Unknown'
	  WHEN position('NONE' in upper(a.organization)) > 0 THEN 'Unknown'
	  WHEN position('N/A' in upper(a.organization)) > 0 THEN 'Unknown'
      WHEN length(a.organization) < 2 THEN 'Unknown'
      WHEN a.organization IS NULL THEN 'Unknown'
      ELSE a.organization END as organization
  FROM bloomapp.users AS a;


GRANT ALL PRIVILEGES on bloomapp.organization_users2 to bloomappuser,readbloom, silpgadmin, segment;
select * FROM bloomapp.organization_users2;

--CREATE TABLE bloomapp.organization_users_mirror AS SELECT * FROM bloomapp.organization_users;


