///@desc Check if instance is outside the room
///@param x
///@param y
function OutsideRoom(argument0, argument1) {

	var _x = argument0;
	var _y = argument1;

	if (_x < oCamera.left || _x > oCamera.right || _y < 0 || _y > room_height)  return 1;
	return 0;


}
