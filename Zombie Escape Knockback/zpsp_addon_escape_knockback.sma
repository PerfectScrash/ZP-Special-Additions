/* 
	[ZPSp] Addon Zombie Escape Knockback

	* Description:
		Give a knockback like in zombie escape mods (Enables only in Zombie escape maps)

*/

#include <amxmodx>
#include <hamsandwich>
#include <fakemeta>
#include <engine>
#include <amx_settings_api>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 43
#assert Zombie Plague Special 4.3 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

new const ZP_CUSTOMIZATION_FILE[] = "zombie_plague_special.ini"

#define PLUGIN "[ZP] Addon: Escape Knockback"
#define VERSION "1.0"
#define AUTHOR "[P]erfec[T] [S]cr[@]s[H]"

// Weapon entity names
new const WEAPONENTNAMES[][] = { "", "weapon_p228", "", "weapon_scout", "weapon_hegrenade", "weapon_xm1014", "weapon_c4", "weapon_mac10", "weapon_aug", "weapon_smokegrenade", 
"weapon_elite", "weapon_fiveseven", "weapon_ump45", "weapon_sg550", "weapon_galil", "weapon_famas", "weapon_usp", "weapon_glock18", "weapon_awp", "weapon_mp5navy", "weapon_m249",
"weapon_m3", "weapon_m4a1", "weapon_tmp", "weapon_g3sg1", "weapon_flashbang", "weapon_deagle", "weapon_sg552", "weapon_ak47", "weapon_knife", "weapon_p90" }

new Float:kb_weapon_power[31] = { -1.0, ... }

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)

	// Disable Plugin functions if not playing zombie escape maps
	if(!zp_is_escape_map())
		return;
	
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	
	new wpn_key, i
	for(i = 1; i < sizeof WEAPONENTNAMES; i++) {
		if(!WEAPONENTNAMES[i][0]) 
			continue
		
		wpn_key = cs_weapon_name_to_id(WEAPONENTNAMES[i])
		static buffer[32]
		format(buffer, charsmax(buffer), "%s", WEAPONENTNAMES[i])
		replace_all(buffer, charsmax(buffer), "weapon_", "")
		strtoupper(buffer)
		amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Knockback Power for Weapons", buffer, kb_weapon_power[wpn_key])
	}
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	if(!is_user_alive(victim) || !is_user_alive(attacker))
		return HAM_IGNORED
	
	if(zp_get_user_zombie(victim) && !zp_get_user_zombie(attacker)) {
		set_pdata_float(victim, 108, 1.0, 50)
		
		static Float:MyOrigin[3]
		pev(attacker, pev_origin, MyOrigin)
	
		hook_ent2(victim, MyOrigin, 100.0 * kb_weapon_power[get_user_weapon(attacker)], 2)
	}
	
	return HAM_IGNORED
}

stock hook_ent2(ent, Float:VicOrigin[3], Float:speed, type)
{
	static Float:fl_Velocity[3]
	static Float:EntOrigin[3]
	
	pev(ent, pev_origin, EntOrigin)
	static Float:distance_f
	distance_f = get_distance_f(EntOrigin, VicOrigin)
	
	new Float:fl_Time = distance_f / speed
	
	if(type == 1)
	{
		fl_Velocity[0] = ((VicOrigin[0] - EntOrigin[0]) / fl_Time) * 1.5
		fl_Velocity[1] = ((VicOrigin[1] - EntOrigin[1]) / fl_Time) * 1.5
		fl_Velocity[2] = (VicOrigin[2] - EntOrigin[2]) / fl_Time		
		} else if(type == 2) {
		fl_Velocity[0] = ((EntOrigin[0] - VicOrigin[0]) / fl_Time) * 1.5
		fl_Velocity[1] = ((EntOrigin[1] - VicOrigin[1]) / fl_Time) * 1.5
		fl_Velocity[2] = (EntOrigin[2] - VicOrigin[2]) / fl_Time
	}
	
	entity_set_vector(ent, EV_VEC_velocity, fl_Velocity)
}
// Simplified get_weaponid (CS only)
stock cs_weapon_name_to_id(const weapon[])
{
	static i
	for (i = 0; i < sizeof WEAPONENTNAMES; i++)
	{
		if(equal(weapon, WEAPONENTNAMES[i]))
			return i;
	}
	
	return 0;
}
