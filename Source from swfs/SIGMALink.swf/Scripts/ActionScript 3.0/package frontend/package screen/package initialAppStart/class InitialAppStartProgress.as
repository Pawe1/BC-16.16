//class InitialAppStartProgress
package frontend.screen.initialAppStart 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
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
    import mx.core.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    
    use namespace mx_internal;
    
    public class InitialAppStartProgress extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function InitialAppStartProgress()
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
            bindings = this._InitialAppStartProgress_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_initialAppStart_InitialAppStartProgressWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return InitialAppStartProgress[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.addEventListener("initialize", this.___InitialAppStartProgress_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function onInit():void
        {
            var loc1:*=null;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.drawBackground();
            loc1 = new starling.display.Quad(width, this.BOTTOM_GAP, core.general.Colors.LIGHTGREY);
            loc1.y = HEIGHT - this.BOTTOM_GAP;
            addChild(loc1);
            return;
        }

        internal function drawBackground():void
        {
            var loc1:*=0;
            loc1 = 0;
            while (loc1 < this.steps) 
            {
                this.addBackgroundCircle(loc1);
                ++loc1;
            }
            this.addBackgroundBar();
            this.setCurrentStep(1);
            return;
        }

        internal function addBackgroundCircle(arg1:int):void
        {
            var loc1:*=new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.InitialStartCircleBackground));
            if (this.CIRCLE_WIDTH == 1) 
            {
                this.CIRCLE_WIDTH = loc1.width;
                this.circleGAP = width - 2 * this.GAP - this.steps * this.CIRCLE_WIDTH;
                this.circleGAP = this.circleGAP / (this.steps - 1);
            }
            loc1.x = this.getCircleX(arg1);
            loc1.y = this.getCircleY();
            addChild(loc1);
            return;
        }

        internal function getCircleX(arg1:int):Number
        {
            return this.GAP + arg1 * this.circleGAP + arg1 * this.CIRCLE_WIDTH;
        }

        internal function getCircleY():Number
        {
            return (height - this.BOTTOM_GAP - this.CIRCLE_WIDTH) / 2;
        }

        internal function drawForegroundCircle():void
        {
            var xTo:Number;
            var tween:starling.animation.Tween;

            var loc1:*;
            tween = null;
            xTo = this.getCircleX((_currentStep - 1));
            if (this._currentStepCircle) 
            {
                tween = new starling.animation.Tween(this._currentStepCircle, TWEEN_DURATION, starling.animation.Transitions.LINEAR);
                tween.animate("x", xTo);
                tween.onComplete = function ():void
                {
                    starling.core.Starling.juggler.remove(tween);
                    return;
                }
                starling.core.Starling.juggler.add(tween);
            }
            else 
            {
                this._currentStepCircle = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.InitialStartCircleForeground));
                this._currentStepCircle.x = xTo;
                this._currentStepCircle.y = this.getCircleY();
                addChild(this._currentStepCircle);
            }
            return;
        }

        internal function addBackgroundBar():void
        {
            var loc1:*=frontend.AssetsManagerCustom.getInstance().getTexture(frontend.Textures.InitialStartRectBackground);
            var loc2:*=new flash.geom.Rectangle(1, 1, 2, 2);
            var loc3:*=new starling.display.Image(loc1);
            loc3.scale9Grid = loc2;
            loc3.width = width - 2 * this.GAP - this.CIRCLE_WIDTH;
            loc3.height = loc1.height;
            loc3.x = this.GAP + this.CIRCLE_WIDTH / 2;
            loc3.y = (height - this.BOTTOM_GAP - loc3.height) / 2;
            addChild(loc3);
            return;
        }

        public function setCurrentStep(arg1:int):void
        {
            _currentStep = arg1;
            this.drawForegroundCircle();
            return;
        }

        public function ___InitialAppStartProgress_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit();
            return;
        }

        internal function _InitialAppStartProgress_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():Number
            {
                return HEIGHT;
            }, null, "this.height")
            result[1] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "this.layout")
            return result;
        }

        public static function set watcherSetupUtil(arg1:feathers.binding.IWatcherSetupUtil):void
        {
            InitialAppStartProgress._watcherSetupUtil = arg1;
            return;
        }

        
        {
            _currentStep = 1;
        }

        internal const BOTTOM_GAP:Number=20 * SIGMALink.scaleFactor;

        internal const GAP:Number=52 * SIGMALink.scaleFactor;

        internal const steps:int=4;

        public static const HEIGHT:Number=103 * SIGMALink.scaleFactor;

        public static const TWEEN_DURATION:Number=0.3;

        internal var CIRCLE_WIDTH:Number=1;

        internal var _currentStepCircle:starling.display.Image;

        internal var circleGAP:Number=1;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        internal static var _currentStep:int=1;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


