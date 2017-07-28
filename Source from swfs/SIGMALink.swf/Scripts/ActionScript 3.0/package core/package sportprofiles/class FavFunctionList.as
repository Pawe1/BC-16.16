//class FavFunctionList
package core.sportprofiles 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class FavFunctionList extends flash.events.EventDispatcher
    {
        public function FavFunctionList()
        {
            favFunctionList = new __AS3__.vec.Vector.<core.sportprofiles.FavFunctionlistItem>();
            super();
            return;
        }

        public function changeFavFunction(arg1:core.sportprofiles.FavFunctionlistItem):void
        {
            var loc1:*=0;
            var loc2:*=false;
            while (loc1 < favFunctionList.length) 
            {
                if (favFunctionList[loc1].position == arg1.position) 
                {
                    loc2 = !(favFunctionList[loc1] == arg1);
                    favFunctionList[loc1] = arg1;
                    if (loc2) 
                    {
                        dispatchEvent(new flash.events.Event("EVENT_FAVFUNCTIONLIST_CHANGED"));
                    }
                    return;
                }
                ++loc1;
            }
            favFunctionList.push(arg1);
            dispatchEvent(new flash.events.Event("EVENT_FAVFUNCTIONLIST_CHANGED"));
            return;
        }

        public function resetFavFunctions():void
        {
            favFunctionList = new __AS3__.vec.Vector.<core.sportprofiles.FavFunctionlistItem>();
            dispatchEvent(new flash.events.Event("EVENT_FAVFUNCTIONLIST_RESETTED"));
            return;
        }

        public function getFavFunctionlistItem(arg1:*):core.sportprofiles.FavFunctionlistItem
        {
            if (favFunctionList.hasOwnProperty(arg1)) 
            {
                return favFunctionList[arg1];
            }
            return null;
        }

        public function toArray():Array
        {
            var loc1:*=[];
            var loc2:*=0;
            while (loc2 < favFunctionList.length) 
            {
                loc1.push(favFunctionList[loc2]);
                ++loc2;
            }
            return loc1;
        }

        public function toObject():Object
        {
            var loc2:*={};
            var loc1:*=0;
            loc2["list"] = {};
            loc2["tid"] = templateId;
            loc2["active"] = active;
            while (loc1 < favFunctionList.length) 
            {
                loc2["list"][favFunctionList[loc1].position] = favFunctionList[loc1].favFuncId;
                ++loc1;
            }
            return loc2;
        }

        public function toJson():String
        {
            var loc1:*=JSON.stringify(toObject());
            return loc1;
        }

        public function fromJson(arg1:String):core.sportprofiles.FavFunctionList
        {
            var loc3:*=null;
            var loc1:*=null;
            if (arg1) 
            {
                loc3 = JSON.parse(arg1);
            }
            if (loc3) 
            {
                if (loc3.hasOwnProperty("list")) 
                {
                    var loc5:*=0;
                    var loc4:*=loc3.list;
                    for (var loc2:* in loc4) 
                    {
                        loc1 = new core.sportprofiles.FavFunctionlistItem(loc3.list[loc2], parseInt(loc2));
                        changeFavFunction(loc1);
                    }
                }
                if (loc3.hasOwnProperty("tid")) 
                {
                    templateId = loc3.tid as uint;
                }
                if (loc3.hasOwnProperty("active")) 
                {
                    active = loc3.active as Boolean;
                }
            }
            return this;
        }

        public static const EVENT_FAVFUNCTIONLIST_CHANGED:String="EVENT_FAVFUNCTIONLIST_CHANGED";

        public static const EVENT_FAVFUNCTIONLIST_RESETTED:String="EVENT_FAVFUNCTIONLIST_RESETTED";

        public static const NAME_ACTIVE:String="active";

        public static const NAME_LIST:String="list";

        public static const NAME_TEMPLATEID:String="tid";

        public var active:Boolean;

        public var templateId:uint;

        internal var favFunctionList:__AS3__.vec.Vector.<core.sportprofiles.FavFunctionlistItem>;
    }
}


