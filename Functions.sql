--Get options of Specific Q
Create function GetOptionsOfSpecificQ(@Q_Id int)
	returns table
	as 
	return(
	select CorrectAnswer as'Options' from CorrectChoice 
	where Q_Id = @Q_Id
	union 
	select WrongAnswer from WrongChoice
	where Q_Id = @Q_Id)

select * from dbo.GetOptionsOfSpecificQ(7)