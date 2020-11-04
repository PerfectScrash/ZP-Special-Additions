/* 						[Map zm_5em1_scrash Script]

		- Description:
			Play 5 maps that change every round without loading.

		- Credits:
			Perfect Scrash: Uniting maps and Making Script for works.

		- Original Map Authors:
			Vitor Bertolino (DH | Chuunas): zm_semnome 
			?????????: zm_foda (I dont know who are author of this map)
			Wagner Araujo: zm_bacana
			Pelaa: za_fox_ldm
			Chaves: zm_trakinax
*/

#include <amxmodx>
#include <engine>
#include <hamsandwich>
#include <zombie_plague_special>

// Map enum index
enum {
	SEMNOME = 0,	// zm_semnome
	FODA,			// zm_foda
	BACANA,			// zm_bacana
	FOX,			// za_fox_ldm
	TRAKINAX 		// zm_trakinax
}

// Name of maps
new const map_names[][] = { "SEMNOME", "FODA", "BACANA", "FOX", "TRAKINAX" }

// Global Vars
new Float:g_spawn_in[33][3], g_current_map, g_enable

// Plugin Register and check if stay in map zm_5em1_scrash for enable script
public plugin_init() {
	register_plugin("[ZPSp] Map Script: zm_5em1_scrash", "1.0", "Perfect Scrash")

	new mapname[32]; get_mapname(mapname, charsmax(mapname))
	if(equal(mapname, "zm_5em1_scrash"))
		g_enable = true
	else
		g_enable = false
}

// Teleport user in correct current map when use unstuck option in menu
public zp_user_unstuck_post(id)
{
	if(!g_enable)	// Not in zm_5em1_scrash?
		return;

	static Float:origin[3]
	if(g_current_map != SEMNOME) {					
		origin[0] = g_spawn_in[id][0]
		origin[1] = g_spawn_in[id][1]
		origin[2] = g_spawn_in[id][2]

		entity_set_origin(id, origin)
	}
}

// Teleport user in correct current map when spawn
public zp_player_spawn_post(id)
{
	if(!g_enable)	// Not in zm_5em1_scrash?
		return;

	static Float:origin[3]
	if(g_current_map != SEMNOME) {					
		origin[0] = g_spawn_in[id][0]
		origin[1] = g_spawn_in[id][1]
		origin[2] = g_spawn_in[id][2]

		entity_set_origin(id, origin)
	}

	client_printcolor(id, "!tConsole: -=| CURRENT MAP STAGE: %s |=-", map_names[g_current_map])
}

// "Change Map" After round end
public zp_round_ended()
{
	if(!g_enable)	// Not in zm_5em1_scrash?
		return;

	if(g_current_map >= TRAKINAX)
		g_current_map = SEMNOME
	else
		g_current_map++

	check_targets(g_current_map) // Set Spawn Points
}

// Set Spawn Points
public check_targets(type)
{
	if(!g_enable)	// Not in zm_5em1_scrash?
		return;

	if(type < SEMNOME || type > TRAKINAX )
	{
		g_current_map = SEMNOME 	// zm_semnome are using default spawn entities
		return;
	}
	else
	{
		// Check what targetname search
		static who_class[32]
		switch(type) {
			case FODA: formatex(who_class, charsmax(who_class), "zm_foda_spawn")
			case TRAKINAX: formatex(who_class, charsmax(who_class), "zm_trakinax_spawn")
			case BACANA: formatex(who_class, charsmax(who_class), "zm_bacana_spawn")
			case FOX: formatex(who_class, charsmax(who_class), "za_fox_spawn")
		}


		// Set Spawn Points
		static ent = -1
		static Float:origin[3], spawn_count
		spawn_count = 0
		while((ent = find_ent_by_tname( ent, who_class )) != 0 )	{
			
			if(!is_valid_ent(ent))
				continue
			
			if(spawn_count <= 32) 
			{
				spawn_count++
				entity_get_vector(ent, EV_VEC_origin, origin)
				g_spawn_in[spawn_count][0] = origin[0]
				g_spawn_in[spawn_count][1] = origin[1]
				g_spawn_in[spawn_count][2] = origin[2]
			}
		}

		// Small bug prevention if exists user with 0 index
		g_spawn_in[0][0] = origin[0]
		g_spawn_in[0][1] = origin[1]
		g_spawn_in[0][2] = origin[2]+10
	}
}

// Client Print color with amx 1.8.2 Supports
#if AMXX_VERSION_NUM < 183
new g_maxpl
stock client_printcolor(target, const message[], any:...) {
	static buffer[512], i, argscount
	argscount = numargs()

	if(!g_maxpl)
		g_maxpl = get_maxplayers()

	// Format message for player
	vformat(buffer, charsmax(buffer), message, 3)

	replace_all(buffer, charsmax(buffer), "!g","^4");    // green
	replace_all(buffer, charsmax(buffer), "!y","^1");    // normal
	replace_all(buffer, charsmax(buffer), "!t","^3");    // team

	if(!target) { // Send to everyone
		static player
		for(player = 1; player <= g_maxpl; player++) {
			if(!is_user_connected(player) continue; // Not connected
			
			// Remember changed arguments
			static changed[5], changedcount // [5] = max LANG_PLAYER occurencies
			changedcount = 0
			
			for(i = 2; i < argscount; i++) { // Replace LANG_PLAYER with player id
				if(getarg(i) == LANG_PLAYER) {
					setarg(i, 0, player)
					changed[changedcount] = i
					changedcount++
				}
			}			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("SayText"), _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for(i = 0; i < changedcount; i++) setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	else { // Send to specific target		
		// Send it
		message_begin(MSG_ONE, get_user_msgid("SayText"), _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}
#else
stock client_printcolor(target, const message[], any:...) {
	static szMsg[512];
	vformat(szMsg, charsmax(szMsg), message, 3);

	replace_string(szMsg, charsmax(szMsg), "!g", "^4");    // green
	replace_string(szMsg, charsmax(szMsg), "!y", "^1");    // normal
	replace_string(szMsg, charsmax(szMsg), "!t", "^3");    // team
	client_print_color(target, print_team_default, "%s", szMsg)
}
#endif
