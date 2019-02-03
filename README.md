# Lil-Players-Actions

PLEASE DONATE: https://github.com/juandayz/Lil-Players-Actions/blob/master/DONATION.md

Allow players to eat tree barks (the skin of a tree)  and drink his own blood.  Just in a last instance where he are daying of hunger or thirs.

***INSTALL:***

1.Drop PlayerActions folder into your MPMissions\yourmap instance\scripts\

2.You will need some kind of right click mods (deploy anything or extra_rc.hpp)

2.A.IF ure using extra_rc.hpp then add into your ```class ExtraRc { ------};```

```ruby
class ItemMachete {
class eattrees2 {
      text = "eat trees bark";
      script = "execVM 'scripts\PlayerActions\eat_trees.sqf'";
      };	
};

class ItemKnife {
class drinkblood {
      text = "DRINK MY BLOOD";
      script = "execVM 'scripts\PlayerActions\drink_my_blood.sqf'";
      };
class eattrees {
      text = "eat trees bark";
      script = "execVM 'scripts\PlayerActions\eat_trees.sqf'";
      };		
};
```

2.B If youre using DeployAnything then add in your : ...\deployanything\overwrites\click_actions\config.sqf
```ruby
DZE_CLICK_ACTIONS = [
//PLAYERACTIONS
["ItemKnife","DrinkMyBlood","execVM 'scripts\PlayerActions\drink_my_blood.sqf';","true"],
["ItemKnife","eat trees bark","execVM 'scripts\PlayerActions\eat_trees.sqf';","true"],
["ItemMachete","eat trees bark","execVM 'scripts\PlayerActions\eat_trees.sqf';","true"],
//PLAYERACTIONS
];
```
