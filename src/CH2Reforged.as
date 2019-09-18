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
	import ui.CH2UI;
	
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
		
		public function onWorldStartedOverride(worldNumber:Number):void 
		{
			var character:Character = CH2.currentCharacter;
			character.onWorldStartedDefault(worldNumber); // default code has to be executed
			
			// check if this is a rerun, set flag on character
			if (character.runsCompletedPerWorld[character.currentWorldId])
			{
				character.setTrait("Rerun", 1);
			}
		}
			
		public function onKilledMonsterOverride(monster:Monster):void 
		{
			var character:Character = CH2.currentCharacter;
			character.onKilledMonsterDefault(monster);	// make sure to execute default game code
			
			if (!character.getTrait("Rerun") == 1) // if this is no rerun, boss kills may award skillpoints
			{
				// determine if monster is some kind of boss, if yes roll for a skillpoint reward
				if (monster.isMiniBoss)
				{
					if (rollNumberToBoolean(995, 1000))
					{
						rewardStatpoint();
					}
					// check Character.as; continue from there
					//character.persist(true, registerDynamicObject(), "traits");
				}
				else if (monster.isBoss)
				{
					if (rollNumberToBoolean(980, 1000))
					{
						rewardStatpoint();
					}
				}
				else if (monster.isFinalBoss)
				{
					if (rollNumberToBoolean(925, 1000))
					{
						rewardStatpoint();
					}
				}
			}
		}
		
		// -----------------
		
		// --- FUNCTIONS ---
		
		// returns an integer between 0 and a given uper limit
		public function rollNumber(ulimit:int):int
		{
			var roll:int = -1;
			roll = Math.floor(Math.random() * ulimit +1);
			return roll;
		}
		
		// rolls between 0 and a given limit; returns true if roll is >= to split, else returns false
		public function rollNumberToBoolean(split:int, limit:int):Boolean
		{
			var broll:Boolean = false;
			if (rollNumber(limit) >= split)
			{
				broll = true;
			}
			return broll;
		}
		
		// imcrements statpoints (skillpoints) by 1 and calls for a UI update
		public function rewardStatpoint():void 
		{
			CH2.currentCharacter.totalStatPointsV2++;
			CH2.currentCharacter.hasNewSkillTreePointsAvailable = true;
			CH2UI.instance.refreshLevelDisplays();
		}
		
		// -----------------
		
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
			character.onWorldStartedHandler = this;
			
			if (_isDebug)
			{
				debugCheats.cheatCharacterDamage(character);
			}
		}
			
		public function onUICreated():void { }
	}
}