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
	import models.Monster;
	
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
			
			public function onKilledMonsterOverride(monster:Monster):void 
			{
				var character:Character = CH2.currentCharacter;
				
				if (monster.isBoss)
				{
					// check Character.as; continue from there
					//character.persist(true, registerDynamicObject(), "traits");
				}
			}
		
		// -----------------s
		
		public function onStartup(game:IdleHeroMain):void
		{
			
		}

		public function onStaticDataLoaded(staticData:Object):void { }

		public function onUserDataLoaded():void { }

		public function onCharacterCreated(character:Character):void
		{
			// add dependency to any character; ensure ppl don't crash their games after uninstalling
			character.modDependencies[MOD_INFO["name"]] = true;
			
			// custom handlers go here
			character.applyWorldTraitsHandler = this;
			character.onKilledMonsterHandler = this;
			
			if (_isDebug)
			{
				debugCheats.cheatCharacterDamage(character);
			}
		}
			
		public function onUICreated():void { }
	}
}