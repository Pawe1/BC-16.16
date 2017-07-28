//class Footer
package frontend.screen.component 
{
    import __AS3__.vec.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import frontend.*;
    import frontend.components.button.*;
    import handler.*;
    import helper.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class Footer extends feathers.controls.LayoutGroup
    {
        public function Footer()
        {
            this._buttonGroup = new Vector.<frontend.components.button.IconButton>();
            this._padding = 10 * SIGMALink.scaleFactor;
            super();
            height = SIGMALink.footerHeight;
            width = SIGMALink.appWidth;
            layoutData = new feathers.layout.AnchorLayoutData(NaN, 0, 0, 0);
            layout = new feathers.layout.HorizontalLayout();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            this._groupLeftRightLayout = new feathers.layout.HorizontalLayout();
            this._groupLeftRightLayout.paddingLeft = this._padding;
            this._groupLeftRightLayout.paddingRight = this._padding;
            this._groupLeftRightLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._groupLeftRightLayout.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            this._groupCenterLayout = new feathers.layout.HorizontalLayout();
            this._groupCenterLayout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._groupCenterLayout.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            this._groupLeft = new feathers.controls.LayoutGroup();
            this._groupLeft.layout = this._groupLeftRightLayout;
            this._groupLeft.layoutData = new feathers.layout.HorizontalLayoutData(NaN, 100);
            addChild(this._groupLeft);
            this._groupCenter = new feathers.controls.LayoutGroup();
            this._groupCenter.layout = this._groupCenterLayout;
            this._groupCenter.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            addChild(this._groupCenter);
            this._groupRight = new feathers.controls.LayoutGroup();
            this._groupRight.layout = this._groupLeftRightLayout;
            this._groupRight.layoutData = new feathers.layout.HorizontalLayoutData(NaN, 100);
            addChild(this._groupRight);
            addEventListener(feathers.events.FeathersEventType.INITIALIZE, this.onInit);
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddetToStage);
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            this._saveYpos = this.y;
            this._saveXpos = this.x;
            return;
        }

        internal function tweenTo(arg1:Number, arg2:Number, arg3:Function=null):void
        {
            starling.core.Starling.juggler.remove(this._tween);
            this._tween = new starling.animation.Tween(this, this.animationDuration, this.animationTransition);
            if (arg3 != null) 
            {
                this._tween.onComplete = arg3;
            }
            this._tween.moveTo(arg1, arg2);
            starling.core.Starling.juggler.add(this._tween);
            return;
        }

        public function set backButtonIsEnabled(arg1:Boolean):void
        {
            if (!this._backButton) 
            {
                return;
            }
            this._backButton.isEnabled = arg1;
            return;
        }

        public function set buttonsEnabled(arg1:Boolean):void
        {
            if (!this._buttonGroup) 
            {
                return;
            }
            var loc1:*=0;
            while (loc1 < this._buttonGroup.length) 
            {
                this._buttonGroup[loc1].isEnabled = arg1;
                ++loc1;
            }
            return;
        }

        public function get showBackButton():Boolean
        {
            return this._showBackButton && !helper.Capabilities_helper.isAndroid();
        }

        public function get forceRightButton():Boolean
        {
            return this._forceRightButton;
        }

        public function set forceRightButton(arg1:Boolean):void
        {
            this._forceRightButton = arg1;
            this.reset();
            if (this._mxmlContentSet) 
            {
                this.drawContent();
            }
            return;
        }

        public override function set mxmlContent(arg1:Array):void
        {
            this._mxmlContentSet = true;
            this.addBackButton();
            var loc1:*=0;
            while (loc1 < arg1.length) 
            {
                if (arg1[loc1] is frontend.components.button.IconButton) 
                {
                    this._buttonGroup.push(arg1[loc1] as frontend.components.button.IconButton);
                }
                ++loc1;
            }
            this.drawContent();
            return;
        }

        public function reset():void
        {
            this._groupLeft.removeChildren();
            this._groupCenter.removeChildren();
            this._groupRight.removeChildren();
            this._backButtonAddet = false;
            this._initialized = false;
            return;
        }

        internal function drawContent():void
        {
            var loc1:*=0;
            if (this._initialized) 
            {
                return;
            }
            this._initialized = true;
            if (this._buttonGroup.length > 0) 
            {
                loc1 = 0;
                while (loc1 < this._buttonGroup.length) 
                {
                    var loc2:*=loc1;
                    switch (loc2) 
                    {
                        case 0:
                        {
                            if (this.showBackButton || !this.forceRightButton) 
                            {
                                this.addButton(this._buttonGroup[loc1], ORIENTATION_LEFT);
                            }
                            else if (this.forceRightButton) 
                            {
                                this.addButton(this._buttonGroup[loc1], ORIENTATION_RIGHT);
                            }
                            else 
                            {
                                this.addButton(this._buttonGroup[loc1], ORIENTATION_LEFT);
                            }
                            break;
                        }
                        case (this._buttonGroup.length - 1):
                        {
                            this.addButton(this._buttonGroup[loc1], ORIENTATION_RIGHT);
                            break;
                        }
                        default:
                        {
                            this.addButton(this._buttonGroup[loc1], ORIENTATION_CENTER);
                            break;
                        }
                    }
                    ++loc1;
                }
                this._groupLeft.validate();
                this._groupRight.validate();
                this._groupCenter.validate();
                this.refreshCenterGap();
            }
            return;
        }

        public function set showBackButton(arg1:Boolean):void
        {
            this._showBackButton = arg1 && !helper.Capabilities_helper.isAndroid();
            return;
        }

        public function refreshCenterGap():void
        {
            if (this._groupCenter.numChildren < 2) 
            {
                return;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            while (loc1 < this._groupCenter.numChildren) 
            {
                if (this._groupCenter.getChildAt(loc1).visible) 
                {
                    loc2 = loc2 + this._groupCenter.getChildAt(loc1).width;
                }
                ++loc1;
            }
            loc3 = this.width - this._groupLeft.width - this._groupRight.width - loc2;
            this._groupCenterLayout.gap = loc3 / (this._groupCenter.numChildren + 1);
            return;
        }

        internal function addBackButton():void
        {
            if (this.showBackButton && !this._backButtonAddet) 
            {
                this._backButton = new frontend.components.button.IconButton();
                this._backButton.image = frontend.Textures.backbutton;
                this._backButton.touchHandler = this.switchToLastScreen;
                this._buttonGroup.unshift(this._backButton);
                this._backButtonAddet = true;
            }
            return;
        }

        internal function switchToLastScreen(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            handler.ViewHandler.getInstance().goBack();
            return;
        }

        internal function addButton(arg1:frontend.components.button.IconButton, arg2:String):void
        {
            var loc1:*=arg2;
            switch (loc1) 
            {
                case ORIENTATION_LEFT:
                {
                    if (this._groupLeft.numChildren == 0) 
                    {
                        this._groupLeft.addChild(arg1);
                    }
                    break;
                }
                case ORIENTATION_CENTER:
                {
                    this._groupCenter.addChild(arg1);
                    break;
                }
                case ORIENTATION_RIGHT:
                {
                    if (this._groupRight.numChildren == 0) 
                    {
                        this._groupRight.addChild(arg1);
                    }
                    break;
                }
            }
            arg1.validate();
            return;
        }

        public function setButtonGroup(arg1:__AS3__.vec.Vector.<frontend.components.button.IconButton>):void
        {
            if (this._initialized) 
            {
                this.reset();
            }
            this._buttonGroup = arg1;
            this.addBackButton();
            this.drawContent();
            return;
        }

        internal function onInit(arg1:starling.events.Event):void
        {
            this.addBackButton();
            this.drawContent();
            return;
        }

        public function show(arg1:Function=null):void
        {
            this.tweenTo(this._saveXpos, this._saveYpos, arg1);
            return;
        }

        public function hide(arg1:Function=null):void
        {
            this.tweenTo(this._saveXpos, SIGMALink.appHeight, arg1);
            return;
        }

        public static const EVENT_TWEEN_COMPLETE:String="tweenComplete";

        internal static const ORIENTATION_CENTER:String="center";

        internal static const ORIENTATION_LEFT:String="left";

        internal static const ORIENTATION_RIGHT:String="right";

        public var animationDuration:Number=0.3;

        public var animationTransition:String="easeIn";

        internal var _showBackButton:Boolean=true;

        internal var _forceRightButton:Boolean=false;

        internal var _backButton:frontend.components.button.IconButton;

        internal var _backButtonAddet:Boolean=false;

        internal var _buttonGroup:__AS3__.vec.Vector.<frontend.components.button.IconButton>;

        internal var _groupCenter:feathers.controls.LayoutGroup;

        internal var _groupLeft:feathers.controls.LayoutGroup;

        internal var _groupLeftRightLayout:feathers.layout.HorizontalLayout;

        internal var _groupRight:feathers.controls.LayoutGroup;

        internal var _initialized:Boolean=false;

        internal var _padding:Number;

        internal var _saveXpos:Number;

        internal var _saveYpos:Number;

        internal var _tween:starling.animation.Tween;

        internal var _groupCenterLayout:feathers.layout.HorizontalLayout;

        internal var _mxmlContentSet:Boolean=false;
    }
}


