package CH2Rlibs.Extenders 
{
	/**
	 * v0.1
	 * @author lowkey-silvertongue
	 */
	
	// --- PACKAGE/CLASS IMPORT ---
	
	// ----------------------------
	
	public dynamic class customTraits
	{
		public function customTraits()
		{
			super();
		}
		
		public static function updateTraits(traits:Object):void
		{
			for (var key:String in traits)
			{
				if (key.indexOf("CH2R") >= 0)
				{
					this[key] = traits[key];
				}
			}
		}
		
		public static function restoreCustomTraits():void
		{
			for (var key:String in this)
			{
				CH2.currentCharacter.setTrait(key, this[key]);
			}
		}
	}

}