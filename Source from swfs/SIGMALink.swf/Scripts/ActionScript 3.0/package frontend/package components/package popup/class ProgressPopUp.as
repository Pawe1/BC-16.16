//class ProgressPopUp
package frontend.components.popup 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import flash.utils.*;
    import frontend.components.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ProgressPopUp extends frontend.components.popup.PopUpBase
    {
        public function ProgressPopUp()
        {
            this.description = new feathers.controls.Label();
            this.headline = new feathers.controls.Label();
            this._2932247_gap = 20 * SIGMALink.scaleFactor;
            this._image = new frontend.components.TextureImage();
            this._percentageLabel = new feathers.controls.Label();
            this._progressBarHeight = 66 * SIGMALink.scaleFactor;
            this._progressBorderWidth = 9 * SIGMALink.scaleFactor;
            super();
            this.popupIgnoresBackButton = true;
            _backgroundSkinColor = core.general.Colors.RED;
            this._progressBar = new feathers.controls.ProgressBar();
            this._progressBar.styleProvider = null;
            this._progressBar.backgroundSkin = new starling.display.Quad(1, this._progressBarHeight - 4 * this._progressBorderWidth, core.general.Colors.RED);
            this._progressBar.fillSkin = new starling.display.Quad(1, this._progressBarHeight - 4 * this._progressBorderWidth, core.general.Colors.WHITE);
            return;
        }

        public function get imageTexture():String
        {
            return this._imageTexture;
        }

        internal function set _819554496imageTexture(arg1:String):void
        {
            this._imageTexture = arg1;
            if (this._image != null) 
            {
                this._image.includeInLayout = !(this._imageTexture == null);
            }
            return;
        }

        protected override function validatePopUpSize():void
        {
            FOOTER_HEIGHT = 90 * SIGMALink.scaleFactor;
            HEADER_HEIGHT = 90 * SIGMALink.scaleFactor;
            width = SIGMALink.appWidth;
            height = SIGMALink.appHeight * 0.33;
            return;
        }

        protected override function createPopUpFooter():feathers.core.IFeathersControl
        {
            return new feathers.controls.LayoutGroup();
        }

        protected override function createPopUpHeader():feathers.core.IFeathersControl
        {
            return new feathers.controls.LayoutGroup();
        }

        protected override function addContent():void
        {
            super.addContent();
            contentHolder.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = this._gap;
            var loc2:*=new feathers.layout.HorizontalLayout();
            loc2.gap = this._gap;
            loc2.padding = this._gap;
            var loc3:*=new feathers.controls.LayoutGroup();
            loc3.layout = loc2;
            loc3.width = width;
            var loc4:*=new feathers.controls.LayoutGroup();
            loc4.layout = loc1;
            if (this._imageTexture == null) 
            {
                this._image.includeInLayout = false;
            }
            else 
            {
                this._image.textureName = this._imageTexture;
                this._image.includeInLayout = true;
            }
            contentHolder.addChild(loc3);
            loc3.addChild(this._image);
            loc3.addChild(loc4);
            this._image.validate();
            loc4.width = width - this._image.width - this._gap * 3;
            this.headline = new feathers.controls.Label();
            this.headline.text = title;
            this.description.maxWidth = loc4.width;
            this.headline.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_RED_POPUP_TITLE;
            loc4.addChild(this.headline);
            this.description.maxWidth = loc4.width;
            this.description.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            this.description.wordWrap = true;
            loc4.addChild(this.description);
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.width = loc4.width;
            loc5.height = this._progressBarHeight;
            loc5.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc5.layout = new feathers.layout.AnchorLayout();
            var loc6:*=new feathers.controls.LayoutGroup();
            loc6.width = loc5.width - 2 * this._progressBorderWidth;
            loc6.height = loc5.height - 2 * this._progressBorderWidth;
            loc6.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.RED);
            loc6.layout = new feathers.layout.AnchorLayout();
            loc6.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc5.addChild(loc6);
            this._progressBar.minimum = 0;
            this._progressBar.maximum = 100;
            this._progressBar.value = 0;
            this._progressBar.width = loc6.width - 2 * this._progressBorderWidth;
            this._progressBar.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            loc6.addChild(this._progressBar);
            loc4.addChild(loc5);
            this._percentageLabel.text = "";
            this._percentageLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            loc4.addChild(this._percentageLabel);
            return;
        }

        public function setProgressPercentage(arg1:uint):void
        {
            var loc1:*=NaN;
            if (this._progressBar == null) 
            {
                return;
            }
            if (arg1 > 100) 
            {
                arg1 = 100;
            }
            if (arg1 != 100) 
            {
                loc1 = arg1;
            }
            else 
            {
                loc1 = this._progressBar.value + arg1 / this._prgressAnimateToCompleteDuration;
            }
            if (loc1 > 100) 
            {
                loc1 = 100;
            }
            this._progressBar.value = loc1;
            this._progressBar.fillSkin.width = this._progressBar.width * this._progressBar.value / 100;
            this._percentageLabel.text = this._progressBar.value + "%";
            if (arg1 == 100) 
            {
                if (this._progressBar.value < 100) 
                {
                    flash.utils.setTimeout(this.setProgressPercentage, this._prgressAnimateToCompleteDuration, arg1);
                }
                else 
                {
                    flash.utils.setTimeout(this.onProgressComplete, this._prgressAnimateToCompleteDuration);
                }
            }
            return;
        }

        internal function onProgressComplete():void
        {
            dispatchEventWith(PROGRESS_COMPLETE);
            return;
        }

        public override function validate():void
        {
            super.validate();
            this.validatePopUpContent();
            return;
        }

        public function validatePopUpContent():void
        {
            this.headline.text = title;
            this.description.text = this.text;
            return;
        }

        public function set imageTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.imageTexture;
            if (loc1 !== arg1) 
            {
                this._819554496imageTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "imageTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _gap():Number
        {
            return this._2932247_gap;
        }

        internal function set _gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2932247_gap;
            if (loc1 !== arg1) 
            {
                this._2932247_gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public static const PROGRESS_COMPLETE:String="progressCompleteEvent";

        internal var _imageTexture:String;

        public var text:String;

        protected var description:feathers.controls.Label;

        protected var headline:feathers.controls.Label;

        internal var _2932247_gap:Number;

        internal var _image:frontend.components.TextureImage;

        internal var _percentageLabel:feathers.controls.Label;

        internal var _prgressAnimateToCompleteDuration:uint=10;

        internal var _progressBar:feathers.controls.ProgressBar;

        internal var _progressBarHeight:Number;

        internal var _progressBorderWidth:Number;
    }
}


