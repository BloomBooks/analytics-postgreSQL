CREATE FUNCTION [dbo].[f_ConvertIPV6to4]
(
@AddrIPV6 varchar(50)
)
RETURNS varchar(17)
AS
BEGIN

declare @ipv4 varchar(17)

set @ipv4 = (

select

cast(convert(int, convert(varbinary, ‘0x’ + substring(substring(@AddrIPV6, (len(@AddrIPV6)-charindex(‘:’, @AddrIPV6)) – 3, 4), 1, 2), 1)) as varchar(3)) + ‘.’ +

cast(convert(int, convert(varbinary, ‘0x’ + substring(substring(@AddrIPV6, (len(@AddrIPV6)-charindex(‘:’, @AddrIPV6)) – 3, 4), 3, 2), 1)) as varchar(3)) + ‘.’ +

cast(convert(int, convert(varbinary, ‘0x’ + substring(substring(@AddrIPV6, (len(@AddrIPV6)-charindex(‘:’, @AddrIPV6)) + 2, 4), 1, 2), 1)) as varchar(3)) + ‘.’ +

cast(convert(int, convert(varbinary, ‘0x’ + substring(substring(@AddrIPV6, (len(@AddrIPV6)-charindex(‘:’, @AddrIPV6)) + 2, 4), 3, 2), 1)) as varchar(3))

)

return @ipv4

END