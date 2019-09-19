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
	 
	public class dataHandler 
	{
		// --- VARIABLES ---
		
		// -----------------
		
		// --- CONSTANTS ---
		
		// -----------------
		
		// --- OVERRIDES ---
		
		// -----------------
		
		// --- FUNCTIONS ---
		
		public static function getPropertyNames(object:Object):Array
		{
			var outcome:Array = [];
			var i:uint = 0;
			for (var key:String in object)
			{
				outcome[i] = key;
				i++;
			}
			return outcome;
		}
		
		public static function rollInteger(limit:int=1):Number 
		{
			return Math.floor(Math.random() * limit +1);
		}
		
		public static function rollSimpleBoolean():Boolean
		{
			return (rollInteger() > 0);
		}
		
		public static function rollComplexBoolean(chancePercent:Number):Boolean
		{
			var outcome:Boolean = false;
			if (chancePercent > 100 || chancePercent < 0)
			{
				return outcome;
			}
			if (rollInteger(1000) <= (chancePercent * 10))
			{
				outcome = true;
			}
			return outcome;
		}
	}

}