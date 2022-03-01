/*=======================================================================================
-> [ZPSp] Addon: Extra Item Limiter

-> How to use:
    - When plugin enables, will be add a limit line in **zpsp_extraitems.ini**
	and you can change limit by round and by map (Similar with zclass limiter)

-> Change Log:
	* 1.0: 
		- First Release.
	* 1.1:
		- Added more limit options.
	* 1.2:
		- Fixing player limit when some disconnect and other player gets the same index. 
========================================================================================*/

#include <amxmodx>
#include <amx_settings_api>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 44
	#assert Zombie Plague Special 4.4 Include File Required. Download Link: https://github.com/PerfectScrash/Zombie-Plague-Special/tree/master/Zombie%20Plague%20Special%204.4%20(Beta)/scripting/include
#endif

#if ZPS_INC_VERSION < 45 // Error compiling fix when use newest version
// Extra Itens file
new const ZP_EXTRAITEMS_FILE[] = "zpsp_extraitems.ini"
#endif

#define NO_LIMIT 0

// Index of Custom Extra item
#define ITEM_INDEX itemid-g_start

new Array:g_ItemLimit, Array:g_MapItemLimit, Array:g_ItemLimitCount, Array:g_MapItemLimitCount, g_start, g_count
new Array:g_PlayerItemLimit, Array:g_PlayerMapItemLimit, Array:g_PlayerLimitCount[33], Array:g_MapPlayerLimitCount[33]

public plugin_init() {
	register_plugin("[ZPSp] Addon: Item Limiter", "1.2", "WiLS | [P]erfect [S]crash")

	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")

	g_ItemLimit = ArrayCreate(1, 1)
	g_MapItemLimit = ArrayCreate(1, 1)
	g_ItemLimitCount = ArrayCreate(1, 1)
	g_MapItemLimitCount = ArrayCreate(1, 1)
	g_PlayerItemLimit = ArrayCreate(1, 1)
	g_PlayerMapItemLimit = ArrayCreate(1, 1)

	for(new i = 1; i <= MaxClients; i++) {
		g_PlayerLimitCount[i] = ArrayCreate(1, 1)
		g_MapPlayerLimitCount[i] = ArrayCreate(1, 1)
	}

	set_task(1.0, "load_save_limiter");
}

// Load/Save Limiter (After every itens get registered)
public load_save_limiter() {
	new index, real_name[128], limit, i
	
	g_start = zp_get_custom_extra_start()
	g_count = zp_get_extra_item_count()

	for (index = g_start; index < g_count; index++) {
		zp_get_extra_item_realname(index, real_name, charsmax(real_name))
		
		limit = NO_LIMIT		
		if (!amx_load_setting_int(ZP_EXTRAITEMS_FILE, real_name, "LIMIT PER ROUND", limit))
			amx_save_setting_int(ZP_EXTRAITEMS_FILE, real_name, "LIMIT PER ROUND", limit)
		
		ArrayPushCell(g_ItemLimit, limit)

		limit = NO_LIMIT;
		if (!amx_load_setting_int(ZP_EXTRAITEMS_FILE, real_name, "LIMIT PER MAP", limit))
			amx_save_setting_int(ZP_EXTRAITEMS_FILE, real_name, "LIMIT PER MAP", limit)

		ArrayPushCell(g_MapItemLimit, limit)

		limit = NO_LIMIT;
		if (!amx_load_setting_int(ZP_EXTRAITEMS_FILE, real_name, "PLAYER LIMIT PER ROUND", limit))
			amx_save_setting_int(ZP_EXTRAITEMS_FILE, real_name, "PLAYER LIMIT PER ROUND", limit)

		ArrayPushCell(g_PlayerItemLimit, limit)

		limit = NO_LIMIT;
		if (!amx_load_setting_int(ZP_EXTRAITEMS_FILE, real_name, "PLAYER LIMIT PER MAP", limit))
			amx_save_setting_int(ZP_EXTRAITEMS_FILE, real_name, "PLAYER LIMIT PER MAP", limit)

		ArrayPushCell(g_PlayerMapItemLimit, limit)

		ArrayPushCell(g_ItemLimitCount, 0)
		ArrayPushCell(g_MapItemLimitCount, 0)

		for(i = 1; i <= MaxClients; i++) {
			ArrayPushCell(g_PlayerLimitCount[i], 0)
			ArrayPushCell(g_MapPlayerLimitCount[i], 0)
		}
	}
}

// Reset Round Limit Count
public event_round_start() {
	static i, item, size;

	// Everyone
	size = ArraySize(g_ItemLimitCount)
	if(size) {
		for(i = 0; i < ArraySize(g_ItemLimitCount); i++) 
			ArraySetCell(g_ItemLimitCount, i, 0)
	}

	// Players
	for(i = 1; i <= MaxClients; i++) {
		size = ArraySize(g_PlayerLimitCount[i])
		if(!size)
			continue;
	
		for(item = 0; item < size; item++) 
			ArraySetCell(g_PlayerLimitCount[i], item, 0)
	}
}	

// Reset player limit on connect
public client_putinserver(id) {
	static item, size;
	size = ArraySize(g_MapPlayerLimitCount[id])
	if(size) {
		for(item = 0; item < ArraySize(g_MapPlayerLimitCount[id]); item++) 
			ArraySetCell(g_MapPlayerLimitCount[id], item, 0)
	}
	size = ArraySize(g_PlayerLimitCount[id])
	if(size) {
		for(item = 0; item < ArraySize(g_PlayerLimitCount[id]); item++) 
			ArraySetCell(g_PlayerLimitCount[id], item, 0)
	}

}

// Increment limit count
public zp_extra_item_selected(id, itemid) {
	if(itemid < g_start)
		return;

	if(ArrayGetCell(g_ItemLimit, ITEM_INDEX) != NO_LIMIT)
		ArraySetCell(g_ItemLimitCount, ITEM_INDEX, ArrayGetCell(g_ItemLimitCount, ITEM_INDEX) + 1)

	if(ArrayGetCell(g_MapItemLimit, ITEM_INDEX) != NO_LIMIT)
		ArraySetCell(g_MapItemLimitCount, ITEM_INDEX, ArrayGetCell(g_MapItemLimitCount, ITEM_INDEX) + 1)

	if(ArrayGetCell(g_PlayerItemLimit, ITEM_INDEX) != NO_LIMIT)
		ArraySetCell(g_PlayerLimitCount[id], ITEM_INDEX, ArrayGetCell(g_PlayerLimitCount[id], ITEM_INDEX)+1)

	if(ArrayGetCell(g_PlayerMapItemLimit, ITEM_INDEX) != NO_LIMIT)
		ArraySetCell(g_MapPlayerLimitCount[id], ITEM_INDEX, ArrayGetCell(g_MapPlayerLimitCount[id], ITEM_INDEX)+1)

}

// Check limit before buy
public zp_extra_item_selected_pre(id, itemid) {
	if(itemid < g_start)
		return PLUGIN_CONTINUE;

	static current, current_map, limit, map_limit
	static pl_current, pl_current_map, pl_limit, pl_map_limit

	pl_current = ArrayGetCell(g_PlayerLimitCount[id], ITEM_INDEX)
	pl_current_map = ArrayGetCell(g_MapPlayerLimitCount[id], ITEM_INDEX)

	current = ArrayGetCell(g_ItemLimitCount, ITEM_INDEX)
	current_map = ArrayGetCell(g_MapItemLimitCount, ITEM_INDEX)

	limit = ArrayGetCell(g_ItemLimit, ITEM_INDEX)
	map_limit = ArrayGetCell(g_MapItemLimit, ITEM_INDEX) 

	pl_limit = ArrayGetCell(g_PlayerItemLimit, ITEM_INDEX)
	pl_map_limit = ArrayGetCell(g_PlayerMapItemLimit, ITEM_INDEX) 

	static text[200]
	text[0] = 0

	// Per Player
	if (pl_limit != NO_LIMIT) 
		format(text, charsmax(text), "\y[%d/%d] ", pl_current, pl_limit)

	if (pl_map_limit != NO_LIMIT) 
		format(text, charsmax(text), "%s\y(%d/%d) ", text, pl_current_map, pl_map_limit)

	// Global
	if (limit != NO_LIMIT)
		format(text, charsmax(text), "%s\r[%d/%d] ", text, current, limit)

	if (map_limit != NO_LIMIT)
		format(text, charsmax(text), "%s\r(%d/%d)", text, current_map, map_limit)

	if(text[0])
		zp_extra_item_textadd(text)
	
	if (limit != NO_LIMIT && current >= limit || map_limit != NO_LIMIT && current_map >= map_limit
	|| pl_limit != NO_LIMIT && pl_current >= pl_limit || pl_map_limit != NO_LIMIT && pl_current_map >= pl_map_limit)
		return ZP_PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}
