state("Mafia3DefinitiveEdition")
{
	int loading       : 0x691E350;
    string150 mission : 0x0691DD18, 0x2E0, 0x540;
}

init
{
    vars.doneMissions = new List<string>();
}

startup
  {

    settings.Add("MafiaIII", true, "All Missions");

    vars.Chapters = new Dictionary<string,string> 
	{
        //{"\"Why Take the Chance?\"","Why Take the Chance"},
        {"\"This Changes Everything\"", "This Changes Everything"},
        {"\"A Taste of the Action\"", "A Taste of the Action"},
        {"\"Go Down On Their Own\"", "Go Down on Their Own"},
        {"\"Never Going To Be Over\"", "Never Going to be Over"},
        {"\"...Time To Make A Change\"", "...Time to Make a Change"},
        {"\"Still Pull This Off\"", "Still Pull This Off"},
        {"\"Damn If This Ain't A Gas\"", "Damn if This Ain't a Gas"},
        {"...A Friend In Jesus", "...A Friend in Jesus"},
        {"Something I've Got To Do", "Something I've Got to Do"},
        {"Old Times Sake", "Old Times Sake"},
        {"Prostitution", "Prostitution"},
        {"Smack", "Smack"},
        {"Kill Ritchie Doucet", "Kill Ritchie Doucet"},
        {"\"That Goes Both Ways\"", "That Goes Both Ways"},
        {"\"Friends Like These\"", "Friends Like These"},
        {"\"We Partners Now?\"", "We Partners Now?"},
        {"Kill The Butcher", "Kill the Butcher"},
        {"\"Only Way's Forward\"", "Only Way's Forward"},
        {"Union Extortion", "Union Extortion"},
        {"Get Michael Grecco", "Get Michael Grecco"},
        {"\"An Emotional Attachment\"", "An Emotional Attachment"},
        {"\"Auto Theft\"", "Auto Theft"},
        {"Kill Frank Pagani: Setup", "Kill Frank Pagani: Setup"},
        {"Kill Frank Pagani: Takedown", "Kill Frank Pagani: Takedown"},
        {"\"Compromised Corruption\"", "Compromised Corruption"},
        {"Blackmail", "Blackmail"},
        {"Kill Tony Derazio", "Kill Tony Derazio"},
        {"\"The Dead Stay Gone\"", "The Dead Stay Gone"},
        {"Guns", "Guns"},
        {"Garbage", "Garbage"},
        {"Get Enzo Conti", "Get Enzo Conti"},
        {"Black Market", "Black Market"},
        {"Gambling", "Gambling"},
        {"Rescue Alvarez", "Rescue Alvarez"},
        {"Kill Tommy Marcano", "Kill Tommy Marcano"},
        {"Drugs", "Drugs"},
        {"Sex", "Sex"},
        {"Kill The Judge", "Kill the Judge"},
        {"Kill 'Uncle' Lou Marcano", "Kill 'Uncle' Lou Marcano"},
        {"Southern Union", "Southern Union"},
        {"PCP", "PCP"},
        {"Kill Remy Duvall", "Kill Remy Duvall"},
        {"Kill Olivia Marcano", "Kill Olivia Marcano"},
        {"Kill Sal Marcano", "Kill Sal Marcano"},
        {"\"Before They Bury You\"", "Before They Bury You"},
        {"Endings", "Endings"}
    };
    foreach (var Tag in vars.Chapters)
		{
			settings.Add(Tag.Key, true, Tag.Value, "MafiaIII");
    	};


		if (timer.CurrentTimingMethod == TimingMethod.RealTime)
// Asks user to change to game time if LiveSplit is currently set to Real Time.
    {        
        var timingMessage = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main timing method.\n"+
            "LiveSplit is currently set to show Real Time (RTA).\n"+
            "Would you like to set the timing method to Game Time?",
            "LiveSplit | Mafia III",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );
        
        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}



update
{ 
    //print(current.loading.ToString());
    //print(current.mission.ToString());
}

isLoading
{
	return current.loading == 1 || current.loading == 2;
}

start
{
    return old.mission != "\"Why Take The Chance?\"" && current.mission == "\"Why Take The Chance?\"";
}

onStart
{
    // This is part of a "cycle fix", makes sure the timer always starts at 0.00
    timer.IsGameTimePaused = true;
    vars.doneMissions.Add(current.mission);
}

split
{
    if (settings[current.mission] && (!vars.doneMissions.Contains(current.mission)))
    {
        vars.doneMissions.Add(current.mission);
        return true;
    }
}

onReset
{
    vars.doneMissions.Clear();
}

exit
{
    timer.IsGameTimePaused = true;
}
