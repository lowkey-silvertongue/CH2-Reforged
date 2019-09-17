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
	
	public class debugCheats 
	{
		// --- VARIABLES ---
		
		// -----------------
		
		// --- CONSTANTS ---
		
		// -----------------
		
		// --- OVERRIDES ---
		
		// -----------------
		
		
		// less monsters - only bosses each zone; drastically reduced monster hp
		public static function fastWorldLessMonsters(character:Character):void
		{
			character.monstersPerZone = 1;
			character.monsterHealthMultiplier = 0.000001;
		}
		
		
		// significantly buff base damage, set crit chance to 100% and increase movement speed and crit damage
		public static function cheatCharacterDamage(character:Character):void 
		{
			character.statValueFunctions[CH2.STAT_DAMAGE] = Character.exponentialMultiplier(25);
			character.statBaseValues[CH2.STAT_DAMAGE] = 500;
			character.statBaseValues[CH2.STAT_CRIT_CHANCE] = 1.0;
			character.statBaseValues[CH2.STAT_CRIT_DAMAGE] = 99999;
			character.statValueFunctions[CH2.STAT_MOVEMENT_SPEED] = Character.exponentialMultiplier(2);
			character.statBaseValues[CH2.STAT_MOVEMENT_SPEED] = 3;
		}
		
	}

}