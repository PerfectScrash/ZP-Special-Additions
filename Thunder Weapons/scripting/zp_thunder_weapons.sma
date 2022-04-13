/*==========================================================================

-----------> [ZPSp] Addon: Thunder Weapons <----------------

---> Description:
-> Give a user an thunder weapon after killing some zombie

---> Cvars:
-> zp_thunder_weapon_dmg - Weapon Damage Multipler

---> Change Log:
* 1.0:
	- Fist Release
* 1.1:
	- Fixed Small bug when you kill a zombie, the weapon model dont change
* 1.2:
	- Small bug fix (Interference with X Custom weapon)

==========================================================================*/


#include <amxmodx>
#include <hamsandwich>
#include <engine>
#include <zombie_plague_special>
#include <amx_settings_api>

/*-------------------------------
-> Credits
---------------------------------*/
#define PLUGIN "[ZPSp] Addon: Thunder Weapons"
#define VERSION "1.2"
#define AUTHOR "Perfect Scrash"

/*-------------------------------
-> User Configuration
---------------------------------*/
new const THUNDER_FILE[] = "zpsp_configs/zp_thunder_models.ini" // Thunder Models File Location

new const sound_thunder[] = "ambience/thunder_clap.wav" // Sound of thunder

/*-------------------------------
-> Variables/Consts
---------------------------------*/
// Weapon Key Name for load (Ordered by index)
new const Wpn_Load_Key[][] = { "", "P228", "", "SCOUT", "HEGRENADE", "XM1014", "C4", "MAC10", "AUG", "SMOKEGRENADE", "ELITE", "FIVESEVEN", "UMP45", "SG550", "GALIL", "FAMAS", "USP", "GLOCK18", "AWP", 
"MP5NAVY", "M249", "M3", "M4A1", "TMP", "G3SG1", "FLASHBANG", "DEAGLE", "SG552", "AK47", "KNIFE", "P90" }

new g_Smoke, g_Lightning, g_has_thunder[33], loaded_count[2], cvar_dmgmultiplier
new Array:wpn_has_v_model, Array:wpn_v_model, Array:wpn_has_p_model, Array:wpn_p_model

/*-------------------------------
-> Plugin Registeration
---------------------------------*/
public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR) // Plugin Registeration

	cvar_dmgmultiplier = register_cvar("zp_thunder_weapon_dmg", "1.1") // Cvar Damage Multi

	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled_Post", 1)	// Player Killed Post Forward
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")			// Take Damage Forward

	log_amx("Loaded %d V Models and %d P Models", loaded_count[0], loaded_count[1]) // Show loaded count
}

/*-------------------------------
-> Load and Precache Models
---------------------------------*/
public plugin_precache() {

	// Create Arrays
	wpn_has_v_model = ArrayCreate(1, 1)
	wpn_has_p_model = ArrayCreate(1, 1)
	wpn_v_model = ArrayCreate(100, 1)
	wpn_p_model = ArrayCreate(100, 1)

	// Precache Some files
	precache_sound(sound_thunder)
	g_Lightning = precache_model("sprites/lgtning.spr");
	g_Smoke = precache_model("sprites/steam1.spr");

	// Load and Precache Models
	static model[100], i; 
	for(i = 0; i < sizeof Wpn_Load_Key; i++) {
		// Error log prevention
		if(!Wpn_Load_Key[i][0]) {
			ArrayPushCell(wpn_has_v_model, 0)
			ArrayPushCell(wpn_has_p_model, 0)
			ArrayPushString(wpn_p_model, "-1")
			ArrayPushString(wpn_v_model, "-1")
			continue;
		}

		// Load P_ Model
		if(amx_load_setting_string(THUNDER_FILE, "Thunder Models", fmt("P_%s", Wpn_Load_Key[i]), model, charsmax(model))) {
			if(!model[0]) {
				ArrayPushCell(wpn_has_p_model, 0)
				ArrayPushString(wpn_p_model, "-1")	
				continue;
			}
			ArrayPushCell(wpn_has_p_model, 1)
			ArrayPushString(wpn_p_model, model)
			precache_model(model)
			loaded_count[1]++
		}
		else {
			ArrayPushCell(wpn_has_p_model, 0)
			ArrayPushString(wpn_p_model, "-1")	
		}

		// Load V_ Model
		if(amx_load_setting_string(THUNDER_FILE, "Thunder Models", fmt("V_%s", Wpn_Load_Key[i]), model, charsmax(model))) {
			if(!model[0]) {
				ArrayPushCell(wpn_has_v_model, 0)
				ArrayPushString(wpn_v_model, "-1")	
				continue;
			}
			ArrayPushCell(wpn_has_v_model, 1)
			ArrayPushString(wpn_v_model, model)
			precache_model(model)
			loaded_count[0]++
		}
		else {
			ArrayPushCell(wpn_has_v_model, 0)
			ArrayPushString(wpn_v_model, "-1")	
		}
	}	
	
}

/*-------------------------------
-> Reset Variables
---------------------------------*/
public client_disconnected(id) g_has_thunder[id] = false;
public zp_user_infected_post(id) g_has_thunder[id] = false;
public zp_user_humanized_post(id) g_has_thunder[id] = false;
public zp_player_spawn_post(id)	g_has_thunder[id] = false;

/*-------------------------------
-> Take Damage - (Used for damage multipler)
---------------------------------*/
public fw_TakeDamage(victim, inflictor, attacker, Float:damage) {
	if(!is_user_alive(attacker))
		return HAM_IGNORED

	if(zp_get_user_zombie(attacker))
		return HAM_IGNORED;

	if(g_has_thunder[attacker])
		SetHamParamFloat(4, damage * get_pcvar_float(cvar_dmgmultiplier))

	return HAM_IGNORED
}

/*-------------------------------
-> Player Killed - (Used for give an attacker a Thunder Weapon)
---------------------------------*/
public fw_PlayerKilled_Post(victim, attacker, shouldgib) {
	if(!is_user_connected(attacker) || !is_user_connected(victim))
		return HAM_IGNORED

	if(!zp_get_user_zombie(victim) || zp_get_human_special_class(attacker))
		return HAM_IGNORED;

	static vOrigin[3], coord[3];
	get_user_origin(victim, vOrigin);
	vOrigin[2] -= 26
	coord[0] = vOrigin[0] + 150;
	coord[1] = vOrigin[1] + 150;
	coord[2] = vOrigin[2] + 800;

	Thunder_Effect(coord, vOrigin);
	zp_set_user_rendering(victim, kRenderFxGlowShell, 255, 255, 255, kRenderNormal, 20)
	emit_sound(victim, CHAN_ITEM, sound_thunder, 1.0, ATTN_NORM, 0, PITCH_NORM);
	emit_sound(attacker, CHAN_ITEM, sound_thunder, 1.0, ATTN_NORM, 0, PITCH_NORM);
	
	if(!g_has_thunder[attacker]) { // Small bug fix (Thanks 8K300FPS)
		g_has_thunder[attacker] = true
		zp_fw_deploy_weapon(attacker, get_user_weapon(attacker)) // Fix model dont change bug
	}

	return HAM_IGNORED;
}

/*-------------------------------
-> Thunder Model
---------------------------------*/
public zp_fw_deploy_weapon(id, weapid) {
	if(!is_user_alive(id))
		return;
	
	if(!g_has_thunder[id]) 
		return;

	static wpn_model[100];
	if(ArrayGetCell(wpn_has_v_model, weapid)) {
		ArrayGetString(wpn_v_model, weapid, wpn_model, charsmax(wpn_model))
		entity_set_string(id, EV_SZ_viewmodel, wpn_model)
	}

	if(ArrayGetCell(wpn_has_p_model, weapid)) {
		ArrayGetString(wpn_p_model, weapid, wpn_model, charsmax(wpn_model))
		entity_set_string(id, EV_SZ_weaponmodel, wpn_model)
	}
}

/*-------------------------------
-> Thunder effect
---------------------------------*/
Thunder_Effect(vec1[3], vec2[3]) {
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY);
	write_byte(0);
	write_coord(vec1[0]);
	write_coord(vec1[1]);
	write_coord(vec1[2]);
	write_coord(vec2[0]);
	write_coord(vec2[1]);
	write_coord(vec2[2]);
	write_short(g_Lightning);
	write_byte(1);
	write_byte(5);
	write_byte(2);
	write_byte(20);
	write_byte(30);
	write_byte(200);
	write_byte(200);
	write_byte(200);
	write_byte(200);
	write_byte(200);
	message_end();

	message_begin( MSG_PVS, SVC_TEMPENTITY, vec2);
	write_byte(TE_SPARKS);
	write_coord(vec2[0]);
	write_coord(vec2[1]);
	write_coord(vec2[2]);
	message_end();

	message_begin(MSG_BROADCAST, SVC_TEMPENTITY, vec2);
	write_byte(TE_SMOKE);
	write_coord(vec2[0]);
	write_coord(vec2[1]);
	write_coord(vec2[2]);
	write_short(g_Smoke);
	write_byte(10);
	write_byte(10)
	message_end();
}
