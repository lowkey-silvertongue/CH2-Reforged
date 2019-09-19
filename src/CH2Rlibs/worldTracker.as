package CH2Rlibs 
{
	/**
	 * v0.1
	 * @author lowkey-silvertongue
	 */
	
	// --- PACKAGE/CLASS IMPORT ---
	import heroclickerlib.CH2;
	import models.Character;
	// ----------------------------
	
	public class worldTracker
	{
		// --- VARIABLES ---
		public var _firstRun:Boolean;
		public var _wasCompleted:Boolean;
		public var _highestZoneReached:Number;
		// -----------------
		
		public function worldTracker()
		{
			super();
			this._wasCompleted = checkWasCompleted();
			this._firstRun = checkFirstRun();
			this._highestZoneReached = 1;
		}
		
		// --- FUNCTIONS ---
		public static function checkWasCompleted():Boolean
		{
			if (CH2.currentCharacter.runsCompletedPerWorld[CH2.currentCharacter.currentWorldId] <= 0)
			{
				return false;
			}
			return true;
		}
		
		public static function checkFirstRun():Boolean
		{
			if (!this._wasCompleted && CH2.currentCharacter.isOnHighestZone)
			{
				return true;
			}
			return false;
		}
		
		public static function calcRewardZone():Number
		{
			CH2.currentCharacter.currentZone
		}
		
		public static function zoneFinished():void
		{
			_highestZoneReached++;
		}
		
		public function resetZoneProgress():void
		{
			_highestZoneReached = 1;
		}
		// -----------------
	}

}