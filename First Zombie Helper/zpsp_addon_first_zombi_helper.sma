/* 
		[ZPSp] Addon: First Zombie Helper

		* Description:
			For prevent a fast human win rounds, first zombie have now a helper and this helper 
			are choosed automaticaly in infection rounds..

*/

#include <amxmodx>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 43
#assert Zombie Plague Special 4.3 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

new g_max_helpers, g_helper_count

public plugin_init() {
	register_plugin("[ZP] First Zombie Helper", "1.0", "[P]erfect [S]crash")
}

public zp_round_started(gm)
{
	if(gm == MODE_INFECTION)
	{
		static id
		
		// Helper Quantity
		switch(zp_get_alive_players()) {
			case 0..9: g_max_helpers = 0
			case 10..19: g_max_helpers = 1
			case 20..24: g_max_helpers = 2
			case 25..32: g_max_helpers = 3
		}
		
		if(g_max_helpers > 0)  {
			g_helper_count = 0
			
			for(new i = 0; i <= g_max_helpers; i++)
			{
				id = zp_get_random_player(1)
				
				// For have a exact helper quantity
				if(g_helper_count >= g_max_helpers)
					break;
				
				if(zp_get_user_zombie(id) || !is_user_alive(id)) {
					i--
					continue;
				}

				zp_infect_user(id)
				g_helper_count++
				
				if(zp_is_escape_map())
					zp_do_random_spawn(id)
				
				zp_colored_print(id, 1, "!g[ZP]!y You are chossed for help the first zombie")
			}
			
			zp_colored_print(0, 1, "!g[ZP]!y Are Chossed !t%d!y Players For Help the First Zombie", g_helper_count)
		}
		else
			zp_colored_print(0, 1, "!g[ZP]!y Not have Helpers in this round")
	}
}

#if ZPS_INC_VERSION < 44

#define CHAT_PREFIX "!g[ZP]!y"

#if AMXX_VERSION_NUM < 183
stock zp_colored_print(target, with_tag, const message[], any:...) {
	static buffer[512], i, argscount
	argscount = numargs()

	// Format message for player
	vformat(buffer, charsmax(buffer), message, 4)

	if(with_tag) 
		format(buffer, charsmax(buffer), "%s %s", CHAT_PREFIX, buffer)

	replace_all(buffer, charsmax(buffer), "!g","^4");    // green
	replace_all(buffer, charsmax(buffer), "!y","^1");    // normal
	replace_all(buffer, charsmax(buffer), "!t","^3");    // team

	if(!target) { // Send to everyone
		static player
		for(player = 1; player <= ZP_MAX_PLAYERS; player++) {
			if(!is_user_connected(player)) continue; // Not connected
			
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
stock zp_colored_print(target, with_tag, const message[], any:...) {
	static szMsg[512];
	vformat(szMsg, charsmax(szMsg), message, 4);
	
	if(with_tag) 
		format(szMsg, charsmax(szMsg), "%s %s", CHAT_PREFIX, szMsg);

	replace_string(szMsg, charsmax(szMsg), "!g", "^4");    // green
	replace_string(szMsg, charsmax(szMsg), "!y", "^1");    // normal
	replace_string(szMsg, charsmax(szMsg), "!t", "^3");    // team
	client_print_color(target, print_team_default, "%s", szMsg)
}
#endif
#endif
