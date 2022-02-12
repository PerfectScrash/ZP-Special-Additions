/* 
		[ZPSp] Addon: First Zombie Helper

		* Description:
			For prevent a fast human win rounds, first zombie have now a helper and this helper 
			are choosed automaticaly in infection rounds.

		* Requeriments:
			- AMX 1.8.3 or higher.
			- Zombie Plague Special 4.3 or Higher

		* Change Log:
			-> 1.0: 
				- First Release
			-> 1.1:
				- No Support more to Amx 1.8.2 or older
				- Added check player for prevent consecutives infections
			-> 1.2:
				- Added Lang Support

*/

#include <amxmodx>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 43
#assert Zombie Plague Special 4.3 or higher Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

new g_max_helpers, g_helper_count, helper_ckeck[33]

public plugin_init() {
	register_plugin("[ZP] Addon: First Zombie Helper", "1.2", "[P]erfect [S]crash")
	register_dictionary("zpsp_zombie_helper.txt")
}

public client_disconnected(id) {
	helper_ckeck[id] = false;
}

public zp_round_started(gm)
{
	static id, i
	if(gm == MODE_INFECTION) {
		// Helper Quantity
		switch(zp_get_alive_players()) {
			case 0..9: g_max_helpers = 0
			case 10..19: g_max_helpers = 1
			case 20..24: g_max_helpers = 2
			case 25..32: g_max_helpers = 3
		}
		
		if(g_max_helpers > 0)  {
			g_helper_count = 0

			for(i = 0; i <= g_max_helpers; i++)	{
				id = zp_get_random_player(1)
				
				// For have a exact helper quantity
				if(g_helper_count >= g_max_helpers)
					break;
				
				if(zp_get_user_zombie(id) || !is_user_alive(id)) {
					i--
					continue;
				}

				if(helper_ckeck[id])
					continue;

				zp_infect_user(id)
				g_helper_count++
				helper_ckeck[id] = true
				
				if(zp_is_escape_map())
					zp_do_random_spawn(id)
				
				client_print_color(id, print_team_default, "%L %L", id, "ZP_HELPER_PREFIX", id, "ZP_CHOSSED_HELPER")
			}
			client_print_color(0, print_team_default, "%L %L", LANG_PLAYER, "ZP_HELPER_PREFIX", LANG_PLAYER, "ZP_PLAYERS_HELPER", g_helper_count)
		}
		else
			client_print_color(0, print_team_default, "%L %L", LANG_PLAYER, "ZP_HELPER_PREFIX", LANG_PLAYER, "ZP_NO_HELPER")
	}

	for(i = 1; i <= MaxClients; i++) {
		if(!is_user_connected(i))
			continue;

		if(!zp_get_user_zombie(i) && helper_ckeck[i])
			helper_ckeck[i] = false;
	}
}