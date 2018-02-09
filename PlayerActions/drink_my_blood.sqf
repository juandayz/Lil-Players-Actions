//by juandayz
private ["_howMany_blood_it_take","_infectionChance","_damage","_thirst"];
closeDialog 1;
if (dayz_actionInProgress) exitWith {systemchat "Wait! im doing it!";};
dayz_actionInProgress = true;

_infectionChance = round(random 10);
_howMany_blood_it_take = [10000,30000];
_damage = round((r_player_blood / r_player_bloodTotal) * 100);
_thirst = round(100 - (dayz_thirst / SleepWater) * 100);

if (vehicle player != player) exitWith {dayz_actionInProgress = false;systemchat "cannot do it into vehicles";};
if (_damage <= 40) exitWith {dayz_actionInProgress = false;systemchat "Actually You should not do that. You can die in the attempt!";};
if (_thirst >= 60) exitWith {dayz_actionInProgress = false;systemchat "You should not cut yourself yet.. because you're not dying of thirst.";}; 
  
player playActionNow "Medic";
[player,"gut",0,false,10] call dayz_zombieSpeak;
[player,50,true,(getPosATL player)] spawn player_alertZombies;
if (_infectionChance < 4) then {r_player_infected = true;player setVariable["USEC_infected",true,true];systemchat "You are infected!Hurry!Visit Dr. Annette Baker in the 3 Sisters to get a cure.";};

if (_damage >=41 && _damage <= 70) then {
["FoodDrink",0,[0,0,90,0]] call dayz_NutritionSystem;	
_howMany_blood_it_take = (random((_howMany_blood_it_take select 1) - (_howMany_blood_it_take select 0)) + (_howMany_blood_it_take select 0)) / 10;
}else{
["FoodDrink",0,[0,0,250,0]] call dayz_NutritionSystem;	
_howMany_blood_it_take = (random((_howMany_blood_it_take select 1) - (_howMany_blood_it_take select 0)) + (_howMany_blood_it_take select 0)) / 5;
};
r_player_blood = r_player_blood - _howMany_blood_it_take;
player setHit["Hands",0.5];
addCamShake [2, 0.5, 25];
"After drinking my blood, I am are no longer thirsty. But the bitter taste in my throat is unbearable..." call dayz_rollingMessages;
dayz_actionInProgress = false;
player setVariable ["messing",[dayz_hunger,dayz_thirst,dayz_nutrition],false]; //No need to be sent to everyplayer
PVDZ_serverStoreVar = [player,"messing",[dayz_hunger,dayz_thirst,dayz_nutrition]]; //update server side only
publicVariableServer "PVDZ_serverStoreVar";