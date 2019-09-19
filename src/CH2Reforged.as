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
	import models.Monster;
	import ui.CH2UI;
	import Overrides.worldStartOverride;
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
		
		private var _isDebug:Boolean = false;
		public var bonusPoints:Number;
		
		// -----------------
		
		// --- CONSTANTS ---
		
		// -----------------
		
		// --- OVERRIDES ---
		
		// default function is empty; override to collect current
		// bonus points on character load and other mod validations
		public function onCharacterLoadedOverride():void
		{
			var character:Character = CH2.currentCharacter;
			// get bonuspoints from character in case
			// it is a modded character
			if (checkCharacterForMod(character))
			{
				bonusPoints = CH2.currentCharacter.getTrait("BonusSP");
				// validate the amount of skillpoints the character has and
				// update them in case they are missing (e.g. player used reset gild funtion)
				if (!validateBonusPoints(character) && (character.gilds > 0))
				{
					character.totalStatPointsV2 = character.level - (calcGildWorldId() * 5) + 6 + bonusPoints;
				}
			}
		}
		
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
			
			// revalidate total amount of skillpoints in case they were reset by the player
			// because we cannot override resetGild() at the moment
			if (!validateBonusPoints(character) && (character.gilds > 0))
			{
				character.totalStatPointsV2 = character.level - (calcGildWorldId() * 5) + 6 + bonusPoints;
			}
			var expectedNumGilds:int = Math.floor((character.currentWorldId - 1) / character.worldsPerGild);
			// --- default code block ---
			character.currentWorldId = worldNumber;
			if (character.gilds < expectedNumGilds)
			{
				// save current bonus skillpoints before the reset
				bonusPoints = character.getTrait("BonusSP");
				character.addGild(character.currentWorldId); // gild function; does stuff and resets skillpoints
				// add our bonus skillpoints back to the character
				addBonusPoints(bonusPoints);
				character.setTrait("BonusSP", bonusPoints);
			}
			character.timeOfLastRun = CH2.user.totalMsecsPlayed;
			// --------------------------
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
					if (rollNumberToBoolean(998, 1000))
					{
						rewardStatpoint();
					}
					// check Character.as; continue from there
					//character.persist(true, registerDynamicObject(), "traits");
				}
				/**
				 * for some reason monster.isBoss is false for 25/50/75 but true for monster.finalBoss
				 * making them virtually identical and leaving no apparent option to distinguish them
				 * code will remain until I find a way around this
				 * 
				if (monster.isBoss)
				{
					if (rollNumberToBoolean(0, 1000))
					{
						rewardStatpoint();
					}
				}
				*/
				if (monster.isFinalBoss)
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
		public function rollNumber(ulimit:Number):int
		{
			var roll:int = 0;
			roll = Math.floor(Math.random() * ulimit +1);
			return roll;
		}
		
		// rolls between 0 and a given limit; returns true if roll is >= to split, else returns false
		public function rollNumberToBoolean(split:Number, limit:Number):Boolean
		{
			var broll:Boolean = false;
			if (rollNumber(limit) >= split)
			{
				broll = true;
			}
			return broll;
		}
		
		public function addBonusPoints(points:Number):void
		{
			var character:Character = CH2.currentCharacter
			character.totalStatPointsV2 = character.totalStatPointsV2 + points;
			character.hasNewSkillTreePointsAvailable = true;
			CH2UI.instance.refreshLevelDisplays();
		}
		
		public function getBonusPoints():Number
		{
			return CH2.currentCharacter.getTrait("BonusSP");
		}
		
		// imcrements statpoints (skillpoints) by 1 and calls for a UI update
		public function rewardStatpoint():void 
		{
			var character:Character = CH2.currentCharacter;
			character.totalStatPointsV2++;
			character.hasNewSkillTreePointsAvailable = true;
			character.addTrait("BonusSP", 1);
			CH2UI.instance.refreshLevelDisplays();
		}
		
		public function checkCharacterForMod(character:Character):Boolean
		{
			var _isModded:Boolean = false;
			if (character.modDependencies[MOD_INFO["name"]])
			{
				_isModded = true;
			}
			return _isModded;
		}
		
		public function calcGildWorldId():Number
		{
			return Math.floor((CH2.currentCharacter.highestWorldCompleted + 1) / CH2.currentCharacter.worldsPerGild) * CH2.currentCharacter.worldsPerGild + 1;
		}
		
		public function validateBonusPoints(character:Character):Boolean
		{
			var hasPoints:Boolean = false;
			var _GildWorldId:Number = calcGildWorldId();
			if (character.totalStatPointsV2 == (character.level - (_GildWorldId * 5 ) + 6 + bonusPoints))
			{
				hasPoints = true;
			}
			return hasPoints;
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
			character.onCharacterLoadedHandler = this;
			
			// init trait which counts extra skillpoints
			character.setTrait("BonusSP", 0);
			bonusPoints = character.getTrait("BonusSP");
			
			if (_isDebug)
			{
				debugCheats.cheatCharacterDamage(character);
			}
		}
			
		public function onUICreated():void { }
	}
}