//class ActivityValueComp
package frontend.screen.activities.component 
{
    import core.general.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
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
    import frontend.components.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class ActivityValueComp extends feathers.controls.LayoutGroup implements feathers.binding.IBindingClient
    {
        public function ActivityValueComp()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1852194636ROW_HEIGHT = 100 * SIGMALink.scaleFactor;
            this._102102gap = 10 * SIGMALink.scaleFactor;
            this._806339567padding = 10 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._ActivityValueComp_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_activities_component_ActivityValueCompWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return ActivityValueComp[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.mxmlContent = [this._ActivityValueComp_LayoutGroup2_i()];
            this._ActivityValueComp_AnchorLayoutData1_i();
            this._ActivityValueComp_AnchorLayoutData3_i();
            this._ActivityValueComp_AnchorLayoutData2_i();
            this.addEventListener("initialize", this.___ActivityValueComp_LayoutGroup1_initialize);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function ___ActivityValueComp_LayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        internal function _ActivityValueComp_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "this.backgroundSkin")
            result[1] = new feathers.binding.Binding(this, null, null, "this.height", "ROW_HEIGHT");
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "this.width")
            result[3] = new feathers.binding.Binding(this, null, null, "iconAndLabelLayout.left", "padding");
            result[4] = new feathers.binding.Binding(this, function ():Number
            {
                return COL_UNIT_WIDTH + padding;
            }, null, "valueLayout.right")
            result[5] = new feathers.binding.Binding(this, null, null, "unitLayout.right", "padding");
            result[6] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_LayoutGroup2.height", "ROW_HEIGHT");
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_ActivityValueComp_LayoutGroup2.width")
            result[8] = new feathers.binding.Binding(this, null, null, "iconAndLabelGroup.layoutData", "iconAndLabelLayout");
            result[9] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout1.gap", "gap");
            result[10] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout1.paddingLeft", "padding");
            result[11] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout1.verticalAlign")
            result[12] = new feathers.binding.Binding(this, null, null, "valueGroup.layoutData", "valueLayout");
            result[13] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout2.gap", "gap");
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.RIGHT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout2.horizontalAlign")
            result[15] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout2.paddingRight", "padding");
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout2.verticalAlign")
            result[17] = new feathers.binding.Binding(this, null, null, "unitGroup.layoutData", "unitLayout");
            result[18] = new feathers.binding.Binding(this, function ():Number
            {
                return COL_UNIT_WIDTH;
            }, null, "unitGroup.width")
            result[19] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout3.gap", "gap");
            result[20] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.HorizontalAlign.LEFT;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout3.horizontalAlign")
            result[21] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout3.paddingLeft", "padding");
            result[22] = new feathers.binding.Binding(this, null, null, "_ActivityValueComp_HorizontalLayout3.paddingRight", "padding");
            result[23] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.layout.VerticalAlign.MIDDLE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_ActivityValueComp_HorizontalLayout3.verticalAlign")
            return result;
        }

        public function get iconAndLabelGroup():feathers.controls.LayoutGroup
        {
            return this._1856091433iconAndLabelGroup;
        }

        public function set iconAndLabelGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1856091433iconAndLabelGroup;
            if (loc1 !== arg1) 
            {
                this._1856091433iconAndLabelGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconAndLabelGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconAndLabelLayout():feathers.layout.AnchorLayoutData
        {
            return this._1831997888iconAndLabelLayout;
        }

        public function set iconAndLabelLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1831997888iconAndLabelLayout;
            if (loc1 !== arg1) 
            {
                this._1831997888iconAndLabelLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconAndLabelLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityValueComp_HorizontalLayout1_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivityValueComp_HorizontalLayout1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_HorizontalLayout1", this._ActivityValueComp_HorizontalLayout1);
            return loc1;
        }

        public function get unitGroup():feathers.controls.LayoutGroup
        {
            return this._494502053unitGroup;
        }

        public function set unitGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._494502053unitGroup;
            if (loc1 !== arg1) 
            {
                this._494502053unitGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get unitLayout():feathers.layout.AnchorLayoutData
        {
            return this._1978043854unitLayout;
        }

        public function set unitLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1978043854unitLayout;
            if (loc1 !== arg1) 
            {
                this._1978043854unitLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unitLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get valueGroup():feathers.controls.LayoutGroup
        {
            return this._2021110670valueGroup;
        }

        public function set valueGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2021110670valueGroup;
            if (loc1 !== arg1) 
            {
                this._2021110670valueGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "valueGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get valueLayout():feathers.layout.AnchorLayoutData
        {
            return this._1642340357valueLayout;
        }

        public function set valueLayout(arg1:feathers.layout.AnchorLayoutData):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1642340357valueLayout;
            if (loc1 !== arg1) 
            {
                this._1642340357valueLayout = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "valueLayout", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get ROW_HEIGHT():uint
        {
            return this._1852194636ROW_HEIGHT;
        }

        public function get gap():Number
        {
            return this._102102gap;
        }

        public function set gap(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._102102gap;
            if (loc1 !== arg1) 
            {
                this._102102gap = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "gap", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get padding():Number
        {
            return this._806339567padding;
        }

        public function set padding(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._806339567padding;
            if (loc1 !== arg1) 
            {
                this._806339567padding = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "padding", loc1, arg1, this);
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
            ActivityValueComp._watcherSetupUtil = arg1;
            return;
        }

        public function setValue(arg1:Object, arg2:utils.converter.IConverter=null, arg3:utils.interfaces.ICustomFormatterBase=null):void
        {
            if (arg2) 
            {
                if (arg3) 
                {
                    this.value = arg3.format(arg2.convert(arg1));
                }
                else 
                {
                    this.value = arg2.convert(arg1);
                }
            }
            else if (arg3) 
            {
                this.value = arg3.format(arg1);
            }
            else 
            {
                this.value = arg1;
            }
            return;
        }

        protected function onInit(arg1:starling.events.Event):void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (this.iconSource) 
            {
                loc3 = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this.iconSource));
                this.iconAndLabelGroup.addChild(loc3);
            }
            if (this.iconText) 
            {
                loc4 = new frontend.components.LangLabel();
                loc4.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
                loc4.text = this.iconText;
                this.iconAndLabelGroup.addChild(loc4);
            }
            if (this.iconTextTranslated) 
            {
                loc5 = new feathers.controls.Label();
                loc5.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_BIGLISTLABEL;
                loc5.text = this.iconTextTranslated;
                this.iconAndLabelGroup.addChild(loc5);
            }
            if (this.valueIconSource != null) 
            {
                loc6 = new starling.display.Image(frontend.AssetsManagerCustom.getInstance().getTexture(this.valueIconSource));
                this.valueGroup.addChild(loc6);
            }
            var loc1:*=new feathers.controls.Label();
            loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            loc1.text = this.value as String;
            this.valueGroup.addChild(loc1);
            var loc2:*=new feathers.controls.Label();
            loc2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            loc2.width = COL_UNIT_WIDTH;
            loc2.text = this.unit;
            loc2.addEventListener(starling.events.TouchEvent.TOUCH, this.onUnitLabelTouch);
            this.unitGroup.addChild(loc2);
            return;
        }

        internal function onUnitLabelTouch(arg1:starling.events.TouchEvent):void
        {
            if (!handler.TouchHandler.isTouch(arg1)) 
            {
                return;
            }
            if (this.clickCallback != null) 
            {
                this.clickCallback();
            }
            return;
        }

        internal function _ActivityValueComp_AnchorLayoutData1_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.bottom = 0;
            loc1.top = 0;
            this.iconAndLabelLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconAndLabelLayout", this.iconAndLabelLayout);
            return loc1;
        }

        internal function _ActivityValueComp_AnchorLayoutData3_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.bottom = 0;
            loc1.top = 0;
            this.unitLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "unitLayout", this.unitLayout);
            return loc1;
        }

        internal function _ActivityValueComp_AnchorLayoutData2_i():feathers.layout.AnchorLayoutData
        {
            var loc1:*=new feathers.layout.AnchorLayoutData();
            loc1.bottom = 0;
            loc1.top = 0;
            this.valueLayout = loc1;
            feathers.binding.BindingManager.executeBindings(this, "valueLayout", this.valueLayout);
            return loc1;
        }

        internal function _ActivityValueComp_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_AnchorLayout1_c();
            loc1.mxmlContent = [this._ActivityValueComp_LayoutGroup3_i(), this._ActivityValueComp_LayoutGroup4_i(), this._ActivityValueComp_LayoutGroup5_i()];
            loc1.id = "_ActivityValueComp_LayoutGroup2";
            this._ActivityValueComp_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_LayoutGroup2", this._ActivityValueComp_LayoutGroup2);
            return loc1;
        }

        internal function _ActivityValueComp_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _ActivityValueComp_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_HorizontalLayout1_i();
            loc1.id = "iconAndLabelGroup";
            this.iconAndLabelGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconAndLabelGroup", this.iconAndLabelGroup);
            return loc1;
        }

        public function set ROW_HEIGHT(arg1:uint):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1852194636ROW_HEIGHT;
            if (loc1 !== arg1) 
            {
                this._1852194636ROW_HEIGHT = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "ROW_HEIGHT", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _ActivityValueComp_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_HorizontalLayout2_i();
            loc1.id = "valueGroup";
            this.valueGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "valueGroup", this.valueGroup);
            return loc1;
        }

        internal function _ActivityValueComp_HorizontalLayout2_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivityValueComp_HorizontalLayout2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_HorizontalLayout2", this._ActivityValueComp_HorizontalLayout2);
            return loc1;
        }

        internal function _ActivityValueComp_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._ActivityValueComp_HorizontalLayout3_i();
            loc1.id = "unitGroup";
            this.unitGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "unitGroup", this.unitGroup);
            return loc1;
        }

        internal function _ActivityValueComp_HorizontalLayout3_i():feathers.layout.HorizontalLayout
        {
            var loc1:*=new feathers.layout.HorizontalLayout();
            this._ActivityValueComp_HorizontalLayout3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_ActivityValueComp_HorizontalLayout3", this._ActivityValueComp_HorizontalLayout3);
            return loc1;
        }

        internal static const COL_UNIT_WIDTH:uint=100 * SIGMALink.scaleFactor;

        public var _ActivityValueComp_HorizontalLayout1:feathers.layout.HorizontalLayout;

        public var _ActivityValueComp_HorizontalLayout2:feathers.layout.HorizontalLayout;

        public var _ActivityValueComp_HorizontalLayout3:feathers.layout.HorizontalLayout;

        public var _ActivityValueComp_LayoutGroup2:feathers.controls.LayoutGroup;

        internal var _1856091433iconAndLabelGroup:feathers.controls.LayoutGroup;

        internal var _1831997888iconAndLabelLayout:feathers.layout.AnchorLayoutData;

        internal var _1978043854unitLayout:feathers.layout.AnchorLayoutData;

        internal var _2021110670valueGroup:feathers.controls.LayoutGroup;

        internal var _1642340357valueLayout:feathers.layout.AnchorLayoutData;

        internal var _1852194636ROW_HEIGHT:uint;

        public var clickCallback:Function;

        internal var _102102gap:Number;

        public var iconSource:String;

        public var iconText:String;

        public var iconTextTranslated:String;

        internal var _806339567padding:Number;

        public var speedBasedValue:Number;

        public var unit:String;

        public var value:Object;

        public var valueIconSource:String;

        mx_internal var _watchers:Array;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        internal var _494502053unitGroup:feathers.controls.LayoutGroup;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


