package com.tvalentius.managers 
{
	/**
	 * Achievement Manager
	 * @author Trimikha Valentius(tvalentius@gmail.com)
	 * @version 1.1
	 */
	public class AchievementManager
	{
		
		/* ACHIEVEMENT MANAGER VAR */
		private var initiated:Boolean;
		private var achievementArray:Array;
		private var numIndex:int;
		private var callback:Function;
		
		/* ACHIEVEMENT MANAGER METHOD */
		public function init(achievementData:Array,_numIndex:int,_callback:Function = null):void
		{
			if (!initiated) {
				achievementArray = achievementData.concat();
				numIndex = _numIndex;
				callback = _callback;
				initiated = true;
			}
		}
		
		/**
		 * 
		 * Set Achievement
		 */
		public function setAchievement(_achievementID:int, count:int,isCumulative:Boolean = true):Boolean
		{
			if (!isCumulative && achievementArray[_achievementID][numIndex] >= count) {
				return false;
			}
			if (achievementArray[_achievementID][numIndex] <= 0) {
				return false;
			}
			
			achievementArray[_achievementID][numIndex] -= count;
			
			if (achievementArray[_achievementID][numIndex] <= 0) {
				if (callback != null) {
					callback();
				}
				return true;
			} else {
				return false;
			}
		}
		/**********************************************
		 * SINGLETON ENFORCER
		 **********************************************/
		private static var _instance:AchievementManager;
		
		
		public function AchievementManager(enf:SingletonEnforcer)
		{

		}
		
		public static function getInstance():AchievementManager
		{
			if(_instance == null) _instance = new AchievementManager(new SingletonEnforcer());
			return _instance;
		}
		
	}

}

class SingletonEnforcer{};