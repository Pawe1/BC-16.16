//class DeviceSportprofileChangeCategoryView
package frontend.screen.mydevices.sportprofiles 
{
    import __AS3__.vec.*;
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
    
    public class DeviceSportprofileChangeCategoryView extends frontend.screen.mydevices.sportprofiles.DeviceSportprofileChangeFuncBaseView
    {
        public function DeviceSportprofileChangeCategoryView()
        {
            super();
            return;
        }

        internal function onCategorySelected(arg1:frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET_CHANGE_FUNCTION, {"sportprofile":sportprofile, "favsetNr":favsetNr, "favsetBox":favsetBox, "category":arg1.category.categoryId}, handler.ViewHandler.slideToLeftTransition(), true);
            return;
        }

        protected override function createItemRendererFactory():feathers.controls.renderers.IListItemRenderer
        {
            var loc1:*=new frontend.screen.mydevices.sportprofiles.list.SportprofilesFavsetItemCategoryItemRenderer();
            return loc1;
        }

        protected override function createDataProvider():feathers.data.ListCollection
        {
            var loc2:*=0;
            var loc5:*=null;
            var loc1:*=core.sportprofiles.SportprofileFavFunctions.getInstance().getCategories();
            var loc3:*=loc1.length;
            var loc4:*=new feathers.data.ListCollection();
            loc2 = 0;
            while (loc2 < loc3) 
            {
                loc5 = new frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem();
                loc5.category = loc1[loc2];
                loc4.push(loc5);
                ++loc2;
            }
            return loc4;
        }

        protected override function goBack():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_SPORT_PROFILE_FAVSET, {"sportprofile":sportprofile, "favsetNr":favsetNr}, handler.ViewHandler.slideToRightTransition(), true);
            return;
        }

        protected override function onListTouchedOk(arg1:starling.events.TouchEvent):void
        {
            if (_customList.selectedItem != null) 
            {
                this.onCategorySelected(_customList.selectedItem as frontend.screen.mydevices.sportprofiles.list.SportprofileCategoryListItem);
            }
            return;
        }
    }
}


