	// -----------------------------------------------
	// Author:  code34 nicolas_boiteux@yahoo.fr
	// warcontext - Unit hang up

	private [
		"_unit"
		];
	
	_unit = _this select 0;

	_unit playMove 'AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon';
	removeAllWeapons _unit; 
	_unit stop true;
	_unit setvariable ["civilrole", "arrest", true];
	sleep 120;
	_unit setvariable ["civilrole", "arrest", false];