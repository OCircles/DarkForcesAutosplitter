// Thanks to
// MikewareXGR for the DOSBox 0.74 MemBase ptr, setting me on the right track for getting this to work
// Vryndar for actually gifting me Dark Forces on Steam so I could get it to work on both versions, and for helping me test
// Thanks to Psych0sis for this really nifty way of selecting DOSBox states

state("DOSBox", "0, 74, 0, 0")
{
    int loading : "DOSBox.exe", 0x193A1A0, 0x29A344;
    int level : "DOSBox.exe", 0x193A1A0, 0x29A154;
    int tLevel : "DOSBox.exe", 0x193A1A0, 0x2811EC;
}

state("DOSBox", "0, 73, 0, 0")
{
    int loading : "DOSBox.exe", 0x00351690, 0x28E344;
    int level : "DOSBox.exe", 0x00351690, 0x28E154; 
    int tLevel : "DOSBox.exe", 0x00351690, 0x2751EC;
} 

state("DOSBox", "0, 74, 2, 0")
{
    int loading : "DOSBox.exe", 0x193E370, 0x29A344;
    int level : "DOSBox.exe", 0x193E370, 0x29A154;
    int tLevel : "DOSBox.exe", 0x193E370, 0x2811EC;
}

state("DOSBox", "0, 74, 3, 0")
{
    int loading : "DOSBox.exe", 0x193C370, 0x29A344;
    int level : "DOSBox.exe", 0x193C370, 0x29A154;
    int tLevel : "DOSBox.exe", 0x193C370, 0x2811EC;
}

init
{
	version = modules.First().FileVersionInfo.ProductVersion;
}

start
{
	return old.loading == 0 && current.loading != 0 && current.level == 1; 
}

isLoading
{
	return current.loading == 0;
	
}

split
{
	int inc=old.tLevel+1; 								// Stupid way to fix stupid issue with 0.73 where exiting the esc menu would split
	bool next = inc == current.tLevel && current.tLevel != 1 && current.tLevel != 0;	// 2nd and 3rd conditional also fixes 0.73 issue where it'd split twice upon running Secret Base only once after starting the g
	if ( current.tLevel == 14 && old.level == 14 && current.level == 0 ) return true;	// For splitting on returning to main menu after final level
	return next;
}
