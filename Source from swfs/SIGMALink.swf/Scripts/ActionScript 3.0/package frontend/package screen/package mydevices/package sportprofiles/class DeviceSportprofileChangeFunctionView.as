//class DeviceSportprofileChangeFunctionView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
    import backend.utils.dbUtils.*;
    import core.settings.interfaces.*;
    import core.sportprofiles.*;
    import feathers.binding.*;
    import feathers.controls.renderers.*;
    import feathers.data.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filesystem.*;
    import flash.geom.*;
    import flash.html.*;
    import flash.html.script.*;
    import flash.media.*;
    import flash.net.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.system.*;
    import flash.text.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;
    import frontend.screen.mydevices.sportprofiles.list.*;
    import handler.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    public class DeviceSportprofileChangeFunctionView extends frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeFuncBaseView
    {
        public function DeviceSportprofileChangeFunctionView()
        {
            super();
            return;
        }

        internal function onFunctionSelected(arg1:frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem):void
        {
            var loc1:*=(sportprofile as core.settings.interfaces.IFavSets).getFavSetObject(favsetNr);
            loc1.changeFavFunction(new core.sportprofiles.FavFunctionlistItem(arg1.favFunction.functionId, favsetBox.position));
            sportprofile.changeFavFunctionList(favsetNr, loc1);
            sportprofile.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveSportprofile(new backend.utils.dbUtils.DBUtilObject(sportprofile, this.onInsertDataComplete, this.onInsertDataComplete, null));
            return;
        }

        protected function onInsertDataComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET, {"sportprofile":sportprofile, "favsetNr":favsetNr}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        protected override function createItemRendererFactory():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.list.SportprofilesFavsetItemFunctionItemRenderer();
            return loc1;
        }

        protected override function createDataProvider():feathers.data.ListCollection
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc5:*=null;
            if (category > 0) 
            {
                loc1 = core.sportprofiles.SportprofileFavFunctions.getInstance().getCategoryFunctions(category).filter(this.filterFunctions);
            }
            else 
            {
                loc1 = core.sportprofiles.SportprofileFavFunctions.getInstance().functions.filter(this.filterFunctions);
            }
            var loc3:*=loc1.length;
            var loc4:*=new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc5 = new frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem();
                loc5.favFunction = loc1[loc2];
                loc4.push(loc5);
                ++loc2;
            }
            return loc4;
        }

        protected override function goBack():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_CATEGORY, {"sportprofile":sportprofile, "favsetNr":favsetNr, "favsetBox":favsetBox}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        protected override function onListTouchedOk(arg1:starling.events.TouchEvent):void
        {
            this.onFunctionSelected(_customList.selectedItem as frontend.screen.mydevices.sportprofiles.list.SportprofileFunctionListItem);
            return;
        }

        internal function filterFunctions(arg1:core.sportprofiles.SportprofileFavFunctionObject, arg2:int, arg3:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>):Boolean
        {
            if (arg1.allowedBoxFormats.indexOf(core.sportprofiles.SportprofileFavFunctionObject.ALLOWED_BOX_FORMAT_ALL) == -1 && favsetBox.boxFormat > 0 && arg1.allowedBoxFormats.indexOf(favsetBox.boxFormat) == -1) 
            {
                return false;
            }
            if (arg1.allowedViews.indexOf(viewFilter) == -1) 
            {
                return false;
            }
            return true;
        }
    }
}


