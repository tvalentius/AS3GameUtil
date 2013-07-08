package com.tvalentius.managers 
{
	import flash.display.Sprite;
	
	/**
	 * SINGLETON FOR MANAGING LEVEL
	 * @author Trimikha Valentius(tvalentius@gmail.com)
	 * @version 1.1
	 */
	public class LevelManager
	{
		
		/* LEVEL MANAGER PROPERTIES */
		private var initiated:Boolean = false;
		private var levelsData:Array = [];
		private var main:Sprite;
		private var currentLevel:int = 0;
		private var bestLevel:int = 0;
		
		
		/* LEVEL MANAGER PROPERTIES */
		public function init(mainClass:Sprite, _levelsData:Array)
		{
			if (!initiated) {
				main = mainClass;
				levelsData = _levelsData;
				initiated = true;
			}
		}
		
		public function setLevel(_level:int)
		{
			currentLevel = _level
			bestLevel = _level
		}
		
		public function setBestLevel(_level:int)
		{
			bestLevel = _level;
		}
		
		public function setCurrentLevel(_level:int)
		{
			currentLevel = _level;
		}
		
		public function getCurrentLevel():int
		{
			return currentLevel;
		}
		
		public function getBestLevel():int
		{
			return bestLevel;
		}
		
		public function getLevelProp(index:int):String
		{
			return levelsData[index-1];
		}
		/**********************************************
		 * SINGLETON ENFORCER
		 **********************************************/
		private static var _instance:LevelManager;
		
		
		public function LevelManager(enf:SingletonEnforcer)
		{

		}
		
		public static function getInstance():LevelManager
		{
			if(_instance == null) _instance = new LevelManager(new SingletonEnforcer());
			return _instance;
		}
		
	}

}

class SingletonEnforcer{};