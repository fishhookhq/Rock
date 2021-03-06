/* Code Generate 'AddBlockAttributeValue(...)' for migrations. 
This will list all of the block attribute values starting with most recently Inserted
Just pick the top few that you need for your migration depending
*/

begin

declare
@crlf varchar(2) = char(13) + char(10),
@BlockTypeId int = 512

SELECT 
        '            // Attrib Value for BlockType: '+ isnull(bt.Name, 'BlockType??') +
        @crlf +
        '            RockMigrationHelper.AddBlockType("'+     
        CONVERT(nvarchar(MAX), bt.Name)+ '","'+ 
        CONVERT(nvarchar(MAX), bt.Description)+ '","'+ 
        CONVERT(nvarchar(MAX), bt.Path)+ '","'+ 
        CONVERT(nvarchar(MAX), bt.Category)+ '","'+ 
		CONVERT(nvarchar(50), bt.Guid)+ '");'+
        @crlf [CodeGen Recently Added BlockTypes]
  FROM [BlockType] bt
  WHERE bt.Id = @BlockTypeId

SELECT 
        '            // Attrib Value for BlockType: '+ isnull(bt.Name, 'BlockType??') +
        @crlf +
        '            RockMigrationHelper.AddBlockTypeAttribute("'+     
        CONVERT(nvarchar(50), bt.Guid)+ '",FieldType.'+ 
        CONVERT(nvarchar(MAX), REPLACE(REPLACE(UPPER(ft.Name),' ', '_'), '-','_'))+ ',"'+ 
        CONVERT(nvarchar(MAX), a.Name)+ '","'+ 
        CONVERT(nvarchar(MAX), a.[Key])+ '","'+ 
        ''+ '",@"'+ 
        CONVERT(nvarchar(MAX), REPLACE(a.[Description],'"','""'))+ '",'+ 
        CONVERT(nvarchar(MAX), a.[Order])+ ',@"'+ 
        CONVERT(nvarchar(MAX), REPLACE(a.[DefaultValue],'"','""'))+ '","'+ 
		CONVERT(nvarchar(50), a.Guid)+ '",'+
        CONVERT(nvarchar(MAX), IIF(a.IsRequired = 1, 'true', 'false'))+ ');'+ 
        @crlf [CodeGen Recently Added BlockTypes]
  FROM [Attribute] [a]
  join [FieldType] [ft] on [ft].[Id] = [a].[FieldTypeId]
  left join [BlockType] bt on [bt].[Id] = @BlockTypeId
  WHERE EntityTypeQualifierValue = CONVERT(nvarchar(MAX), @BlockTypeId) AND EntityTypeQualifierColumn = N'BlockTypeId'
end