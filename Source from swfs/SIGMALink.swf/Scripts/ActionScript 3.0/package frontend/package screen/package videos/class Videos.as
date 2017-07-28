//class Videos
package frontend.screen.videos 
{
    import com.adobe.serialization.json.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.events.*;
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
    import frontend.screen.component.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class Videos extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function Videos()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.dic_ImageUrl_Group = new flash.utils.Dictionary();
            this.dic_ImageUrl_VideoId = new flash.utils.Dictionary();
            this.dic_loader_callLabel = new flash.utils.Dictionary();
            this.dic_playButton_videoId = new flash.utils.Dictionary();
            this.dic_shareButton_VideoId = new flash.utils.Dictionary();
            this.dic_videoId_Title = new flash.utils.Dictionary();
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._Videos_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_videos_VideosWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return Videos[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._Videos_ScrollContainer1_i(), this._Videos_Footer1_i()];
            this.addEventListener("addedToStage", this.___Videos_CustomScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___Videos_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        protected function addetToStage(arg1:starling.events.Event):void
        {
            this.loadPlaylist();
            return;
        }

        protected function removedFromStage(arg1:starling.events.Event):void
        {
            this.scroller.removeChildren();
            this.nextYPos = 0;
            return;
        }

        internal function _Videos_ScrollContainer1_i():feathers.controls.ScrollContainer
        {
            var loc1:*=new feathers.controls.ScrollContainer();
            loc1.layout = this._Videos_AnchorLayout1_c();
            loc1.id = "scroller";
            this.scroller = loc1;
            feathers.binding.BindingManager.executeBindings(this, "scroller", this.scroller);
            return loc1;
        }

        internal function _Videos_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _Videos_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        public function ___Videos_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.addetToStage(arg1);
            return;
        }

        public function ___Videos_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.removedFromStage(arg1);
            return;
        }

        internal function _Videos_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("VIDEOS.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[1] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "scroller.height")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "scroller.width")
            return result;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get scroller():feathers.controls.ScrollContainer
        {
            return this._402164678scroller;
        }

        public function set scroller(arg1:feathers.controls.ScrollContainer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._402164678scroller;
            if (loc1 !== arg1) 
            {
                this._402164678scroller = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "scroller", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            Videos._watcherSetupUtil = arg1;
            return;
        }

        internal function loadPlaylist():void
        {
            var loc1:*=utils.LanguageManager.getString("YOUTUBE_PLAYLIST_ID");
            var loc2:*=new flash.net.URLRequest("https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=" + loc1 + "&key=" + API_KEY);
            loc2.method = flash.net.URLRequestMethod.GET;
            var loc3:*=new flash.net.URLLoader();
            loc3.addEventListener(starling.events.Event.COMPLETE, this.onLoadPlaylistComplete);
            loc3.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoadPlaylistError);
            loc3.load(loc2);
            return;
        }

        internal function onLoadPlaylistError(arg1:flash.events.IOErrorEvent=null):void
        {
            this.isOnline = false;
            return;
        }

        internal function onLoadPlaylistComplete(arg1:flash.events.Event=null):void
        {
            var loc2:*=0;
            this.isOnline = true;
            this.eventInfo = com.adobe.serialization.json.JSON.decode(arg1.target.data);
            var loc1:*=this.eventInfo.items as Array;
            var loc3:*=loc1.length;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                this.generateYoutubeItem(loc1[loc2].snippet.title, loc1[loc2].snippet.resourceId, loc1[loc2].snippet.thumbnails.maxres, loc2);
                ++loc2;
            }
            return;
        }

        internal function generateYoutubeItem(arg1:String, arg2:Object, arg3:Object, arg4:uint):void
        {
            var loc1:*=new frontend.screen.videos.YoutubeItem();
            loc1.layoutData = new feathers.layout.AnchorLayoutData(this.nextYPos);
            loc1.apiKey = API_KEY;
            loc1.title = arg1;
            loc1.resourceId = arg2;
            loc1.thumbnail = arg3;
            loc1.width = this.scroller.width;
            this.scroller.addChild(loc1);
            loc1.validate();
            this.nextYPos = this.nextYPos + loc1.height;
            return;
        }

        internal static const API_KEY:String="AIzaSyD8XxBdKKE0KRmrNqAAplGGcegLSgvT9R8";

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _402164678scroller:feathers.controls.ScrollContainer;

        internal var currentState:String;

        internal var dic_ImageUrl_Group:flash.utils.Dictionary;

        internal var dic_ImageUrl_VideoId:flash.utils.Dictionary;

        internal var dic_loader_callLabel:flash.utils.Dictionary;

        internal var dic_playButton_videoId:flash.utils.Dictionary;

        internal var dic_shareButton_VideoId:flash.utils.Dictionary;

        internal var dic_videoId_Title:flash.utils.Dictionary;

        internal var eventInfo:Object;

        internal var imageRatio:Number=1;

        internal var isOnline:Boolean=false;

        internal var nextYPos:Number=0;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


