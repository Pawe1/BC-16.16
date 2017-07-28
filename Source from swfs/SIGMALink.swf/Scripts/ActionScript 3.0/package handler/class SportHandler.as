//class SportHandler
package handler 
{
    import __AS3__.vec.*;
    import core.general.*;
    import core.sport.*;
    import flash.events.*;
    import flash.utils.*;
    import frontend.*;
    import init.interfaces.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class SportHandler extends flash.events.EventDispatcher implements init.interfaces.ISportHandler
    {
        public function SportHandler(arg1:flash.events.IEventDispatcher=null)
        {
            this.sportsIdDic = new flash.utils.Dictionary(true);
            this._sportsInUseDic = new flash.utils.Dictionary(true);
            this.sportsShortNameDic = new flash.utils.Dictionary(true);
            super(arg1);
            return;
        }

        public function get sportsInUseDic():flash.utils.Dictionary
        {
            return this._sportsInUseDic;
        }

        public function resolveSportById(arg1:uint=0):core.sport.Sport
        {
            var loc1:*=null;
            if (arg1 == 0) 
            {
                loc1 = this.sports[0];
                return loc1;
            }
            return this.sportsIdDic[arg1] as core.sport.Sport;
        }

        public function resolveSportByType(arg1:core.general.UnitType):core.sport.Sport
        {
            return this.sports[0];
        }

        public function resolveSportByShortName(arg1:String):core.sport.Sport
        {
            return this.sportsShortNameDic[arg1] as core.sport.Sport;
        }

        public function resolveSportByKeyName(arg1:String):core.sport.Sport
        {
            var loc1:*=0;
            var loc2:*=this.sports.length;
            loc1 = 0;
            while (loc1 < loc2) 
            {
                if (this.sports[loc1].keyName == arg1) 
                {
                    return this.sports[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public function getNumberOfSportsInUse():int
        {
            var loc2:*=undefined;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=this.sportsInUseDic;
            for each (loc2 in loc4) 
            {
                ++loc1;
            }
            return loc1;
        }

        public function getSportIds(arg1:Array=null):Array
        {
            if (!arg1) 
            {
                arg1 = [];
            }
            var loc1:*=[];
            var loc2:*=0;
            var loc3:*=handler.SportHandler.getInstance().sports.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (arg1.indexOf(handler.SportHandler.getInstance().sports[loc2].sportId) == -1) 
                {
                    loc1.push(handler.SportHandler.getInstance().sports[loc2].sportId);
                }
                ++loc2;
            }
            return loc1;
        }

        public static function getInstance():handler.SportHandler
        {
            if (_instance == null) 
            {
                _instance = new SportHandler();
            }
            return _instance;
        }

        public static function init():void
        {
            var loc1:*=getInstance();
            var loc2:*=core.sport.SportLoader.initSports();
            loc1.sports = core.sport.SportLoader.getSports();
            loc1.sportsIdDic = core.sport.SportLoader.getSportsIdDic();
            return;
        }

        public static function getSportIcon(arg1:core.sport.Sport):starling.textures.Texture
        {
            return frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.sportTextureByKeyName(arg1.keyName));
        }

        public static function getSportBackgroundSkin(arg1:core.sport.Sport):starling.display.Quad
        {
            return new starling.display.Quad(1, 1, arg1.color);
        }

        public static const LOAD_FROM_DB_COMPLETE:String="loadFromDBCompleteEvent";

        public static const SAVE_SPORT_COMPLETE:String="saveSportCompleteEvent";

        public static const SAVE_SPORT_ERROR:String="saveSportErrorEvent";

        public var sports:__AS3__.vec.Vector.<core.sport.Sport>;

        public var sportsIdDic:flash.utils.Dictionary;

        internal var _sportsInUseDic:flash.utils.Dictionary;

        protected var sportsShortNameDic:flash.utils.Dictionary;

        internal static var _instance:handler.SportHandler;
    }
}


