/*
		[ZPSp] Addon: Delayed Infection Bomb

		* Description:
			Set a time for use a Infection Bomb Again after used in first time on current round.

		* Cvars:
			zp_extra_infbomb_timer "120" - Time for use a Infection Bomb Again.

*/

#include <amxmodx>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 44
	#assert Zombie Plague Special 4.4 Include File Required. Download Link: https://github.com/PerfectScrash/Zombie-Plague-Special/tree/master/Zombie%20Plague%20Special%204.4%20(Beta)/scripting/include
#endif

#define PLUGIN  "[ZPSp] Addon: Delayed Infection Bomb"
#define VERSION "1.0"
#define AUTHOR  "[P]erfec[T] [S]cr[@]s[H]"

#define TASK_BOMB 1231012
new cvar_timer, g_timer

public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	cvar_timer = register_cvar("zp_extra_infbomb_timer", "120")
}

public zp_round_ended() {
	g_timer = 0
	remove_task(TASK_BOMB)
}

public zp_extra_item_selected_pre(id, itemid)
{
	if(itemid != EXTRA_INFBOMB)
		return PLUGIN_CONTINUE;

	if(g_timer) {
		static szText[100]
		formatex(szText, charsmax(szText), "\r[Wait %d Seconds]", g_timer)
		zp_extra_item_textadd(szText)
		return ZP_PLUGIN_HANDLED
	}

	return PLUGIN_CONTINUE;
}

public zp_extra_item_selected(id, itemid)
{
	if(itemid != EXTRA_INFBOMB)
		return PLUGIN_CONTINUE;

	if(g_timer) {
		zp_colored_print(id, 1, "Infection Bomb Will be available in !t%d seconds", g_timer)
		return ZP_PLUGIN_HANDLED;
	}
	else {
		g_timer = get_pcvar_num(cvar_timer)
		set_task(1.0, "timer", TASK_BOMB, _, _, "b")
	}
	return PLUGIN_CONTINUE;
}

public timer()
{
	if(!g_timer) {
		remove_task(TASK_BOMB) 
		zp_colored_print(0, 1, "Infection Bomb are available again. !t[Just Buy and Use]")
		return;
	}
	else g_timer--
}
