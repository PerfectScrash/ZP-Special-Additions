#include <amxmodx>
#include <amx_settings_api>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 45
	#assert Zombie Plague Special 4.5 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

#define NO_LIMIT 0

new Array:g_ZombieClassLimit, Array:g_HumanClassLimit

public plugin_init() {
	register_plugin("[ZPSp] Addon: Class Limiter", "1.2", "WiLS | [P]erfect [S]crash")
	
	g_ZombieClassLimit = ArrayCreate(1, 1)
	g_HumanClassLimit = ArrayCreate(1, 1)
	
	static index, count, real_name[32], limit
	count = zp_get_zclass_count()
	for (index = 0; index < count; index++) {
		zp_get_zombie_class_realname(index, real_name, charsmax(real_name))
		
		limit = NO_LIMIT
		
		if(!amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "LIMIT", limit))
			amx_save_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "LIMIT", limit)

		ArrayPushCell(g_ZombieClassLimit, limit)
	}
	count = zp_get_hclass_count()
	for (index = 0; index < count; index++) {
		zp_get_human_class_realname(index, real_name, charsmax(real_name))
		
		limit = NO_LIMIT
		
		if(!amx_load_setting_int(ZP_HUMANCLASSES_FILE, real_name, "LIMIT", limit))
			amx_save_setting_int(ZP_HUMANCLASSES_FILE, real_name, "LIMIT", limit)

		ArrayPushCell(g_HumanClassLimit, limit)
	}

}

public zp_zombie_class_choosed_pre(id, classid) {
	// Prevent log error
	if(classid < 0 || classid >= ArraySize(g_ZombieClassLimit))
		return PLUGIN_CONTINUE;

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


public zp_human_class_choosed_pre(id, classid) {
	// Prevent log error
	if(classid < 0 || classid >= ArraySize(g_HumanClassLimit))
		return PLUGIN_CONTINUE;

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
