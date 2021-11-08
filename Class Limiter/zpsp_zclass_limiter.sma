#include <amxmodx>
#include <amx_settings_api>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 34
	#assert Zombie Plague Special 3.4 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

// Zombie Classes file
new const ZP_ZOMBIECLASSES_FILE[] = "zpsp_zombieclasses.ini"

#define NO_LIMIT 0

new g_MaxPlayers, Array:g_ZombieClassLimit

public plugin_init()
{
	register_plugin("[ZPSp] Class Limiter", "1.1", "WiLS | [P]erfect [S]crash")
	
	g_MaxPlayers = get_maxplayers()
	g_ZombieClassLimit = ArrayCreate(1, 1)
	
	static index, count, real_name[32], limit
	
	count = zp_get_zclass_count()
	for (index = 0; index < count; index++)
	{
		zp_get_zombie_class_realname(index, real_name, charsmax(real_name))
		
		limit = NO_LIMIT
		
		if (!amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "LIMIT", limit))
			amx_save_setting_int(ZP_ZOMBIECLASSES_FILE, real_name, "LIMIT", limit)

		ArrayPushCell(g_ZombieClassLimit, limit)
	}

}

public zp_zombie_class_choosed_pre(id, classid)
{
	// Prevent log error
	if(classid < 0 || classid >= ArraySize(g_ZombieClassLimit))
		return PLUGIN_CONTINUE;

	static current, limit, text[32]
	current = players_using_zombie_class(classid)
	limit = ArrayGetCell(g_ZombieClassLimit, classid)
	if (limit != NO_LIMIT) {
		formatex(text, charsmax(text), "\r[%d/%d]", current, limit)
		zp_zombie_class_textadd(text)
	}
	
	if (zp_get_user_zombie_class(id) == classid || zp_get_user_next_class(id) == classid)
		return PLUGIN_CONTINUE;
	
	if (limit != NO_LIMIT && current >= limit)
		return ZP_PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}


players_using_zombie_class(classid)
{
	new id, counter
	
	for (id = 1; id <= g_MaxPlayers; id++) {
		if (!is_user_connected(id))
			continue;
		
		if (zp_get_user_zombie_class(id) == classid || zp_get_user_next_class(id) == classid)
			counter++
	}
	
	return counter;
}
