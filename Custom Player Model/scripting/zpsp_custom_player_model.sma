/* 
	[ZPSp] Plugin: Custom Player Model

	* Description:
		Give for any user a Custom Player Model/Skin by Nick/Ip/Steam ID/Flag Acess
	
	* Changelog:
		- 1.0: First release.
		- 1.1: Added Body/Skin support
		- 1.2: Fixex 0/0.mdl not found error
*/

#include <amxmodx>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 45
#assert Zombie Plague Special 4.5 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

#define PLUGIN "[ZP] Plugin: Player Skins"
#define VERSION "1.1"
#define AUTHOR "[P]erfec[T] [S]cr[@]s[H]"

new const INI_FILE[] = "zpsp_player_skins.ini"

new Array:skin_authtype, Array:skin_authid, Array:skin_zombie_precache, Array:skin_human_precache, user_skin_id[33]
new Array:skin_zombie_body, Array:skin_zombie_skin, Array:skin_human_body, Array:skin_human_skin;

public plugin_precache() {
	register_plugin(PLUGIN, VERSION, AUTHOR)

	skin_authtype = ArrayCreate(1, 1)
	skin_authid = ArrayCreate(32, 1)
	skin_zombie_precache = ArrayCreate(32, 1)
	skin_zombie_body = ArrayCreate(1, 1)
	skin_zombie_skin = ArrayCreate(1, 1)
	skin_human_precache = ArrayCreate(32, 1)
	skin_human_body = ArrayCreate(1, 1)
	skin_human_skin = ArrayCreate(1, 1)
	
	load_skins_files()
	
	static i, buffer[250]

	for (i = 0; i < ArraySize(skin_human_precache); i++) {
		ArrayGetString(skin_human_precache, i, buffer, charsmax(buffer))

		if(!equal(buffer, "!default"))
			precache_player_model(buffer)
	}
	
	for (i = 0; i < ArraySize(skin_zombie_precache); i++) {
		ArrayGetString(skin_zombie_precache, i, buffer, charsmax(buffer))

		if(!equal(buffer, "!default"))
			precache_player_model(buffer)
	}
}


public load_skins_files() {
	static sConfig[128]; get_localinfo("amxx_configsdir", sConfig, charsmax(sConfig))
	formatex(sConfig, charsmax(sConfig), "%s/%s", sConfig, INI_FILE);

	if(!file_exists(sConfig)) {
		set_fail_state("File zpsp_player_skins.ini Not found")
		return;
	}
	
	new Len, Line[512], Data[8][64], authtype, MaxFileLine, loaded_count, Num, x;
	MaxFileLine = file_size(sConfig, 1);
	
	for(Num = 0; Num < MaxFileLine; Num++) {
		read_file(sConfig, Num, Line, charsmax(Line), Len);
		parse(Line, Data[0], charsmax(Data[]), Data[1], charsmax(Data[]), Data[2], charsmax(Data[]), Data[3], charsmax(Data[]),
		Data[4], charsmax(Data[]), Data[5], charsmax(Data[]), Data[6], charsmax(Data[]), Data[7], charsmax(Data[]));
		
		if(Line[0] == ';' || 2 > strlen(Line) || !Line[0] || Line[0] == '/' || Line[0] == '\')
			continue;
		
		for(x = 0; x < 8; x++)
			remove_quotes(Data[x]);
		
		strtolower(Data[0])
		
		if(Data[0][0] == 's')	// Steam
			authtype = 0
		
		if(Data[0][0] == 'n')	// Nick
			authtype = 1
			
		if(Data[0][0] == 'i') 	// IP
			authtype = 2
		
		if(Data[0][0] == 'f')	// Flag
			authtype = 3

		ArrayPushCell(skin_authtype, authtype)
		ArrayPushString(skin_authid, Data[1])
		ArrayPushString(skin_human_precache, Data[2])
		ArrayPushCell(skin_human_body, str_to_num(Data[3]))
		ArrayPushCell(skin_human_skin, str_to_num(Data[4]))
		ArrayPushString(skin_zombie_precache, Data[5])
		ArrayPushCell(skin_zombie_body, str_to_num(Data[6]))
		ArrayPushCell(skin_zombie_skin, str_to_num(Data[7]))
		loaded_count++
	}
	
	log_amx("[ZP Player Skins] Loaded %d Skin of Users", loaded_count)
}

// Change user model
public zp_user_model_change_pre(id, model[], body, skin) {
	if(!is_user_alive(id))
		return PLUGIN_CONTINUE

	if(zp_get_human_special_class(id) || zp_get_zombie_special_class(id) || !user_skin_id[id])
		return PLUGIN_CONTINUE;

	static skin_string[32];
		
	if(zp_get_user_zombie(id)) {
		ArrayGetString(skin_zombie_precache, user_skin_id[id]-1, skin_string, charsmax(skin_string))
		body = ArrayGetCell(skin_zombie_body, user_skin_id[id]-1)
		skin = ArrayGetCell(skin_zombie_skin, user_skin_id[id]-1)
	}
	else {
		ArrayGetString(skin_human_precache, user_skin_id[id]-1, skin_string, charsmax(skin_string))
		body = ArrayGetCell(skin_human_body, user_skin_id[id]-1)
		skin = ArrayGetCell(skin_human_skin, user_skin_id[id]-1)
	}
		
	if(!equal(skin_string, "!default")) {
		zp_set_param_string(skin_string)	// Change a forward parameter (More faster than zp override user model)
		zp_set_fw_param_int(2, body)
		zp_set_fw_param_int(3, skin)
		//return ZP_PLUGIN_SUPERCEDE;
		return PLUGIN_CONTINUE;
	}

	return PLUGIN_CONTINUE;
}

public client_putinserver(id) {
	user_skin_id[id] = 0
	
	static user_authstring[64], authstring[64], user_flag, find, i
	find = -1
	
	for(i = 0; i < ArraySize(skin_authtype); i++) 
	{
		ArrayGetString(skin_authid, i, authstring, charsmax(authstring))

		switch(ArrayGetCell(skin_authtype, i)) {
			case 0: {	// Steam
				get_user_authid(id, user_authstring, charsmax(user_authstring)) 
				if(equal(authstring, user_authstring)) find = i
			}
			case 1: {   // Name
				get_user_name(id, user_authstring, charsmax(user_authstring)) 
				if(equal(authstring, user_authstring)) find = i
			}
			case 2: {   // IP
				get_user_ip(id, user_authstring, charsmax(user_authstring), 1) 
				if(equal(authstring, user_authstring)) find = i
			}
			case 3: {   // Flag
				user_flag = read_flags(authstring)
				if(get_user_flags(id) & user_flag) find = i
			}
		}
	}
	
	if(find != -1)
		user_skin_id[id] = find+1
}



precache_player_model(const modelname[]) {  
	static longname[128] 
	formatex(longname, charsmax(longname), "models/player/%s/%s.mdl", modelname, modelname)  	
	precache_model(longname) 
	
	copy(longname[strlen(longname)-4], charsmax(longname) - (strlen(longname)-4), "T.mdl") 
	if (file_exists(longname)) precache_model(longname) 
}
