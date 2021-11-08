![alt link](https://forums.alliedmods.net/image-proxy/92faeeab856647eeb4e5cccb54e5120e99eeb3ff/68747470733a2f2f692e696d6775722e636f6d2f4f4e5a595441302e676966/)

## Description:
- With this Lasermine you can custonomize any way you want using the menu (You can open with a bind or writing in say /lm);
- You can change Glow/Line Color;
- You can change Model that you want;
- You can change Lasermine Skin;
- You can change Line Sprite;
- And More...

## Configuring and Install:
- First at all you need edit .sma file to configure for your main plugin and set to a extra item mode

**Example:**
- I use Zombie Plague Special and i want to set the lasermine for zp special only and in a extra item mode. I needed to make this:

**Find**
```
// Uncomment your Main Plugin Version
#define ZP_43 // Zombie Plague 4.3
//#define ZP_50 // Zombie Plague 5.0
//#define ZP_ADVANCE // Zombie Plague Advance
//#define ZP_SPECIAL // Zombie Plague Special


// You want a lasermine like a extra item? 
// If yes uncomment "#define EXTRA_ITEM_VERSION"
//#define EXTRA_ITEM_VERSION
#define LM_COST 10 // Price of lasermine in a extra item menu
```

**Change to**
```
// Uncomment your Main Plugin Version
//#define ZP_43 // Zombie Plague 4.3
//#define ZP_50 // Zombie Plague 5.0
//#define ZP_ADVANCE // Zombie Plague Advance
#define ZP_SPECIAL // Zombie Plague Special


// You want a lasermine like a extra item? 
// If yes uncomment "#define EXTRA_ITEM_VERSION"
//#define EXTRA_ITEM_VERSION
#define LM_COST 10 // Price of lasermine in a extra item menu
```

Now i compile the plugin and install.

**How to Install????**
- .amxx file in plugins directory (cstrike/addons/amxmodx/plugins)
- .cfg in configs directory (cstrike/addons/amxmodx/configs)
- .txt in lang directory (cstrike/addons/amxmodx/data/lang)
- Any resources directory (models, sprites and sound) in a cstrike directory

## Line Sprite List:
![alt link](https://forums.alliedmods.net/image-proxy/2ab39bf9fc4e815890f7d513f5539c3f53f26950/68747470733a2f2f692e696d6775722e636f6d2f564245326168702e706e67/)

## Screenshoot:
- https://steamuserimages-a.akamaihd.net/ugc/874122013279081458/666B419B4A6C0BB947158FB60107DF5A56CB79EC/
- https://steamuserimages-a.akamaihd.net/ugc/870744894164667683/C6AB4E085AEECBECE5123AC720A16296433EE6DF/

## Video (4.2 Version)
- https://www.youtube.com/watch?v=pw3YgYikFPo

## Cvars: 
```
// Original Lasermine Cvars
zp_ltm "1"			; Lasermine ON/OFF (1 / 0)
zp_ltm_admin_only "0"		; Lasermine access level (0 is all, 1 is admin only)
zp_ltm_max_deploy "1" 		; Max have ammo and max deploy count.
zp_ltm_dmg "200"		; Laser hit damage.
zp_ltm_health "250" 		; Lasermines health. over 1000 is very hard mine :)
zp_ltm_radius "320.0"		; Lasermine explode radius. ( it's float value)
zp_ltm_rdmg "100"		; Lasermine explode damage. ( on center )
zp_ltm_line "1"			; Lasermine line (0 is invisible, 1 is visible)
zp_ltm_glow "1"			; Lasermine Glow (0: Disable | 1: Enable)
zp_ltm_bright "255"		; Laser line brightness.
zp_ltm_ldmgmode "2"		; Laser hit damage mode. (0 is frame dmg, 1 is once dmg, 2 is seconds dmg)
zp_ltm_ldmgseconds "1"		; Seconds dmg. (dmg mode 2 only, damage / seconds default 1 sec)

// Edited Version Cvars
zp_ltm_glow_color_aleatory "1"	; Random Glow Color (0: Disable | 1: Enable)
zp_ltm_line_color_aleatory "1"	; Random Line Color (0: Disable | 1: Enable)
zp_ltm_glow_color "0 255 0" 	; Glow RGB color (If when (zp_ltm_glow_color_aleatory) stay off)
zp_ltm_line_color "255 0 0" 	; Line RGB color (If when (zp_ltm_line_color_aleatory) stay off)
zp_ltm_show_status "1"		; Show Lasermine HUD
zp_ltm_ap_for_kill_allow "1"	; Allow ap reward (0: Disable | 1: Enable)
zp_ltm_ap_for_kill_quantity "2"	; Ammo packs reward quantity
zp_ltm_autobind_enable "1"	; Auto Bind? (0: Disable | 1: Enable)
zp_ltm_ignore_frags "1"		; Ignore Frags? (0: Disable | 1: Enable)
zp_ltm_flag_acess "b"		; Lasermine Flag Access (If "zp_ltm_admin_only" is enable)
zp_ltm_menu_enable "1"		; Enable lasermine main menu (0: Disable | 1: Enable)
zp_ltm_default_model "-1"	; Default model (-1: Randonized | 0: Classic | 1: Normal | 2: Gauss | 3: Alien | 4: Perfect | 5: End of Day | 6: Kraken's Eye | 7: Eyeball | 8: Infinity Gauntlet)
zp_ltm_default_sprite "-1"	; Default sprite (-1: Randonized | 0: Normal | 1: Shock | 2: Neon | 3: Dotted | 4: 4i20 | 5: Triangle | 6: Double Line | 7: Spiral | 8 - Heartbeat | 9 - Love Heart | 10 - Am. Start | 11 - Skull)
zp_ltm_solid "0"		; Lasermine solid? (0: Disable | 1: Enable)	
zp_ltm_breakable_block "1"	; Only Owner/Zombies Can Destroy Lasermine? (0: Disable | 1: Zombies/Owner Only Can Destroy | 2: Owner Only Can Destroy)
zp_ltm_remove_distance "200.0"	; Lasermine Max Distance for remove
zp_ltm_realistic_detail "0"	; Realistic Detail [Line cuts when player pass] (0: Disable | 1: Enable)

///////////////////////////// 4.3 Version - New Cvars //////////////////////////////
zp_ltm_immediate_change "1" 	; Change Model/Skin/Glow Immediatly without replant
zp_ltm_model_menu "1"		; Change Model Menu (0: Disable | 1: Enable)
zp_ltm_skin_menu "1"		; Change Skin Menu (0: Disable | 1: Enable)
zp_ltm_default_skin_id "-1"	; Skin ID (-1: Randonized | 0 - 5: ID of Model Skin)
zp_ltm_allowed_specials "1"	; Survivor/Sniper/Berserker/Wesker/Spy Can deploy the lasermine? (0: Not | 1: Yes)
zp_ltm_mode "1"			; Lasermine Mode (0 - Tripmine (Simple Explode) | 1 - Lasermine)
zp_ltm_knockback "1"		; Explosion Knockback? (0 - No | 1 - Only Zombies | 2 - Affect Owner too | 3 - All Players)
zp_ltm_start_ammo "0"		; Start Ammo of Lasermine (ONLY IN EXTRA ITEM VERSION !!)		

// Game Mode Cvars 
zp_ltm_enable_in_infection "1" // Allowed Lasermine in Infection Mode
zp_ltm_enable_in_multi "1" // Allowed Lasermine in Multi-infection Mode
zp_ltm_enable_in_swarm "1" // Allowed Lasermine in Swarm Mode
zp_ltm_enable_in_plague "1" // Allowed Lasermine in Plague Mode
zp_ltm_enable_in_nemesis "1" // Allowed Lasermine in Nemesis Mode
zp_ltm_enable_in_survivor "1" // Allowed Lasermine in Survivor Mode

// Cvars for ZP 50 / Advance / Special Only
zp_ltm_enable_in_armageddon "1" // Allowed Lasermine in Armageddon Mode

// Cvars for ZP Advance/Special Only
zp_ltm_enable_in_sniper "1" // Allowed Lasermine in Sniper Mode
zp_ltm_enable_in_assassin "1" // Allowed Lasermine in Assassin Mode
zp_ltm_enable_in_custom "1" // Allowed Lasermine in Custom Mode

// Cvars for ZP Special Only
zp_ltm_enable_in_berserker "1" // Allowed Lasermine in Berserker Mode
zp_ltm_enable_in_predator "1" // Allowed Lasermine in Predator Mode
zp_ltm_enable_in_wesker "1" // Allowed Lasermine in Wesker Mode
zp_ltm_enable_in_bombardier "1" // Allowed Lasermine in Bombardier Mode
zp_ltm_enable_in_spy "1" // Allowed Lasermine in Spy Mode
zp_ltm_enable_in_dragon "1" // Allowed Lasermine in Dragon Mode
```

## Change Log:
```
* 1.0:
	- First Version.
* 1.1:
	- Fixed bug that Lasermine Dont Works.
	- Show Lasermine Owner Name.
	- Make Random Color Of Glow/Line in raibom style (When Enable).
* 1.2:
	- Fixed Bug: When Player Die and Lasermine dont removed
	- Fixed Bug: Cant Plant If your Lasermine destroyed one time
* 1.3:
	- Added: Solid Mode
* 1.4:
	- Fixed Some Bugs
	- Added Natives and Forwards
* 2.0:
	- Fixed Some Error Logs.
* 2.1:
	- Fixed Some Bugs.
	- Added More Cvars for Easily Config.
* 2.2:
	- Fixed More Error Logs
	- Added Lasermine Main Menu for Personal Configuration
* 2.3:
	- Fixed bug when R,G,B are equal to 0 for make line invisible
	- Fixed bug when some time radius crashes the server
	- New Main Menu Options (Choose Sprites/Models)
* 3.0:
	- Added More Models
	- Added Lang Support
* 3.1:
	- Added More Sprites
* 3.2/3.3:
	- Fixed More Error Logs
	- Added More Cvars for Easily Config.
* 3.4:
	- Fixed More Error Logs
	- Added Model "Perfect Lasermine"
* 4.0:
	- Fixed Some error logs
	- Fixed Small bug when plant lasermine and lasermine does not stay in the wall
	- Added one Cvar for define the max distance for remove the Lasermine
	- Added mode for lasermine can kill entities (Like Oberon Boss and Others)
* 4.1:
	- Improved Code
	- Fixed Lang
* 4.2:
	- Added more Models/Sprites for Lasermine
	- Added Realistic Detail of Lasermine (Cut the laser when it passes over)
	- End of Style "Rainbow" for Reduce Lag
	- Fixed Native/Cvar Error Logs
	- Improved Code
	- Fixed Forward "zp_fw_lm_planted_pre"
	- Removed Native "zp_get_lasermine_id"
	- Removed CZ Tutor Print (Because some steam players have bug when show tutor in screen)
* 4.3:
	- Fixed Error Log
	- Fixed Neon Color Line Sprite (Color are rights. Now white color are white color even and not yellow color)
	- Improved Dotted Line Sprite (More Dotts are appears now)
	- Added cvars for enable lasermine in certain gamemode.
	- Added Skin System
	- Removed Red Eye Model
	- Alien 2 (Dark Alien) are now skin of Alien 1
	- Added Eyeball and Infinity Gauntlet LM Model
	- Now are 9 models in 1 mdl (Need Update Resources)
	- Some with Sprites - 10 sprites in 1 .spr (Need Update Resources)
	- Added Sprites: Heartbeat, Love Heart, Amazing Stars, Skull
	- Added Remove Glow Option (In choose glow menu)
	- Updated Lang
	- Added Extra Item Configuration 
	- Added ZP Version Configuration
	- Added Many Cvars (See the ltm_cvars.cfg)
	- Added Lasermine Mode (Simple Explode or Normal lasermine)
```



