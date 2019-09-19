package Overrides
{
	/**
	 * v0.1
	 * @author lowkey-silvertongue
	 */
	
	import heroclickerlib.CH2;
	import models.Character;
	import CH2Rlibs.worldTracker;
	import CH2Rlibs.dataHandler;
	
	public class worldStartOverride 
	{
		public static function worldStart(worldNumber:Number):void
		{
			var character:Character = CH2.currentCharacter;
			
			// --- default code block ---
			character.currentWorldId = worldNumber;
			var expectedNumGilds:int = Math.floor((character.currentWorldId - 1) / character.worldsPerGild);
			if (character.gilds < expectedNumGilds)
			{
				character.addGild(character.currentWorldId); // gild function; does stuff and resets skillpoints
			}
			character.timeOfLastRun = CH2.user.totalMsecsPlayed;
		}
	}

}