// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProfileStructPost(){

}

function ProfileStructSetIDs(_struct)
{
	var _names = struct_get_names(_struct);
	
	for (var _i = 0; _i < len(_names); _i++)
	{
		var _profile = struct_get(_struct, _names[_i]);
		struct_set(_profile, "id", _names[_i]);
	}
}