/// @desc DrawTextOutline(text, offset, x, y)
/// @desc Made by KyronFinder
function DrawTextOutline(argument0, argument1, argument2, argument3) {

	/// @arg text
	/// @arg offset
	/// @arg x
	/// @arg y

	var txt = argument0;
	var off = argument1;
	var xx = argument2;
	var yy = argument3;

	draw_set_color(c_black);

	draw_text(xx+off,yy,txt);
	draw_text(xx,yy+off,txt);
	draw_text(xx-off,yy,txt);
	draw_text(xx,yy-off,txt);
	draw_text(xx+off,yy+off,txt);
	draw_text(xx-off,yy+off,txt);
	draw_text(xx-off,yy-off,txt);
	draw_text(xx+off,yy-off,txt);

	draw_set_color(c_white);
	draw_text(xx,yy,txt);


}
