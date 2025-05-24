Kid Icarus SNES Port - Rev C

This is a 1:1 port of the NES version of Kid Icarus, running on the SNES. It is utilizing FastROM/HiROM.  Additionally, this port has the following features:
* The Kid Icarus Randomizer (developed by FruitBatSalad and myself) has been built in as an option. This includes
    * The screens in the scrolling levels. These will normally be randomized every load, which means it’ll change on death, but the seed can be fixed via the password screen (see next note)
    * Doors in World 1, World 2 & World 3. There’s no guarantee on the number or types of rooms you’ll find, other than the game will not spawn strength upgrade rooms in world 1 if you already have a strength of +1 or higher. It will not spawn them in world 2 if you have a strength of +3 or higher.
    * Fortresses - These are randomized once per playthrough, so if you die they will always remain the same. The fortresses get longer as the game goes on, with 1-4 being 32 rooms, 2-4 being 40 rooms, and 3-4 being 48 rooms.
    * Enemies in Fortresses - If you see Eggplant Wizards be careful! There might not be a hospital!
    * World 4 screens and enemies
    * Removed the hidden score requirement for upgrade rooms
    * Adjusted prices in shops to be more reasonable
    * Pencil, Map, and Torch functionality are enabled by default in the fortresses so that you can find your way in the new mazes
    * Updated Title Screen & Credits
* Backgrounds, which have been adapted from the 3D Classic Version of Kid Icarus on the 3DS
* Ability to choose between two different NES palettes
* Support for MSU1 music, a selection of tracks are included in this archive, see tracklist.txt for which track is which if you want to replace them.  MSU will fall back to 2A03 if track is not present
* Bill and Lance can help you out if you want a boost

This has been tested in Mesen2, bsnes, Mister, and on original hardware via SD2Snes.

Rev F Changes
* Eggplant status is now a timed status in the randomizer
* Hospitals have been removed from the Fortress levels in the randomizer
* You can now set a randomizer seed in the continue menu:
    * Enable the randomizer on the title screen
    * Enter any 6 character password that starts with:  KI
* fixed randomization of enemies in worlds 2, 3, and 4

KNOWN ISSUES
--------------------
* For the fortresses a path is generated so that they should be completable from any room that you can get to. This does not count going into the corner of a room that is a dead-end in and of itself, so don’t go anywhere that you shouldn’t =)
* because of the ordering of sprites/bg1/bg2 the spike enemies in fortresses appear on top of the bg tile they use

WHAT & HOW TO REPORT TO ME
--------------------------------------------
If you encounter issues and would like to report them to me, please reach out to @rumbleminze on Twitter/X

Happy Gaming!
-Rumbleminze