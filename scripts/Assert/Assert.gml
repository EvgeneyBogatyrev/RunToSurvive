///@desc Assert(statement, message)
///@argc statement
///@argc error message
function Assert(argument0, argument1) {

	///If statement is false, show error message and end game

	var _statement =  argument0;
	var _error     =  argument1;


	if (!_statement)
		Raise(_error);	


}
