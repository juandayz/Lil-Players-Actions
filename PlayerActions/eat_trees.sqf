private ["_howMany_blood_it_take","_damage","_hunger","_objName","_tree","_distance2d"];

if (dayz_actionInProgress) exitWith {systemchat "Wait! im doing it!";};
closeDialog 1;
dayz_actionInProgress = true;
_howMany_blood_it_take = [10000,30000];
_howMany_blood_it_take = (random((_howMany_blood_it_take select 1) - (_howMany_blood_it_take select 0)) + (_howMany_blood_it_take select 0)) / 10;
_hunger = round(100 - (dayz_hunger / SleepFood) * 100);//read hunger as 0% to 100%
_damage = round((r_player_blood / r_player_bloodTotal) * 100); //read blood as 0% to 100%



if (_damage <= 40) exitWith {dayz_actionInProgress = false;systemchat "Actually You should not do that. You can die in the attempt!";};
if (_hunger >= 60) exitWith {dayz_actionInProgress = false;systemchat "You should not eat them unless you really are hungry...";}; 


_tree = objNull;
{
	if (typeOf _x in dayz_treeTypes && {alive _x} && {(_x call fn_getModelName) in dayz_trees}) exitWith {

		_tree = _x;
	};
} count nearestObjects [getPosATL player, [], 20];


if (!isNull _tree) then {
	_distance2d = [player, _tree] call BIS_fnc_distance2D;	
	if (_distance2d > 3) exitWith {systemchat "you need be 2mts near a tree to eat his bark";dayz_actionInProgress = false;};
_tree = _this select 0;

["FoodDrink",0,[0,180,0,0]] call dayz_NutritionSystem;
player setVariable ["messing",[dayz_hunger,dayz_thirst,dayz_nutrition],false]; //No need to be sent to everyplayer
PVDZ_serverStoreVar = [player,"messing",[dayz_hunger,dayz_thirst,dayz_nutrition]]; //update server side only
publicVariableServer "PVDZ_serverStoreVar";

r_player_blood = r_player_blood - _howMany_blood_it_take;
player setHit["Hands",0.5];
systemchat "Your stomach does not tolerate it well. You feel an intense pain in your belly.";
addCamShake [2, 0.5, 25];
[player,"gut",0,false,10] call dayz_zombieSpeak;
player playActionNow "Medic";


"I have cheated my hunger for a few moments with this tree bark..." call dayz_rollingMessages;

}else{
	systemchat "you need be 2mts near a tree to eat his bark";
};
	dayz_actionInProgress = false;
