private _v=_this;
//if!(local _v)exitWith{};
private _m=[];
private _r=[];
private _s=[];
private _sm=[];
private _p=[];
private _l=0;
_v setVariable["dapsActive",TRUE,TRUE];
_v setVariable["dapsLastAmmo",(_v call DAPS_fnc_CountAmmo),TRUE];
_v setVariable["dapsType","Heavy APS",TRUE];
_v setVariable["dapsAmmo",6,TRUE];
_v setVariable["dapsAmmoMax",6,TRUE];
private _time=-1;
private _reg=[];
while{TRUE}do{
	if!(alive _v)exitWith{};
	if(_v call DAPS_fnc_Active)then{
		_s=_v nearObjects["ShellCore",300];
		_r=_v nearObjects["RocketCore",100];
		_m=_v nearObjects["MissileCore",100];
		_sm=_v nearObjects["SubmunitionCore",200];
		_p=_v nearObjects["ammo_Penetrator_Base",200];
		_r=_r+_m+_s+_sm+_p;
		_r=_r-_reg;
		if((count _r)>0)then{[_v,_r select 0]spawn DAPS_fnc_Generic;_l=.5;_reg pushBack(_r select 0)};
		if((count _r)>1)then{[_v,_r select 1]spawn DAPS_fnc_Generic;_l=.5;_reg pushBack(_r select 1)};
		if(_l>0)then{sleep _l;_l=0};
	};
	if((call DAPS_fnc_Time)>_time)then{
		_v call DAPS_fnc_RearmCheck;
		_time=(call DAPS_fnc_Time)+dapsRearmDelay;
		{if!(alive _x)then{_reg=_reg-[_x]}}forEach _reg;
	};
	sleep .005;
};