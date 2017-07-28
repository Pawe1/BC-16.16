//class PopUpBase
package frontend.components.popup 
{
    import core.general.*;
    import debug.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import frontend.*;
    import frontend.components.button.*;
    import handler.*;
    import helper.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    import utils.*;
    
    public class PopUpBase extends feathers.controls.Panel
    {
        public function PopUpBase()
        {
            super();
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            return;
        }

        protected function set _layoutGap(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1431588301_layoutGap;
            if (loc1 !== arg1) 
            {
                this._1431588301_layoutGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_layoutGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function closePopUp():void
        {
            var loc1:*=undefined;
            var loc2:*=0;
            var loc3:*=currentPopUps;
            for (loc1 in loc3) 
            {
                removePopUps(loc1, loc1 is frontend.components.popup.PopUpBase);
            }
            checkPopUpMode();
            return;
        }

        public static function showModalPopUp(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Boolean=true, arg4:Boolean=true, arg5:Boolean=false):void
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            handler.ViewHandler.getInstance().popUpMode = true;
            currentPopUps[arg1] = frontend.components.popup.PopUpBase;
            closeOnTouchOutside = arg5;
            var loc1:*=CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP;
            if (arg1 is frontend.components.popup.PopUpBase) 
            {
                loc1 = (arg1 as frontend.components.popup.PopUpBase).closeTweenDirection;
            }
            feathers.core.PopUpManager.addPopUp(arg1, arg2, !arg3, createCustomOverlayFactory);
            if (arg3) 
            {
                loc2 = 0;
                loc3 = 0;
                var loc4:*=loc1;
                switch (loc4) 
                {
                    case CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:
                    {
                        arg1.y = SIGMALink.appHeight;
                        loc2 = SIGMALink.appHeight - arg1.height;
                        if (!arg4) 
                        {
                            loc2 = loc2 - SIGMALink.footerHeight;
                        }
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2});
                        break;
                    }
                    case CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:
                    {
                        arg1.y = 0;
                        arg1.x = SIGMALink.appWidth;
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2, "x":loc3});
                        break;
                    }
                    case CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:
                    {
                        arg1.y = 0;
                        arg1.x = SIGMALink.appWidth * -1;
                        starling.core.Starling.juggler.tween(arg1, TWEEN_DURATION, {"y":loc2, "x":loc3});
                        break;
                    }
                }
            }
            return;
        }

        internal static function removePopUp(arg1:starling.display.DisplayObject, arg2:Function=null):void
        {
            var p_popup:starling.display.DisplayObject;
            var p_callback:Function=null;

            var loc1:*;
            p_popup = arg1;
            p_callback = arg2;
            try 
            {
                feathers.core.PopUpManager.removePopUp(p_popup);
            }
            catch (e:Error)
            {
                debug.Debug.error("Versuch PopUp zu schließen fehlgeschlagen. PopUp existiert nicht mehr.");
            }
            finally
            {
                if (p_callback != null) 
                {
                    p_callback();
                }
            }
            return;
        }

        public function get popupIgnoresBackButton():Boolean
        {
            return this._popupIgnoresBackButton;
        }

        public function set popupIgnoresBackButton(arg1:Boolean):void
        {
            this._popupIgnoresBackButton = arg1;
            if (stage != null) 
            {
                if (this._popupIgnoresBackButton) 
                {
                    stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
                }
                else 
                {
                    stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
                }
            }
            return;
        }

        protected function customDraw():void
        {
            if (this._validate) 
            {
                if (header && !(header.height == HEADER_HEIGHT)) 
                {
                    header.height = HEADER_HEIGHT;
                    header.validate();
                }
                if (footer && !(footer.height == FOOTER_HEIGHT)) 
                {
                    footer.height = FOOTER_HEIGHT;
                    footer.validate();
                }
                backgroundSkin = new starling.display.Quad(1, 1, this._backgroundSkinColor);
                outerPadding = 0;
                padding = 0;
                this._validate = false;
            }
            return;
        }

        public static function removePopUps(arg1:starling.display.DisplayObject, arg2:Boolean=true, arg3:Function=null):void
        {
            var p_popup:starling.display.DisplayObject;
            var p_tween:Boolean=true;
            var p_callback:Function=null;
            var yTo:Number;
            var xTo:Number;
            var tweenDirection:String;

            var loc1:*;
            yTo = NaN;
            xTo = NaN;
            tweenDirection = null;
            p_popup = arg1;
            p_tween = arg2;
            p_callback = arg3;
            if (feathers.core.PopUpManager.isPopUp(p_popup)) 
            {
                if (p_tween) 
                {
                    yTo = 0;
                    xTo = 0;
                    tweenDirection = CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP;
                    if (p_popup is frontend.components.popup.PopUpBase) 
                    {
                        tweenDirection = (p_popup as frontend.components.popup.PopUpBase).closeTweenDirection;
                    }
                    var loc2:*=tweenDirection;
                    switch (loc2) 
                    {
                        case CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:
                        {
                            yTo = SIGMALink.appHeight;
                            xTo = p_popup.x;
                            break;
                        }
                        case CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:
                        {
                            xTo = SIGMALink.appWidth * -1;
                            break;
                        }
                        case CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:
                        {
                            xTo = SIGMALink.appWidth;
                            break;
                        }
                    }
                    starling.core.Starling.juggler.tween(p_popup, TWEEN_DURATION, {"y":yTo, "x":xTo, "onComplete":function ():void
                    {
                        removePopUp(p_popup, p_callback);
                        return;
                    }})
                }
                else 
                {
                    removePopUp(p_popup, p_callback);
                }
            }
            if (currentPopUps[p_popup] != null) 
            {
                delete currentPopUps[p_popup];
            }
            checkPopUpMode();
            return;
        }

        internal static function checkPopUpMode():void
        {
            var loc2:*=undefined;
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=currentPopUps;
            for (loc2 in loc4) 
            {
                ++loc1;
            }
            handler.ViewHandler.getInstance().popUpMode = loc1 > 0;
            return;
        }

        internal static function onTouchOutside(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (closeOnTouchOutside) 
            {
                closePopUp();
            }
            closeOnTouchOutside = false;
            return;
        }

        internal static function createCustomOverlayFactory():starling.display.DisplayObject
        {
            var quad:starling.display.Quad;

            var loc1:*;
            quad = null;
            quad = new starling.display.Quad(1, 1, starling.utils.Color.BLACK);
            quad.alpha = 0;
            quad.addEventListener(starling.events.Event.ADDED_TO_STAGE, function ():void
            {
                starling.core.Starling.juggler.tween(quad, TWEEN_DURATION, {"alpha":MODAL_ALPHA});
                quad.addEventListener(starling.events.TouchEvent.TOUCH, onTouchOutside);
                return;
            })
            quad.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, function ():void
            {
                quad.alpha = 0;
                quad.removeEventListener(starling.events.TouchEvent.TOUCH, onTouchOutside);
                return;
            })
            return quad;
        }

        public static function get FOOTER_HEIGHT():int
        {
            return frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT;
        }

        public static function get HEADER_HEIGHT():int
        {
            return frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT;
        }

        public static function set HEADER_HEIGHT(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._907846425HEADER_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "HEADER_HEIGHT", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get OUTER_PADDING():int
        {
            return frontend.components.popup.PopUpBase._529003507OUTER_PADDING;
        }

        public static function set OUTER_PADDING(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._529003507OUTER_PADDING;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._529003507OUTER_PADDING = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "OUTER_PADDING", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static function get staticEventDispatcher():starling.events.EventDispatcher
        {
            return _staticBindingEventDispatcher;
        }

        
        {
            closeOnTouchOutside = false;
            currentPopUps = new flash.utils.Dictionary();
            _staticBindingEventDispatcher = new starling.events.EventDispatcher();
        }

        public function close():void
        {
            closePopUp();
            return;
        }

        public function show(arg1:Boolean=true, arg2:Boolean=true, arg3:Boolean=true, arg4:Boolean=false):void
        {
            frontend.components.popup.PopUpBase.showModalPopUp(this, arg1, arg2, arg3, arg4);
            return;
        }

        protected function onAddedToStage(arg1:starling.events.Event):void
        {
            debug.Debug.debug("[POPUP] onAddedToStage");
            removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            if (helper.Capabilities_helper.isAndroid() && this.popupIgnoresBackButton) 
            {
                stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            handler.ViewHandler.getInstance().handleAndroidBackButton = !this.popupIgnoresBackButton;
            this.initLayout();
            this.addContent();
            return;
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            debug.Debug.debug("[POPUP] onRemovedFromStage");
            removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.onRemovedFromStage);
            if (helper.Capabilities_helper.isAndroid()) 
            {
                stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.androidBackButtonHandler);
            }
            handler.ViewHandler.getInstance().handleAndroidBackButton = true;
            if (this.closeCallback != null) 
            {
                this.closeCallback(this);
            }
            return;
        }

        protected function androidBackButtonHandler(arg1:starling.events.KeyboardEvent):void
        {
            debug.Debug.debug("[POPUP] androidBackButtonHandler");
            if (arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                arg1.stopImmediatePropagation();
            }
            return;
        }

        protected function createPopUpHeader():feathers.core.IFeathersControl
        {
            debug.Debug.debug("[POPUP] createPopUpHeader");
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = new feathers.layout.AnchorLayout();
            loc1.backgroundSkin = new starling.display.Quad(1, 1, 16777215);
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = HEADER_HEIGHT;
            loc2.layoutData = this.headerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Label();
            loc3.text = title;
            loc3.layoutData = this.titleLayoutData;
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_POPUP_TITLE;
            loc2.addChild(loc3);
            var loc4:*=new frontend.components.button.IconButton();
            loc4.image = frontend.Textures.closeiconred;
            loc4.layoutData = this.closeIconLayoutData;
            loc4.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc4);
            return loc1;
        }

        protected function createPopUpFooter():feathers.core.IFeathersControl
        {
            debug.Debug.debug("createPopUpFooter");
            var loc1:*=new feathers.controls.LayoutGroup();
            if (!this.showCloseButton) 
            {
                return loc1;
            }
            loc1.layout = new feathers.layout.AnchorLayout();
            var loc2:*=new feathers.controls.LayoutGroup();
            loc2.layout = new feathers.layout.AnchorLayout();
            loc2.height = FOOTER_HEIGHT;
            loc2.layoutData = this.footerLayoutData;
            loc1.addChild(loc2);
            var loc3:*=new feathers.controls.Button();
            loc3.label = utils.LanguageManager.getString("CLOSE_BUTTON");
            loc3.layoutData = this.closeButtonLayoutData;
            loc3.addEventListener(starling.events.Event.TRIGGERED, this.closeButton_triggeredHandler);
            loc2.addChild(loc3);
            return loc1;
        }

        protected function closeButton_triggeredHandler(arg1:starling.events.Event):void
        {
            return;
        }

        protected function initLayout():void
        {
            FOOTER_HEIGHT = this.showCloseButton ? 90 * SIGMALink.scaleFactor : 0;
            HEADER_HEIGHT = 100 * SIGMALink.scaleFactor;
            this._layoutGap = 20 * SIGMALink.scaleFactor;
            OUTER_PADDING = 8 * SIGMALink.scaleFactor;
            this._doublePadding = OUTER_PADDING << 1;
            this.validatePopUpSize();
            this.headerLayoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            this.titleLayoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, this._layoutGap, NaN, 0);
            this.closeIconLayoutData = new feathers.layout.AnchorLayoutData(NaN, this._layoutGap, NaN, NaN, NaN, 0);
            this.footerLayoutData = new feathers.layout.AnchorLayoutData(0, NaN, 0, NaN, 0, 0);
            this.closeButtonLayoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, this._layoutGap);
            footerFactory = this.createPopUpFooter;
            headerFactory = this.createPopUpHeader;
            layout = new feathers.layout.AnchorLayout();
            this.contentLayoutData = new feathers.layout.AnchorLayoutData(0, 0, 0, 0);
            return;
        }

        protected function validatePopUpSize():void
        {
            width = SIGMALink.appWidth - this._doublePadding;
            height = SIGMALink.appHeight - this._doublePadding;
            return;
        }

        protected function addContent():void
        {
            this.contentHolder = new feathers.controls.LayoutGroup();
            this.contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.contentHolder.layout = new feathers.layout.AnchorLayout();
            this.contentHolder.layoutData = this.contentLayoutData;
            this.contentHolder.width = width;
            this.contentHolder.height = height - HEADER_HEIGHT - FOOTER_HEIGHT;
            this.myViewPort = new flash.geom.Rectangle(0, 0, this.contentHolder.width, this.contentHolder.height);
            addChild(this.contentHolder);
            return;
        }

        protected override function draw():void
        {
            this.customDraw();
            super.draw();
            return;
        }

        public static function set FOOTER_HEIGHT(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT;
            if (loc1 !== arg1) 
            {
                frontend.components.popup.PopUpBase._253748299FOOTER_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "FOOTER_HEIGHT", loc1, arg1, frontend.components.popup.PopUpBase);
                loc3 = frontend.components.popup.PopUpBase.staticEventDispatcher;
                if (!(loc3 == null) && loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _doublePadding():int
        {
            return this._1627099903_doublePadding;
        }

        protected function set _doublePadding(arg1:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1627099903_doublePadding;
            if (loc1 !== arg1) 
            {
                this._1627099903_doublePadding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_doublePadding", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get _layoutGap():int
        {
            return this._1431588301_layoutGap;
        }

        internal static const MODAL_ALPHA:Number=0.8;

        internal static const TWEEN_DURATION:Number=0.3;

        public static const CUSTOM_TWEEN_DIRECTION_BOTTOM_TO_TOP:String="tweenBottomToTop";

        public static const CUSTOM_TWEEN_DIRECTION_LEFT_TO_RIGHT:String="tweenLeftToRight";

        public static const CUSTOM_TWEEN_DIRECTION_RIGHT_TO_LEFT:String="tweenRightToLeft";

        public var closeCallback:Function;

        public var closeTweenDirection:String="tweenBottomToTop";

        public var contentHolder:feathers.controls.LayoutGroup;

        internal var _popupIgnoresBackButton:Boolean=true;

        protected var _backgroundSkinColor:uint=15658734;

        protected var _1627099903_doublePadding:int;

        protected var _1431588301_layoutGap:int;

        protected var _validate:Boolean=true;

        protected var closeButtonLayoutData:feathers.layout.AnchorLayoutData;

        protected var closeIconLayoutData:feathers.layout.AnchorLayoutData;

        protected var contentLayoutData:feathers.layout.AnchorLayoutData;

        protected var footerLayoutData:feathers.layout.AnchorLayoutData;

        protected var headerLayoutData:feathers.layout.AnchorLayoutData;

        protected var myViewPort:flash.geom.Rectangle;

        protected var titleLayoutData:feathers.layout.AnchorLayoutData;

        internal static var _907846425HEADER_HEIGHT:int;

        internal static var _529003507OUTER_PADDING:int;

        public static var closeOnTouchOutside:Boolean=false;

        public var showCloseButton:Boolean=false;

        internal static var currentPopUps:flash.utils.Dictionary;

        internal static var _staticBindingEventDispatcher:starling.events.EventDispatcher;

        internal static var _253748299FOOTER_HEIGHT:int;
    }
}


