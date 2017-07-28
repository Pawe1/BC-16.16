//class ActivityShare
package frontend.screen.activities.share 
{
    import backend.oauth.*;
    import backend.sharing.*;
    import backend.utils.dbUtils.*;
    import core.activities.*;
    import core.general.*;
    import core.sport.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
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
    import frontend.*;
    import frontend.components.button.*;
    import frontend.components.menuList.*;
    import frontend.screen.activities.list.*;
    import frontend.screen.component.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    
    use namespace mx_internal;
    
    public class ActivityShare extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function ActivityShare()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._iconButtonCallout = new frontend.components.button.IconButtonCallout();
            this._3685147yPos = HEADER_HEIGHT;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityShare_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_share_ActivityShareWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivityShare[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = true;
            this.hasBackwardNavigation = true;
            this.mxmlContent = [this._ActivityShare_LayoutGroup1_i(), this._ActivityShare_LayoutGroup2_i(), this._ActivityShare_LayoutGroup3_i(), this._ActivityShare_Footer1_c()];
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _ActivityShare_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_ActivityShare_Label2";
            this._ActivityShare_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityShare_Label2", this._ActivityShare_Label2);
            return loc1;
        }

        internal function _ActivityShare_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "loader";
            this.loader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "loader", this.loader);
            return loc1;
        }

        internal function _ActivityShare_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.visible = false;
            loc1.layout = this._ActivityShare_AnchorLayout2_c();
            loc1.mxmlContent = [this._ActivityShare_Button1_i()];
            loc1.id = "shareButtonGroup";
            this.shareButtonGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "shareButtonGroup", this.shareButtonGroup);
            return loc1;
        }

        internal function _ActivityShare_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityShare_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.styleName = "WHITEBUTTON";
            loc1.addEventListener("touch", this.___ActivityShare_Button1_touch);
            loc1.id = "_ActivityShare_Button1";
            this._ActivityShare_Button1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityShare_Button1", this._ActivityShare_Button1);
            return loc1;
        }

        public function ___ActivityShare_Button1_touch(arg1:starling.events.TouchEvent):void
        {
            this.shareHandler(arg1);
            return;
        }

        internal function _ActivityShare_Footer1_c():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.mxmlContent = [this._ActivityShare_IconButton1_i()];
            return loc1;
        }

        internal function _ActivityShare_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.id = "settingIcon";
            this.settingIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "settingIcon", this.settingIcon);
            return loc1;
        }

        internal function doSharing(arg1:String=null):void
        {
            handler.SharingHandler.getInstance().addEventListener(backend.sharing.SharingEvent.MULTI_SHARING_FINISHED, this.onSharingFinished);
            handler.SharingHandler.getInstance().addEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onSharingComplete);
            handler.SharingHandler.getInstance().addEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onSharingError);
            handler.SharingHandler.getInstance().doSharing(arg1);
            return;
        }

        public function set comesFromSharingOptions(arg1:Boolean):void
        {
            this._comesFromSharingOptions = arg1;
            if (this._comesFromSharingOptions) 
            {
                handler.ViewHandler.getInstance().addBackFunction(this.backButtonFunction);
                addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            }
            return;
        }

        internal function _ActivityShare_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("ACTIVITYSHARE.TITLE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[2] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "header.backgroundSkin")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return HEADER_HEIGHT;
            }, null, "header.height")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(0);
            }, null, "header.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "header.width")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, frontend.screen.activities.share.ShareButton.PADDING, frontend.screen.activities.share.ShareButton.PADDING);
            }, null, "_ActivityShare_Label1.layoutData")
            result[7] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.PLEASE_SELECT");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityShare_Label1.text")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, frontend.screen.activities.share.ShareButton.PADDING, frontend.screen.activities.share.ShareButton.PADDING);
            }, null, "_ActivityShare_Label2.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.SHARED");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityShare_Label2.text")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "loader.layoutData")
            result[11] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            }, null, "shareButtonGroup.backgroundSkin")
            result[12] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "shareButtonGroup.height")
            result[13] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(yPos);
            }, null, "shareButtonGroup.layoutData")
            result[14] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "shareButtonGroup.width")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("APPSETTINGS.KONTEN.SHARE_BUTTON");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityShare_Button1.label")
            result[16] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            }, null, "_ActivityShare_Button1.layoutData")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityShare_Button1.width")
            result[18] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.settingsiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "settingIcon.image")
            result[19] = new feathers.binding.Binding(this, function ():Function
            {
                return openAccountSettings;
            }, null, "settingIcon.touchHandler")
            return result;
        }

        public function get header():feathers.controls.LayoutGroup
        {
            return this._1221270899header;
        }

        public function set header(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1221270899header;
            if (loc1 !== arg1) 
            {
                this._1221270899header = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "header", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get loader():feathers.controls.LayoutGroup
        {
            return this._1097519085loader;
        }

        public function set loader(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1097519085loader;
            if (loc1 !== arg1) 
            {
                this._1097519085loader = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "loader", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set settingIcon(arg1:frontend.components.button.IconButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._122546455settingIcon;
            if (loc1 !== arg1) 
            {
                this._122546455settingIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "settingIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get shareButtonGroup():feathers.controls.LayoutGroup
        {
            return this._1554344690shareButtonGroup;
        }

        public function set shareButtonGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1554344690shareButtonGroup;
            if (loc1 !== arg1) 
            {
                this._1554344690shareButtonGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "shareButtonGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get yPos():Number
        {
            return this._3685147yPos;
        }

        internal function set yPos(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3685147yPos;
            if (loc1 !== arg1) 
            {
                this._3685147yPos = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "yPos", loc1, arg1, this);
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
            ActivityShare._watcherSetupUtil = arg1;
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            handler.ViewHandler.getInstance().removeBackFunction(this.backButtonFunction);
            return;
        }

        internal function backButtonFunction():void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_ACTIVITIES_LIST, null, handler.ViewHandler.slideToRightTransition());
            return;
        }

        protected override function validateProperties():void
        {
            this.addLoader();
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityStatement(this.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityComplete, this.loadActivityError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function addLoader():void
        {
            this.loader.removeChildren();
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTextureAtlas("loaderAnimation");
            if (loc1) 
            {
                this.movieClip = new starling.display.MovieClip(loc1.getTextures("frame_"), 30);
                this.loader.addChild(this.movieClip);
                this.movieClip.play();
                if (!starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.add(this.movieClip);
                }
            }
            return;
        }

        internal function loadActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activitiesError");
            return;
        }

        internal function loadActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            var loc2:*=null;
            var loc1:*=arg1.getResult();
            if (loc1.length == 0) 
            {
                return;
            }
            this._activity = core.activities.ActivityFactory.createLogFromDB(loc1[0], false);
            if (this._activity.dataType == core.general.DataType.LOG && this._activity.entries.length == 0) 
            {
                loc2 = handler.ActivityHandler.getInstance().generateLoadActivityEntries(this._activity.activityId);
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc2, this.loadActivityEntriesComplete, this.loadActivityEntriesError, Workers.worker_DatabaseWorker);
            }
            else 
            {
                this.validateContent();
            }
            return;
        }

        internal function loadActivityEntriesError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityEntriesError");
            return;
        }

        internal function loadActivityEntriesComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityEntriesComplete(arg1.getResult(), this._activity);
            var loc1:*=handler.ActivityHandler.getInstance().generateLoadActivityMarker(this._activity.activityId);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.READ, loc1, this.loadActivityMarkerComplete, this.loadActivityMarkerError, Workers.worker_DatabaseWorker);
            this.validateContent();
            return;
        }

        internal function loadActivityMarkerError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("activityMarkerError");
            return;
        }

        internal function loadActivityMarkerComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().loadActivityMarkerComplete(arg1.getResult(), this._activity);
            return;
        }

        internal function validateContent():void
        {
            var loc4:*=null;
            this.yPos = HEADER_HEIGHT;
            var loc1:*=1 * SIGMALink.scaleFactor;
            var loc2:*=0;
            var loc3:*=0;
            this.clearAccountButtons();
            if (contains(this._iconButtonCallout)) 
            {
                removeChild(this._iconButtonCallout);
            }
            if (!backend.oauth.StravaOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                if (this.isValidLogActivity()) 
                {
                    ++loc3;
                    this.st = new frontend.screen.activities.share.ShareButton();
                    this.st.textureName = frontend.Textures.shareStrava;
                    this.st.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.STRAVA.TITLE");
                    this.st.shared = this._activity.sharedToStrava;
                    this.st.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                    addChild(this.st);
                    this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
                }
            }
            if (!backend.oauth.TrainingPeaksOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                if (this.isValidLogActivity()) 
                {
                    ++loc3;
                    this.tp = new frontend.screen.activities.share.ShareButton();
                    this.tp.textureName = frontend.Textures.shareTrainingPeaks;
                    this.tp.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TRAININGPEAKS.TITLE");
                    this.tp.shared = this._activity.sharedToTrainingPeaks;
                    this.tp.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                    addChild(this.tp);
                    this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
                }
            }
            if (!backend.oauth.TwoPeakOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                if (this.isValidLogActivity()) 
                {
                    ++loc3;
                    this._2p = new frontend.screen.activities.share.ShareButton();
                    this._2p.textureName = frontend.Textures.shareTwoPeak;
                    this._2p.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWOPEAK.TITLE");
                    this._2p.shared = this._activity.sharedTo2Peak;
                    this._2p.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                    addChild(this._2p);
                    this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
                }
            }
            if (!backend.oauth.FacebookGoViralHandler.getInstance().loggedOut) 
            {
                ++loc2;
                ++loc3;
                this.fb = new frontend.screen.activities.share.ShareButton();
                this.fb.textureName = frontend.Textures.shareFacebook;
                this.fb.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.FACEBOOK.TITLE");
                this.fb.shared = this._activity.sharedToFacebook;
                this.fb.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                addChild(this.fb);
                this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
            }
            if (!backend.oauth.TwitterOAuth.getInstance().loggedOut) 
            {
                ++loc2;
                ++loc3;
                this.tw = new frontend.screen.activities.share.ShareButton();
                this.tw.textureName = frontend.Textures.shareTwitter;
                this.tw.title = utils.LanguageManager.getString("APPSETTINGS.KONTEN.TWITTER.TITLE");
                this.tw.shared = this._activity.sharedToTwitter;
                this.tw.layoutData = new feathers.layout.AnchorLayoutData(this.yPos);
                addChild(this.tw);
                this.yPos = this.yPos + (frontend.screen.activities.share.ShareButton.ROW_HEIGHT + loc1);
            }
            if (loc2 == 0 || loc3 == 0) 
            {
                this.shareButtonGroup.visible = false;
                this.header.visible = false;
                loc4 = "";
                if (loc2 == 0) 
                {
                    loc4 = utils.LanguageManager.getString("APPSETTINGS.KONTEN.NO_ACCOUNTS");
                }
                if (loc2 > 0 && loc3 == 0) 
                {
                    loc4 = utils.LanguageManager.getString("APPSETTINGS.KONTEN.NO_VALID_ACCOUNTS");
                }
                loc4 = loc4 + (" " + utils.LanguageManager.getString("NO_DATA_SHARING_ACCOUNTS"));
                this._iconButtonCallout.calloutText = loc4;
                this._iconButtonCallout.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, SIGMALink.footerHeight, NaN);
                this._iconButtonCallout.anchor = this.settingIcon;
                addChild(this._iconButtonCallout);
            }
            else 
            {
                this.shareButtonGroup.visible = true;
                this.header.visible = true;
            }
            return;
        }

        internal function clearAccountButtons():void
        {
            if (this.movieClip) 
            {
                this.movieClip.stop();
                if (starling.core.Starling.juggler.contains(this.movieClip)) 
                {
                    starling.core.Starling.juggler.remove(this.movieClip);
                }
                this.movieClip = null;
            }
            this.loader.removeChildren();
            if (this.st) 
            {
                removeChild(this.st);
                this.st = null;
            }
            if (this.tp) 
            {
                removeChild(this.tp);
                this.tp = null;
            }
            if (this._2p) 
            {
                removeChild(this._2p);
                this._2p = null;
            }
            if (this.fb) 
            {
                removeChild(this.fb);
                this.fb = null;
            }
            if (this.tw) 
            {
                removeChild(this.tw);
                this.tw = null;
            }
            return;
        }

        internal function isValidLogActivity():Boolean
        {
            return this._activity.entries.length > 0 && !(this._activity.sport.keyName == core.sport.Sport.ACTIVITY_TRACKER);
        }

        internal function shareHandler(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.SharingHandler.getInstance().prepareUpload();
            this._useOwnMessage = false;
            if (this.st && this.st.selected) 
            {
                this.st.startLoading();
                handler.SharingHandler.getInstance().addStravaActivity(this._activity);
            }
            if (this.tp && this.tp.selected) 
            {
                this.tp.startLoading();
                handler.SharingHandler.getInstance().addTrainingPeaksActivity(this._activity);
            }
            if (this._2p && this._2p.selected) 
            {
                this._2p.startLoading();
                handler.SharingHandler.getInstance().addTwoPeakActivity(this._activity);
            }
            if (this.fb && this.fb.selected) 
            {
                this.fb.startLoading();
                handler.SharingHandler.getInstance().addFacebookActivity(this._activity);
                this._useOwnMessage = true;
            }
            if (this.tw && this.tw.selected) 
            {
                this.tw.startLoading();
                handler.SharingHandler.getInstance().addTwitterActivity(this._activity);
            }
            if (this._useOwnMessage) 
            {
                this.openOwnMessagePopUp();
            }
            else 
            {
                this.doSharing();
            }
            return;
        }

        internal function openOwnMessagePopUp():void
        {
            this.doSharing(handler.SharingHandler.getInstance().getSharingStandardText());
            return;
        }

        public function get settingIcon():frontend.components.button.IconButton
        {
            return this._122546455settingIcon;
        }

        internal function onSharingComplete(arg1:backend.sharing.SharingEvent):void
        {
            this._activity = arg1.activity;
            var loc1:*=arg1.currentTarget as handler.SharingHandler;
            if (this.st && loc1.currentActivitySharing.oauthInstance == backend.oauth.StravaOAuth.getInstance()) 
            {
                this.st.stopLoading();
                this.st.selected = false;
                this.st.shared = this._activity.sharedToStrava;
            }
            if (this.tp && loc1.currentActivitySharing.oauthInstance == backend.oauth.TrainingPeaksOAuth.getInstance()) 
            {
                this.tp.stopLoading();
                this.tp.selected = false;
                this.tp.shared = this._activity.sharedToTrainingPeaks;
            }
            if (this._2p && loc1.currentActivitySharing.oauthInstance == backend.oauth.TwoPeakOAuth.getInstance()) 
            {
                this._2p.stopLoading();
                this._2p.selected = false;
                this._2p.shared = this._activity.sharedTo2Peak;
            }
            if (this.fb && loc1.currentActivitySharing.oauthInstance == backend.oauth.FacebookGoViralHandler.getInstance()) 
            {
                this.fb.stopLoading();
                this.fb.selected = false;
                this.fb.shared = this._activity.sharedToFacebook;
            }
            if (this.tw && loc1.currentActivitySharing.oauthInstance == backend.oauth.TwitterOAuth.getInstance()) 
            {
                this.tw.stopLoading();
                this.tw.selected = false;
                this.tw.shared = this._activity.sharedToTwitter;
            }
            return;
        }

        internal function onSharingError(arg1:backend.sharing.SharingEvent):void
        {
            var loc1:*=arg1.eventTarget.currentTarget as backend.sharing.ActivitySharing;
            var loc2:*=loc1.oauthInstance.getErrorMessage(loc1.errorStatus);
            if (this.st && loc1.oauthInstance == backend.oauth.StravaOAuth.getInstance()) 
            {
                this.st.shared = arg1.activity.sharedToStrava;
                this.st.showError(loc2);
            }
            if (this.tp && loc1.oauthInstance == backend.oauth.TrainingPeaksOAuth.getInstance()) 
            {
                this.tp.shared = arg1.activity.sharedToTrainingPeaks;
                this.tp.showError(loc2);
            }
            if (this._2p && loc1.oauthInstance == backend.oauth.TwoPeakOAuth.getInstance()) 
            {
                this._2p.shared = arg1.activity.sharedTo2Peak;
                this._2p.showError(loc2);
            }
            if (this.fb && loc1.oauthInstance == backend.oauth.FacebookGoViralHandler.getInstance()) 
            {
                this.fb.shared = arg1.activity.sharedToFacebook;
                this.fb.showError(loc2);
            }
            if (this.tw && loc1.oauthInstance == backend.oauth.TwitterOAuth.getInstance()) 
            {
                this.tw.shared = arg1.activity.sharedToTwitter;
                this.tw.showError(loc2);
            }
            return;
        }

        internal function onSharingFinished(arg1:backend.sharing.SharingEvent):void
        {
            handler.SharingHandler.getInstance().removeEventListener(backend.sharing.SharingEvent.MULTI_SHARING_FINISHED, this.onSharingFinished);
            handler.SharingHandler.getInstance().removeEventListener(backend.sharing.SharingEvent.SHARING_COMPLETE, this.onSharingComplete);
            handler.SharingHandler.getInstance().removeEventListener(backend.sharing.SharingEvent.SHARING_ERROR, this.onSharingError);
            var loc1:*=handler.ActivityHandler.getInstance().generateUpdateSharingInformation(this._activity);
            backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, loc1, this.onUpdateActivityComplete, this.onUpdateActivityError, Workers.worker_DatabaseWorker);
            return;
        }

        internal function onUpdateActivityComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.ActivityHandler.getInstance().dispatchEvent(new frontend.screen.activities.list.ActivityListEvent(frontend.screen.activities.list.ActivityListEvent.UPDATE, this._activity));
            return;
        }

        internal function onUpdateActivityError(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            debug.Debug.error("onUpdateActivityError");
            return;
        }

        internal function openAccountSettings(arg1:starling.events.TouchEvent):void
        {
            handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_APPSETTINGS_KONTEN, {"gotoActivityId":this.activityId}, handler.ViewHandler.slideToLeftTransition());
            return;
        }

        internal function _ActivityShare_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.visible = false;
            loc1.layout = this._ActivityShare_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityShare_Label1_i(), this._ActivityShare_Label2_i()];
            loc1.id = "header";
            this.header = loc1;
            feathers.binding.BindingManager.executeBindings(this, "header", this.header);
            return loc1;
        }

        internal function _ActivityShare_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityShare_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_ActivityShare_Label1";
            this._ActivityShare_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityShare_Label1", this._ActivityShare_Label1);
            return loc1;
        }

        internal static const HEADER_HEIGHT:Number=80 * SIGMALink.scaleFactor;

        internal static const PADDING:Number=20 * SIGMALink.scaleFactor;

        public var _ActivityShare_Button1:feathers.controls.Button;

        public var _ActivityShare_Label1:feathers.controls.Label;

        public var _ActivityShare_Label2:feathers.controls.Label;

        internal var _1221270899header:feathers.controls.LayoutGroup;

        internal var _1097519085loader:feathers.controls.LayoutGroup;

        internal var _122546455settingIcon:frontend.components.button.IconButton;

        internal var _1554344690shareButtonGroup:feathers.controls.LayoutGroup;

        public var activityId:int;

        internal var _2p:frontend.screen.activities.share.ShareButton;

        internal var _activity:core.activities.Activity;

        internal var _iconButtonCallout:frontend.components.button.IconButtonCallout;

        internal var _useOwnMessage:Boolean=false;

        internal var fb:frontend.screen.activities.share.ShareButton;

        internal var initialValidated:Boolean=false;

        internal var movieClip:starling.display.MovieClip;

        internal var st:frontend.screen.activities.share.ShareButton;

        internal var tp:frontend.screen.activities.share.ShareButton;

        internal var tw:frontend.screen.activities.share.ShareButton;

        internal var _3685147yPos:Number;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal var _comesFromSharingOptions:Boolean=false;

        mx_internal var _bindings:Array;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


