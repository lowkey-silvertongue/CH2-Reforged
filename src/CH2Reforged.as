package
{
	
	/**
	 * v0.1
	 * @author lowkey-silvertongue
	 */
	
	 
	// --- PACKAGE/CLASS IMPORT ---
	 
	import flash.display.Sprite;
	import heroclickerlib.CH2;
	import models.Character;
	import CH2Rlibs.debugCheats;
	
	// ----------------------------
	
	public class CH2Reforged extends Sprite
	{
		// --- VARIABLES ---
		
		public var MOD_INFO:Object =
		{
			"name": "CH2 Reforged",
			"description": "Adds various improvements to the game not covered by Omnimod",
			"version": 1,
			"author": "lowkey-silvertongue"
		};
		
		private var _isDebug:Boolean = true;
		
		// -----------------
		
		// --- CONSTANTS ---
		
		// -----------------
		
		// --- OVERRIDES ---
		
			public function applyWorldTraitsOverride(worldNumber:Number):void
			{
				var character:Character = CH2.currentCharacter;
				
				if (_isDebug)
				{
					debugCheats.fastWorldLessMonsters(character);
				}
			}
		
		// -----------------
		
		public function onStartup(game:IdleHeroMain):void
		{
			
		}

		public function onStaticDataLoaded(staticData:Object):void { }

		public function onUserDataLoaded():void { }

		public function onCharacterCreated(character:Character):void
		{
			character.modDependencies[MOD_INFO["name"]] = true;
			character.applyWorldTraitsHandler = this;
			if (_isDebug)
			{
				debugCheats.cheatCharacterDamage(character);
			}
		}
			
		public function onUICreated():void { }
	}
}