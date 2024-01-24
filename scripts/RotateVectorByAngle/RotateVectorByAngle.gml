// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
//x2=cosβx1−sinβy1
//y2=sinβx1+cosβy1

function GetRotatedXOffset(_x, _y, _angle){
	return _x * dcos(_angle) - _y * dsin(_angle);
}

function GetRotatedYOffset(_x, _y, _angle){
	return _x * dsin(_angle) + _y * dcos(_angle);
}