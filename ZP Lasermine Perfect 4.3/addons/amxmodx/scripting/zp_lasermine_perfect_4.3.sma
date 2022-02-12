/*==================================================================================================================================================================================================================================================
											[Plugin Edited/Made By:]

||||||||             |||||||							||||||||             |||||||	     ||||||||		|||||||			     ||||||||		|||||||            ||||||||	     ||||||||
||	||||||||||| 	  ||		     	     ||||			||	||||||||||||	  ||	     ||	     ||||||||||	     ||			     ||	    ||||||||||||     ||		   ||	   ||	   ||	   ||
||	||	  ||	  ||			     ||				||           ||		  ||	     ||	    ||		     ||			     ||	    ||	      ||     ||            ||	   ||	   ||	   ||
||	||	   || 	  ||			     ||				||           ||		  ||	     ||	    ||		     ||  		     ||	    || |||||  ||     ||            ||	   ||	   ||	   ||
||	||	   || 	  ||	||||||||  |||||||| ||||||| ||||||||  ||||||||	||           ||		  ||	     ||      ||||||||||	     ||  ||||||||  ||||||||  ||     || || ||  ||     ||  |||||||   ||	   ||||||||||	   ||
||	||||||||||||  	  ||	||    ||  ||	     ||    ||    ||  ||		||           ||		  ||	     ||		      ||     ||	 ||	   ||	     ||	    || |||||| ||     || ||         ||	   ||	   ||	   ||
||	||	      	  ||	||||||||  ||	     ||    ||||||||  ||		||           ||		  ||	     ||		      ||     ||	 ||	   ||	     ||     ||	      ||     || ||||||||   ||	   ||	   ||	   ||
||	||	      	  ||	||        ||	     ||    ||        ||		||           ||		  ||	     ||	     ||||||||||	     ||	 ||        ||        ||     ||||||||||||     ||        ||  ||	   ||	   ||	   ||
||	||	      	  ||	||||||||  ||	     ||    ||||||||  ||||||||	||||||||	     |||||||	     ||||||||		|||||||  ||||||||  ||        ||||||||		||||||| ||||||||   ||||||||	     ||||||||
||||||||	     |||||||
	
		=|-----------------------------------------------------------------------------------------------------------------------------------------------------|=
				
											----------[Change Logs]----------
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
									- Adicionado um esquema para matar o Boss Na Lasermine
									- Added mode for lasermine can kill entities (Like Oberon Boss and Others)
								* 4.1:
									- Improved Code
									- Fixed Lang
								* 4.2:
									- Added more Models/Sprites for Lasermine
									- Added Realistic Detail of Lasermine (Cut the laser mine when it passes over)
									- End of Style "Rainbow" for Reduce Lag
									- Fixed Native/Cvar Error Logs
									- Improved Code
									- Fixed Forward "zp_fw_lm_planted_pre"
									- Removed CZ Tutor Print (Because some steam players have bug when show tutor in screen)
								* 4.3:
									- Fixed Error Log
									- Fixed Neon Color Line Sprite (Color are rights. Now white color are white color even and not yellow color)
									- Fixed Dotted Line Sprite (More Dotts are appears now)
									- Added cvars for enable lasermine in certain gamemode.
									- Added Skin System
									- Removed Red Eye Model
									- Alien 2 (Dark Alien) are now skin of Alien 1
									- Added Eyeball and Infinity Gauntlet Model
									- Now are 9 models in 1 mdl (Need Update Resources)
									- Some with Sprites - 10 sprites in 1 .spr (Need Update Resources)
									- Added Sprites: Heartbeat, Love Heart, Amazing Stars, Skull
									- Added Remove Glow Option (In choose glow menu)
									- Updated Lang
									- Added Extra Item Configuration 
									- Added ZP Version Configuration
									- Added Many Cvars (See the ltm_cvars.cfg)
									- Added Lasermine Mode (Simple Explode or Normal lasermine)

											----------[Credits]----------
								- [P]erfec[T] [S]cr[@]s[H]: For Editing and Posting this Plugin
								- SandStriker: For Original Version

		=|---------------------------------------------------------------------------------------------------------------------------------------------------------|=					
										      -------------||-------------
====================================================================================================================================================================================================================================================*/

/*===========================================================================================================================================================================================
											[Configuration]
===========================================================================================================================================================================================*/
// Uncomment your Main Plugin Version
//#define ZP_43 // Zombie Plague 4.3
//#define ZP_50 // Zombie Plague 5.0
//#define ZP_ADVANCE // Zombie Plague Advance
#define ZP_SPECIAL // Zombie Plague Special


// You want a lasermine like a extra item? 
// If yes uncomment "#define EXTRA_ITEM_VERSION"
//#define EXTRA_ITEM_VERSION
#define LM_COST 10 // Price of lasermine in a extra item menu

/*===========================================================================================================================================================================================
											[Includes]
===========================================================================================================================================================================================*/
#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <xs>
#include <hamsandwich>

#if defined ZP_43
#include <zombieplague>
const MODE_NONE = 0
const MAX_CVARS = MODE_PLAGUE+1
#endif

#if defined ZP_50
#include <zp50_gamemodes>
#include <zp50_class_zombie>
#define LIBRARY_AMMOPACKS "zp50_ammopacks"
#include <zp50_ammopacks>
#define LIBRARY_SURVIVOR "zp50_class_survivor"
#include <zp50_class_survivor>
#include <cstrike>
const MAX_CVARS = 7

#if defined EXTRA_ITEM_VERSION
#define LIBRARY_EXTRAITEMS "zp50_items"
#include <zp50_items>
#endif
#endif

#if defined ZP_ADVANCE
#include <zombie_plague_advance>
const MODE_CUSTOM = MODE_LNJ+1
const MAX_CVARS = MODE_CUSTOM+1
#endif

#if defined ZP_SPECIAL
#include <zombie_plague_special>
#define MODE_CUSTOM MODE_LNJ+1
const MAX_CVARS = MODE_CUSTOM+1
#endif

/*===========================================================================================================================================================================================
										[Defines, Cvars e Consts]
===========================================================================================================================================================================================*/
#define PLUGIN "[ZP] Addon: Perfect Lasermine"
#define VERSION "4.3"
#define AUTHOR "[P]erfec[T] [S]cr[@]s[H] | SandStriker"

#define RemoveEntity(%1)	engfunc(EngFunc_RemoveEntity,%1)
#define LASERMINE_TEAM		pev_iuser1
#define LASERMINE_OWNER		pev_iuser2
#define LASERMINE_STEP		pev_iuser3
#define LASERMINE_HITING	pev_iuser4
#define LASERMINE_COUNT		pev_fuser1
#define LASERMINE_POWERUP	pev_fuser2
#define LASERMINE_BEAMTHINK	pev_fuser3
#define LASERMINE_BEAMENDPOINT	pev_vuser1

#define LM_HANDLED 91

// Lasermine Think Action
enum { 
	POWERUP_THINK = 0, 
	BEAMBREAK_THINK, 
	EXPLOSE_THINK
};

// If you want to add/remove more models/sprites/sounds you need to edit here first
// PS: If you dont know edit, please, DONT NOT CHANGE
#define MAX_MODELS 9
#define MAX_SPRITES 12
#define MAX_BEAMS 3
#define MAX_SKINS 6
#define MAX_SOUNDS 7

#define TASK_HUD 33092

// Color
enum {
	RED = 0,
	GREEN,
	BLUE,
	CUSTOM_R,
	CUSTOM_G,
	CUSTOM_B,
	MAX_COLOR
}

// Mode
enum {
	GLOW = 0,
	LINE,
	MODEL,
	SKIN,
	SPRITE,
	MAX_MODES
}

// Lasermine Action Sounds
enum { POWERUP_SOUND = 0, ACTIVATE_SOUND, STOP_SOUND }

// Forward
enum {
	PLANTED_PRE = 0,
	PLANTED_POST,
	REMOVED_PRE,
	REMOVED_POST,
	DESTROYED_POST,
	DAMAGED_PRE,
	DAMAGED_POST,
	MAX_FORWARDS
}

// (4.3 Update) Skin Langs
enum _skins { szSkin1[32], szSkin2[32], szSkin3[32], szSkin4[32], szSkin5[32], szSkin6[32] }
new const skin_langs[MAX_MODELS][_skins] = {
	{ "LM_HL_SKIN1", "LM_HL_SKIN2", "LM_HL_SKIN3", "LM_HL_SKIN4", "LM_HL_SKIN5", "LM_HL_SKIN6" },
	{ "LM1_SKIN1", "LM1_SKIN2", "LM1_SKIN3", "LM1_SKIN4", "LM1_SKIN5", "LM1_SKIN6" },
	{ "LM2_SKIN1", "LM2_SKIN2", "LM2_SKIN3", "LM2_SKIN4", "LM2_SKIN5", "LM2_SKIN6" },
	{ "LM3_SKIN1", "LM3_SKIN2", "LM3_SKIN3", "LM3_SKIN4", "LM3_SKIN5", "LM3_SKIN6" },
	{ "LM4_SKIN1", "LM4_SKIN2", "LM4_SKIN3", "LM4_SKIN4", "LM4_SKIN5", "LM4_SKIN6" },
	{ "LM5_SKIN1", "LM5_SKIN2", "LM5_SKIN3", "LM5_SKIN4", "LM5_SKIN5", "LM5_SKIN6" },
	{ "LM6_SKIN1", "LM6_SKIN2", "LM6_SKIN3", "LM6_SKIN4", "LM6_SKIN5", "LM6_SKIN6" },
	{ "LM7_SKIN1", "LM7_SKIN2", "LM7_SKIN3", "LM7_SKIN4", "LM7_SKIN5", "LM7_SKIN6" },
	{ "LM8_SKIN1", "LM8_SKIN2", "LM8_SKIN3", "LM8_SKIN4", "LM8_SKIN5", "LM8_SKIN6" }
}

// Menu Keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

// CS Player PData Offsets
const PDATA_SAFE = 2
const OFFSET_CSMENUCODE = 205
const OFFSET_LINUX = 5

// Models
new const model_langs[MAX_MODELS][] = { 
	"CHOOSE_LM_HL", // Classic
	"CHOOSE_LM1", // Normal
	"CHOOSE_LM2", // Gauss
	"CHOOSE_LM3", // Alien
	"CHOOSE_LM4", // Perfect
	"CHOOSE_LM5", // End of Day
	"CHOOSE_LM6", // Kraken Eye
	"CHOOSE_LM7", // Eyeball
	"CHOOSE_LM8" // Infinity Gauntlet
}


// (4.3 Update) Now are 8 models in 1 mdl
new const LM_MODEL[] = "models/zombie_plague/v_lasermine_perfect_43.mdl"

// Sprites
new const spr_langs[MAX_SPRITES][] = { 
	"CHOOSE_SPR1", // Normal
	"CHOOSE_SPR2", // Shock
	"CHOOSE_SPR3", // Neon
	"CHOOSE_SPR4", // Dotted
	"CHOOSE_SPR5", // 4i20
	"CHOOSE_SPR6", // Triangle
	"CHOOSE_SPR7", // Double Ray
	"CHOOSE_SPR8", // Spiral
	"CHOOSE_SPR9", // Heartbeat
	"CHOOSE_SPR10", // Love Heart
	"CHOOSE_SPR11", // Amazing Stars
	"CHOOSE_SPR12" // Skull
}

new const Sprites[MAX_BEAMS][] = { 
	"sprites/laserbeam.spr", // Default
	"sprites/lgtning.spr", // Shock
	"sprites/lasermine_perfect/lm_line_sprites.spr"	// Others
}
new beam[MAX_BEAMS]
new const Spr_Explode[] = "sprites/zerogxplode.spr"

// Menu Sounds
new const Menu_Sounds[][] = {
	"lasermine_perfect/ok.wav",
	"lasermine_perfect/error.wav"
}

// Lasermine Sounds
new const Lasermine_Sounds[MAX_SOUNDS][] = { 
	"weapons/grenade_hit3.wav", 
	"weapons/gren_cock1.wav", 
	"weapons/hks3.wav",	
	"debris/beamstart9.wav",	
	"items/gunpickup2.wav", 
	"debris/bustglass1.wav", 
	"debris/bustglass2.wav"
}

// Color Lang
new const color_lang[][] = { 
	"COLOR_WHITE", 
	"COLOR_YELLOW", 
	"COLOR_RED", 
	"COLOR_GREEN", 
	"COLOR_BLUE",
	"COLOR_CUSTOM", 
	"COLOR_DEFAULT" 
}

// Entity Properties
new const Lasermine_Classname[] = "zp_lasermine"
new const Breakable_classname[] = "func_breakable";

// Variables
new cvar_lm[36], g_deployed[33], g_lasermine_imune[33], lm_flag_access, boom, allow_plant, g_maxplayers, g_configured_lm[33][MAX_MODES],
g_lasermine_id[MAX_MODES][33], glow_color_RGB[MAX_COLOR][33], line_color_RGB[MAX_COLOR][33], g_invisible_effect[33], g_Burn_SprId

// Forwards
new g_fwDummyResult, g_forward[MAX_FORWARDS]
new cvar_gamemode[MAX_CVARS]

#if defined ZP_50
new g_GameMode[MAX_CVARS]
#endif

#if defined EXTRA_ITEM_VERSION
new g_itemid, g_lm_ammo[33], cvar_start_ammo
#endif

/*===========================================================================================================================================================================================
											[Plugin Register]
===========================================================================================================================================================================================*/
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR); // Plugin Register
	register_cvar("zp_lasermine_perfect", VERSION, FCVAR_SERVER|FCVAR_UNLOGGED|FCVAR_SPONLY); // Dont Remove
	register_dictionary("lasermine_perfect_43.txt") // Lang Register

	// Command Register
	register_clcmd("+setlaser", "Create_Lasermine");
	register_clcmd("+dellaser", "Remove_Lasermine");
	register_clcmd("[LM]Change_color_glow_R", "change_color_glow_red")
	register_clcmd("[LM]Change_color_glow_G", "change_color_glow_green")
	register_clcmd("[LM]Change_color_glow_B", "change_color_glow_blue")
	register_clcmd("[LM]Change_color_line_R", "change_color_line_red")
	register_clcmd("[LM]Change_color_line_G", "change_color_line_green")
	register_clcmd("[LM]Change_color_line_B", "change_color_line_blue")
	register_clcmd("lasermine_menu", "lm_configs_menu")
	register_clcmd("say /lm", "lm_configs_menu")
	register_clcmd("say_team /lm", "lm_configs_menu")
	register_clcmd("say lm", "lm_configs_menu")
	register_clcmd("say_team lm", "lm_configs_menu")
	
	register_cvars()
	
	// Forward Register
	g_forward[PLANTED_PRE] = CreateMultiForward("zp_fw_lm_planted_pre", ET_CONTINUE, FP_CELL)
	g_forward[PLANTED_POST] = CreateMultiForward("zp_fw_lm_planted_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forward[REMOVED_PRE] = CreateMultiForward("zp_fw_lm_removed_pre", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forward[REMOVED_POST] = CreateMultiForward("zp_fw_lm_removed_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forward[DESTROYED_POST] = CreateMultiForward("zp_fw_lm_destroyed_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forward[DAMAGED_PRE] = CreateMultiForward("zp_fw_lm_user_damaged_pre", ET_CONTINUE, FP_CELL, FP_CELL, FP_CELL, FP_CELL)
	g_forward[DAMAGED_POST] = CreateMultiForward("zp_fw_lm_user_damaged_post", ET_IGNORE, FP_CELL, FP_CELL, FP_CELL, FP_CELL)

	// Events
	register_event("DeathMsg", "DeathEvent", "a");
	register_event("ResetHUD", "Spawn_Event", "b");
	RegisterHam(Ham_TakeDamage, Breakable_classname, "Lasermine_TakeDamagePre")

	// Fakemeta Forwards.
	register_forward(FM_Think, "Lasermine_Think");
	register_forward(FM_Touch, "Lasermine_Touch")

	// Register Main Menu
	register_menu("LM Main Menu", KEYSMENU, "lm_configs_menu_handler")

	// Cache Maxplayers
	g_maxplayers = get_maxplayers()

	#if defined EXTRA_ITEM_VERSION
	#if defined ZP_50
	g_itemid = zp_items_register("Lasermine", LM_COST)
	#else
	g_itemid = zp_register_extra_item("Lasermine", LM_COST, ZP_TEAM_HUMAN)
	#endif
	#endif
}

// Cache Cvars
register_cvars() { 
	cvar_lm[0] = register_cvar("zp_ltm_max_deploy", "1");
	cvar_lm[1] = register_cvar("zp_ltm_dmg", "60");	
	cvar_lm[2] = register_cvar("zp_ltm_health", "500");
	cvar_lm[3] = register_cvar("zp_ltm_radius", "320.0");
	cvar_lm[4] = register_cvar("zp_ltm_rdmg", "1000"); 
	cvar_lm[5] = register_cvar("zp_ltm_line", "1");
	cvar_lm[6] = register_cvar("zp_ltm_glow_color", "255 255 255");
	cvar_lm[7] = register_cvar("zp_ltm_line_color", "255 255 255");
	cvar_lm[8] = register_cvar("zp_ltm_show_status", "1");
	cvar_lm[9] = register_cvar("zp_ltm_ap_for_kill_allow", "1");
	cvar_lm[10] = register_cvar("zp_ltm_glow_color_aleatory", "1");
	cvar_lm[11] = register_cvar("zp_ltm_line_color_aleatory", "1");
	cvar_lm[12] = register_cvar("zp_ltm_admin_only", "0");
	cvar_lm[13] = register_cvar("zp_ltm_glow", "1");
	cvar_lm[14] = register_cvar("zp_ltm_ldmgmode", "2"); 
	cvar_lm[15] = register_cvar("zp_ltm_bright", "255");	
	cvar_lm[16] = register_cvar("zp_ltm_ldmgseconds", "1");
	cvar_lm[17] = register_cvar("zp_ltm_autobind_enable", "1");
	cvar_lm[18] = register_cvar("zp_ltm_ignore_frags", "1");
	cvar_lm[19] = register_cvar("zp_ltm_ap_for_kill_quantity", "2");
	cvar_lm[20] = register_cvar("zp_ltm_flag_acess", "b");
	cvar_lm[21] = register_cvar("zp_ltm_default_model", "-1");
	cvar_lm[22] = register_cvar("zp_ltm_menu_enable", "1");
	cvar_lm[23] = register_cvar("zp_ltm_default_sprite", "-1");
	cvar_lm[24] = register_cvar("zp_ltm_solid", "0");
	cvar_lm[25] = register_cvar("zp_ltm_breakable_block", "1");
	cvar_lm[26] = register_cvar("zp_ltm_remove_distance", "200.0");
	cvar_lm[27] = register_cvar("zp_ltm_realistic_detail", "1");
	cvar_lm[28] = register_cvar("zp_ltm_immediate_change", "1");
	cvar_lm[29] = register_cvar("zp_ltm_model_menu", "1");
	cvar_lm[30] = register_cvar("zp_ltm_skin_menu", "1");
	cvar_lm[31] = register_cvar("zp_ltm_default_skin_id", "-1");
	cvar_lm[32] = register_cvar("zp_ltm_allowed_specials", "1");
	cvar_lm[33] = register_cvar("zp_ltm_allowed_kill_in_madness", "1");
	cvar_lm[34] = register_cvar("zp_ltm_mode", "1");
	cvar_lm[35] = register_cvar("zp_ltm_knockback", "1");

	#if defined EXTRA_ITEM_VERSION
	cvar_start_ammo = register_cvar("zp_ltm_start_ammo", "0")
	#endif

	#if defined ZP_50 // ZP 5.0 only
	cvar_gamemode[0] = register_cvar("zp_ltm_enable_in_infection", "1")
	cvar_gamemode[1] = register_cvar("zp_ltm_enable_in_multi", "1")
	cvar_gamemode[2] = register_cvar("zp_ltm_enable_in_swarm", "1")
	cvar_gamemode[3] = register_cvar("zp_ltm_enable_in_plague", "1")
	cvar_gamemode[4] = register_cvar("zp_ltm_enable_in_nemesis", "1")
	cvar_gamemode[5] = register_cvar("zp_ltm_enable_in_survivor", "1")
	cvar_gamemode[6] = register_cvar("zp_ltm_enable_in_armageddon", "1")

	#else // 4.3 / Advance / Special Cvars
	cvar_gamemode[MODE_INFECTION] = register_cvar("zp_ltm_enable_in_infection", "1")
	cvar_gamemode[MODE_MULTI] = register_cvar("zp_ltm_enable_in_multi", "1")
	cvar_gamemode[MODE_SWARM] = register_cvar("zp_ltm_enable_in_swarm", "1")
	cvar_gamemode[MODE_PLAGUE] = register_cvar("zp_ltm_enable_in_plague", "1")
	cvar_gamemode[MODE_NEMESIS] = register_cvar("zp_ltm_enable_in_nemesis", "1")
	cvar_gamemode[MODE_SURVIVOR] = register_cvar("zp_ltm_enable_in_survivor", "1")

	#if !defined ZP_43 
	cvar_gamemode[MODE_SNIPER] = register_cvar("zp_ltm_enable_in_sniper", "1")
	cvar_gamemode[MODE_ASSASSIN] = register_cvar("zp_ltm_enable_in_assassin", "1")	// ZP Advance / Special Cvars
	cvar_gamemode[MODE_LNJ] = register_cvar("zp_ltm_enable_in_armageddon", "1")
	cvar_gamemode[MODE_CUSTOM] = register_cvar("zp_ltm_enable_in_custom", "1")

	#if defined ZP_SPECIAL
	cvar_gamemode[MODE_BERSERKER] = register_cvar("zp_ltm_enable_in_berserker", "1")
	cvar_gamemode[MODE_PREDATOR] = register_cvar("zp_ltm_enable_in_predator", "1")
	cvar_gamemode[MODE_WESKER] = register_cvar("zp_ltm_enable_in_wesker", "1")				// ZP Special Cvars only
	cvar_gamemode[MODE_BOMBARDIER] = register_cvar("zp_ltm_enable_in_bombardier", "1")
	cvar_gamemode[MODE_SPY] = register_cvar("zp_ltm_enable_in_spy", "1")
	cvar_gamemode[MODE_DRAGON] = register_cvar("zp_ltm_enable_in_dragon", "1")
	#endif

	#endif
	#endif
}

/*------------------------------------------------------------------------------------
				[Native Register]
-------------------------------------------------------------------------------------*/
public plugin_natives() {
	register_library("zp_lasermine_perfect")
	register_native("zp_get_user_lm_imunne", "native_get_user_lm_imunne", 1)
	register_native("zp_set_user_lm_imunne", "native_set_user_lm_imunne", 1)
	register_native("zp_get_user_lm_deployed_num", "native_get_user_lm_deployed_num", 1)
	register_native("zp_remove_lasermine", "native_remove_lasermine", 1)
	
	register_native("zp_is_valid_lasermine", "native_is_valid_lasermine", 1)
	register_native("zp_lasermine_get_owner", "native_lasermine_get_owner", 1)
	register_native("zp_set_lasermine_health", "native_set_lasermine_health", 1)
	register_native("zp_get_lasermine_health", "native_get_lasermine_health", 1)
	
	register_native("zp_set_user_ltm_model", "native_set_user_ltm_model", 1)
	register_native("zp_get_user_ltm_model", "native_get_user_ltm_model", 1)
	register_native("zp_set_user_ltm_sprite", "native_set_user_ltm_sprite", 1)
	register_native("zp_get_user_ltm_sprite", "native_get_user_ltm_sprite", 1)
	register_native("zp_set_user_ltm_skin", "native_set_user_ltm_skin", 1)
	register_native("zp_get_user_ltm_skin", "native_get_user_ltm_skin", 1)
	
	register_native("zp_set_ltm_line_color", "native_set_ltm_line_color", 1)
	register_native("zp_get_ltm_line_color_id", "native_get_ltm_line_color_id", 1)
	register_native("zp_set_ltm_glow_color", "native_set_ltm_glow_color", 1)
	register_native("zp_get_ltm_glow_color_id", "native_get_ltm_glow_color_id", 1)

	#if defined ZP_50
	set_module_filter("module_filter")
	set_native_filter("native_filter")
	#endif
}

#if defined ZP_50
public module_filter(const module[])
{
	if (equal(module, LIBRARY_AMMOPACKS) || equal(module, LIBRARY_SURVIVOR))
		return PLUGIN_HANDLED;

	#if defined EXTRA_ITEM_VERSION
	if(equal(module, LIBRARY_EXTRAITEMS))
		return PLUGIN_HANDLED;
	#endif
	
	return PLUGIN_CONTINUE;
}
public native_filter(const name[], index, trap) {
	if (!trap) return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}
#endif

/*------------------------------------------------------------------------------------
				[Plugin Precache]
-------------------------------------------------------------------------------------*/
public plugin_precache() {
	new i
	for(i = 0; i < sizeof Lasermine_Sounds; i++) 
		precache_sound(Lasermine_Sounds[i]);

	for(i = 0; i < sizeof Menu_Sounds; i++)
		precache_sound(Menu_Sounds[i]);
	
	for(i = 0; i < MAX_BEAMS; i++) 
		beam[i] = precache_model(Sprites[i]);

	precache_model(LM_MODEL);
	boom = precache_model(Spr_Explode);
	g_Burn_SprId = precache_model("sprites/muzzleflash1.spr")
}

/*------------------------------------------------------------------------------------
			   [Load Configs]
-------------------------------------------------------------------------------------*/
public plugin_cfg() {
	#if defined ZP_50
	g_GameMode[0] = zp_gamemodes_get_id("Infection Mode")
	g_GameMode[1] = zp_gamemodes_get_id("Multiple Infection Mode")
	g_GameMode[2] = zp_gamemodes_get_id("Swarm Mode")
	g_GameMode[3] = zp_gamemodes_get_id("Plague Mode")
	g_GameMode[4] = zp_gamemodes_get_id("Nemesis Mode")
	g_GameMode[5] = zp_gamemodes_get_id("Survivor Mode")
	g_GameMode[6] = zp_gamemodes_get_id("Armageddon Mode")
	#endif

	arrayset(g_deployed, 0, sizeof(g_deployed));

	new file[64]; get_localinfo("amxx_configsdir",file,63);
	format(file, 63, "%s/ltm_cvars.cfg", file);
	
	if(file_exists(file)) server_cmd("exec %s", file), server_exec();
	else log_amx("[Lasermine Perfect %s] ltm_cvars.cfg Not Found", VERSION)
	
	new lm_access[32]; get_pcvar_string(cvar_lm[20], lm_access, sizeof(lm_access)-1)
	lm_flag_access = read_flags(lm_access)
}

/*===========================================================================================================================================================================================
										     [Command Action]
===========================================================================================================================================================================================*/
// Remove Lasermine
public Remove_Lasermine(id) {
	if(!Allow_Remove(id)) 
		return PLUGIN_HANDLED;
	
	static tgt,body, Float:vo[3],Float:to[3]; get_user_aiming(id,tgt,body);

	if(!is_entity_pdata_valid(tgt)) 
		return PLUGIN_HANDLED;

	ExecuteForward(g_forward[REMOVED_PRE], g_fwDummyResult, id, tgt)

	if (g_fwDummyResult >= LM_HANDLED)
		return PLUGIN_HANDLED;
	
	pev(id,pev_origin,vo); pev(tgt,pev_origin,to);
	
	if(get_distance_f(vo,to) > get_pcvar_float(cvar_lm[26])) 
		return PLUGIN_HANDLED;
		
	static EntityName[32]; pev(tgt, pev_classname, EntityName, 31);
	if(equal(EntityName, Lasermine_Classname) && pev(tgt,LASERMINE_OWNER) == id) {
		RemoveEntity(tgt); 
		g_deployed[id]--;
		#if defined EXTRA_ITEM_VERSION
		g_lm_ammo[id]++;
		#endif
		emit_sound(id, CHAN_ITEM, Lasermine_Sounds[4], VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
		ExecuteForward(g_forward[REMOVED_POST], g_fwDummyResult, id, tgt)
	}
	return PLUGIN_CONTINUE;
}

// Create Lasermine
public Create_Lasermine(id) {
	ExecuteForward(g_forward[PLANTED_PRE], g_fwDummyResult, id)
	
	if (g_fwDummyResult >= LM_HANDLED || !Allow_Plant(id)) 
		return PLUGIN_HANDLED;

	if(!g_configured_lm[id][MODEL]) g_lasermine_id[MODEL][id] = random_num(0, MAX_MODELS-1)
	if(!g_configured_lm[id][SKIN]) g_lasermine_id[SKIN][id] = random_num(0, MAX_SKINS-1)
	if(!g_configured_lm[id][SPRITE] && !g_deployed[id]) g_lasermine_id[SPRITE][id] = random_num(0, MAX_SPRITES-1)

	// motor
	new i_Ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, Breakable_classname));
	if(!i_Ent) {
		client_printcolor(id, "%L Nao Foi Possivel Cria a Entidade", id, "CHATTAG");
		return PLUGIN_HANDLED_MAIN;
	}

	set_pev(i_Ent,pev_classname,Lasermine_Classname);
	engfunc(EngFunc_SetModel,i_Ent, LM_MODEL);
	set_pev(i_Ent, pev_body, g_lasermine_id[MODEL][id]);
	set_pev(i_Ent, pev_skin, g_lasermine_id[SKIN][id]);
	set_pev(i_Ent, pev_solid, SOLID_NOT);
	set_pev(i_Ent, pev_movetype, MOVETYPE_FLY);
	set_pev(i_Ent, pev_frame, 0);
	
	set_pev(i_Ent,pev_sequence,0);
	
	set_pev(i_Ent, pev_framerate,0);
	set_pev(i_Ent, pev_takedamage, DAMAGE_YES);
	set_pev(i_Ent, pev_dmg, 100.0);
	
	set_user_health(i_Ent,get_pcvar_num(cvar_lm[2]));
	
	static Float:vOrigin[3];
	static Float:vNewOrigin[3],Float:vNormal[3],Float:vTraceDirection[3], Float:vTraceEnd[3],Float:vEntAngles[3];
	pev(id, pev_origin, vOrigin);
	vOrigin[2] += 15
	velocity_by_aim(id, 500, vTraceDirection);
	xs_vec_add(vTraceDirection, vOrigin, vTraceEnd);
	engfunc(EngFunc_TraceLine, vOrigin, vTraceEnd, DONT_IGNORE_MONSTERS, id, 0);
	
	static Float:fFraction;
	get_tr2(0, TR_flFraction, fFraction);
	
	// -- We hit something!
	if (fFraction < 1.0) {
		// -- Save results to be used later.
		get_tr2(0, TR_vecEndPos, vTraceEnd);
		get_tr2(0, TR_vecPlaneNormal, vNormal);
	}

	xs_vec_mul_scalar(vNormal, 8.0, vNormal);
	xs_vec_add(vTraceEnd, vNormal, vNewOrigin);

	engfunc(EngFunc_SetSize, i_Ent, Float:{ -4.0, -4.0, -4.0 }, Float:{ 4.0, 4.0, 4.0 });
	engfunc(EngFunc_SetOrigin, i_Ent, vNewOrigin);

	// -- Rotate tripmine.
	vector_to_angle(vNormal,vEntAngles);
	set_pev(i_Ent,pev_angles,vEntAngles);

	// -- Calculate laser end origin.
	static Float:vBeamEnd[3], Float:vTracedBeamEnd[3];
        
	xs_vec_mul_scalar(vNormal, 8192.0, vNormal);
	xs_vec_add(vNewOrigin, vNormal, vBeamEnd);

	engfunc(EngFunc_TraceLine, vNewOrigin, vBeamEnd, IGNORE_MONSTERS, -1, 0);

	get_tr2(0, TR_vecPlaneNormal, vNormal);
	get_tr2(0, TR_vecEndPos, vTracedBeamEnd);

	// -- Save results to be used later.
	set_pev(i_Ent, LASERMINE_OWNER, id);
	set_pev(i_Ent,LASERMINE_BEAMENDPOINT, vTracedBeamEnd);
	static Float:fCurrTime
	fCurrTime = get_gametime();

	set_pev(i_Ent,LASERMINE_POWERUP, fCurrTime + 0.1);
   
	set_pev(i_Ent,LASERMINE_STEP,POWERUP_THINK);
	set_pev(i_Ent,pev_nextthink, fCurrTime + 0.1);

	if(g_lasermine_id[LINE][id] == 0 && !g_deployed[id]) {
		static szColors_line[16]
		if(!get_pcvar_num(cvar_lm[11])) {
			get_pcvar_string(cvar_lm[7], szColors_line, 15)
									
			static gRed2[4], gGreen2[4], gBlue2[4], iRed2, iGreen2, iBlue2
			parse(szColors_line, gRed2, 3, gGreen2, 3, gBlue2, 3)
										
			iRed2 = clamp(str_to_num(gRed2), 0, 255)
			iGreen2 = clamp(str_to_num(gGreen2), 0, 255)
			iBlue2 = clamp(str_to_num(gBlue2), 0, 255)
						
			line_color_RGB[RED][id] = iRed2;
			line_color_RGB[GREEN][id] = iGreen2;
			line_color_RGB[BLUE][id] = iBlue2;
		}
		if(get_pcvar_num(cvar_lm[11])) {
			line_color_RGB[RED][id] = random_num(0,255);
			line_color_RGB[GREEN][id] = random_num(0,255);
			line_color_RGB[BLUE][id] = random_num(0,255);
		}
	}
	
	if(get_pcvar_num(cvar_lm[13]))
		Lasermine_Set_Glow(i_Ent)

	PlaySound(i_Ent,POWERUP_SOUND);
	g_deployed[id]++;

	#if defined EXTRA_ITEM_VERSION
	g_lm_ammo[id]--;
	#endif
	
	ExecuteForward(g_forward[PLANTED_POST], g_fwDummyResult, id, i_Ent)
	
	return 1;
}

/*===========================================================================================================================================================================================
											 [LM Action]
===========================================================================================================================================================================================*/
public Lasermine_Think(i_Ent) {
	if(!is_entity_pdata_valid(i_Ent)) 
		return FMRES_IGNORED;
	
	new EntityName[32]; pev(i_Ent, pev_classname, EntityName, 31);
	
	if(!equal(EntityName, Lasermine_Classname)) return FMRES_IGNORED;
		
	static Float:fCurrTime; 
	fCurrTime = get_gametime();
	
	switch(pev(i_Ent, LASERMINE_STEP)) {
		case POWERUP_THINK : {
			static Float:fPowerupTime;
			pev(i_Ent, LASERMINE_POWERUP, fPowerupTime);

			if(fCurrTime > fPowerupTime) {
				set_pev(i_Ent, pev_solid, SOLID_SLIDEBOX);
				set_pev(i_Ent, LASERMINE_STEP, BEAMBREAK_THINK);

				PlaySound(i_Ent, ACTIVATE_SOUND);
			}

			set_pev(i_Ent, pev_nextthink, fCurrTime + 0.1);
		}
		case BEAMBREAK_THINK :
		{
			static Float:vEnd[3],Float:vOrigin[3];
			pev(i_Ent, pev_origin, vOrigin);
			pev(i_Ent, LASERMINE_BEAMENDPOINT, vEnd);

			static iHit, Float:fFraction, Trace_Result;
			engfunc(EngFunc_TraceLine, vOrigin, vEnd, DONT_IGNORE_MONSTERS, i_Ent, Trace_Result);

			get_tr2(Trace_Result, TR_flFraction, fFraction);
			iHit = get_tr2(Trace_Result, TR_pHit);

			// -- Something has passed the laser.
			if (fFraction < 1.0)
			{
				if(get_pcvar_num(cvar_lm[27])) 
					get_tr2(Trace_Result, TR_vecEndPos, vEnd)

				// -- Ignoring others tripmines entity.
				if(pev_valid(iHit))
				{
					pev(iHit, pev_classname, EntityName, 31);
	
					if(!equal(EntityName, Lasermine_Classname))
					{
						set_pev(i_Ent, pev_enemy, iHit);

						if(get_pcvar_num(cvar_lm[34]))
							Lasermine_Damage(i_Ent,iHit);
						
						else if(is_user_connected(iHit)) {
							if(zp_get_user_zombie(iHit))
								set_pev(i_Ent, LASERMINE_STEP, EXPLOSE_THINK);
						}

						set_pev(i_Ent, pev_nextthink, fCurrTime + random_float(0.1, 0.3));
					}
				}
			}
			if(get_pcvar_num(cvar_lm[14])!=0) {
				if(pev(i_Ent,LASERMINE_HITING) != iHit)
					set_pev(i_Ent,LASERMINE_HITING,iHit);
			}
 
			// -- Tripmine is still there.
			if (pev_valid(i_Ent))
			{
				static Float:fHealth;
				pev(i_Ent, pev_health, fHealth);

				if(fHealth <= 0.0 || (pev(i_Ent,pev_flags) & FL_KILLME))
				{
					set_pev(i_Ent, LASERMINE_STEP, EXPLOSE_THINK);
					set_pev(i_Ent, pev_nextthink, fCurrTime + random_float(0.1, 0.3));
				}
                    
				static Float:fBeamthink;
				pev(i_Ent, LASERMINE_BEAMTHINK, fBeamthink);
                    
				if(fBeamthink < fCurrTime && get_pcvar_num(cvar_lm[5]))
				{
					Show_Lasermine_Line(i_Ent, vOrigin, vEnd);
					set_pev(i_Ent, LASERMINE_BEAMTHINK, fCurrTime + 0.1);
				}
				set_pev(i_Ent, pev_nextthink, fCurrTime + 0.01);
			}
		}
		case EXPLOSE_THINK : {
			static id
			id = pev(i_Ent,LASERMINE_OWNER)

			// -- Stopping entity to think
			set_pev(i_Ent, pev_nextthink, 0.0);
			PlaySound(i_Ent, STOP_SOUND);
			g_deployed[id]--;
			Lasermine_Explosion(i_Ent); Lasermine_Radius_Damage(i_Ent); RemoveEntity(i_Ent);
			
			ExecuteForward(g_forward[DESTROYED_POST], g_fwDummyResult, id, i_Ent)
		}
	}

	return FMRES_IGNORED;
}

/*------------------------------------------------------------------------------------
			   [Lasermine Take Damage Pre]
-------------------------------------------------------------------------------------*/
public Lasermine_TakeDamagePre(victim, inflictor, attacker, Float:f_Damage, bit_Damage) { 
	if(!is_entity_pdata_valid(victim)) 
		return HAM_IGNORED;

	static EntityName[32], i_Owner; 

	pev(victim, pev_classname, EntityName, 31);
	if(!equal(EntityName, Lasermine_Classname)) 
		return HAM_IGNORED;
	
	i_Owner = pev(victim, LASERMINE_OWNER) 
	if(i_Owner != attacker && (!zp_get_user_zombie(attacker) && get_pcvar_num(cvar_lm[25]) == 1 || get_pcvar_num(cvar_lm[25]) == 2)) 
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED 
} 

/*------------------------------------------------------------------------------------
			   [Lasermine Sounds]
-------------------------------------------------------------------------------------*/
PlaySound(i_Ent, i_SoundType) {
	if(!is_entity_pdata_valid(i_Ent)) return FMRES_IGNORED;
	
	static EntityName[32]; pev(i_Ent, pev_classname, EntityName, 31);
	if(!equal(EntityName, Lasermine_Classname)) return FMRES_IGNORED;
	
	switch (i_SoundType) {
		case POWERUP_SOUND : {
			emit_sound(i_Ent, CHAN_VOICE, Lasermine_Sounds[0], VOL_NORM, ATTN_NORM, 0, PITCH_NORM);
			emit_sound(i_Ent, CHAN_BODY , Lasermine_Sounds[1], 0.2, ATTN_NORM, 0, PITCH_NORM);
		}
		case ACTIVATE_SOUND: emit_sound(i_Ent, CHAN_VOICE, Lasermine_Sounds[2], 0.5, ATTN_NORM, 1, 75);
		case STOP_SOUND : {
			emit_sound(i_Ent, CHAN_BODY , Lasermine_Sounds[1], 0.2, ATTN_NORM, SND_STOP, PITCH_NORM);
			emit_sound(i_Ent, CHAN_VOICE, Lasermine_Sounds[2], 0.5, ATTN_NORM, SND_STOP, 75);
		}
	}
	
	return FMRES_IGNORED;
}

/*------------------------------------------------------------------------------------
			   [Show Lasermine Line]
-------------------------------------------------------------------------------------*/
Show_Lasermine_Line(i_Ent,const Float:v_Origin[3], const Float:v_EndOrigin[3]) {
	if(!is_entity_pdata_valid(i_Ent)) return FMRES_IGNORED;
	
	static classname[32], tcolor[3], id, sprid, sprwave, sprlife, sprwidth, sprspd, frame, fps; 
	pev(i_Ent, pev_classname, classname, 31) 
	if(!equal(classname, Lasermine_Classname)) return FMRES_IGNORED;
	 
	id = pev(i_Ent,LASERMINE_OWNER)
		
	tcolor[0] = line_color_RGB[RED][id];
	tcolor[1] = line_color_RGB[GREEN][id];
	tcolor[2] = line_color_RGB[BLUE][id];

	sprwave = 0; sprlife = 1; sprwidth = 5; sprspd = 50; frame = 0; fps = 0
	
	switch(g_lasermine_id[SPRITE][id]) {
		case 0:	sprid = beam[0]					// Default
		case 1:	sprid = beam[1], sprwave = 5, fps = 1	// Shock
		case 2:	sprid = beam[2], sprwidth = 25, sprspd = 20	// Neon
		case 3:	sprid = beam[2], sprwidth = 15, frame = 1	// Dotted
		case 4:	sprid = beam[2], sprwidth = 40, sprspd = 15, frame = 2	// 4i20
		case 5:	sprid = beam[2], sprwidth = 8, frame = 3	// Triangle
		case 6:	sprid = beam[2], frame = 4					// Double Ray
		case 7:	sprid = beam[2], sprwidth = 15, frame = 5, sprspd = 20	// Spiral 
		case 8:	sprid = beam[2], sprwidth = 30, sprspd = 10, frame = 6	// Heartbeat 
		case 9:	sprid = beam[2], sprwidth = 30, sprspd = 10, frame = 7	// Heart Love
		case 10: sprid = beam[2], sprwidth = 30, sprspd = 10, frame = 8 // Amazing Star
		case 11: sprid = beam[2], sprwidth = 40, sprspd = 15, frame = 9 // Skull
	}
	
	message_begin(MSG_BROADCAST,SVC_TEMPENTITY);
	write_byte(TE_BEAMPOINTS);
	engfunc(EngFunc_WriteCoord,v_EndOrigin[0]);
	engfunc(EngFunc_WriteCoord,v_EndOrigin[1]);
	engfunc(EngFunc_WriteCoord,v_EndOrigin[2]);
	engfunc(EngFunc_WriteCoord,v_Origin[0]);
	engfunc(EngFunc_WriteCoord,v_Origin[1]);
	engfunc(EngFunc_WriteCoord,v_Origin[2]);
	write_short(sprid);
	write_byte(frame);
	write_byte(fps);
	write_byte(sprlife);	//Life
	write_byte(sprwidth);	//Width
	write_byte(sprwave);	//wave
	write_byte(tcolor[0]); // r
	write_byte(tcolor[1]); // g
	write_byte(tcolor[2]); // b
	write_byte(get_pcvar_num(cvar_lm[15]));
	write_byte(sprspd);
	message_end();

	// Effects when cut
	if(get_pcvar_num(cvar_lm[27])) {
		message_begin(MSG_BROADCAST ,SVC_TEMPENTITY)
		write_byte(TE_EXPLOSION)
		engfunc(EngFunc_WriteCoord, v_EndOrigin[0])
		engfunc(EngFunc_WriteCoord, v_EndOrigin[1])
		engfunc(EngFunc_WriteCoord, v_EndOrigin[2]-10.0)
		write_short(g_Burn_SprId)	// sprite index
		write_byte(1)	// scale in 0.1's
		write_byte(30)	// framerate
		write_byte(TE_EXPLFLAG_NODLIGHTS | TE_EXPLFLAG_NOPARTICLES | TE_EXPLFLAG_NOSOUND)	// flags
		message_end()
	}
	
	return FMRES_IGNORED;
}

/*------------------------------------------------------------------------------------
			   [Lasermine Glow]
-------------------------------------------------------------------------------------*/
public Lasermine_Set_Glow(i_Ent) {
	if(!is_entity_pdata_valid(i_Ent)) return;
	
	static classname[32], id; 

	pev(i_Ent, pev_classname, classname, 31) 
	if(!equal(classname, Lasermine_Classname)) return;
	
	id = pev(i_Ent,LASERMINE_OWNER)

	if(g_lasermine_id[GLOW][id] == -1  || !get_pcvar_num(cvar_lm[13])) {
		set_rendering(i_Ent, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 5);
		return;
	}
		
	switch(g_lasermine_id[GLOW][id]) {
		case 1: {
			glow_color_RGB[RED][id] = 255
			glow_color_RGB[GREEN][id] = 255
			glow_color_RGB[BLUE][id] = 255
		}
		case 2: {
			glow_color_RGB[RED][id] = 255
			glow_color_RGB[GREEN][id] = 255
			glow_color_RGB[BLUE][id] = 0
		}
		case 3: {
			glow_color_RGB[RED][id] = 255
			glow_color_RGB[GREEN][id] = 0
			glow_color_RGB[BLUE][id] = 0
		}
		case 4: {
			glow_color_RGB[RED][id] = 0
			glow_color_RGB[GREEN][id] = 255
			glow_color_RGB[BLUE][id] = 0
		}
		case 5: {
			glow_color_RGB[RED][id] = 0
			glow_color_RGB[GREEN][id] = 255
			glow_color_RGB[BLUE][id] = 255
		}
		case 6: {
			glow_color_RGB[RED][id] = glow_color_RGB[CUSTOM_R][id]
			glow_color_RGB[GREEN][id] = glow_color_RGB[CUSTOM_G][id]
			glow_color_RGB[BLUE][id] = glow_color_RGB[CUSTOM_B][id];
		}
		case 0: {	
			if(!get_pcvar_num(cvar_lm[10])) {
				static szColors[16]; get_pcvar_string(cvar_lm[6], szColors, 15)
				new gRed[4], gGreen[4], gBlue[4], iRed, iGreen, iBlue
				parse(szColors, gRed, 3, gGreen, 3, gBlue, 3)
								
				iRed = clamp(str_to_num(gRed), 0, 255)
				iGreen = clamp(str_to_num(gGreen), 0, 255)
				iBlue = clamp(str_to_num(gBlue), 0, 255)
					
				glow_color_RGB[RED][id] = iRed
				glow_color_RGB[GREEN][id] = iGreen
				glow_color_RGB[BLUE][id] = iBlue
			}
			else if(get_pcvar_num(cvar_lm[10])) glow_color_RGB[RED][id] = random_num(0,255), glow_color_RGB[GREEN][id] = random_num(0,255), glow_color_RGB[BLUE][id] = random_num(0,255);
		}
	}

	set_rendering(i_Ent, kRenderFxGlowShell, glow_color_RGB[RED][id], glow_color_RGB[GREEN][id], glow_color_RGB[BLUE][id], g_invisible_effect[id] ? kRenderTransAlpha : kRenderNormal,5);	
	return;
}

/*------------------------------------------------------------------------------------
			   [Set Damage Effects]
-------------------------------------------------------------------------------------*/
// Radius Damage
Lasermine_Radius_Damage(i_Ent) {
	if(!is_entity_pdata_valid(i_Ent)) return PLUGIN_HANDLED;
	
	static classname[32], Float:originF[3], Float:g_radius, g_damage, victim, attacker; 

	pev(i_Ent, pev_classname, classname, 31) 
	if(!equal(classname, Lasermine_Classname)) return PLUGIN_HANDLED;
	 
	pev(i_Ent, pev_origin, originF)
	
	g_radius = get_pcvar_float(cvar_lm[3])
	g_damage = get_pcvar_num(cvar_lm[4])
	
	victim = -1
	
	attacker = pev(i_Ent, LASERMINE_OWNER)
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, g_radius)) != 0) {
		ExecuteForward(g_forward[DAMAGED_PRE], g_fwDummyResult, victim, attacker, 1, i_Ent)
		
		if (g_fwDummyResult >= LM_HANDLED || !is_user_alive(victim)) 
			continue;
		
		if(zp_get_user_zombie(victim)) 
			set_user_extra_damage(victim, attacker, g_damage, "Lasermine")

		ExecuteForward(g_forward[DAMAGED_POST], g_fwDummyResult, victim, attacker, 1, i_Ent)

		Lasermine_Knockback(i_Ent, get_pcvar_float(cvar_lm[4]), get_pcvar_float(cvar_lm[3]))		
	}
	
	return PLUGIN_CONTINUE
}

// Knockback
Lasermine_Knockback(iCurrent,Float:Amount,Float:Radius) {
	if(!get_pcvar_num(cvar_lm[35]) || !is_entity_pdata_valid(iCurrent))
		return;

	// Get given parameters
	static Float:vecSrc[3]; pev(iCurrent, pev_origin, vecSrc);
	new ent = -1, Float: tmpdmg = Amount, Float:kickback = 0.0;
	
	// Needed for doing some nice calculations :P
	static Float:Tabsmin[3], Float:Tabsmax[3], Float:vecSpot[3], Float:Aabsmin[3], Float:Aabsmax[3], Float:vecSee[3], trRes;
	static Float:flFraction, Float:vecEndPos[3], Float:distance, Float:origin[3], Float:vecPush[3], Float:invlen, Float:velocity[3];

	// Calculate falloff
	static Float:falloff;
	if (Radius > 0.0) falloff = Amount / Radius;
	else falloff = 1.0;
	
	// Find monsters and players inside a specifiec radius
	while((ent = engfunc(EngFunc_FindEntityInSphere, ent, vecSrc, Radius)) != 0) {
		if(!is_user_alive(ent)) 
			continue;
	
		if(!zp_get_user_zombie(ent) && get_pcvar_num(cvar_lm[35]) < 3) {
			if(get_pcvar_num(cvar_lm[35]) == 1 || get_pcvar_num(cvar_lm[35]) == 2 && pev(iCurrent, LASERMINE_OWNER) != ent)
				continue;
		}

		kickback = 1.0; tmpdmg = Amount;
		// The following calculations are provided by Orangutanz, THANKS!
		// We use absmin and absmax for the most accurate information
		pev(ent, pev_absmin, Tabsmin); pev(ent, pev_absmax, Tabsmax);
		xs_vec_add(Tabsmin,Tabsmax,Tabsmin); xs_vec_mul_scalar(Tabsmin,0.5,vecSpot);
			
		pev(iCurrent, pev_absmin, Aabsmin); pev(iCurrent, pev_absmax, Aabsmax);
		xs_vec_add(Aabsmin,Aabsmax,Aabsmin); xs_vec_mul_scalar(Aabsmin,0.5,vecSee);
		
		engfunc(EngFunc_TraceLine, vecSee, vecSpot, 0, iCurrent, trRes);
		get_tr2(trRes, TR_flFraction, flFraction);

		// Explosion can 'see' this entity, so hurt them! (or impact through objects has been enabled xD)
		if (flFraction >= 0.9 || get_tr2(trRes, TR_pHit) == ent) {
			// Work out the distance between impact and entity
			get_tr2(trRes, TR_vecEndPos, vecEndPos);
				
			distance = get_distance_f(vecSrc, vecEndPos) * falloff;
			tmpdmg -= distance;
				
			if(tmpdmg < 0.0) tmpdmg = 0.0;
				
			// Kickback Effect
			if(kickback != 0.0) {
				xs_vec_sub(vecSpot,vecSee,origin);
				
				invlen = 1.0/get_distance_f(vecSpot, vecSee);

				xs_vec_mul_scalar(origin,invlen,vecPush);
				pev(ent, pev_velocity, velocity)
				xs_vec_mul_scalar(vecPush,tmpdmg,vecPush);
				xs_vec_mul_scalar(vecPush,kickback,vecPush);
				xs_vec_add(velocity,vecPush,velocity);
					
				if(tmpdmg < 60.0) xs_vec_mul_scalar(velocity,12.0,velocity);
				else xs_vec_mul_scalar(velocity,4.0,velocity);
				
				if(velocity[0] != 0.0 || velocity[1] != 0.0 || velocity[2] != 0.0) set_pev(ent, pev_velocity, velocity);
			}
		}
	}
	return
}

// Explosion
Lasermine_Explosion(iCurrent) {
	if(!is_entity_pdata_valid(iCurrent)) return;

	static Float:vOrigin[3]; pev(iCurrent,pev_origin,vOrigin);

	message_begin(MSG_BROADCAST, SVC_TEMPENTITY);
	write_byte(99); //99 = KillBeam
	write_short(iCurrent);
	message_end();

	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, vOrigin, 0);
	write_byte(TE_EXPLOSION);
	engfunc(EngFunc_WriteCoord,vOrigin[0]);
	engfunc(EngFunc_WriteCoord,vOrigin[1]);
	engfunc(EngFunc_WriteCoord,vOrigin[2]);
	write_short(boom);
	write_byte(30);
	write_byte(15);
	write_byte(0);
	message_end();
}

// Lasermine Damage
public Lasermine_Damage(iCurrent,isHit) {
	if(!is_entity_pdata_valid(iCurrent))	// Fixed 4.2 Error log
		return PLUGIN_CONTINUE

	if(isHit < 0) return PLUGIN_CONTINUE
	
	switch(get_pcvar_num(cvar_lm[14])) {
		case 1: if(pev(iCurrent,LASERMINE_HITING) == isHit) return PLUGIN_CONTINUE;
		
		case 2:	{
			if(pev(iCurrent, LASERMINE_HITING) == isHit) {
				static Float:cnt
				static now, htime;now = floatround(get_gametime())

				pev(iCurrent, LASERMINE_COUNT, cnt); htime = floatround(cnt)

				if(now - htime < get_pcvar_num(cvar_lm[16])) return PLUGIN_CONTINUE;

				else set_pev(iCurrent,LASERMINE_COUNT, get_gametime())
			}
			else set_pev(iCurrent,LASERMINE_COUNT, get_gametime())
		}
	}

	static Float:vOrigin[3],Float:vEnd[3], szClassName[32], attacker_id
	attacker_id = pev(iCurrent,LASERMINE_OWNER)
	pev(iCurrent,pev_origin,vOrigin); pev(iCurrent,pev_vuser1,vEnd)
	szClassName[0] = '^0'; pev(isHit, pev_classname, szClassName,32)
	
	ExecuteForward(g_forward[DAMAGED_PRE], g_fwDummyResult, isHit, attacker_id, 0, iCurrent)

	if (g_fwDummyResult >= LM_HANDLED) 
		return PLUGIN_CONTINUE;

	if(is_user_connected(isHit)) {
		if(is_user_alive(isHit) && zp_get_user_zombie(isHit) && !g_lasermine_imune[isHit]) {
			emit_sound(isHit, CHAN_WEAPON, Lasermine_Sounds[3], 1.0, ATTN_NORM, 0, PITCH_NORM)
			set_user_extra_damage(isHit, attacker_id , get_pcvar_num(cvar_lm[1]), "Lasermine")	
		}
	}
	else if(is_entity_pdata_valid(isHit) && !equal(szClassName, Lasermine_Classname) && pev(isHit, pev_takedamage) != DAMAGE_NO) {
		emit_sound(isHit, CHAN_WEAPON, Lasermine_Sounds[3], 1.0, ATTN_NORM, 0, PITCH_NORM)
		ExecuteHamB(Ham_TakeDamage, isHit, 0, attacker_id, get_pcvar_float(cvar_lm[1]), DMG_BLAST) 
	}
	
	ExecuteForward(g_forward[DAMAGED_POST], g_fwDummyResult, isHit, attacker_id, 0, iCurrent)
	
	return PLUGIN_CONTINUE
}

/*------------------------------------------------------------------------------------
		   [Set Solid Mode]
-------------------------------------------------------------------------------------*/
public Lasermine_Touch(player, lm) {
	if(!is_user_alive(player) || !is_entity_pdata_valid(lm) || get_pcvar_num(cvar_lm[24])) return FMRES_IGNORED;
	
	static classname[32]; pev(lm, pev_classname, classname, 31) 
	
	if(equal(classname, Lasermine_Classname)) {
		set_pev(lm, pev_solid, SOLID_NOT)
		set_task(1.0, "solid_again", lm)
	}
	return FMRES_IGNORED 
}	

// Back to Solid
public solid_again(lm) {
	if(!is_entity_pdata_valid(lm)) return FMRES_IGNORED;
	
	static classname[32]; pev(lm, pev_classname, classname, 31) 
	if(!equal(classname, Lasermine_Classname)) return FMRES_IGNORED;
	
	set_pev(lm, pev_solid, SOLID_BBOX);
	
	return FMRES_IGNORED;
}

/*------------------------------------------------------------------------------------
		   [Lasermine Hud]
-------------------------------------------------------------------------------------*/
public Lasermine_Hud(iTaskIndex) {
	static iPlayer; iPlayer = iTaskIndex - TASK_HUD;
	if(!is_user_connected(iPlayer)) {
		remove_task(iTaskIndex)
		return;
	}

	static iEntity, iDummy, cClassname[ 32 ], id, name[32]; 
	get_user_aiming(iPlayer, iEntity, iDummy, 9999); 
	pev(iEntity, pev_classname, cClassname, 31);

	id = pev(iEntity, LASERMINE_OWNER); 
	get_user_name(id, name, charsmax(name));
	if(is_user_alive(iPlayer) && is_entity_pdata_valid(iEntity) && equal(cClassname, Lasermine_Classname) && get_pcvar_num(cvar_lm[8])) {
		set_hudmessage(50, 100, 150, -1.0, 0.60, 0, 6.0, 1.1, 0.0, 0.0, -1);
		show_hudmessage(iPlayer, "%L", iPlayer, "SHOW_LM_STATUS", name, pev(iEntity, pev_health));
	}
} 

/*------------------------------------------------------------------------------------
			   [Basic Bug Prevention]
-------------------------------------------------------------------------------------*/
// Client Connect
public client_putinserver(id) {
	g_lasermine_id[LINE][id] = 0
	g_lasermine_id[GLOW][id] = 0
	
	if(get_pcvar_num(cvar_lm[21]) < 0 || get_pcvar_num(cvar_lm[21]) >= MAX_MODELS) {
		g_lasermine_id[MODEL][id] = random_num(0, MAX_MODELS-1)
		g_configured_lm[id][MODEL] = false
	}
	else {
		g_configured_lm[id][MODEL] = true
		g_lasermine_id[MODEL][id] = get_pcvar_num(cvar_lm[21])
	}

	if(get_pcvar_num(cvar_lm[31]) >= MAX_SKINS || get_pcvar_num(cvar_lm[31]) < 0) {
		g_configured_lm[id][SKIN] = false
		g_lasermine_id[SKIN][id] = random_num(0, MAX_SKINS-1)
	}
	else {
		g_configured_lm[id][SKIN] = true
		g_lasermine_id[SKIN][id] = get_pcvar_num(cvar_lm[31])
	}

	if(get_pcvar_num(cvar_lm[23]) >= MAX_SPRITES || get_pcvar_num(cvar_lm[23]) < 0) {
		g_configured_lm[id][SPRITE] = false
		g_lasermine_id[SPRITE][id] = random_num(0, MAX_SPRITES-1)
	}
	else {
		g_configured_lm[id][SPRITE] = true
		g_lasermine_id[SPRITE][id] = get_pcvar_num(cvar_lm[23])
	}

	g_deployed[id] = 0;
	if(get_pcvar_num(cvar_lm[17])) set_task(5.0, "AutoBind", id);
	set_task(1.0, "Lasermine_Hud", id + TASK_HUD, _, _, "b");
}

// Client Disconect
#if AMXX_VERSION_NUM 183
public client_disconnected(id) {
#else
public client_disconnect(id) {
#endif
	RemoveAllTripmines(id);
	remove_task(id + TASK_HUD)
}

// Player Spawn
public Spawn_Event(id) {
	RemoveAllTripmines(id);
	g_lasermine_imune[id] = false

	#if defined EXTRA_ITEM_VERSION
	if(get_pcvar_num(cvar_start_ammo) > 0) 
		g_lm_ammo[id] = get_pcvar_num(cvar_start_ammo)
	else 
		g_lm_ammo[id] = 0
	#endif
	
	if(get_pcvar_num(cvar_lm[22])) client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MENU_INTRODUCTION")
	
	return PLUGIN_CONTINUE
}

// Player Die
public DeathEvent() {
	static id
	id = read_data(2)
	if(is_user_connected(id)) {
		RemoveAllTripmines(id);
		g_lasermine_imune[id] = false
	}
	return PLUGIN_CONTINUE
}


#if defined ZP_50 // ZP 5.0 Version
// Round End
public zp_fw_gamemodes_end() {
	for(new id = 1; id <= g_maxplayers; id++) {
		allow_plant = 0
		g_lasermine_imune[id] = false
		RemoveAllTripmines(id);
	}
}

public zp_fw_core_infect_post(id) RemoveAllTripmines(id); // Player Infected
public zp_fw_core_cure_post(id) RemoveAllTripmines(id); // Use Antidote / Turn to Special Class

// Round Start
public zp_fw_gamemodes_start(gm_id)
{
	allow_plant = -1
	for(new i = 0; i < MAX_CVARS; i++) {
		if (gm_id == g_GameMode[i] && get_pcvar_num(cvar_gamemode[i])) {
			allow_plant = 1
			break;
		}
	}
}

#else // Others Versions
public zp_user_infected_post(id) RemoveAllTripmines(id); // Player Infected
public zp_user_humanized_post(id) RemoveAllTripmines(id); // Use Antidote / Turn to Special Class

// Round End
public zp_round_ended() {
	for(new id = 1; id <= g_maxplayers; id++) {
		allow_plant = 0
		g_lasermine_imune[id] = false
		RemoveAllTripmines(id);
	}
}

// Round Start
public zp_round_started(gamemode) {

	if(gamemode <= MODE_NONE) {
		allow_plant = -1
		return;
	}

	#if defined ZP_43
	if(gamemode > MODE_PLAGUE) {
		allow_plant = -1
		return;
	}
	else {
		allow_plant = get_pcvar_num(cvar_gamemode[gamemode]) ? 1 : -1
		return;
	}
	#else 
	if(gamemode >= MODE_CUSTOM) {	
		allow_plant = get_pcvar_num(cvar_gamemode[MODE_CUSTOM]) ? 1 : -1
		return;
	}
	else {
		allow_plant = get_pcvar_num(cvar_gamemode[gamemode]) ? 1 : -1
		return;
	}
	#endif
}
#endif


// Remove Lasermine
public RemoveAllTripmines(i_Owner) {
	static clsname[32], iEnt;
	iEnt = g_maxplayers + 1;
	while((iEnt = engfunc(EngFunc_FindEntityByString, iEnt, "classname", Lasermine_Classname))) {
		if (i_Owner) {
			if(pev(iEnt, LASERMINE_OWNER) != i_Owner) continue;

			clsname[0] = '^0'
			pev(iEnt, pev_classname, clsname, sizeof(clsname)-1);
                
			if (equali(clsname, Lasermine_Classname)) {
				PlaySound(iEnt, STOP_SOUND);
				RemoveEntity(iEnt);
			}
		}
		else set_pev(iEnt, pev_flags, FL_KILLME);
	}
	g_deployed[i_Owner]=0;
}

// Lasermine Update
public Lasermine_Update_Settings(i_Owner, update) {
	if(!is_user_connected(i_Owner))
		return

	if(!get_pcvar_num(cvar_lm[28])) {
		client_printcolor(i_Owner, "%L %L", i_Owner, "CHATTAG", i_Owner, "STR_SAVE_MODEL");
		return;
	}

	static clsname[32], iEnt;
	iEnt = g_maxplayers + 1;
	while((iEnt = engfunc(EngFunc_FindEntityByString, iEnt, "classname", Lasermine_Classname))) {
		if (i_Owner) {
			if(pev(iEnt, LASERMINE_OWNER) != i_Owner) continue;

			clsname[0] = '^0'
			pev(iEnt, pev_classname, clsname, sizeof(clsname)-1);

			if(!equali(clsname, Lasermine_Classname))
				continue;
		        
			if(update == GLOW)
				Lasermine_Set_Glow(iEnt)

			else if(update == MODEL) {
				set_pev(iEnt, pev_body, g_lasermine_id[MODEL][i_Owner])
				g_configured_lm[i_Owner][MODEL] = true
				g_configured_lm[i_Owner][SKIN] = true
			}

			else if(update == SKIN) {
				set_pev(iEnt, pev_skin, g_lasermine_id[SKIN][i_Owner])
				g_configured_lm[i_Owner][SKIN] = true
				g_configured_lm[i_Owner][MODEL] = true
			}
		}
	}
}

/*------------------------------------------------------------------------------------
			   [Lasermine Binds]
-------------------------------------------------------------------------------------*/
// Auto Bind (If is enable)
public AutoBind(id) {
	client_cmd(id, "bind v +setlaser")
	client_cmd(id, "bind l +dellaser")
	client_cmd(id, "bind p lasermine_menu")
}

// Manual Bind (In Main Menu)
public MakeBind(id) {
	client_cmd(id, "bind v +setlaser")
	client_cmd(id, "bind l +dellaser")
	client_cmd(id, "bind p lasermine_menu")

	set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
	show_hudmessage(id, "%L", id, "STR_MAKE_BIND_SUCEFFULL");

	client_cmd(id, "spk %s", Menu_Sounds[0])
	lm_configs_menu(id);
}

/*===========================================================================================================================================================================================
												[Native Function]
===========================================================================================================================================================================================*/
public native_get_user_lm_imunne(id) return g_lasermine_imune[id];
public native_set_user_lm_imunne(id, bool:isimunne) g_lasermine_imune[id] = isimunne ? true : false;

public native_remove_lasermine(id) RemoveAllTripmines(id);

public native_set_user_ltm_model(id, amount) {
	if(amount >= MAX_MODELS) g_lasermine_id[MODEL][id] = random_num(0, MAX_MODELS-1)
	else g_lasermine_id[MODEL][id] = amount

	Lasermine_Update_Settings(id, MODEL)

	g_lasermine_id[SKIN][id] = 0
	Lasermine_Update_Settings(id, SKIN)
}

public native_get_user_ltm_model(id) return g_lasermine_id[MODEL][id]

public native_set_user_ltm_sprite(id, amount) {
	if(amount >= MAX_SPRITES) g_lasermine_id[SPRITE][id] = random_num(0, MAX_SPRITES-1)
	else g_lasermine_id[SPRITE][id] = amount

	g_configured_lm[id][SPRITE] = true
}

public native_get_user_ltm_sprite(id) return g_lasermine_id[SPRITE][id];

public native_is_valid_lasermine(ent) return is_valid_lasermine(ent);

public native_set_ltm_line_color(id, R, G, B) {
	line_color_RGB[CUSTOM_R][id] = R
	line_color_RGB[CUSTOM_G][id] = G
	line_color_RGB[CUSTOM_B][id] = B
	g_lasermine_id[LINE][id] = 6
}

public native_get_ltm_line_color_id(id) return g_lasermine_id[LINE][id];

public native_set_ltm_glow_color(id, R, G, B) {
	glow_color_RGB[CUSTOM_R][id] = R
	glow_color_RGB[CUSTOM_G][id] = G
	glow_color_RGB[CUSTOM_B][id] = B
	g_lasermine_id[GLOW][id] = 6
	Lasermine_Update_Settings(id, GLOW)
}

public native_get_ltm_glow_color_id(id) return g_lasermine_id[GLOW][id];

public native_lasermine_get_owner(ent) {
	if(!is_valid_lasermine(ent)) return 0;
	
	return pev(ent, LASERMINE_OWNER);
}

public native_set_lasermine_health(ent, amount) {
	if(!is_valid_lasermine(ent)) return 0;
	
	set_pev(ent, pev_health, amount)
	
	return 1;
}

public native_get_lasermine_health(ent) {
	if(!is_valid_lasermine(ent)) return 0;
	
	return pev(ent, pev_health);
}

public native_get_user_lm_deployed_num(id) return g_deployed[id];

public native_set_user_ltm_skin(id, amount) {
	if(amount >= MAX_SKINS) g_lasermine_id[SKIN][id] = random_num(0, MAX_SKINS-1)
	else g_lasermine_id[SKIN][id] = amount

	Lasermine_Update_Settings(id, SKIN)
}

public native_get_user_ltm_skin(id) return g_lasermine_id[SKIN][id]

/*===========================================================================================================================================================================================
											  [Lasermine Main Menu]
===========================================================================================================================================================================================*/
public lm_configs_menu(id) {
	if(!get_pcvar_num(cvar_lm[22])) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MENU_DISABLE")
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}
	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}
	else {
		static menu[1500], len
		len = 0
		len += formatex(menu[len], charsmax(menu) - len, "%L %L^n", id, "MENU_TAG", id, "MENU_CONFIG_TITLE")
		
		len += formatex(menu[len], charsmax(menu) - len, "^n\r1. %s%L", get_pcvar_num(cvar_lm[13]) ? "\w" : "\d", id, "MENU_CHOOSE_GLOW_COLOR");
		len += formatex(menu[len], charsmax(menu) - len, "^n\r2. %s%L", get_pcvar_num(cvar_lm[5]) ? "\w" : "\d", id, "MENU_CHOOSE_LINE_COLOR");
		len += formatex(menu[len], charsmax(menu) - len, "^n\r3. %s%L", get_pcvar_num(cvar_lm[29]) ? "\w" : "\d", id, "MENU_CHOOSE_MODEL");
		len += formatex(menu[len], charsmax(menu) - len, "^n\r4. %s%L", get_pcvar_num(cvar_lm[30]) ? "\w" : "\d", id, "MENU_CHOOSE_SKIN");
		len += formatex(menu[len], charsmax(menu) - len, "^n\r5. %s%L",  get_pcvar_num(cvar_lm[5]) ? "\w" : "\d", id, "MENU_CHOOSE_SPRITE");

		if(get_pcvar_num(cvar_lm[13]) && g_lasermine_id[GLOW][id] != -1)
			len += formatex(menu[len], charsmax(menu) - len, "^n\r6. \w%L %s^n",  id, "MENU_GLOW_INVISIBLE_EFFECT", g_invisible_effect[id] ? "\r[ON]" : "\d[OFF]");
		else
			len += formatex(menu[len], charsmax(menu) - len, "^n\r6. \d%L^n",  id, "MENU_GLOW_INVISIBLE_EFFECT");

		len += formatex(menu[len], charsmax(menu) - len, "^n\r7. \w%L^n", id, "MENU_MAKE_BIND");
		len += formatex(menu[len], charsmax(menu) - len, "^n\r8. \w%L", id, "MENU_SET_LM");
		len += formatex(menu[len], charsmax(menu) - len, "^n\r9. \w%L", id, "MENU_DEL_LM");
		len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0. \w%L", id, "MENU_EXITNAME");

		// Fix for AMXX custom menus
		if (is_entity_pdata_valid(id) == PDATA_SAFE)
			set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)

		show_menu(id, KEYSMENU, menu, -1, "LM Main Menu")
		client_cmd(id, "spk %s", Menu_Sounds[0])
	}
	return PLUGIN_CONTINUE
}

public lm_configs_menu_handler(id, key) { 
	if(!get_pcvar_num(cvar_lm[22])) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MENU_DISABLE")
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}
	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	} 

	switch(key+1) {
		case 1: color_menu(id, GLOW) // Choose Glow Color
		case 2: color_menu(id, LINE) // Choose Line Color
		case 3: choose_menu(id, MODEL) // Choose LM Model
		case 4: choose_menu(id, SKIN) // Choose LM Skin
		case 5: choose_menu(id, SPRITE) // Choose LM Sprite
		case 6: {
			if(!get_pcvar_num(cvar_lm[13]) || g_lasermine_id[GLOW][id] == -1) {
				lm_configs_menu(id)
				return PLUGIN_HANDLED;
			}
			g_invisible_effect[id] = g_invisible_effect[id] ? false : true	// Invisible Effect
			Lasermine_Update_Settings(id, GLOW)
			lm_configs_menu(id)
		}
		case 7: MakeBind(id) // Manual Bind
		case 8: Create_Lasermine(id), lm_configs_menu(id); // Plant Lasermine
		case 9: Remove_Lasermine(id), lm_configs_menu(id); // Remove Lasermine
	}
	return PLUGIN_HANDLED
} 

/*------------------------------------------------------------------------------------
				[Choose Line/Glow Color]
-------------------------------------------------------------------------------------*/
public color_menu(id, mode) {
	if(!get_pcvar_num(cvar_lm[22]))
		return PLUGIN_HANDLED

	if(!get_pcvar_num(cvar_lm[13]) && mode == GLOW || !get_pcvar_num(cvar_lm[5]) && mode == LINE) {
		client_cmd(id, "spk %s", Menu_Sounds[1])
		client_printcolor(id, "%L %L", id, "CHATTAG", id, mode == GLOW ? "STR_GLOW_DISABLE" : "STR_LINE_DISABLE")
		lm_configs_menu(id)
		return PLUGIN_HANDLED
	}

	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}
	set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
	show_hudmessage(id, "%L", id, mode == GLOW ? "STR_CHOOSE_GLOW_COLOR" : "STR_CHOOSE_LINE_COLOR")

	client_cmd(id, "spk %s", Menu_Sounds[0])
	
	static szText[512], szNum[32]
	formatex(szText, charsmax(szText), "%L %L", id, "MENU_TAG", id, mode == GLOW ? "GLOW_COLOR_MENU_TITLE" : "STR_CHOOSE_LINE_COLOR")
	new g_Menu = menu_create(szText, "color_menu_handler")

	if(mode == GLOW) { // No Glow
		formatex(szText, charsmax(szText), "%L %s", id, "OPTION_NOGLOW", g_lasermine_id[mode][id] == -1 ? "\d[\rX\d]" : "\d[]")
		menu_additem(g_Menu, szText, "G:-1")
	}
	for(new i = 1; i <= 7; i++) {
		formatex(szText, charsmax(szText), "%L %s", id, color_lang[i-1], g_lasermine_id[mode][id] == (i == 7 ? 0 : i) ? "\d[\rX\d]" : "\d[]")
		formatex(szNum, charsmax(szNum), "%s%d", mode == GLOW ? "G:" : "L:", i)
		menu_additem(g_Menu, szText, szNum)
	}

	formatex(szText, charsmax(szText), "\w%L", id, "MENU_BACKNAME");
	menu_setprop(g_Menu, MPROP_BACKNAME, szText)
	
	formatex(szText, charsmax(szText), "\w%L", id, "MENU_NEXTNAME");
	menu_setprop(g_Menu, MPROP_NEXTNAME, szText)
	
	formatex(szText, charsmax(szText), "\w%L", id, "MENU_BACK_TO_MAINMENU");
	menu_setprop(g_Menu, MPROP_EXITNAME, szText)
	menu_setprop(g_Menu, MPROP_EXIT, MEXIT_NORMAL)
	
	// Fix for AMXX custom menus
	if (is_entity_pdata_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)

	menu_display(id, g_Menu, 0)  

	return PLUGIN_CONTINUE
}

public color_menu_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		lm_configs_menu(id)
		return PLUGIN_HANDLED
	}
	if(!get_pcvar_num(cvar_lm[22])) {
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static cmd[32], maccess, callback, iChoice 
	menu_item_getinfo(menu, item, maccess, cmd, charsmax(cmd),_,_, callback) 
	iChoice = str_to_num(cmd[2])

	// Glow
	if(equal(cmd, "G:", 2)) {
		if(!get_pcvar_num(cvar_lm[13])) {
			client_cmd(id, "spk %s", Menu_Sounds[1])
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_GLOW_DISABLE")
			menu_destroy(menu)
			lm_configs_menu(id)
			return PLUGIN_HANDLED
		}

		switch(iChoice) {
			case 1: g_lasermine_id[GLOW][id] = 1
			case 2: g_lasermine_id[GLOW][id] = 2
			case 3: g_lasermine_id[GLOW][id] = 3
			case 4: g_lasermine_id[GLOW][id] = 4
			case 5: g_lasermine_id[GLOW][id] = 5
			case 6:  {
				client_cmd(id, "messagemode ^"[LM]Change_color_glow_R^"")
				set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
				show_hudmessage(id, "%L", id, "STR_DEFINE_RED");
			}
			case 7: g_lasermine_id[GLOW][id] = 0
			case -1: g_lasermine_id[GLOW][id] = -1
			
		} 
		Lasermine_Update_Settings(id, GLOW)
	}
	// Line
	if(equal(cmd, "L:", 2)) {
		if(!get_pcvar_num(cvar_lm[5])) {
			client_cmd(id, "spk %s", Menu_Sounds[1])
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_LINE_DISABLE")
			menu_destroy(menu)
			lm_configs_menu(id)
			return PLUGIN_HANDLED
		}
		switch(iChoice) {
			case 1: {
				g_lasermine_id[LINE][id] = 1
				line_color_RGB[RED][id] = 255
				line_color_RGB[GREEN][id] = 255
				line_color_RGB[BLUE][id] = 255;
			}
			case 2: {
				g_lasermine_id[LINE][id] = 2
				line_color_RGB[RED][id] = 255
				line_color_RGB[GREEN][id] = 255
				line_color_RGB[BLUE][id] = 0;
			}
			case 3: {
				g_lasermine_id[LINE][id] = 3
				line_color_RGB[RED][id] = 255
				line_color_RGB[GREEN][id] = 0
				line_color_RGB[BLUE][id] = 0;
			}
			case 4: {
				g_lasermine_id[LINE][id] = 4
				line_color_RGB[RED][id] = 0
				line_color_RGB[GREEN][id] = 255
				line_color_RGB[BLUE][id] = 0;
			}
			case 5: {
				g_lasermine_id[LINE][id] = 5
				line_color_RGB[RED][id] = 0
				line_color_RGB[GREEN][id] = 255
				line_color_RGB[BLUE][id] = 255;
			}
			case 6: {
				client_cmd(id, "messagemode ^"[LM]Change_color_line_R^"")
				set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
				show_hudmessage(id, "%L", id, "STR_DEFINE_RED");
			}
			case 7: {
				g_lasermine_id[LINE][id] = 0
				static szColors_line[16]
				if(!get_pcvar_num(cvar_lm[11])) {
					get_pcvar_string(cvar_lm[7], szColors_line, 15)
									
					static gRed2[4], gGreen2[4], gBlue2[4], iRed2, iGreen2, iBlue2
					parse(szColors_line, gRed2, 3, gGreen2, 3, gBlue2, 3)
										
					iRed2 = clamp(str_to_num(gRed2), 0, 255)
					iGreen2 = clamp(str_to_num(gGreen2), 0, 255)
					iBlue2 = clamp(str_to_num(gBlue2), 0, 255)
						
					line_color_RGB[RED][id] = iRed2;
					line_color_RGB[GREEN][id] = iGreen2;
					line_color_RGB[BLUE][id] = iBlue2;
				}
				if(get_pcvar_num(cvar_lm[11])) {
					line_color_RGB[RED][id] = random_num(0,255);
					line_color_RGB[GREEN][id] = random_num(0,255);
					line_color_RGB[BLUE][id] = random_num(0,255);
				}
			}
		}
	}

	if(iChoice != 6) client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_COLOR_SUCEFFULL")
	client_cmd(id, "spk %s", Menu_Sounds[0])
	menu_destroy(menu)
	lm_configs_menu(id)
	
	return PLUGIN_CONTINUE 
} 
/*------------------------------------------------------------------------------------
				[Custom Color Command Action]
-------------------------------------------------------------------------------------*/
public change_color_glow_red(id) {
	static param[6]; read_argv(1, param, charsmax(param))
	return define_color(id, RED, GLOW, param)
}

public change_color_glow_green(id) {
	static param[6]; read_argv(1, param, charsmax(param))
	return define_color(id, GREEN, GLOW, param)
}

public change_color_glow_blue(id) {
	static param[6]; read_argv(1, param, charsmax(param))
	return define_color(id, BLUE, GLOW, param)
}

public change_color_line_red(id) {
	static param[6]; read_argv(1, param, charsmax(param))
	return define_color(id, RED, LINE, param);
}

public change_color_line_green(id) {
	static param[6]; read_argv(1, param, charsmax(param))
	return define_color(id, GREEN, LINE, param);
}

public change_color_line_blue(id) {
	static param[6]; read_argv(1, param, charsmax(param))
	return define_color(id, BLUE, LINE, param);
}

stock define_color(id, color_mode, mode, const param[]) {			
	if(!is_user_connected(id))
		return PLUGIN_HANDLED;

	for (new x; x < strlen(param); x++) {
		if(!isdigit(param[x])) {
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_DEFINE_COLOR_ERROR1")
			client_cmd(id, "spk %s", Menu_Sounds[1])
			lm_configs_menu(id)
			return PLUGIN_HANDLED        
		}
	}
	static amount
	amount = str_to_num(param)

	if (amount < 0 || amount > 255) {
		lm_configs_menu(id)
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_DEFINE_COLOR_ERROR2")
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED    
	}
	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}
	if(!get_pcvar_num(cvar_lm[22]))
		return PLUGIN_HANDLED

	if(mode == GLOW) // Glow
	{
		if(!get_pcvar_num(cvar_lm[13])) {
			client_cmd(id, "spk %s", Menu_Sounds[1])
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_GLOW_DISABLE")
			lm_configs_menu(id)
			return PLUGIN_HANDLED
		}
		else if(color_mode == RED) {
			glow_color_RGB[CUSTOM_R][id] = amount
			client_cmd(id, "messagemode ^"[LM]Change_color_glow_G^"");
			set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
			show_hudmessage(id, "%L", id, "STR_DEFINE_GREEN");
		}
		else if(color_mode == GREEN) {
			glow_color_RGB[CUSTOM_G][id] = amount
			client_cmd(id, "messagemode ^"[LM]Change_color_glow_B^"");
			set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
			show_hudmessage(id, "%L", id, "STR_DEFINE_BLUE");
		}
		else if(color_mode == BLUE) {
			g_lasermine_id[GLOW][id] = 6
			glow_color_RGB[CUSTOM_B][id] = amount
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_COLOR_SUCEFFULL")
			Lasermine_Update_Settings(id, GLOW)
		}
	}
	else if(mode == LINE) {
		if(!get_pcvar_num(cvar_lm[5])) {
			client_cmd(id, "spk %s", Menu_Sounds[1])
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_LINE_DISABLE")
			lm_configs_menu(id)
			return PLUGIN_HANDLED
		}
		else if(color_mode == RED) {
			line_color_RGB[CUSTOM_R][id] = amount
			client_cmd(id, "messagemode ^"[LM]Change_color_line_G^"");
			set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
			show_hudmessage(id, "%L", id, "STR_DEFINE_GREEN");
		}
		else if(color_mode == GREEN) {
			line_color_RGB[CUSTOM_G][id] = amount
			client_cmd(id, "messagemode ^"[LM]Change_color_line_B^"");
			set_hudmessage(100, 255, 100, -1.0, -1.0, 0, 6.0, 6.0, 0.0, 0.0, -1);
			show_hudmessage(id, "%L", id, "STR_DEFINE_BLUE");
		}
		else if(color_mode == BLUE) {
			line_color_RGB[CUSTOM_B][id] = amount
			if(line_color_RGB[CUSTOM_R][id] < 30 && line_color_RGB[CUSTOM_G][id] < 30 && line_color_RGB[CUSTOM_B][id] < 30) {
				client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_DEFINE_COLOR_ERROR3")
				lm_configs_menu(id)
				return PLUGIN_HANDLED
			}

			g_lasermine_id[LINE][id] = 6
			line_color_RGB[RED][id] = line_color_RGB[CUSTOM_R][id]
			line_color_RGB[GREEN][id] = line_color_RGB[CUSTOM_G][id]
			line_color_RGB[BLUE][id] = line_color_RGB[CUSTOM_B][id]
			
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_COLOR_SUCEFFULL")
		}
	}

	lm_configs_menu(id)
	client_cmd(id, "spk %s", Menu_Sounds[0])
	
	return PLUGIN_CONTINUE;
}

/*------------------------------------------------------------------------------------
				[Choose Model/Sprite of Lasermine]
-------------------------------------------------------------------------------------*/
public choose_menu(id, choose_id) {
	if(!get_pcvar_num(cvar_lm[22]))
		return PLUGIN_HANDLED

	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}

	if(!get_pcvar_num(cvar_lm[5]) && choose_id == SPRITE || !get_pcvar_num(cvar_lm[29]) && choose_id == MODEL || !get_pcvar_num(cvar_lm[30]) && choose_id == SKIN) {
		client_cmd(id, "spk %s", Menu_Sounds[1])
		client_printcolor(id, "%L %L", id, "CHATTAG", id, choose_id == LINE ? "STR_LINE_DISABLE" : choose_id == MODEL ? "STR_MODEL_DISABLE" : "STR_SKIN_DISABLE")
		lm_configs_menu(id)
		return PLUGIN_HANDLED
	}

	client_cmd(id, "spk %s", Menu_Sounds[0])
	
	static szText[512], szItem[32], i

	if(choose_id == MODEL) formatex(szText, charsmax(szText), "%L %L", id, "MENU_TAG", id, "CHOOSE_LM_MODEL_MENU_TITLE")
	else if(choose_id == SKIN) formatex(szText, charsmax(szText), "%L %L", id, "MENU_TAG", id, "CHOOSE_LM_SKIN_MENU_TITLE")
	else formatex(szText, charsmax(szText), "%L %L", id, "MENU_TAG", id, "CHOOSE_LM_SPR_MENU_TITLE")
	new g_Menu = menu_create(szText, "choose_menu_handler")
	
	if(choose_id == MODEL) {
		for(i = 0; i < MAX_MODELS; i++) {
			formatex(szText, charsmax(szText), "\w%L %s", id, model_langs[i], g_lasermine_id[MODEL][id] == i ? "\d[\rX\d]" : "\d[]")
			formatex(szItem, charsmax(szItem), "M:%d", i)
			menu_additem(g_Menu, szText, szItem)
		}
	}
	else if(choose_id == SKIN) {
		for(i = 0; i < MAX_SKINS; i++) {
			formatex(szText, charsmax(szText), "\w%s %s", get_skin_name(id, i), g_lasermine_id[SKIN][id] == i ? "\d[\rX\d]" : "\d[]")
			formatex(szItem, charsmax(szItem), "E:%d", i)
			menu_additem(g_Menu, szText, szItem)
		}
	}
	else {
		for(i = 0; i < MAX_SPRITES; i++) {
			formatex(szText, charsmax(szText), "\w%L %s", id, spr_langs[i], g_lasermine_id[SPRITE][id] == i ? "\d[\rX\d]" : "\d[]")
			formatex(szItem, charsmax(szItem), "S:%d", i)
			menu_additem(g_Menu, szText, szItem)
		}
	}

	menu_setprop(g_Menu, MPROP_EXIT, MEXIT_ALL)
	
	formatex(szText, charsmax(szText), "\w%L", id, "MENU_BACKNAME");
	menu_setprop(g_Menu, MPROP_BACKNAME, szText)
	
	formatex(szText, charsmax(szText), "\w%L", id, "MENU_NEXTNAME");
	menu_setprop(g_Menu, MPROP_NEXTNAME, szText)
	
	formatex(szText, charsmax(szText), "\w%L", id, "MENU_BACK_TO_MAINMENU");
	menu_setprop(g_Menu, MPROP_EXITNAME, szText)

	// Fix for AMXX custom menus
	if (is_entity_pdata_valid(id) == PDATA_SAFE)
		set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX)

	menu_display(id, g_Menu, 0) 

	return PLUGIN_CONTINUE
}

public choose_menu_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		lm_configs_menu(id)
		return PLUGIN_HANDLED
	}
	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access)) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
		client_cmd(id, "spk %s", Menu_Sounds[1])
		return PLUGIN_HANDLED
	}
	if(!get_pcvar_num(cvar_lm[22])) 
		return PLUGIN_HANDLED

	
	static cmd[16], maccess, callback, iChoice 
	menu_item_getinfo(menu, item, maccess, cmd, charsmax(cmd),_,_, callback) 
	iChoice = str_to_num(cmd[2])
	
	if(equal(cmd, "M:", 2)) {
		g_lasermine_id[MODEL][id] = iChoice
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MODEL_SUCEFFULL");
		Lasermine_Update_Settings(id, MODEL)
		g_configured_lm[id][MODEL] = true
		g_configured_lm[id][SKIN] = true
		
		g_lasermine_id[SKIN][id] = 0
		Lasermine_Update_Settings(id, SKIN)
	}
	else if(equal(cmd, "E:", 2)) {
		g_lasermine_id[SKIN][id] = iChoice
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_SKIN_SUCEFFULL");
		Lasermine_Update_Settings(id, SKIN)
		g_configured_lm[id][MODEL] = true
		g_configured_lm[id][SKIN] = true
	}
	else if(equal(cmd, "S:", 2)) {
		if(!get_pcvar_num(cvar_lm[5])) {
			client_cmd(id, "spk %s", Menu_Sounds[1])
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_LINE_DISABLE")
			lm_configs_menu(id)
			return PLUGIN_HANDLED
		}
		g_lasermine_id[SPRITE][id] = iChoice
		g_configured_lm[id][SPRITE] = true
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_SPRITE_SUCEFFULL");
	}
	client_cmd(id, "spk %s", Menu_Sounds[0])
	
	lm_configs_menu(id)
	
	return PLUGIN_CONTINUE 
} 

#if defined EXTRA_ITEM_VERSION

#if defined ZP_50
public zp_fw_items_select_pre(id, itemid)
{
	if(g_itemid != itemid)
		return ZP_ITEM_AVAILABLE;

	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access))
		return ZP_ITEM_DONT_SHOW;

	if(!get_pcvar_num(cvar_lm[0]) || zp_get_user_zombie(id) || zp_is_user_special(id) && !get_pcvar_num(cvar_lm[32]))
		return ZP_ITEM_DONT_SHOW;

	if(g_lm_ammo[id]+g_deployed[id] >= get_pcvar_num(cvar_lm[0]))
		return ZP_ITEM_NOT_AVAILABLE;

	return ZP_ITEM_AVAILABLE;
}

public zp_fw_items_select_post(id, itemid) 
{
	if(g_itemid == itemid) {
		g_lm_ammo[id]++
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_BOUGHT_LM")
	}
}
#else 

#if defined ZP_SPECIAL
public zp_extra_item_selected_pre(id, itemid)
{
	if(g_itemid != itemid)
		return PLUGIN_CONTINUE;

	if(get_pcvar_num(cvar_lm[12]) && !(get_user_flags(id) & lm_flag_access))
		return ZP_PLUGIN_SUPERCEDE;

	if(!get_pcvar_num(cvar_lm[0]))
		return ZP_PLUGIN_SUPERCEDE;

	if(g_lm_ammo[id]+g_deployed[id] >= get_pcvar_num(cvar_lm[0]))
		return ZP_PLUGIN_HANDLED;

	return PLUGIN_CONTINUE;
}
#endif

public zp_extra_item_selected(id, itemid)
{
	if(g_itemid == itemid) {
		if(!Allowed_Time(id))
			return ZP_PLUGIN_HANDLED;

		if(g_lm_ammo[id]+g_deployed[id] >= get_pcvar_num(cvar_lm[0])) {
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MAX_BUY");
			return ZP_PLUGIN_HANDLED;
		}

		g_lm_ammo[id]++
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_BOUGHT_LM")
	}
	return PLUGIN_CONTINUE;
}
#endif

#endif



/*===========================================================================================================================================================================================
												 [Bools]
===========================================================================================================================================================================================*/
bool:is_valid_lasermine(ent) {
	if(!is_entity_pdata_valid(ent)) return false;

	static EntityName[32]; pev(ent, pev_classname, EntityName, 31);
	if(!equal(EntityName, Lasermine_Classname)) return false;
	
	return true;
}

bool:Allowed_Time(id) {
	if(!is_user_alive(id)) return false;

	if(!zp_has_round_started()) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_DELAY");
		return false;
	}
	if (zp_get_user_zombie(id) || zp_is_user_special(id) && !get_pcvar_num(cvar_lm[32])) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_CBT");
		return false;
	}
	if(allow_plant == -1) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MODE_DISABLE");
		return false;
	}
	if(allow_plant == 0) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_ENDROUND");
		return false;
	}
	if(get_pcvar_num(cvar_lm[12])) {
		if(get_user_flags(id) & lm_flag_access) return true;
		else {
			client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NOACCESS");
			return false;
		}
	}

	return true;
}

bool:Allow_Remove(id) {
	if(!Allowed_Time(id)) return false;
	static tgt,body,Float:vo[3],Float:to[3];
	get_user_aiming(id,tgt,body);
	if(!is_entity_pdata_valid(tgt)) return false;
	pev(id,pev_origin,vo);
	pev(tgt,pev_origin,to);
	if(get_distance_f(vo,to) > get_pcvar_float(cvar_lm[26])) return false;
	
	static EntityName[32];
	pev(tgt, pev_classname, EntityName, 31);
	if(!equal(EntityName, Lasermine_Classname)) return false;
	if(pev(tgt,LASERMINE_OWNER) != id) return false;
	
	return true;
}

bool:Allow_Plant(id) {
	if (!Allowed_Time(id)) return false;

	if (g_deployed[id] >= get_pcvar_num(cvar_lm[0])) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_MAXDEPLOY");
		return false;
	}
	#if defined EXTRA_ITEM_VERSION
	if(!g_lm_ammo[id]) {
		client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_NO_HAVE");
		return false;
	}
	#endif
	
	static Float:vTraceDirection[3], Float:vTraceEnd[3],Float:vOrigin[3];
	
	pev(id, pev_origin, vOrigin); 
	vOrigin[2] += 15
	velocity_by_aim(id, 128, vTraceDirection);
	xs_vec_add(vTraceDirection, vOrigin, vTraceEnd);
	
	engfunc(EngFunc_TraceLine, vOrigin, vTraceEnd, DONT_IGNORE_MONSTERS, id, 0);
	
	static Float:fFraction,Float:vTraceNormal[3]; get_tr2(0, TR_flFraction, fFraction);
	
	// -- We hit something!
	if (fFraction < 1.0) {
		// -- Save results to be used later.
		get_tr2(0, TR_vecEndPos, vTraceEnd);
		get_tr2(0, TR_vecPlaneNormal, vTraceNormal);

		return true;
	}

	client_printcolor(id, "%L %L", id, "CHATTAG", id, "STR_PLANTWALL")
	return false;
}

/*===========================================================================================================================================================================================
												[Stocks]
===========================================================================================================================================================================================*/
// Extra Damage
stock set_user_extra_damage(id, attacker, damage, weaponDescription[]) {
	if (pev(id, pev_takedamage) == DAMAGE_NO && get_pcvar_num(cvar_lm[33]) || damage <= 0 || !zp_get_user_zombie(id)) 
		return;
 
	if (pev_user_health(id) - damage <= 0) {
		set_msg_block(get_user_msgid("DeathMsg"), BLOCK_SET);
		ExecuteHamB(Ham_Killed, id, attacker, 2);
		set_msg_block(get_user_msgid("DeathMsg"), BLOCK_NOT);
        
		message_begin(MSG_BROADCAST, get_user_msgid("DeathMsg"));
		write_byte(attacker);
		write_byte(id);
		write_byte(0);
		write_string(weaponDescription);
		message_end();
                
		if(!get_pcvar_num(cvar_lm[18])) 
			set_pev(attacker, pev_frags, float(get_user_frags(attacker) + 1));
                        
		static kname[32], vname[32], kauthid[32], vauthid[32], kteam[10], vteam[10];
        
		get_user_name(attacker, kname, 31); get_user_team(attacker, kteam, 9); get_user_authid(attacker, kauthid, 31);
		get_user_name(id, vname, 31); get_user_team(id, vteam, 9); get_user_authid(id, vauthid, 31);
                        
		log_message("^"%s<%d><%s><%s>^" killed ^"%s<%d><%s><%s>^" with ^"%s^"", kname, get_user_userid(attacker), kauthid, kteam, 
		vname, get_user_userid(id), vauthid, vteam, weaponDescription);
		
		if(get_pcvar_num(cvar_lm[9])) {
			zp_set_user_ammo_packs(attacker, zp_get_user_ammo_packs(attacker) + get_pcvar_num(cvar_lm[19]))
			client_printcolor(attacker, "%L %L", attacker, "CHATTAG", attacker, "STR_LM_KILL_RWD", get_pcvar_num(cvar_lm[19]))
		}
	}
	else {
		static origin[3]; get_user_origin(id, origin);
		message_begin(MSG_ONE,get_user_msgid("Damage"),{0,0,0},id);
		write_byte(21);
		write_byte(20);
		write_long(DMG_BLAST);
		write_coord(origin[0]);
		write_coord(origin[1]);
		write_coord(origin[2]);
		message_end();
		set_pev(id, pev_health, pev(id, pev_health) - float(damage));
	}
}

// Colored Chat
stock client_printcolor(const id, const input[], any:...) {
	static msg[191], count, players[32]
	count = 1
	vformat(msg, 190, input, 3)
	
	replace_all(msg, 190, "!g", "^4")  // Green
	replace_all(msg, 190, "!y", "^1")  // Yellow
	replace_all(msg, 190, "!t", "^3")  // Team
	
	if (id) players[0] = id; 
	else get_players(players, count, "ch") 

	for (new i = 0; i < count; i++) {
		if (is_user_connected(players[i])) {
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, players[i])
			write_byte(players[i]);
			write_string(msg);
			message_end();
		}
	}
}
/*------------------------------------------------------------------------------------
				[Fakemeta Stocks]
-------------------------------------------------------------------------------------*/
stock set_rendering(entity, fx = kRenderFxNone, r = 255, g = 255, b = 255, render = kRenderNormal, amount = 16) {
	static Float:RenderColor[3];
	RenderColor[0] = float(r);
	RenderColor[1] = float(g);
	RenderColor[2] = float(b);

	set_pev(entity, pev_renderfx, fx);
	set_pev(entity, pev_rendercolor, RenderColor);
	set_pev(entity, pev_rendermode, render);
	set_pev(entity, pev_renderamt, float(amount));

	return 1;
}

stock pev_user_health(id) {
	static Float:health
	pev(id,pev_health,health)
	return floatround(health)
}

stock set_user_health(id,health) health > 0 ? set_pev(id, pev_health, float(health)) : dllfunc(DLLFunc_ClientKill, id);

stock get_user_godmode(index) {
	static Float:val
	pev(index, pev_takedamage, val)
	return (val == DAMAGE_NO)
}

stock set_user_frags(index, frags) {
	set_pev(index, pev_frags, float(frags))
	return 1
}

stock pev_user_frags(index) {
	static Float:frags;
	pev(index,pev_frags,frags);
	return floatround(frags);
}
stock is_entity_pdata_valid(ent)
{
	if(pev_valid(ent) == 2)
		return 1

	return 0
}

stock get_skin_name(id, skin)
{
	static szSkinLang[32], modelid
	modelid = g_lasermine_id[MODEL][id]
	switch(skin)
	{
		case 0: formatex(szSkinLang, charsmax(szSkinLang), "%L", id, skin_langs[modelid][szSkin1])
		case 1: formatex(szSkinLang, charsmax(szSkinLang), "%L", id, skin_langs[modelid][szSkin2])
		case 2: formatex(szSkinLang, charsmax(szSkinLang), "%L", id, skin_langs[modelid][szSkin3])
		case 3: formatex(szSkinLang, charsmax(szSkinLang), "%L", id, skin_langs[modelid][szSkin4])
		case 4: formatex(szSkinLang, charsmax(szSkinLang), "%L", id, skin_langs[modelid][szSkin5])
		case 5: formatex(szSkinLang, charsmax(szSkinLang), "%L", id, skin_langs[modelid][szSkin6])
	}
	return szSkinLang
}


bool:zp_is_user_special(id)
{
	#if defined ZP_43
	if(zp_get_user_survivor(id)) return true;
	#endif
	
	#if defined ZP_50
	if (LibraryExists(LIBRARY_SURVIVOR, LibType_Library) && zp_class_survivor_get(id)) return true;
	#endif
	
	#if defined ZP_ADVANCE
	if(zp_get_user_survivor(id) || zp_get_user_sniper(id) || zp_get_user_nemesis(id) || zp_get_user_assassin(id)) return true;
	#endif
	
	#if defined ZP_SPECIAL
	if(zp_get_human_special_class(id) || zp_get_zombie_special_class(id)) return true;
	#endif

	return false
}

#if defined ZP_50
stock zp_has_round_started()
{
	if (zp_gamemodes_get_current() == ZP_NO_GAME_MODE)
		return 0; // not started
		
	return 1; // started
}

stock zp_get_user_zombie(id)
	return zp_core_is_zombie(id)

stock zp_get_user_ammo_packs(id)
{
	if (LibraryExists(LIBRARY_AMMOPACKS, LibType_Library))
		return zp_ammopacks_get(id);

	return cs_get_user_money(id)
}

stock zp_set_user_ammo_packs(id, amount)
{
	if (LibraryExists(LIBRARY_AMMOPACKS, LibType_Library))
		return zp_ammopacks_set(id, amount);
	
	if(amount > 16000)
		return cs_set_user_money(id, 16000)
	else
		return cs_set_user_money(id, amount)

	return 1;
}

#endif