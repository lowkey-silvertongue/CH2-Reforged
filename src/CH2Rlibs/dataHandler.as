package CH2Rlibs 
{
	import models.Character;
	
	/**
	 * v0.1
	 * @author lowkey-silvertongue
	 */
	
	 // --- PACKAGE/CLASS IMPORT ---
	 
	 // ----------------------------
	 
	public class dataHandler 
	{
		// --- VARIABLES ---
		
		// -----------------
		
		// --- CONSTANTS ---
		
		// -----------------
		
		// --- OVERRIDES ---
		
		// -----------------
		
		
		// add any custom trait with given name and init with 0
		public static function addCustomTrait(character:Character, trait:String):void
		{
			character.addTrait(trait, 0);
		}
		
		// set any custom trait with given name to given value
		public static function setCustomTrait(character:Character,trait:String, value:Number):void
		{
			character.setTrait(trait, value);
		}
		
		// get any custom trait with given name and return value
		public static function getCustomTrait(character:Character, trait:String):Number
		{
			var value:Number = character.getTrait(trait);
			return value;
		}
		
	}

}