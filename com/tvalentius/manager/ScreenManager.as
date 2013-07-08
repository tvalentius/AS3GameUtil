package com.tvalentius.manager 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	/**
	 * Singleton for managing screen
	 * @author Trimikha Valentius(Chocorobokun)
	 * 
	 */
	public class ScreenManager
	{	
		/* SCREEN MANAGER VARS */
		private var _initiated:Boolean = false;
		private var _screenArray:Array;
		private var _screenDict:Dictionary;
		private var _view:DisplayObjectContainer;
		private var _main:Sprite;
		private var _prevScreen:String;
		private var _activeScreenArray:Array = [];
		public var currentScreen:String;
		
		
		/* METHOD FOR THE SCREEN MANAGER */
		
		/**
		 * Initialize the Screen Manager
		 * 
		 * @param	mainClass: the DocumentClass
		 * @param	container: the container of the screen
		 */
		public function init(_documentClass:Sprite , _container:DisplayObjectContainer):void
		{
			if (!_initiated) {
				_screenDict = new Dictionary(true);
				_screenArray = [];
				_main = _documentClass;
				_view = _container;
				_initiated = true;
			}	
		}
		
		/**
		 * Add screen to the screen manager
		 * 
		 * @param	screenMov : screen object
		 * @param	screenName	: screen name identifier
		 */
		public function addScreen(_screen:Sprite, _screenName:String):Boolean		
		{
			
			for (var i in _screenArray) {
				if (_screenArray[i].name == _screenName) {
					return false
				}
			}
			
			var screenObj:Object = new Object();
			var scrn:Sprite = _screen;
			
			screenObj.name = _screenName;
			screenObj.screen = scrn;
			
			_screenDict[_screenName] = screenObj;
			_screenArray.push(screenObj);
			trace(_screenName + " Stored!");
			return true;
			
		}
		
		/**
		 * change the screen
		 * 
		 * @param	screenName : screen name identifier
		 * @param	removeCurrentScreen : remove current screen if true
		 * @param 	xPos : x position of the screen
		 * @param	yPos : y position of the screen
		 */
		public function changeToScreen(_screenName:String , _removeCurrentScreen:Boolean = true , _xPos:Number = 0 ,_yPos:Number = 0):void
		{
			var scrnObj:Object
			if (_removeCurrentScreen && currentScreen) {
				trace("CURRENT SCREEN DETECTED");
				scrnObj = _screenDict[currentScreen];
				_view.removeChild(scrnObj.screen);
				
				for (var i in _activeScreenArray) {
					if (_activeScreenArray[i] == currentScreen) {
						_activeScreenArray.splice(i, 1);
						break;
					}
				}
			}
			scrnObj = _screenDict[_screenName];
			scrnObj.screen.x = _xPos;
			scrnObj.screen.y = _yPos;
			_view.addChild(scrnObj.screen);
			
			
			_activeScreenArray.push(_screenName);
			trace("CURRENT SCREEN 1:" + currentScreen);
			currentScreen = _activeScreenArray[_activeScreenArray.length - 1];
			trace("CURRENT SCREEN 2:" + currentScreen);
			
		}
		
		/**
		 * Remove current active screen
		 * @param	screenName: name identifier of the screen
		 */
		public function removeScreen(_screenName:String):void
		{
			var scrnObj:Object = _screenDict[_screenName];
			_view.removeChild(scrnObj.screen);
			trace(scrnObj.name + " Removed!!");
			if(_screenName == currentScreen) {
				for (var i in _activeScreenArray) {
					if (_activeScreenArray[i] == currentScreen) {
						_activeScreenArray.splice(i, 1);
						break;
					}
				}
				if(_activeScreenArray[_activeScreenArray.length - 1]) {
					currentScreen = _activeScreenArray[_activeScreenArray.length - 1];
				} else {
					currentScreen = null;
				}
			}
			trace("CURRENT SCREEN IS " + currentScreen);
		}
		
		/**
		 * Get Selected Screen
		 * @param	screenName: name identifier of the screen
		 * @return the screen
		 */
		public function getScreen(_screenName:String):*
		{
			return _screenDict[_screenName].screen;
		}
		
		/**
		 * Get Current Screen Name/Id
		 * @return screen name
		 */
		public function getCurrentScreenName():String
		{
			return currentScreen;
		}
		
		/**********************************************
		 * SINGLETON ENFORCER
		 **********************************************/
		private static var _instance:ScreenManager;
		
		
		public function ScreenManager(enf:SingletonEnforcer)
		{

		}
		
		public static function getInstance():ScreenManager
		{
			if(_instance == null) _instance = new ScreenManager(new SingletonEnforcer());
			return _instance;
		}
		
	}

}

class SingletonEnforcer{};