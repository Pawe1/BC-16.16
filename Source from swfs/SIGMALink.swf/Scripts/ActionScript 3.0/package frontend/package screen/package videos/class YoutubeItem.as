//class YoutubeItem
package frontend.screen.videos 
{
    import com.adobe.serialization.json.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.accessibility.*;
    import flash.data.*;
    import flash.debugger.*;
    import flash.desktop.*;
    import flash.display.*;
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
    import frontend.*;
    import frontend.components.*;
    import frontend.components.core.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class YoutubeItem extends frontend.components.core.Group implements feathers.binding.IBindingClient
    {
        public function YoutubeItem()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._YoutubeItem_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_videos_YoutubeItemWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return YoutubeItem[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._YoutubeItem_VGroup1_i()];
            this.addEventListener("initialize", this.___YoutubeItem_Group1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _YoutubeItem_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._YoutubeItem_HorizontalLayout1_c();
            loc1.mxmlContent = [this._YoutubeItem_Label2_i(), this._YoutubeItem_LangLabel1_c()];
            loc1.id = "_YoutubeItem_LayoutGroup2";
            this._YoutubeItem_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_LayoutGroup2", this._YoutubeItem_LayoutGroup2);
            return loc1;
        }

        internal function _YoutubeItem_HorizontalLayout1_c():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.gap = 3;
            return loc1;
        }

        internal function _YoutubeItem_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_YoutubeItem_Label2";
            this._YoutubeItem_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_Label2", this._YoutubeItem_Label2);
            return loc1;
        }

        internal function _YoutubeItem_LangLabel1_c():frontend.components.LangLabel
        {
            var loc1:*=new frontend.components.LangLabel();
            loc1.text = "YOUTUBE_PLAYLIST_CALLS";
            return loc1;
        }

        public function ___YoutubeItem_Group1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _YoutubeItem_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "_YoutubeItem_TextureImage1";
            this._YoutubeItem_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_TextureImage1", this._YoutubeItem_TextureImage1);
            return loc1;
        }

        internal function _YoutubeItem_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[1] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return bgImage;
            }, null, "_YoutubeItem_VGroup1.backgroundSkin")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_YoutubeItem_VGroup1.width")
            result[3] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.playbuttonbig;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_YoutubeItem_TextureImage1.textureName")
            result[4] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return transparentBgSkin;
            }, null, "_YoutubeItem_LayoutGroup1.backgroundSkin")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_YoutubeItem_LayoutGroup1.width")
            result[6] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.LEFT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_YoutubeItem_VerticalLayout1.horizontalAlign")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_YoutubeItem_VerticalLayout1.verticalAlign")
            result[8] = new feathers.binding.Binding(this, null, null, "_YoutubeItem_Label1.text", "title");
            result[9] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showStats;
            }, null, "_YoutubeItem_LayoutGroup2.includeInLayout")
            result[10] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showStats;
            }, null, "_YoutubeItem_LayoutGroup2.visible")
            result[11] = new feathers.binding.Binding(this, null, null, "_YoutubeItem_Label2.text", "views");
            return result;
        }

        public function get title():String
        {
            return this._110371416title;
        }

        public function set title(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._110371416title;
            if (loc1 !== arg1) 
            {
                this._110371416title = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "title", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get views():Number
        {
            return this._112204398views;
        }

        public function set views(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._112204398views;
            if (loc1 !== arg1) 
            {
                this._112204398views = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "views", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get bgImage():starling.display.Image
        {
            return this._199389162bgImage;
        }

        internal function set bgImage(arg1:starling.display.Image):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._199389162bgImage;
            if (loc1 !== arg1) 
            {
                this._199389162bgImage = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "bgImage", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function set showStats(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1914417246showStats;
            if (loc1 !== arg1) 
            {
                this._1914417246showStats = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showStats", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get transparentBgSkin():starling.display.Quad
        {
            return this._1607745364transparentBgSkin;
        }

        internal function set transparentBgSkin(arg1:starling.display.Quad):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1607745364transparentBgSkin;
            if (loc1 !== arg1) 
            {
                this._1607745364transparentBgSkin = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "transparentBgSkin", loc1, arg1, this);
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
            YoutubeItem._watcherSetupUtil = arg1;
            return;
        }

        internal function showVideo(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            debug.Debug.debug("open video: " + this.videoURL);
            flash.net.navigateToURL(new flash.net.URLRequest(this.videoURL));
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            if (!this.apiKey || this.apiKey == "") 
            {
                debug.Debug.debug("No apiKey defined!");
                return;
            }
            this.transparentBgSkin = new starling.display.Quad(1, 1, 16777215);
            this.transparentBgSkin.alpha = 0.8;
            this.videoURL = VIDEO_BASE_URL + this.resourceId.videoId;
            this.loadBackground();
            this.loadStats();
            return;
        }

        internal function loadStats():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.resourceId) 
            {
                loc1 = new flash.net.URLLoader();
                loc2 = new flash.net.URLRequest("https://www.googleapis.com/youtube/v3/videos?part=statistics&id=" + this.resourceId.videoId + "&key=" + this.apiKey);
                loc1.addEventListener(starling.events.Event.COMPLETE, this.onLoadVideoStatisticComplete);
                loc1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onError);
                loc1.load(loc2);
            }
            return;
        }

        internal function onError(arg1:flash.events.IOErrorEvent=null):void
        {
            debug.Debug.debug("onError");
            return;
        }

        internal function onLoadVideoStatisticComplete(arg1:flash.events.Event=null):void
        {
            var p_event:flash.events.Event=null;
            var eventInfo:Object;

            var loc1:*;
            eventInfo = null;
            p_event = arg1;
            (p_event.currentTarget as flash.net.URLLoader).removeEventListener(starling.events.Event.COMPLETE, this.onLoadVideoStatisticComplete);
            try 
            {
                eventInfo = com.adobe.serialization.json.JSON.decode(p_event.target.data);
                this.showStats = true;
                this.views = eventInfo.items[0].statistics.viewCount;
            }
            catch (e:Error)
            {
                debug.Debug.debug("Error occured while parsing part \'statistic\': " + e.message);
                showStats = false;
            }
            return;
        }

        internal function loadBackground():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.thumbnail) 
            {
                this.imageRatio = SIGMALink.appWidth / this.thumbnail.width;
                this.height = this.thumbnail.height * this.imageRatio;
                loc1 = new flash.display.Loader();
                loc2 = new flash.net.URLRequest(this.thumbnail.url);
                loc1.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onBackgroundImageLoaded);
                loc1.load(loc2);
            }
            return;
        }

        internal function onBackgroundImageLoaded(arg1:flash.events.Event=null):void
        {
            var p_event:flash.events.Event=null;
            var loadedBitmap:flash.display.Bitmap;
            var texture:starling.textures.Texture;

            var loc1:*;
            loadedBitmap = null;
            texture = null;
            p_event = arg1;
            if (!p_event) 
            {
                return;
            }
            (p_event.currentTarget as flash.display.LoaderInfo).removeEventListener(flash.events.Event.COMPLETE, this.onBackgroundImageLoaded);
            try 
            {
                loadedBitmap = p_event.currentTarget.loader.content as flash.display.Bitmap;
                texture = starling.textures.Texture.fromBitmap(loadedBitmap);
                this.bgImage = new starling.display.Image(texture);
            }
            catch (e:Error)
            {
                debug.Debug.debug("Error loading background image: " + e.message);
                showStats = false;
            }
            return;
        }

        internal function _YoutubeItem_VGroup1_i():frontend.components.core.VGroup
        {
            var loc1:*=new frontend.components.core.VGroup();
            loc1.gap = 2;
            loc1.percentHeight = 100;
            loc1.horizontalAlign = "center";
            loc1.verticalAlign = "bottom";
            loc1.mxmlContent = [this._YoutubeItem_VGroup2_c(), this._YoutubeItem_LayoutGroup1_i()];
            loc1.id = "_YoutubeItem_VGroup1";
            this._YoutubeItem_VGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_VGroup1", this._YoutubeItem_VGroup1);
            return loc1;
        }

        internal function _YoutubeItem_VGroup2_c():frontend.components.core.VGroup
        {
            var loc1:*=new frontend.components.core.VGroup();
            loc1.percentHeight = 100;
            loc1.horizontalAlign = "center";
            loc1.touchGroup = true;
            loc1.verticalAlign = "middle";
            loc1.percentWidth = 100;
            loc1.mxmlContent = [this._YoutubeItem_TextureImage1_i()];
            loc1.addEventListener("touch", this.___YoutubeItem_VGroup2_touch);
            return loc1;
        }

        internal function get showStats():Boolean
        {
            return this._1914417246showStats;
        }

        public function ___YoutubeItem_VGroup2_touch(arg1:starling.events.TouchEvent):void
        {
            this.showVideo(arg1);
            return;
        }

        internal function _YoutubeItem_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._YoutubeItem_VerticalLayout1_i();
            loc1.mxmlContent = [this._YoutubeItem_Label1_i(), this._YoutubeItem_LayoutGroup2_i()];
            loc1.id = "_YoutubeItem_LayoutGroup1";
            this._YoutubeItem_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_LayoutGroup1", this._YoutubeItem_LayoutGroup1);
            return loc1;
        }

        internal function _YoutubeItem_VerticalLayout1_i():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 3;
            loc1.padding = 10;
            this._YoutubeItem_VerticalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_VerticalLayout1", this._YoutubeItem_VerticalLayout1);
            return loc1;
        }

        internal function _YoutubeItem_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_YoutubeItem_Label1";
            this._YoutubeItem_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_YoutubeItem_Label1", this._YoutubeItem_Label1);
            return loc1;
        }

        internal static const VIDEO_BASE_URL:String="https://www.youtube.com/watch?v=";

        public var _YoutubeItem_Label1:feathers.controls.Label;

        public var _YoutubeItem_Label2:feathers.controls.Label;

        public var _YoutubeItem_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _YoutubeItem_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _YoutubeItem_TextureImage1:frontend.components.TextureImage;

        public var _YoutubeItem_VerticalLayout1:feathers.layout.VerticalLayout;

        public var apiKey:String="";

        public var resourceId:Object;

        public var thumbnail:Object;

        internal var _110371416title:String="";

        internal var _112204398views:Number=0;

        internal var _199389162bgImage:starling.display.Image;

        internal var imageRatio:Number=1;

        internal var _1914417246showStats:Boolean=false;

        internal var _1607745364transparentBgSkin:starling.display.Quad;

        internal var videoURL:String="";

        public var _YoutubeItem_VGroup1:frontend.components.core.VGroup;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


