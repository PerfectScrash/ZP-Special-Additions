/*=============================================================================================
			 [ZPSp] Addon: Zombie/Human Class Limiter

	-> How to use:
	When plugin enables, will be add a limit line in **zpsp_zombieclasses.ini** 
	or **zpsp_humanclasses.ini** and you can change limit for what you want.

	-> Changelog:
		-1.0:
			- First Release
		-1.1:
			- Fixed error logs
		-1.2:
			- Added Human Class Support (Works only in ZPSp 4.5)
		-1.3:
			- Added min players option
=============================================================================================*/

#include <amxmodx>
#include <amx_settings_api>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 45
	#assert Zombie Plague Special 4.5 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

#define NO_LIMIT 0

new Array:g_ZombieClassLimit, Array:g_HumanClassLimit, Array:g_ZombieClassMinPlayers, Array:g_HumanClassMinPlayers

// Plugin Main
public plugin_init() {
	register_plugin("[ZPSp] Addon: Class Limiter", "1.3", "WiLS | [P]erfect [S]crash")
	
	g_ZombieClassLimit = ArrayCreate(1, 1)
	g_HumanClassLimit = ArrayCreate(1, 1)
	g_ZombieClassMinPlayers = ArrayCreate(1, 1)
	g_HumanClassMinPlayers = ArrayCreate(1, 1)
	
	static index, count, real_name[32], limit
	count = zp_get_zclass_count()
	for (index = 0; index < count; index++) {
		zp_get_zombie_class_realname(index, real_name, charsmax(real_name))
		
		limit = NO_LIMIT
		if(!amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "LIMIT", limit))
			amx_save_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "LIMIT", limit)

		ArrayPushCell(g_ZombieClassLimit, limit)
		
		limit = NO_LIMIT
		if(!amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "MIN PLAYERS REQUIRED", limit))
			amx_save_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "MIN PLAYERS REQUIRED", limit)

		ArrayPushCell(g_ZombieClassMinPlayers, limit)
	}
	count = zp_get_hclass_count()
	for (index = 0; index < count; index++) {
		zp_get_human_class_realname(index, real_name, charsmax(real_name))
		
		limit = NO_LIMIT
		if(!amx_load_setting_int(ZP_HUMANCLASSES_FILE, real_name, "LIMIT", limit))
			amx_save_setting_int(ZP_HUMANCLASSES_FILE, real_name, "LIMIT", limit)

		ArrayPushCell(g_HumanClassLimit, limit)
		
		limit = NO_LIMIT
		if(!amx_load_setting_int(ZP_HUMANCLASSES_FILE, real_name, "MIN PLAYERS REQUIRED", limit))
			amx_save_setting_int(ZP_HUMANCLASSES_FILE, real_name, "MIN PLAYERS REQUIRED", limit)

		ArrayPushCell(g_HumanClassMinPlayers, limit)
	}

}
// Check limit when open zclass menu
public zp_zombie_class_choosed_pre(id, classid) {
	// Prevent log error
	if(classid < 0 || classid >= ArraySize(g_ZombieClassLimit))
		return PLUGIN_CONTINUE;

	// Min Players Required
	static min_players;
	min_players = ArrayGetCell(g_ZombieClassMinPlayers, classid);
	if(min_players != NO_LIMIT) { // Two ifs for dont execute unecessary loops (Most Perfomace)
		if(GetPlayersNum() < min_players) {
			zp_menu_textadd(fmt("\r[Required %d Players]", min_players))
			return ZP_PLUGIN_HANDLED;
		}
	}

	static current, limit
	current = get_players_using_class(GET_ZOMBIE, classid)
	limit = ArrayGetCell(g_ZombieClassLimit, classid)
	if(limit != NO_LIMIT)
		zp_menu_textadd(fmt("\r[%d/%d]", current, limit))
	
	if(zp_get_user_zombie_class(id) == classid || zp_get_user_next_class(id) == classid)
		return PLUGIN_CONTINUE;
	
	if(limit != NO_LIMIT && current >= limit)
		return ZP_PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Check limit when open hclass menu
public zp_human_class_choosed_pre(id, classid) {
	// Prevent log error
	if(classid < 0 || classid >= ArraySize(g_HumanClassLimit))
		return PLUGIN_CONTINUE;

	// Min Players Required
	static min_players;
	min_players = ArrayGetCell(g_HumanClassMinPlayers, classid);
	if(min_players != NO_LIMIT) { // Two ifs for dont execute unecessary loops (Most Perfomace)
		if(GetPlayersNum() < min_players) {
			zp_menu_textadd(fmt("\r[Required %d Players]", min_players))
			return ZP_PLUGIN_HANDLED;
		}
	}

	static current, limit
	current = get_players_using_class(GET_HUMAN, classid)
	limit = ArrayGetCell(g_HumanClassLimit, classid)
	if(limit != NO_LIMIT)
		zp_menu_textadd(fmt("\r[%d/%d]", current, limit))
	
	if(zp_get_user_human_class(id) == classid || zp_get_next_human_class(id) == classid)
		return PLUGIN_CONTINUE;
	
	if(limit != NO_LIMIT && current >= limit)
		return ZP_PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Get Players Using X Class Count
get_players_using_class(is_zm, classid) {
	static id, counter
	counter = 0
	for (id = 1; id <= MaxClients; id++) {
		if(!is_user_connected(id))
			continue;
		
		if(is_zm) {
			if(zp_get_user_zombie_class(id) == classid || zp_get_user_next_class(id) == classid)
				counter++
		}
		else {
			if(zp_get_user_human_class(id) == classid || zp_get_next_human_class(id) == classid)
				counter++
		}
	}
	return counter;
}


// Get Real Players Count (Spec/Bots/Unassigned dont count)
stock GetPlayersNum() {
	static playerCnt, i, userTeam;
	playerCnt = 0;
	for(i = 1; i <= MaxClients; i++) {
		if(!is_user_connected(i))
			continue;

		if(is_user_bot(i))
			continue;

		userTeam = get_user_team(i)
		if(userTeam == 1 || userTeam == 2)
			playerCnt++;
	}
	return playerCnt;
}
