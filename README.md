## Gone Fishing

Gone Fishing - fishing gear swapper addon for World of Warcraft  
Copyright (C) 2013  Christian Garbs <mitch@cgarbs.de>
 
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


## Basic Usage

1. Create a macro that executes the ```/gonefishing``` command
   and put it in your action bar.

2. Call the macro to equip everything that raises your fishing
   skill:  rods, boots and hats.  Gone Fishing automatically
   selects your items with the highest fishing stats.

3. Catch those fish!
   
4. Call the macro again to unequip your fishing gear and switch
   back to the gear previously worn.


## Advanced usage

Gone Fishing supports all ```[conditionals]``` so you can write
more complex macros like this:

```
/use [nomod] fishing 
/gonefishing [mod]
```

This will cast your fishing rod if you click the macro
without any modifiers (shift/ctrl/alt) and it will invoke
/gonefishing instead only if you hold a modifier.  
This saves space in your action bar.


## Download / Updates

- Download/Installation via Curse: http://www.curse.com/addons/wow/gonefishing
- Project homepage: https://github.com/mmitch/gonefishing/
- Curseforge Project: http://wow.curseforge.com/addons/gonefishing/


#### Manual installation

Put both ```gonefishing.toc``` and ```gonefishing.lua``` under
```Interface/Addons/gonefishing``` in your WoW directory.


## Limitations

Gone Fishing is dumb and does not save your previous equipment to
disk.  If you log out while wearing your fishing gear, Gone Fishing
can't switch back to your original gear after you log in again.
(In fact Gonefishing will think your fishing gear is your original
gear and again become confused.)

Gone Fishing uses an equipment set named "GONEFISHING_tmp" to store
your original gear.  After restoring your gear, the equipment set is
deleted.  So be warned: If you create you own equipment set named
"GONEFISHING_tmp", it will be overwritten and deleted.  Of course
nobody will ever name their equipment sets that way, but you
officially have been warned :-)


#### Todo list

- does not take enchantments (eg. gloves) into account
- choose a nice icon for the equipment set
- colorize debug output (unneeded?)
- translate README (don't want to...)
- save stored gear over login/logout.
  check if this could lead to confusion and problems
