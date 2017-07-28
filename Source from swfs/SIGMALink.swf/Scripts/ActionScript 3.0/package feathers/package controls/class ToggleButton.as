//class ToggleButton
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.keyboard.*;
    import feathers.utils.touch.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    
    public class ToggleButton extends feathers.controls.Button implements feathers.core.IGroupedToggle
    {
        public function ToggleButton()
        {
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            if (feathers.controls.ToggleButton.globalStyleProvider) 
            {
                return feathers.controls.ToggleButton.globalStyleProvider;
            }
            return feathers.controls.Button.globalStyleProvider;
        }

        public override function get currentState():String
        {
            if (this._isSelected) 
            {
                return super.currentState + "AndSelected";
            }
            return super.currentState;
        }

        public function set selectedDisabledIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, arg1);
            return;
        }

        public override function dispose():void
        {
            if (this._defaultSelectedSkin && !(this._defaultSelectedSkin.parent === this)) 
            {
                this._defaultSelectedSkin.dispose();
            }
            if (this._defaultSelectedIcon && !(this._defaultSelectedIcon.parent === this)) 
            {
                this._defaultSelectedIcon.dispose();
            }
            super.dispose();
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            if (!this.tapToSelect) 
            {
                this.tapToSelect = new feathers.utils.touch.TapToSelect(this);
                this.longPress.tapToSelect = this.tapToSelect;
            }
            if (!this.keyToSelect) 
            {
                this.keyToSelect = new feathers.utils.keyboard.KeyToSelect(this);
            }
            return;
        }

        public function get isToggle():Boolean
        {
            return this._isToggle;
        }

        public function set isToggle(arg1:Boolean):void
        {
            if (this._isToggle === arg1) 
            {
                return;
            }
            this._isToggle = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            if (loc1 || loc2) 
            {
                this.refreshSelectionEvents();
            }
            super.draw();
            return;
        }

        public function get isSelected():Boolean
        {
            return this._isSelected;
        }

        public function set isSelected(arg1:Boolean):void
        {
            if (this._isSelected === arg1) 
            {
                return;
            }
            this._isSelected = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        protected override function getCurrentSkin():starling.display.DisplayObject
        {
            var loc1:*=null;
            if (this._stateToSkinFunction === null) 
            {
                loc1 = this._stateToSkin[this.currentState] as starling.display.DisplayObject;
                if (loc1 !== null) 
                {
                    return loc1;
                }
                if (this._isSelected && !(this._defaultSelectedSkin === null)) 
                {
                    return this._defaultSelectedSkin;
                }
                return this._defaultSkin;
            }
            return super.getCurrentSkin();
        }

        public function get toggleGroup():feathers.core.ToggleGroup
        {
            return this._toggleGroup;
        }

        public function set toggleGroup(arg1:feathers.core.ToggleGroup):void
        {
            if (this._toggleGroup == arg1) 
            {
                return;
            }
            if (this._toggleGroup && this._toggleGroup.hasItem(this)) 
            {
                this._toggleGroup.removeItem(this);
            }
            this._toggleGroup = arg1;
            if (this._toggleGroup && !this._toggleGroup.hasItem(this)) 
            {
                this._toggleGroup.addItem(this);
            }
            return;
        }

        protected override function getCurrentIcon():starling.display.DisplayObject
        {
            var loc1:*=null;
            if (this._stateToIconFunction === null) 
            {
                loc1 = this._stateToIcon[this.currentState] as starling.display.DisplayObject;
                if (loc1 !== null) 
                {
                    return loc1;
                }
                if (this._isSelected && !(this._defaultSelectedIcon === null)) 
                {
                    return this._defaultSelectedIcon;
                }
                return this._defaultIcon;
            }
            return super.getCurrentIcon();
        }

        public function get defaultSelectedSkin():starling.display.DisplayObject
        {
            return this._defaultSelectedSkin;
        }

        public function set defaultSelectedSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._defaultSelectedSkin === arg1) 
            {
                return;
            }
            if (!(this._defaultSelectedSkin === null) && this.currentSkin === this._defaultSelectedSkin) 
            {
                this.removeCurrentSkin(this._defaultSelectedSkin);
                this.currentSkin = null;
            }
            this._defaultSelectedSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectedUpSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.UP_AND_SELECTED);
        }

        public function set selectedUpSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.UP_AND_SELECTED, arg1);
            return;
        }

        public function get selectedDownSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.DOWN_AND_SELECTED);
        }

        public function set selectedDownSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, arg1);
            return;
        }

        public function get selectedHoverSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.HOVER_AND_SELECTED);
        }

        public function set selectedHoverSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.HOVER_AND_SELECTED, arg1);
            return;
        }

        public function get selectedDisabledSkin():starling.display.DisplayObject
        {
            return this.getSkinForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED);
        }

        public function set selectedDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            this.setSkinForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, arg1);
            return;
        }

        public function get selectedFontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.selectedFormat;
        }

        public function set selectedFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.selectedFormat = arg1;
            return;
        }

        protected override function getCurrentLabelProperties():Object
        {
            var loc1:*=null;
            if (this._stateToLabelPropertiesFunction === null) 
            {
                loc1 = this._stateToLabelProperties[this.currentState];
                if (loc1 !== null) 
                {
                    return loc1;
                }
                if (this._isSelected && !(this._defaultSelectedLabelProperties === null)) 
                {
                    return this._defaultSelectedLabelProperties;
                }
                return this._defaultLabelProperties;
            }
            return super.getCurrentIcon();
        }

        public function get defaultSelectedLabelProperties():Object
        {
            if (this._defaultSelectedLabelProperties === null) 
            {
                this._defaultSelectedLabelProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._defaultSelectedLabelProperties;
        }

        public function set defaultSelectedLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._defaultSelectedLabelProperties !== null) 
            {
                this._defaultSelectedLabelProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._defaultSelectedLabelProperties.defaultSelectedValue = arg1;
            if (this._defaultSelectedLabelProperties !== null) 
            {
                this._defaultSelectedLabelProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectedUpLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.UP_AND_SELECTED]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.UP_AND_SELECTED] = loc1;
            }
            return loc1;
        }

        public function set selectedUpLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.UP_AND_SELECTED]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.UP_AND_SELECTED] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectedDownLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DOWN_AND_SELECTED]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.DOWN_AND_SELECTED] = loc1;
            }
            return loc1;
        }

        public function set selectedDownLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DOWN_AND_SELECTED]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.DOWN_AND_SELECTED] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectedHoverLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.HOVER_AND_SELECTED]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.HOVER_AND_SELECTED] = loc1;
            }
            return loc1;
        }

        public function set selectedHoverLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.HOVER_AND_SELECTED]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.HOVER_AND_SELECTED] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectedDisabledLabelProperties():Object
        {
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED_AND_SELECTED]);
            if (!loc1) 
            {
                loc1 = new feathers.core.PropertyProxy(childProperties_onChange);
                this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED_AND_SELECTED] = loc1;
            }
            return loc1;
        }

        public function set selectedDisabledLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            var loc1:*=feathers.core.PropertyProxy(this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED_AND_SELECTED]);
            if (loc1) 
            {
                loc1.removeOnChangeCallback(childProperties_onChange);
            }
            this._stateToLabelProperties[feathers.controls.ButtonState.DISABLED_AND_SELECTED] = arg1;
            if (arg1) 
            {
                feathers.core.PropertyProxy(arg1).addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshSelectionEvents():void
        {
            this.tapToSelect.isEnabled = this._isEnabled && this._isToggle;
            this.tapToSelect.tapToDeselect = this._isToggle;
            this.keyToSelect.isEnabled = this._isEnabled && this._isToggle;
            this.keyToSelect.keyToDeselect = this._isToggle;
            return;
        }

        public function get defaultSelectedIcon():starling.display.DisplayObject
        {
            return this._defaultSelectedIcon;
        }

        public function set defaultSelectedIcon(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._defaultSelectedIcon === arg1) 
            {
                return;
            }
            if (!(this._defaultSelectedIcon === null) && this.currentIcon === this._defaultSelectedIcon) 
            {
                this.removeCurrentIcon(this._defaultSelectedIcon);
                this.currentIcon = null;
            }
            this._defaultSelectedIcon = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get selectedUpIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.UP_AND_SELECTED);
        }

        public function set selectedUpIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.ButtonState.UP_AND_SELECTED, arg1);
            return;
        }

        public function get selectedDownIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.DOWN_AND_SELECTED);
        }

        public function set selectedDownIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, arg1);
            return;
        }

        public function get selectedHoverIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.HOVER_AND_SELECTED);
        }

        public function set selectedHoverIcon(arg1:starling.display.DisplayObject):void
        {
            this.setIconForState(feathers.controls.ButtonState.HOVER_AND_SELECTED, arg1);
            return;
        }

        public function get selectedDisabledIcon():starling.display.DisplayObject
        {
            return this.getIconForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED);
        }

        public static const STATE_UP:String="up";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_UP_AND_SELECTED:String="upAndSelected";

        public static const STATE_DOWN_AND_SELECTED:String="downAndSelected";

        public static const STATE_HOVER_AND_SELECTED:String="hoverAndSelected";

        public static const STATE_DISABLED_AND_SELECTED:String="disabledAndSelected";

        public static const ICON_POSITION_TOP:String="top";

        public static const ICON_POSITION_RIGHT:String="right";

        public static const ICON_POSITION_BOTTOM:String="bottom";

        public static const ICON_POSITION_LEFT:String="left";

        public static const ICON_POSITION_MANUAL:String="manual";

        public static const ICON_POSITION_LEFT_BASELINE:String="leftBaseline";

        public static const ICON_POSITION_RIGHT_BASELINE:String="rightBaseline";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        protected var tapToSelect:feathers.utils.touch.TapToSelect;

        protected var keyToSelect:feathers.utils.keyboard.KeyToSelect;

        protected var _isToggle:Boolean=true;

        protected var _isSelected:Boolean=false;

        protected var _toggleGroup:feathers.core.ToggleGroup;

        protected var _defaultSelectedSkin:starling.display.DisplayObject;

        protected var _defaultSelectedLabelProperties:feathers.core.PropertyProxy;

        protected var _defaultSelectedIcon:starling.display.DisplayObject;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


