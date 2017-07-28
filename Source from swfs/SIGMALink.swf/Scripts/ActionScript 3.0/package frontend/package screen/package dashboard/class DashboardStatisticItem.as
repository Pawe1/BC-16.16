//class DashboardStatisticItem
package frontend.screen.dashboard 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.*;
    import frontend.components.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DashboardStatisticItem extends frontend.components.core.Group
    {
        public function DashboardStatisticItem()
        {
            this._1398151987iconWidth = 50 * SIGMALink.scaleFactor;
            this._1973788148minItemHeight = 45 * SIGMALink.scaleFactor;
            this._480004446unitWidth = 50 * SIGMALink.scaleFactor;
            this._575915578elementGap = 17 * SIGMALink.scaleFactor;
            super();
            percentWidth = 100;
            minHeight = this.minItemHeight;
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            layout = new feathers.layout.AnchorLayout();
            return;
        }

        public function set labelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._607740351labelText;
            if (loc1 !== arg1) 
            {
                this._607740351labelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "labelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get minItemHeight():Number
        {
            return this._1973788148minItemHeight;
        }

        public function set minItemHeight(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1973788148minItemHeight;
            if (loc1 !== arg1) 
            {
                this._1973788148minItemHeight = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "minItemHeight", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitText():String
        {
            return this._292671279unitText;
        }

        public function set unitText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._292671279unitText;
            if (loc1 !== arg1) 
            {
                this._292671279unitText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitWidth():Number
        {
            return this._480004446unitWidth;
        }

        public function set unitWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._480004446unitWidth;
            if (loc1 !== arg1) 
            {
                this._480004446unitWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get valueText():String
        {
            return this._valueText;
        }

        internal function set _765711810valueText(arg1:String):void
        {
            this._valueText = arg1;
            this.valueLabel.text = this._valueText;
            return;
        }

        public override function set width(arg1:Number):void
        {
            super.width = arg1;
            if (this.unitLayoutData) 
            {
                this.unitLayoutData.left = width - this.unitWidth;
            }
            if (this.label) 
            {
                this.label.maxWidth = width - 2 * this.elementGap - this.iconWidth - this.valueLabel.width - this.unitWidth;
            }
            return;
        }

        public function set valueText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.valueText;
            if (loc1 !== arg1) 
            {
                this._765711810valueText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "valueText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected function get elementGap():Number
        {
            return this._575915578elementGap;
        }

        protected function set elementGap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._575915578elementGap;
            if (loc1 !== arg1) 
            {
                this._575915578elementGap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "elementGap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get unitLayoutData():feathers.layout.AnchorLayoutData
        {
            return this._514893160unitLayoutData;
        }

        internal function set unitLayoutData(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._514893160unitLayoutData;
            if (loc1 !== arg1) 
            {
                this._514893160unitLayoutData = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitLayoutData", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            var loc1:*=new frontend.components.TextureImage();
            loc1.textureName = this.iconName;
            loc1.touchable = false;
            loc1.layoutData = this.setImagePos();
            addChild(loc1);
            this.label = new feathers.controls.Label();
            this.label.text = this.labelText;
            this.label.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
            this.label.touchable = false;
            this.label.layoutData = this.setLabelPos();
            addChild(this.label);
            this.valueLabel = new feathers.controls.Label();
            this.valueLabel.text = this.valueText;
            this.valueLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this.valueLabel.touchable = false;
            this.valueLabel.layoutData = this.setValuePos();
            addChild(this.valueLabel);
            this.unit = new feathers.controls.Label();
            this.unit.text = this.unitText;
            this.unit.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this.unit.touchable = false;
            this.unit.layoutData = this.setUnitPos();
            addChild(this.unit);
            return;
        }

        internal function setImagePos():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.left = this.elementGap;
            loc1.verticalCenter = 0;
            return loc1;
        }

        internal function setLabelPos():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.left = this.elementGap + this.iconWidth;
            loc1.verticalCenter = 0;
            return loc1;
        }

        internal function setValuePos():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.right = this.elementGap + this.unitWidth;
            loc1.verticalCenter = 0;
            return loc1;
        }

        internal function setUnitPos():feathers.layout.AnchorLayoutData
        {
            this.unitLayoutData = new feathers.layout.AnchorLayoutData();
            this.unitLayoutData.left = 0;
            this.unitLayoutData.verticalCenter = 0;
            return this.unitLayoutData;
        }

        public function get iconName():String
        {
            return this._738113884iconName;
        }

        public function set iconName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._738113884iconName;
            if (loc1 !== arg1) 
            {
                this._738113884iconName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconWidth():Number
        {
            return this._1398151987iconWidth;
        }

        public function set iconWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1398151987iconWidth;
            if (loc1 !== arg1) 
            {
                this._1398151987iconWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get labelText():String
        {
            return this._607740351labelText;
        }

        internal var _738113884iconName:String="";

        internal var _1398151987iconWidth:Number;

        internal var _607740351labelText:String;

        internal var _1973788148minItemHeight:Number;

        internal var _292671279unitText:String;

        internal var _480004446unitWidth:Number;

        internal var _valueText:String;

        protected var _575915578elementGap:Number;

        internal var label:feathers.controls.Label;

        internal var unit:feathers.controls.Label;

        internal var _514893160unitLayoutData:feathers.layout.AnchorLayoutData;

        internal var valueLabel:feathers.controls.Label;
    }
}


