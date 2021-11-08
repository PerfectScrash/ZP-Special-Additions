/* 
	[ZPSp] Plugin: Custom Player Model

	* Description:
		Give for any user a Custom Player Model/Skin by Nick/Ip/Steam ID/Flag Acess
*/

#include <amxmodx>
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 43
#assert Zombie Plague Special 4.3 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

#define PLUGIN "[ZP] Plugin: Player Skins"
#define VERSION "1.0"
#define AUTHOR "[P]erfec[T] [S]cr[@]s[H]"

new const INI_FILE[] = "zpsp_player_skins.ini"

new Array:skin_authtype, Array:skin_authid, Array:skin_zombie_precache, Array:skin_human_precache, user_skin_id[33]

public plugin_init() {
	register_plugin(PLUGIN, VERSION, AUTHOR)
}

// Change user model
public zp_user_model_change_pre(id, model[])
{
	if(!is_user_alive(id))
		return PLUGIN_CONTINUE

	if(zp_get_human_special_class(id) || zp_get_zombie_special_class(id) || !user_skin_id[id])
		return PLUGIN_CONTINUE;

	static skin_string[32]
		
	if(zp_get_user_zombie(id)) 
		ArrayGetString(skin_zombie_precache, user_skin_id[id]-1, skin_string, charsmax(skin_string))
	else 
		ArrayGetString(skin_human_precache, user_skin_id[id]-1, skin_string, charsmax(skin_string))
		
	if(!equal(skin_string, "!default") && !equal(skin_string, model)) {
		zp_set_model_param(skin_string)	// Change a forward parameter (More faster than zp override user model)
		//return ZP_PLUGIN_SUPERCEDE;
		return PLUGIN_CONTINUE;
	}

	return PLUGIN_CONTINUE;
}

public client_putinserver(id)
{
	user_skin_id[id] = 0
	
	static user_authstring[64], authstring[64], user_flag, find
	find = -1
	
	for(new i = 0; i < ArraySize(skin_authtype); i++) 
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


public plugin_precache()
{	
	skin_authtype = ArrayCreate(1, 1)
	skin_authid = ArrayCreate(32, 1)
	skin_zombie_precache = ArrayCreate(32, 1)
	skin_human_precache = ArrayCreate(32, 1)
	
	load_skins_files()
	
	new i, buffer[250]

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


public load_skins_files()
{
	new sConfig[128]; get_localinfo("amxx_configsdir", sConfig, charsmax(sConfig))
	formatex(sConfig, charsmax(sConfig), "%s/%s", sConfig, INI_FILE);

	if(!file_exists(sConfig)) {
		set_fail_state("File zpsp_player_skins.ini Not found")
		return;
	}
	
	new Len, Line[512], Data[4][64], authtype, MaxFileLine, loaded_count;
	MaxFileLine = file_size(sConfig, 1);
	
	for(new Num; Num < MaxFileLine; Num++)
	{
		read_file(sConfig, Num, Line, charsmax(Line), Len);
		parse(Line, Data[0], charsmax(Data[]), Data[1], charsmax(Data[]), Data[2], charsmax(Data[]), Data[3], charsmax(Data[]));
		
		if(Line[0] == ';' || 2 > strlen(Line) || !Line[0] || Line[0] == '/' || Line[0] == '\')
			continue;
		
		remove_quotes(Data[0]);
		remove_quotes(Data[1]);
		remove_quotes(Data[2]);
		remove_quotes(Data[3]);
		
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
		ArrayPushString(skin_zombie_precache, Data[3])
		loaded_count++
	}
	
	log_amx("[ZP Player Skins] Loaded %d Skin of Users", loaded_count)
}

precache_player_model(const modelname[]) 
{  
	static longname[128] 
	formatex(longname, charsmax(longname), "models/player/%s/%s.mdl", modelname, modelname)  	
	precache_model(longname) 
	
	copy(longname[strlen(longname)-4], charsmax(longname) - (strlen(longname)-4), "T.mdl") 
	if (file_exists(longname)) precache_model(longname) 
}
