#include <amxmodx>
#include <amx_settings_api>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 44
	#assert Zombie Plague Special 4.4 Include File Required. Download Link: https://github.com/PerfectScrash/Zombie-Plague-Special/tree/master/Zombie%20Plague%20Special%204.4%20(Beta)/scripting/include
#endif

// Extra Itens file
new const ZP_EXTRAITEMS_FILE[] = "zpsp_extraitems.ini"

#define NO_LIMIT 0

// Index of Custom Extra item
#define ITEM_INDEX itemid-g_start

new Array:g_ItemLimit, Array:g_MapItemLimit, Array:g_ItemLimitCount, Array:g_MapItemLimitCount, g_start, g_count

public plugin_init()
{
	register_plugin("[ZPSp] Item Limiter", "1.0", "WiLS | [P]erfect [S]crash")

	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	
	g_ItemLimit = ArrayCreate(1, 1)
	g_MapItemLimit = ArrayCreate(1, 1)
	g_ItemLimitCount = ArrayCreate(1, 1)
	g_MapItemLimitCount = ArrayCreate(1, 1)

	set_task(1.0, "load_save_limiter")
}

public load_save_limiter()
{
	new index, real_name[32], limit
	
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

		ArrayPushCell(g_ItemLimitCount, 0)
		ArrayPushCell(g_MapItemLimitCount, 0)
	}
}

public event_round_start()
{
	// Reset Round Limit Count
	for(new i = 0; i < ArraySize(g_ItemLimitCount); i++) 
		ArraySetCell(g_ItemLimitCount, i, 0)
}	

public zp_extra_item_selected(id, itemid)
{
	if(itemid < g_start || itemid >= ArraySize(g_ItemLimitCount) || itemid >= ArraySize(g_MapItemLimitCount))
		return;

	if(ArrayGetCell(g_ItemLimit, ITEM_INDEX) != NO_LIMIT)
		ArraySetCell(g_ItemLimitCount, ITEM_INDEX, ArrayGetCell(g_ItemLimitCount, ITEM_INDEX) + 1)

	if(ArrayGetCell(g_MapItemLimit, ITEM_INDEX) != NO_LIMIT)
		ArraySetCell(g_MapItemLimitCount, ITEM_INDEX, ArrayGetCell(g_MapItemLimitCount, ITEM_INDEX) + 1)
}

public zp_extra_item_selected_pre(id, itemid)
{
	if(itemid < g_start || itemid >= ArraySize(g_ItemLimitCount) || itemid >= ArraySize(g_MapItemLimitCount))
		return PLUGIN_CONTINUE;

	static current, current_map, limit, map_limit
	current = ArrayGetCell(g_ItemLimitCount, ITEM_INDEX)
	current_map = ArrayGetCell(g_MapItemLimitCount, ITEM_INDEX)

	limit = ArrayGetCell(g_ItemLimit, ITEM_INDEX)
	map_limit = ArrayGetCell(g_MapItemLimit, ITEM_INDEX) 

	static text[64]
	text[0] = 0

	if (limit != NO_LIMIT)
		format(text, charsmax(text), "\y[%d/%d] ", current, limit)

	if (map_limit != NO_LIMIT)
		format(text, charsmax(text), "%s\r[%d/%d]", text, current_map, map_limit)

	if(text[0])
		zp_extra_item_textadd(text)
	
	if (limit != NO_LIMIT && current >= limit || map_limit != NO_LIMIT && current_map >= map_limit)
		return ZP_PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}
