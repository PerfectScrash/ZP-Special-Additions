#if defined _zp_lasermine_perfect_included
  #endinput
#endif
#define _zp_lasermine_perfect_included

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp_lasermine_perfect
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp_lasermine_perfect
	#endif
#else
	#pragma library zp_lasermine_perfect
#endif

#define LASERMINE_INC_VERSION 43
#define LM_HANDLED 91

// Enuns for Native Lasermine Set/Get Model
// (0: Classic | 1: Normal | 2: Gauss | 3: Alien | 4: Perfect | 5: End of Day | 6: Kraken's Eye | 7: Eyeball | 8: Inf. Gauntlet)
enum { 
	LM_Half_life = 0, 
	LM_Normal, 
	LM_Gauss, 
	LM_Alien, 
	LM_Perfect, 
	LM_EndOfDay, 
	LM_KrakenEye,
	LM_Eyeball,
	LM_InfGauntlet
}

// Enuns for Native Lasermine Set/Get Sprite
enum { 
	Normal = 0, 
	Shock,
	Neon, 
	Dotted,
	4i20, 
	Triangle, 
	DoubleBeam, 
	Spiral,
	Heartbeat,
	LoveHeart,
	AmazingStar,
	Skull
}

// Enuns for Native zp_get_user_(glow/line)_color_id
enum { 
	Default = 0, 
	white, 
	yellow, 
	red, 
	green, 
	blue, 
	custom
}

// Enuns for forward damaged_(pre/post)
enum { 
	LM_DMG_LASER = 0, 
	LM_DMG_KNOCKBACK 
}


//  --------------------------------------- [Natives] -----------------------------------------
/* Change Lasermine Model
   
   [Example]
   
   zp_set_user_ltm_model(id, LM_RedEye)
   client_print(id, print_chat, "You not stay with a Lasermine Red Eye")

*/
native zp_set_user_ltm_model(id, amount)

/* View Lasermine Model Id

   [Example]
   
   if(zp_get_user_ltm_model(id) == LM_Half_life)
	client_print(id, print_chat, "Your Current Lasermine is: Classic")
*/
native zp_get_user_ltm_model(id)

/* Change Lasermine skin
   
   [Example]
   
   zp_set_user_ltm_skin(id, 0)
   client_print(id, print_chat, "Your current skin are changed to default")

*/
native zp_set_user_ltm_skin(id, amount)

/* View Lasermine skin Id

   [Example]
   
   if(zp_get_user_ltm_skin(id) == 5)
	client_print(id, print_chat, "Your Current Lasermine is: Rainbowned Skin")
*/
native zp_get_user_ltm_skin(id)

/* Change Line Sprite
   
   [Example]
   
   zp_set_user_ltm_sprite(id, Neon)
   client_print(id, print_chat, "You Are Using now Neon Sprite")

*/
native zp_set_user_ltm_sprite(id, amount)

/* View Line Sprite

   [Example]
   
   if(zp_get_user_ltm_sprite(id) == Spiral)
	client_print(id, print_chat, "You are using now Spiral Sprite")
*/
native zp_get_user_ltm_sprite(id)

/* Change Line Color
  
   [Example]
   
   zp_set_ltm_line_color(id, 255, 0, 100)
   client_print(id, print_chat, "Your Line Color are changed to Purple")

*/
native zp_set_ltm_line_color(id, R, G, B)

/* Change Glow Color
  
   [Example]
   
   zp_set_ltm_glow_color(id, 255, 69, 0)
   client_print(id, print_chat, "Your Glow Color are changed to Orange")

*/
native zp_set_ltm_glow_color(id, R, G, B)

/* View Line Color ID

   [Example]
   
   if(zp_get_ltm_line_color_id(id) == Default)
	client_print(id, print_chat, "Your Current Line Color ID is: Default")
*/
native zp_get_ltm_line_color_id(id)

/* View Line Color ID

   [Example]
   
   if(zp_get_ltm_glow_color_id(id) == red)
	client_print(id, print_chat, "Your Current Glow Color ID is: Red")
*/
native zp_get_ltm_glow_color_id(id)

native zp_is_valid_lasermine(ent) // This entity is a Lasermine?

native zp_lasermine_get_owner(ent) // Get Owner ID

native zp_set_lasermine_health(ent, amount) // Set Lasermine Health

native zp_get_lasermine_health(ent) // Get Lasermine Health

native zp_get_user_lm_deployed_num(id) // Get User Deployed Quantity

// Old Version Natives
native zp_get_user_lm_imunne(id) // Get user imunity the Lasermine
native zp_set_user_lm_imunne(id, bool:isimunne) // Set user imunity the Lasermine
native zp_remove_lasermine(id) // Remove User Lasermine

//  --------------------------------------- [Forwards] -----------------------------------------
// When User Plant the Lasermine
// Use 'return LM_HANDLED' for stop Planting
forward zp_fw_lm_planted_pre(id) 

// Execute when user planted the lasermine
forward zp_fw_lm_planted_post(id, ent) 

// Execute when user remove the lasermine
// Use 'return LM_HANDLED' for stop remove
forward zp_fw_lm_removed_pre(id, ent) 

// Execute when user removed the lasermine
forward zp_fw_lm_removed_post(id, ent) 

// Execute when lasermine are destroyed
forward zp_fw_lm_destroyed_post(owner, ent) 

// Execute Before User Get Damage of Lasermine
// Use 'return LM_HANDLED' for preventing the user get damage of Lasermine
forward zp_fw_lm_user_damaged_pre(victim, attacker, damage_type, ent) 

// Execute layer User Get Damage of Lasermine
forward zp_fw_lm_user_damaged_post(victim, attacker, damage_type, ent) 