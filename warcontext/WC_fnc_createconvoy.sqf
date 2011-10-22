	// -----------------------------------------------
	// Author: =[A*C]= code34 nicolas_boiteux@yahoo.fr
	// WARCONTEXT - create a enemy convoy

	if (!isServer) exitWith{};

	private [
		"_arrayofvehicle",
		"_bucket",
		"_group",
		"_unit", 
		"_target",
		"_lastposition",
		"_position",
		"_vehicle",
		"_vehicles",
		"_find",
		"_typeof"
		];

	diag_log "WARCONTEXT: BUILD 1 CONVOY";

	_target = position (wctownlocations call BIS_fnc_selectRandom);
	_position = _target findemptyposition [10, 300];
	_bucket = 0;

	_arrayofvehicle = [_position, 0, (wcvehicleslistE call BIS_fnc_selectRandom), east] call BIS_fnc_spawnVehicle;

	sleep 2;

	_vehicle 	= _arrayofvehicle select 0;
	_arrayofpilot 	= _arrayofvehicle select 1;
	_group 		= _arrayofvehicle select 2;

	_vehicle setVehicleLock "LOCKED";
	_unit = driver _vehicle;

	wcgarbage = [_vehicle] spawn WC_fnc_vehiclehandler;
	wcgarbage = [_group] spawn WC_fnc_grouphandler;	

	_target = wctownlocations call BIS_fnc_selectRandom;

	_group setBehaviour "SAFE";
	_group setSpeedMode "FULL";

	_lastposition = position _vehicle;

	while { count (crew _vehicle) > 0 } do {
		if(position _unit distance position _target > 150) then {
			{	
				_x domove position _target;
			}foreach (crew _vehicle);
			sleep 60;
		} else {
			_target = wctownlocations call BIS_fnc_selectRandom;
		};

		if(format["%1", _lastposition] == format["%1", position _vehicle]) then {
			_bucket = _bucket + 1;
		};
		_lastposition = position _vehicle;

		if(_bucket > 10) then {
			_target = wctownlocations call BIS_fnc_selectRandom;
			_bucket = 0;
		};

		_vehicle setFuel 1;
		sleep 5;
	};