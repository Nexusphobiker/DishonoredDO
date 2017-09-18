//Dishonored: Death of the Outsider Autosplitter for v1.142.3.8
//Credits: stole the structure from CursedToast
//By Nexusphobiker 

state("Dishonored_DO")
{
	byte isPaused : "Dishonored_DO.exe", 0x268D758, 0x1F7B28;
	int isPausedSecondary : "Dishonored_DO.exe", 0x268D758, 0x1F7B20;
	int time : "Dishonored_DO.exe", 0x268D758, 0x1F8084;
	int questID : "Dishonored_DO.exe",0x268D758,0x1F7F08,0x20;
	string128 map : "Dishonored_DO.exe", 0x3FEB2B0;
}

startup
{
    //Mission 1
    settings.Add("mission1", true, "Mission 01");
	settings.Add("mission1_enterarea", true, "Get to the bath house","mission1");
	settings.Add("mission1_key",true,"Take the control panel key","mission1");
	settings.Add("mission1_return",true,"Return to the dreadful whale","mission1"); 
	
	//Mission 2
	settings.Add("mission2", true, "Mission 02");
	settings.Add("mission2_enterarea", true, "Get to the rich district","mission2");
	//settings.Add("mission2_redcamelia", true, "Read the note in the red camelia","mission2"); (not needed)
	settings.Add("mission2_secretsignal",true,"Read the note containing the secret signal","mission2");
	settings.Add("mission2_shanyunhouse",true,"Enter shan yuns house","mission2");
	settings.Add("mission2_shanyunkey",true,"Take shan yuns key from the safe","mission2");
	settings.Add("mission2_ivanapartmentkey",true,"Take ivans apartment key","mission2");
	settings.Add("mission2_ivankey",true,"Take ivans key from his desk","mission2");
	settings.Add("mission2_return",true,"Return to the dreadful whale","mission2");
	
	
	//Mission 3
	//Possible improvements: A checkpoint could be added for the opening of the tresor itself by checking if the keys are still in the inventory.
	settings.Add("mission3",true,"Mission 03");
	settings.Add("mission3_enterarea", true, "Get to the rich district","mission3");
	settings.Add("mission3_moontincture", true, "Take the moon tincture","mission3");
	settings.Add("mission3_enterbank",true,"Enter the bank","mission3");
	settings.Add("mission3_taketresorkey",true,"Take the tresor key","mission3");
	settings.Add("mission3_return",true,"Return to the dreadful whale","mission3");
	
	//Mission 4
	//Possible improvements: Same as for mission 3 could be checked if the projector slide got removed from the inventory to check if it was watched in a projector.	
	settings.Add("mission4",true,"Mission 04");
	settings.Add("mission4_takearchive",true,"Take the projector slide","mission4");
	settings.Add("mission4_return",true,"Move on","mission4");
	
	//Mission 5
	settings.Add("mission5",true,"Mission 05");
	settings.Add("mission5_enterthevoid",true,"Step into the void","mission5");
	settings.Add("mission5_finnish",true,"End","mission5");
	
	//Sidequests are not getting tracked the same way main quests are. Leaving it out for now
	//settings.Add("mission1_sidequest_deaddog",true,"Sidequest: Burn the white dog","mission1");
	//settings.Add("mission1_sidequest_searchanddestroy",true,"Sidequest: Industrial Espionage","mission1");
}

init
{
    //Mission 1
	vars.mission1_enterarea = 0;
	vars.mission1_key = 0;
	vars.mission1_return = 0;
	
	//Mission 2
    vars.mission2_enterarea = 0;
	vars.mission2_redcamelia = 0;
	vars.mission2_secretsignal = 0;
	vars.mission2_shanyunhouse = 0;
	vars.mission2_shanyunkey = 0;
	vars.mission2_ivanapartmentkey = 0;
	vars.mission2_ivankey = 0;
	vars.mission2_return = 0;
	
	//Mission 3
	vars.mission3_enterarea = 0;
	vars.mission3_moontincture = 0;
	vars.mission3_enterbank = 0;
	vars.mission3_taketresorkey = 0;
	vars.mission3_return = 0;
	
	//Mission 4
	vars.mission4_takearchive = 0;
	vars.mission4_return = 0;
	
	//Mission 5 
	vars.mission5_enterthevoid = 0;
	vars.mission5_finnish = 0;
}


start
{
	return current.map == "dlc01/boat/boat_01/boat_01_p" && current.isPaused == (byte)1; 
}

update
{
   if (timer.CurrentPhase == TimerPhase.NotRunning)
	{
		//Mission 1
		vars.mission1_enterarea = 0;
		vars.mission1_key = 0;
		vars.mission1_return = 0;
	
		//Mission 2
		vars.mission2_enterarea = 0;
		vars.mission2_redcamelia = 0;
		vars.mission2_secretsignal = 0;
		vars.mission2_shanyunhouse = 0;
		vars.mission2_shanyunkey = 0;
		vars.mission2_ivanapartmentkey = 0;
		vars.mission2_ivankey = 0;
		vars.mission2_return = 0;
		
		//Mission 3
	    vars.mission3_enterarea = 0;
		vars.mission3_moontincture = 0;
		vars.mission3_enterbank = 0;
		vars.mission3_taketresorkey = 0;
		vars.mission3_return = 0;
		
		//Mission 4
		vars.mission4_takearchive = 0;
		vars.mission4_return = 0;
		
		//Mission 5
		vars.mission5_enterthevoid = 0;
		vars.mission5_finnish = 0;
	}
}

split
{
	//print("########################## MAP:"+current.map+" ##########################");
	
    //######################################  Mission 1 ###################################### 
	if(settings["mission1_enterarea"] && vars.mission1_enterarea == 0){
		if(current.map == "dlc01/boxing/boxing_p"){
		vars.mission1_enterarea = 1;
		return true;
		}
    }
	
	if(settings["mission1_key"] && vars.mission1_key == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,44);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/keys/dlc01/bc/key_machine"){
				vars.mission1_key = 1;
				return true;
			}
		}
    }
	
	if(settings["mission1_return"] && vars.mission1_return == 0){
		if(current.map == "dlc01/boat/boat_02/boat_02_p"){
		vars.mission1_return = 1;
		return true;
		}
    }
	
	//###################################### Mission 2 ###################################### 
	if(settings["mission2_enterarea"] && vars.mission2_enterarea == 0){
		if(current.map == "dlc01/rich_district/rich_district_01/rich_district_01_p"){
		vars.mission2_enterarea = 1;
		return true;
		}
    }
	
	//Not needed
	/*if(settings["mission2_redcamelia"] && vars.mission2_redcamelia == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x40 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x38,(i-1)*0x30,0 ).DerefBytes(game,69);
		
		if(item.Length != 0){
			//print(">>>>>>>>>>>>>>>>>>>TEST: "+System.Text.Encoding.Default.GetString(item));
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/dlc01/notes/rich_district01/note_rd1_tattoo_ledger"){
				vars.mission2_redcamelia = 1;
				return true;
			}
		}
    }*/
	
	if(settings["mission2_secretsignal"] && vars.mission2_secretsignal == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x40 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x38,(i-1)*0x30,0 ).DerefBytes(game,69);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/dlc01/notes/rich_district01/note_rd1_secret_signal"){
				vars.mission2_secretsignal = 1;
				return true;
			}
		}
    }
	
	if(settings["mission2_shanyunhouse"] && vars.mission2_shanyunhouse == 0){
		if(current.map == "dlc01/appartment/appartment_p"){
		vars.mission2_shanyunhouse = 1;
		return true;
		}
    }
	
	if(settings["mission2_shanyunkey"] && vars.mission2_shanyunkey == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,65);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/dlc01/keys/rich_district01/singer_banksafe_key"){
				vars.mission2_shanyunkey = 1;
				return true;
			}
		}
    }
	
	if(settings["mission2_ivanapartmentkey"] && vars.mission2_ivanapartmentkey == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,64);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/dlc01/keys/rich_district01/ivan_apartment_key"){
				vars.mission2_ivanapartmentkey = 1;
				return true;
			}
		}
    }
	
	if(settings["mission2_ivankey"] && vars.mission2_ivankey == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,69);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/dlc01/keys/rich_district01/politician_banksafe_key"){
				vars.mission2_ivankey = 1;
				return true;
			}
		}
    }
	
	if(settings["mission2_return"] && vars.mission2_return == 0){
		if(current.map == "dlc01/boat/boat_03/boat_03_p"){
		vars.mission2_return = 1;
		return true;
		}
    }
	
	
	//###################################### Mission 3 ###################################### 
	if(settings["mission3_enterarea"] && vars.mission3_enterarea == 0){
		if(current.map == "dlc01/rich_district/rich_district_02/rich_district_02_p"){
		vars.mission3_enterarea = 1;
		return true;
		}
    }
	
	if(settings["mission3_moontincture"] && vars.mission3_moontincture == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,64);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/campaign/dlc01/richdistrict01/props/chloroform/chloroform"){
				vars.mission3_moontincture = 1;
				return true;
			}
		}
    }
	
	if(settings["mission3_enterbank"] && vars.mission3_enterbank == 0){
		if(current.map == "dlc01/bank/bank_p"){
		vars.mission3_enterbank = 1;
		return true;
		}
    }
	
	if(settings["mission3_taketresorkey"] && vars.mission3_taketresorkey == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,50);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/interactive/dlc01/keys/bank/bank_keys_owner"){
				vars.mission3_taketresorkey = 1;
				return true;
			}
		}
    }
	
	if(settings["mission3_return"] && vars.mission3_return == 0){
		if(current.map == "dlc01/conservatory/conservatory_p"){
		vars.mission3_return = 1;
		return true;
		}
    }
	
	//###################################### Mission 4 ###################################### 
	if(settings["mission4_takearchive"] && vars.mission4_takearchive == 0){
		byte i = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x70 ).Deref<byte>(game);
        byte[] item = new DeepPointer("Dishonored_DO.exe", 0x268D758,0x1F7F08,0x68,(i-1)*0x30,0 ).DerefBytes(game,48);
		
		if(item.Length != 0){
			if(System.Text.Encoding.Default.GetString(item)=="models/campaign/dlc01/conservatory/slide_archive"){
				vars.mission4_takearchive = 1;
				return true;
			}
		}
    }
	
	if(settings["mission4_return"] && vars.mission4_return == 0){
		if(current.map == "dlc01/hollow/hollow_p"){
		vars.mission4_return = 1;
		return true;
		}
    }
	
	//###################################### Mission 5 ###################################### 
	if(settings["mission5_enterthevoid"] && vars.mission5_enterthevoid == 0){
		if(current.map == "dlc01/deep_void/deep_void_p"){
		vars.mission5_enterthevoid = 1;
		return true;
		}
    }
	
	if(settings["mission5_finnish"] && vars.mission5_finnish == 0){
		if(current.map == "dlc01/dlc01_end/dlc01_end_p"){
		vars.mission5_finnish = 1;
		return true;
		}
    }
}
isLoading
{
	int bitTest = 0x0000284C;
	vars.test3 = new DeepPointer("Dishonored_DO.exe", 0x268D758, 0x1F7B20,4*(current.isPaused-1)).Deref<int>(game);
	int time = current.time;
	if ((bitTest & (1 << vars.test3)) != 0)
	{
		return true;
	}
	else if(current.map != old.map && time == old.time)
	{
		return true;
	}
	else
	{
		if(time == 0){
			return true;
		}
		return false;
	}
}