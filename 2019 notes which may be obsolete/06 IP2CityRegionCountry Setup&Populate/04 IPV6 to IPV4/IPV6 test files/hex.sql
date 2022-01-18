first pad the last 4 bytes so address is
/0:0:0:0:0:ffff:0a41:0380 
then simply convert each of the last 4 bytes from hex to decimal
0a=10
41=65
03=3
80=128
so ip = 10.65.3.128

select hex_to_int('80') ;

		/* This portion is based on that example:	
			SELECT(SUBSTRING(OctTemp2,1,2)) into aa;
			SELECT(SUBSTRING(OctTemp2,3,2)) into bb;
		    SELECT(SUBSTRING(OctTemp1,1,2)) into cc;
			SELECT(SUBSTRING(OctTemp1,3,2)) into dd;
			a:=hex_to_int(aa);  b:=hex_to_int(bb); 	
			c:=hex_to_int(cc);  d:=hex_to_int(dd);	
		  	iptemp := CAST((CAST(a AS text)||CAST(b AS text)||CAST(c AS text)||CAST(d AS text)) AS bigint); */
		  /*  ipint :=iptemp;  */
		/*
For example, the following is an IPv6 address represented with 32 hexadecimal digits Note:
32 hex digits with 4 bits/hex digit = 128 bits):
6789:ABCD:1234:EF98:7654:321F:EDCB:AF21
For example, the decimal equivalent of the first eight hexadecimal 
characters in the previous full IPv6 address is
6789:ABCD = 103.137.171.205
The completed decimal equivalent number for the full IPv6 address is
103.137.171.205.18.52.239.152.118.84.50.31.237.203.175.33
*/
select hex_to_int('00') ;
select hex_to_int('67') ;
select hex_to_int('89') ;
select hex_to_int('AB') ;
select hex_to_int('CD') ;
select hex_to_int('12') ;
select hex_to_int('34') ;
select hex_to_int('EF') ;
select hex_to_int('98') ;
select hex_to_int('76') ;
select hex_to_int('54') ;
select hex_to_int('32') ;
select hex_to_int('1F') ;
select hex_to_int('ED') ;
select hex_to_int('CB') ;
select hex_to_int('AF') ;
select hex_to_int('21') ;

