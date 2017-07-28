//class MenuListItem
package frontend.components.menuList 
{
    import backend.utils.dbUtils.*;
    import configCache.*;
    import core.general.*;
    import debug.*;
    import feathers.binding.*;
    import feathers.controls.*;
    import feathers.data.*;
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
    import frontend.components.core.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.components.popup.*;
    import handler.*;
    import mx.core.*;
    import starling.animation.*;
    import starling.display.*;
    import starling.events.*;
    import starling.filters.*;
    import starling.text.*;
    import starling.textures.*;
    import starling.utils.*;
    import utils.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    use namespace mx_internal;
    
    public class MenuListItem extends frontend.components.core.TouchLayoutGroup implements feathers.binding.IBindingClient
    {
        public function MenuListItem()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._1761778276customBackgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this._2146088563itemWidth = SIGMALink.appWidth;
            this._229163114maxRightLabelWidth = SIGMALink.appWidth;
            this._1973788148minItemHeight = 65 * SIGMALink.scaleFactor;
            this._806339567padding = 20 * SIGMALink.scaleFactor;
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._MenuListItem_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_components_menuList_MenuListItemWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return frontend.components.menuList.MenuListItem[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.touchGroup = true;
            this.layout = this._MenuListItem_AnchorLayout1_c();
            this.mxmlContent = [this._MenuListItem_LayoutGroup1_i(), this._MenuListItem_LayoutGroup2_i(), this._MenuListItem_LayoutGroup3_i(), this._MenuListItem_TextureImage2_i(), this._MenuListItem_LayoutGroup4_i(), this._MenuListItem_LayoutGroup5_i()];
            this.addEventListener("initialize", this.___MenuListItem_TouchLayoutGroup1_initialize);
            this.addEventListener("touch", this.___MenuListItem_TouchLayoutGroup1_touch);
            this.addEventListener("triggered", this.___MenuListItem_TouchLayoutGroup1_triggered);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        public function get leftLabel():feathers.controls.Label
        {
            return this._1723849517leftLabel;
        }

        public function set leftLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1723849517leftLabel;
            if (loc1 !== arg1) 
            {
                this._1723849517leftLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftLablGroup():feathers.controls.LayoutGroup
        {
            return this._166888697leftLablGroup;
        }

        public function set leftLablGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._166888697leftLablGroup;
            if (loc1 !== arg1) 
            {
                this._166888697leftLablGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftLablGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftSubLabel():feathers.controls.Label
        {
            return this._138659259leftSubLabel;
        }

        public function set leftSubLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._138659259leftSubLabel;
            if (loc1 !== arg1) 
            {
                this._138659259leftSubLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftSubLabel2():feathers.controls.Label
        {
            return this._3469783leftSubLabel2;
        }

        public function set leftSubLabel2(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3469783leftSubLabel2;
            if (loc1 !== arg1) 
            {
                this._3469783leftSubLabel2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabel2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get rightGroup():feathers.controls.LayoutGroup
        {
            return this._1409862205rightGroup;
        }

        public function set rightGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1409862205rightGroup;
            if (loc1 !== arg1) 
            {
                this._1409862205rightGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "rightGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get rightLabel():feathers.controls.Label
        {
            return this._1405764040rightLabel;
        }

        public function set rightLabel(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1405764040rightLabel;
            if (loc1 !== arg1) 
            {
                this._1405764040rightLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "rightLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get selector():feathers.controls.LayoutGroup
        {
            return this._1191572447selector;
        }

        public function set selector(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1191572447selector;
            if (loc1 !== arg1) 
            {
                this._1191572447selector = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selector", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get toggleBtn():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            return this._942316136toggleBtn;
        }

        public function set toggleBtn(arg1:frontend.components.menuList.editors.base.OnOffToggleButton):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._942316136toggleBtn;
            if (loc1 !== arg1) 
            {
                this._942316136toggleBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "toggleBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get checkable():Boolean
        {
            return this._398964322checkable;
        }

        public function set checkable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._398964322checkable;
            if (loc1 !== arg1) 
            {
                this._398964322checkable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "checkable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get checked():Boolean
        {
            return this._742313895checked;
        }

        public function set checked(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._742313895checked;
            if (loc1 !== arg1) 
            {
                this._742313895checked = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "checked", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get clickCallback():Function
        {
            return this._134069779clickCallback;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        internal function set _339742651dataProvider(arg1:feathers.data.ListCollection):void
        {
            this._dataProvider = arg1;
            if (this._dataProvider == null) 
            {
                this.hasDataProvider = false;
            }
            else 
            {
                this.hasDataProvider = true;
            }
            return;
        }

        public function set clickCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._134069779clickCallback;
            if (loc1 !== arg1) 
            {
                this._134069779clickCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "clickCallback", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get customBackgroundSkin():starling.display.Quad
        {
            return this._1761778276customBackgroundSkin;
        }

        public function set customBackgroundSkin(arg1:starling.display.Quad):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1761778276customBackgroundSkin;
            if (loc1 !== arg1) 
            {
                this._1761778276customBackgroundSkin = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "customBackgroundSkin", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.editor != null) 
            {
                this.editor.maxChars = this.maxChars;
            }
            return;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.dataProvider;
            if (loc1 !== arg1) 
            {
                this._339742651dataProvider = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "dataProvider", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get displayText():Boolean
        {
            return this._1714331919displayText;
        }

        public function get editable():Boolean
        {
            return this._editable;
        }

        internal function set _1602416228editable(arg1:Boolean):void
        {
            this._editable = arg1;
            if (this.editIcon) 
            {
                var loc1:*;
                this.editIcon.includeInLayout = loc1 = this.editable && !this.selectMode && !(this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
                this.editIcon.visible = loc1;
            }
            return;
        }

        public function set displayText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1714331919displayText;
            if (loc1 !== arg1) 
            {
                this._1714331919displayText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "displayText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set editable(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.editable;
            if (loc1 !== arg1) 
            {
                this._1602416228editable = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editable", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set functionButtonLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.functionButtonLabel;
            if (loc1 !== arg1) 
            {
                this._1158351894functionButtonLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "functionButtonLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get functionButtonLabel():String
        {
            return this._functionButtonLabel;
        }

        internal function set _1158351894functionButtonLabel(arg1:String):void
        {
            if (this._functionButtonLabel != arg1) 
            {
                this._functionButtonLabel = arg1;
                if (this._initialized) 
                {
                    this._functionBtnText = this._useLocalesForText ? utils.LanguageManager.getString(this.functionButtonLabel) : this.functionButtonLabel;
                }
            }
            return;
        }

        public function get functionButtonVisible():Boolean
        {
            return this._249692184functionButtonVisible;
        }

        public function set functionButtonVisible(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._249692184functionButtonVisible;
            if (loc1 !== arg1) 
            {
                this._249692184functionButtonVisible = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "functionButtonVisible", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get hasTouchEvents():Boolean
        {
            return this._1186943550hasTouchEvents;
        }

        public function set hasTouchEvents(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1186943550hasTouchEvents;
            if (loc1 !== arg1) 
            {
                this._1186943550hasTouchEvents = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hasTouchEvents", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconTexture():String
        {
            return this._iconTexture;
        }

        internal function set _2057836958iconTexture(arg1:String):void
        {
            this._iconTexture = arg1;
            if (this._iconTexture == null) 
            {
                this.iconGroup.removeChild(this.icon);
                this.icon = null;
                this.hasIcon = false;
            }
            else if (this.icon) 
            {
                this.icon.source = frontend.AssetsManagerCustom.getInstance().getTexture(this._iconTexture);
            }
            else 
            {
                this.icon = new feathers.controls.ImageLoader();
                this.icon.source = frontend.AssetsManagerCustom.getInstance().getTexture(this._iconTexture);
                this.iconGroup.addChildAt(this.icon, 0);
                this.hasIcon = true;
            }
            this.validateSizesAndPositions();
            return;
        }

        public function set iconTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.iconTexture;
            if (loc1 !== arg1) 
            {
                this._2057836958iconTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get isSelected():Boolean
        {
            return this._398301669isSelected;
        }

        public function set isSelected(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._398301669isSelected;
            if (loc1 !== arg1) 
            {
                this._398301669isSelected = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "isSelected", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get itemWidth():Number
        {
            return this._2146088563itemWidth;
        }

        public function get leftSubLabelText():String
        {
            return this._leftSubLabelText;
        }

        internal function set _290204040leftSubLabelText(arg1:String):void
        {
            if (this._leftSubLabelText != arg1) 
            {
                this._leftSubLabelText = arg1;
                this._displaySubText = this.leftSubLabelText.length > 0;
            }
            return;
        }

        public function set itemWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._2146088563itemWidth;
            if (loc1 !== arg1) 
            {
                this._2146088563itemWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "itemWidth", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get leftSubLabelText2():String
        {
            return this._leftSubLabelText2;
        }

        internal function set _406390698leftSubLabelText2(arg1:String):void
        {
            if (this._leftSubLabelText2 != arg1) 
            {
                this._leftSubLabelText2 = arg1;
                this._displaySubText2 = this.leftSubLabelText2.length > 0;
            }
            return;
        }

        public function set leftSubLabelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.leftSubLabelText;
            if (loc1 !== arg1) 
            {
                this._290204040leftSubLabelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        public function set leftSubLabelText2(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.leftSubLabelText2;
            if (loc1 !== arg1) 
            {
                this._406390698leftSubLabelText2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "leftSubLabelText2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get maxRightLabelWidth():Number
        {
            return this._229163114maxRightLabelWidth;
        }

        public function set maxRightLabelWidth(arg1:Number):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._229163114maxRightLabelWidth;
            if (loc1 !== arg1) 
            {
                this._229163114maxRightLabelWidth = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "maxRightLabelWidth", loc1, arg1, this);
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

        public function get preClickCallback():Function
        {
            return this._139960310preClickCallback;
        }

        public function set preClickCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._139960310preClickCallback;
            if (loc1 !== arg1) 
            {
                this._139960310preClickCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "preClickCallback", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get saveCompleteCallback():Function
        {
            return this._346085435saveCompleteCallback;
        }

        public function set saveCompleteCallback(arg1:Function):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._346085435saveCompleteCallback;
            if (loc1 !== arg1) 
            {
                this._346085435saveCompleteCallback = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "saveCompleteCallback", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set selectMode(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.selectMode;
            if (loc1 !== arg1) 
            {
                this._1656159041selectMode = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "selectMode", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set text(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.text;
            if (loc1 !== arg1) 
            {
                this._3556653text = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "text", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get selectMode():Boolean
        {
            return this._selectMode;
        }

        internal function set _1656159041selectMode(arg1:Boolean):void
        {
            this._selectMode = arg1;
            this.validateSizesAndPositions();
            return;
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

        public function get text():String
        {
            return this._text;
        }

        internal function set _3556653text(arg1:String):void
        {
            if (this._text != arg1) 
            {
                this._text = arg1;
                if (this._initialized) 
                {
                    this._leftLabelText = this.useLocalesForText ? utils.LanguageManager.getString(arg1) : arg1;
                }
            }
            return;
        }

        public function get type():String
        {
            return this._3575610type;
        }

        public function set type(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._3575610type;
            if (loc1 !== arg1) 
            {
                this._3575610type = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "type", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function set useLocalesForText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.useLocalesForText;
            if (loc1 !== arg1) 
            {
                this._173316252useLocalesForText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "useLocalesForText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get useLocalesForTitle():Boolean
        {
            return this._1077721343useLocalesForTitle;
        }

        public function set useLocalesForTitle(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1077721343useLocalesForTitle;
            if (loc1 !== arg1) 
            {
                this._1077721343useLocalesForTitle = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "useLocalesForTitle", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get useLocalesForText():Boolean
        {
            return this._useLocalesForText;
        }

        internal function set _173316252useLocalesForText(arg1:Boolean):void
        {
            if (this._useLocalesForText != arg1) 
            {
                this._useLocalesForText = arg1;
                if (this._initialized) 
                {
                    this._leftLabelText = this._useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text;
                    this._functionBtnText = this._useLocalesForText ? utils.LanguageManager.getString(this.functionButtonLabel) : this.functionButtonLabel;
                }
            }
            return;
        }

        internal function get _displaySubText():Boolean
        {
            return this._1238976138_displaySubText;
        }

        internal function set _displaySubText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1238976138_displaySubText;
            if (loc1 !== arg1) 
            {
                this._1238976138_displaySubText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_displaySubText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get value():Object
        {
            return this._value;
        }

        public function set value(arg1:Object):void
        {
            if (arg1 == null || arg1 is String && arg1 === "") 
            {
                if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT || this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING) 
                {
                    arg1 = this.defaultValues;
                }
                else if (this.type != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD) 
                {
                    if (this.defaultValue != null) 
                    {
                        arg1 = this.defaultValue;
                    }
                }
                else if (arg1 == null) 
                {
                    arg1 = this.defaultValue;
                }
            }
            this._value = arg1;
            this.format(this._value);
            return;
        }

        internal function _MenuListItem_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "iconGroup";
            this.iconGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "iconGroup", this.iconGroup);
            return loc1;
        }

        internal function get _displaySubText2():Boolean
        {
            return this._246445336_displaySubText2;
        }

        internal function set _displaySubText2(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._246445336_displaySubText2;
            if (loc1 !== arg1) 
            {
                this._246445336_displaySubText2 = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_displaySubText2", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _functionBtnText():String
        {
            return this._949723250_functionBtnText;
        }

        internal function set _functionBtnText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._949723250_functionBtnText;
            if (loc1 !== arg1) 
            {
                this._949723250_functionBtnText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_functionBtnText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _leftLabelText():String
        {
            return this._783677445_leftLabelText;
        }

        internal function set _leftLabelText(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._783677445_leftLabelText;
            if (loc1 !== arg1) 
            {
                this._783677445_leftLabelText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_leftLabelText", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get formattedValue():String
        {
            return this._1695807979formattedValue;
        }

        internal function set formattedValue(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1695807979formattedValue;
            if (loc1 !== arg1) 
            {
                this._1695807979formattedValue = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "formattedValue", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get hasChild():Boolean
        {
            return this._114623138hasChild;
        }

        internal function set hasChild(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._114623138hasChild;
            if (loc1 !== arg1) 
            {
                this._114623138hasChild = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hasChild", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get hasIcon():Boolean
        {
            return this._696608307hasIcon;
        }

        internal function set hasIcon(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._696608307hasIcon;
            if (loc1 !== arg1) 
            {
                this._696608307hasIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "hasIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get showValue():Boolean
        {
            return this._1912202124showValue;
        }

        internal function set showValue(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1912202124showValue;
            if (loc1 !== arg1) 
            {
                this._1912202124showValue = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "showValue", loc1, arg1, this);
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
            frontend.components.menuList.MenuListItem._watcherSetupUtil = arg1;
            return;
        }

        protected override function changeState(arg1:String):void
        {
            super.changeState(arg1);
            if (this.showDownStateSkin) 
            {
                if (currentState == STATE_DOWN && this.editable) 
                {
                    backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
                }
                else 
                {
                    backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
                }
            }
            return;
        }

        internal function format(arg1:Object):void
        {
            var loc1:*=this.converter ? this.converter.convert(arg1) : arg1;
            if (this.formatter == null) 
            {
                if (this.dataProvider) 
                {
                    this.formattedValue = this.getValueFromDataProvider(loc1.toString());
                }
                else 
                {
                    this.formattedValue = loc1.toString();
                }
            }
            else if (arg1.hasOwnProperty("start") && arg1.hasOwnProperty("end")) 
            {
                this.formattedValue = this.formatter.format(arg1.start) + " - " + this.formatter.format(arg1.end);
            }
            else 
            {
                this.formattedValue = this.formatter.format(loc1) as String;
            }
            if (this.unitString != "") 
            {
                this.formattedValue = this.formattedValue + (" " + this.unitString);
            }
            return;
        }

        protected function triggeredHandler(arg1:starling.events.Event):void
        {
            if (!this.hasTouchEvents) 
            {
                return;
            }
            if (this.selectMode) 
            {
                this.isSelected = !this.isSelected;
                return;
            }
            debug.Debug.debug("MenuItem clicked " + (this.useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text));
            if (this.type == null) 
            {
                debug.Debug.error("Kein MenuItem-Typ (type) definiert: Abbruch!");
                return;
            }
            var loc1:*=this.type;
            switch (loc1) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU:
                {
                    if (this.destination == null) 
                    {
                        return;
                    }
                    handler.ViewHandler.getInstance().showScreen(this.destination, this.destinationObject, handler.ViewHandler.slideToLeftTransition());
                    return;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK:
                {
                    if (this.clickCallback != null) 
                    {
                        this.clickCallback();
                        return;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                {
                    this.onToggleChanged(!this.checked);
                    return;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON:
                {
                    if (this.functionButtonCallback != null) 
                    {
                        this.functionButtonCallback();
                    }
                    break;
                }
            }
            if (this.editable) 
            {
                this.showEditor();
            }
            return;
        }

        public function showEditor():void
        {
            if (!this.editorClass) 
            {
                this.editorClass = frontend.components.menuList.editors.base.EditorClasses.getEditor(this.type);
            }
            this.editor = new this.editorClass();
            this.editor.unitString = this.unitString;
            var loc1:*=this.type;
            switch (loc1) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_UNIT_SELECTOR:
                {
                    this.editor.dataProvider = this.dataProvider;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER:
                {
                    this.editor.converter = this.converter;
                    this.editor.formatter = this.formatter;
                    this.editor.minimum = this.minimum;
                    this.editor.maximum = this.maximum;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE:
                {
                    this.editor.formatter = this.formatter;
                    this.editor.minimum = this.minimum;
                    this.editor.maximum = this.maximum;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE:
                {
                    this.editor.formatter = this.formatter;
                    this.editor.minimumDifference = this.minimumDifference;
                    this.editor.minimum = this.minimum;
                    this.editor.maximum = this.maximum;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME:
                {
                    this.editor.formatter = this.formatter;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA:
                {
                    this.editor.maxChars = this.maxChars;
                    break;
                }
            }
            this.editor.owner = this;
            this.editor.rawValue = this.value;
            this.editor.title = this.useLocalesForTitle ? utils.LanguageManager.getString(this.title) : this.title;
            this.editor.saveCompleteCallback = this.saveCompleteCallback;
            frontend.components.popup.PopUpBase.showModalPopUp(this.editor, true, (this.editor as frontend.components.menuList.editors.base.EditorBase).useTween);
            return;
        }

        public function validateSizesAndPositions():void
        {
            this.rightGroup_resizeHandler();
            this.rightLabel.maxWidth = this.itemWidth - this.leftLabel.width - 2 * this.padding - (this._selectMode ? editGroupWidth : 0) - this.padding;
            if (this.displayText) 
            {
                this.rightLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, this.padding, NaN, NaN, NaN, 0);
            }
            else 
            {
                this.rightLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, this.padding, NaN, (this._selectMode ? editGroupWidth : 0) + this.padding, NaN, 0);
            }
            var loc1:*;
            this.editIcon.includeInLayout = loc1 = this.editable && !this.selectMode && !(this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE);
            this.editIcon.visible = loc1;
            return;
        }

        public function onInit(arg1:starling.events.Event=null):void
        {
            var loc1:*=null;
            this._initialized = true;
            if (this.text.length > 0) 
            {
                this._leftLabelText = this._useLocalesForText ? utils.LanguageManager.getString(this.text) : this.text;
            }
            if (this.functionButtonLabel.length > 0) 
            {
                this._functionBtnText = this._useLocalesForText ? utils.LanguageManager.getString(this.functionButtonLabel) : this.functionButtonLabel;
            }
            this.validateSizesAndPositions();
            var loc2:*=this.type;
            switch (loc2) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SUBMENU:
                {
                    this.hasChild = true;
                    this.showValue = false;
                    this.editable = false;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CLICK_CALLBACK:
                {
                    this.editable = false;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RADIO:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CHECKBOX_MULTI:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE:
                {
                    if (this.useConfigCache && !(this.configCacheAttribute == "")) 
                    {
                        loc1 = configCache.ConfigCache.getInstance().getValue(this.configCacheAttribute, "");
                    }
                    else 
                    {
                        loc1 = this.defaultValue;
                    }
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING) 
                    {
                        this.showValue = false;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME:
                {
                    loc1 = this.defaultValue;
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT) 
                    {
                        this.showValue = false;
                    }
                    if (this.type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME) 
                    {
                        this.showValue = false;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_UNIT_SELECTOR:
                {
                    loc1 = this.defaultValue;
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    this.showValue = false;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING:
                {
                    loc1 = this.defaultValues;
                    if (loc1 != null) 
                    {
                        this.value = loc1;
                    }
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                {
                    this.hasChild = false;
                    this.showValue = false;
                    if (this.useConfigCache && !(this.configCacheAttribute == "")) 
                    {
                        loc1 = configCache.ConfigCache.getInstance().getValue(this.configCacheAttribute, this.defaultValue as Boolean) as Boolean;
                    }
                    else 
                    {
                        loc1 = this.defaultValue as Boolean;
                    }
                    if (loc1 != null) 
                    {
                        this.checked = loc2 = loc1;
                        this.value = loc2;
                    }
                    break;
                }
                default:
                {
                    this.hasChild = false;
                    this.showValue = false;
                    this.editable = false;
                    break;
                }
            }
            return;
        }

        internal function getValueFromDataProvider(arg1:String):String
        {
            var loc1:*=0;
            var loc2:*="";
            if (this.dataProvider) 
            {
                loc1 = 0;
                while (loc1 < this.dataProvider.data.length) 
                {
                    if (this.dataProvider.data[loc1].data.toString() == arg1) 
                    {
                        loc2 = this.dataProvider.data[loc1].label;
                        this.selectedIndex = loc1;
                        return loc2;
                    }
                    ++loc1;
                }
            }
            return loc2;
        }

        internal function onToggleChanged(arg1:Boolean):void
        {
            if (!this.editable) 
            {
                return;
            }
            debug.Debug.debug("onToggleChanged: " + arg1);
            this.checked = arg1;
            var loc1:*=new frontend.components.menuList.editors.base.EditorReturnObject();
            loc1.rawValue = this.checked;
            loc1.dispatchCompleteEvent = true;
            this.handleReturnValue(loc1);
            if (this.saveCompleteCallback != null) 
            {
                this.saveCompleteCallback(this, loc1);
            }
            return;
        }

        public function handleReturnValue(arg1:frontend.components.menuList.editors.base.EditorReturnObject=null):void
        {
            var p_editorReturnObject:frontend.components.menuList.editors.base.EditorReturnObject=null;
            var onInsertComplete:Function;
            var onInsertError:Function;

            var loc1:*;
            p_editorReturnObject = arg1;
            if (p_editorReturnObject == null) 
            {
                return;
            }
            var loc2:*=this.type;
            switch (loc2) 
            {
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD:
                {
                    this.value = p_editorReturnObject.rawValue as String;
                    break;
                }
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RADIO:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CHECKBOX_MULTI:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE:
                case frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE:
                {
                    this.value = p_editorReturnObject.rawValue;
                    break;
                }
            }
            if (this.useConfigCache && !(this.configCacheAttribute == "")) 
            {
                configCache.ConfigCache.getInstance().setValue(this.configCacheAttribute, this.value);
                if (p_editorReturnObject.dispatchCompleteEvent) 
                {
                    dispatchEvent(new starling.events.Event("completeEvent"));
                }
            }
            else if (this.saveToDbUseUpdate && !(this.saveToDbUseUpdateObject == null)) 
            {
                onInsertComplete = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                {
                    if (saveToDbUseUpdateObject.completeCallback != null) 
                    {
                        saveToDbUseUpdateObject.completeCallback(value);
                    }
                    if (p_editorReturnObject.dispatchCompleteEvent) 
                    {
                        dispatchEvent(new starling.events.Event("completeEvent"));
                    }
                    return;
                }
                onInsertError = function (arg1:backend.utils.dbUtils.DBUtilEvent):void
                {
                    if (saveToDbUseUpdateObject.errorCallback != null) 
                    {
                        saveToDbUseUpdateObject.errorCallback(value);
                    }
                    return;
                }
                if (this.type != frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE) 
                {
                    if (p_editorReturnObject.rawValue is core.general.TireSize) 
                    {
                        this.saveToDbUseUpdateObject.updateValue = p_editorReturnObject.rawValue.data;
                    }
                    else 
                    {
                        this.saveToDbUseUpdateObject.updateValue = p_editorReturnObject.rawValue;
                    }
                }
                else 
                {
                    this.saveToDbUseUpdateObject.updateValue = p_editorReturnObject.rawValue.start;
                    this.saveToDbUseUpdateObject.updateValue2 = p_editorReturnObject.rawValue.end;
                }
                backend.utils.dbUtils.DBUtil.getInstance().call(flash.data.SQLMode.UPDATE, this.saveToDbUseUpdateObject.getSqlUpdateStatement(), onInsertComplete, onInsertError, null, null, this.saveToDbUseUpdateObject.getParams());
            }
            else 
            {
                dispatchEvent(new starling.events.Event("completeEvent"));
            }
            return;
        }

        protected function rightGroup_resizeHandler(arg1:starling.events.Event=null):void
        {
            if (this.leftLabelAlignTop) 
            {
                this.leftLablGroup.layoutData = new feathers.layout.AnchorLayoutData(this.padding, this.rightGroup.width + this.padding, NaN, this.hasIcon ? this.ICON_GROUP_WIDTH + 2 * this.padding : this.padding);
            }
            else 
            {
                this.leftLablGroup.layoutData = new feathers.layout.AnchorLayoutData(NaN, this.rightGroup.width + this.padding, NaN, this.hasIcon ? this.ICON_GROUP_WIDTH + 2 * this.padding : this.padding, NaN, 0);
            }
            this.leftLablGroup.validate();
            this.leftLabel.maxWidth = this.itemWidth - (this._selectMode ? editGroupWidth : 0) - this.padding - this.rightGroup.width;
            this.leftLabel.validate();
            this.leftSubLabel.maxWidth = this.itemWidth - (this._selectMode ? editGroupWidth : 0) - this.padding - this.rightGroup.width;
            this.leftSubLabel.validate();
            this.leftSubLabel2.maxWidth = this.itemWidth - (this._selectMode ? editGroupWidth : 0) - this.padding - this.rightGroup.width;
            this.leftSubLabel2.validate();
            return;
        }

        internal function _MenuListItem_AnchorLayout1_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        public function set customLayoutContent(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1777226238customLayoutContent;
            if (loc1 !== arg1) 
            {
                this._1777226238customLayoutContent = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "customLayoutContent", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _MenuListItem_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MenuListItem_VerticalLayout1_c();
            loc1.mxmlContent = [this._MenuListItem_Label1_i(), this._MenuListItem_Label2_i(), this._MenuListItem_Label3_i()];
            loc1.id = "leftLablGroup";
            this.leftLablGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftLablGroup", this.leftLablGroup);
            return loc1;
        }

        internal function _MenuListItem_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 2;
            return loc1;
        }

        internal function _MenuListItem_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "leftLabel";
            this.leftLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftLabel", this.leftLabel);
            return loc1;
        }

        internal function _MenuListItem_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "leftSubLabel";
            this.leftSubLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftSubLabel", this.leftSubLabel);
            return loc1;
        }

        internal function _MenuListItem_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "leftSubLabel2";
            this.leftSubLabel2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "leftSubLabel2", this.leftSubLabel2);
            return loc1;
        }

        internal function _MenuListItem_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MenuListItem_AnchorLayout2_c();
            loc1.mxmlContent = [this._MenuListItem_TextureImage1_i(), this._MenuListItem_Label4_i(), this._MenuListItem_OnOffToggleButton1_i(), this._MenuListItem_Button1_i()];
            loc1.addEventListener("resize", this.__rightGroup_resize);
            loc1.id = "rightGroup";
            this.rightGroup = loc1;
            feathers.binding.BindingManager.executeBindings(this, "rightGroup", this.rightGroup);
            return loc1;
        }

        internal function _MenuListItem_AnchorLayout2_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _MenuListItem_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.touchable = false;
            loc1.id = "_MenuListItem_TextureImage1";
            this._MenuListItem_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MenuListItem_TextureImage1", this._MenuListItem_TextureImage1);
            return loc1;
        }

        internal function _MenuListItem_Label4_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "rightLabel";
            this.rightLabel = loc1;
            feathers.binding.BindingManager.executeBindings(this, "rightLabel", this.rightLabel);
            return loc1;
        }

        internal function _MenuListItem_OnOffToggleButton1_i():frontend.components.menuList.editors.base.OnOffToggleButton
        {
            var loc1:*=new frontend.components.menuList.editors.base.OnOffToggleButton();
            loc1.id = "toggleBtn";
            this.toggleBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "toggleBtn", this.toggleBtn);
            return loc1;
        }

        internal function _MenuListItem_Button1_i():feathers.controls.Button
        {
            var loc1:*=new feathers.controls.Button();
            loc1.id = "functionBtn";
            this.functionBtn = loc1;
            feathers.binding.BindingManager.executeBindings(this, "functionBtn", this.functionBtn);
            return loc1;
        }

        public function __rightGroup_resize(arg1:starling.events.Event):void
        {
            this.rightGroup_resizeHandler(arg1);
            return;
        }

        internal function _MenuListItem_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "editIcon";
            this.editIcon = loc1;
            feathers.binding.BindingManager.executeBindings(this, "editIcon", this.editIcon);
            return loc1;
        }

        internal function _MenuListItem_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._MenuListItem_AnchorLayout3_c();
            loc1.mxmlContent = [this._MenuListItem_Check1_i()];
            loc1.id = "selector";
            this.selector = loc1;
            feathers.binding.BindingManager.executeBindings(this, "selector", this.selector);
            return loc1;
        }

        internal function _MenuListItem_AnchorLayout3_c():feathers.layout.AnchorLayout
        {
            var loc1:*=new feathers.layout.AnchorLayout();
            return loc1;
        }

        internal function _MenuListItem_Check1_i():feathers.controls.Check
        {
            var loc1:*=new feathers.controls.Check();
            loc1.hasLabelTextRenderer = false;
            loc1.verticalAlign = "middle";
            loc1.id = "_MenuListItem_Check1";
            this._MenuListItem_Check1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_MenuListItem_Check1", this._MenuListItem_Check1);
            return loc1;
        }

        internal function _MenuListItem_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.includeInLayout = false;
            loc1.visible = false;
            loc1.id = "customLayoutContent";
            this.customLayoutContent = loc1;
            feathers.binding.BindingManager.executeBindings(this, "customLayoutContent", this.customLayoutContent);
            return loc1;
        }

        public function ___MenuListItem_TouchLayoutGroup1_initialize(arg1:starling.events.Event):void
        {
            this.onInit(arg1);
            return;
        }

        public function ___MenuListItem_TouchLayoutGroup1_touch(arg1:starling.events.TouchEvent):void
        {
            touchHandler(arg1);
            return;
        }

        public function ___MenuListItem_TouchLayoutGroup1_triggered(arg1:starling.events.Event):void
        {
            this.triggeredHandler(arg1);
            return;
        }

        internal function _MenuListItem_bindingsSetup():Array
        {
            var result:Array;

            var loc1:*;
            result = [];
            result[0] = new feathers.binding.Binding(this, null, null, "this.backgroundSkin", "customBackgroundSkin");
            result[1] = new feathers.binding.Binding(this, null, null, "this.minHeight", "minItemHeight");
            result[2] = new feathers.binding.Binding(this, null, null, "this.width", "itemWidth");
            result[3] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasIcon;
            }, null, "iconGroup.includeInLayout")
            result[4] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            }, null, "iconGroup.layoutData")
            result[5] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasIcon;
            }, null, "iconGroup.visible")
            result[6] = new feathers.binding.Binding(this, function ():Number
            {
                return ICON_GROUP_WIDTH;
            }, null, "iconGroup.width")
            result[7] = new feathers.binding.Binding(this, null, null, "leftLabel.includeInLayout", "displayText");
            result[8] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftLabel.styleName")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_leftLabelText;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftLabel.text")
            result[10] = new feathers.binding.Binding(this, null, null, "leftLabel.visible", "displayText");
            result[11] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText;
            }, null, "leftSubLabel.includeInLayout")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftSubLabel.styleName")
            result[13] = new feathers.binding.Binding(this, null, null, "leftSubLabel.text", "leftSubLabelText");
            result[14] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText;
            }, null, "leftSubLabel.visible")
            result[15] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText2;
            }, null, "leftSubLabel2.includeInLayout")
            result[16] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "leftSubLabel2.styleName")
            result[17] = new feathers.binding.Binding(this, null, null, "leftSubLabel2.text", "leftSubLabelText2");
            result[18] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _displaySubText2;
            }, null, "leftSubLabel2.visible")
            result[19] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            }, null, "rightGroup.layoutData")
            result[20] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasChild;
            }, null, "_MenuListItem_TextureImage1.includeInLayout")
            result[21] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            }, null, "_MenuListItem_TextureImage1.layoutData")
            result[22] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.pfeilmitbg;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_MenuListItem_TextureImage1.textureName")
            result[23] = new feathers.binding.Binding(this, function ():Boolean
            {
                return hasChild;
            }, null, "_MenuListItem_TextureImage1.visible")
            result[24] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showValue;
            }, null, "rightLabel.includeInLayout")
            result[25] = new feathers.binding.Binding(this, null, null, "rightLabel.isEnabled", "editable");
            result[26] = new feathers.binding.Binding(this, null, null, "rightLabel.maxWidth", "maxRightLabelWidth");
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUVALUE;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "rightLabel.styleName")
            result[28] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=formattedValue;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "rightLabel.text")
            result[29] = new feathers.binding.Binding(this, function ():Boolean
            {
                return showValue;
            }, null, "rightLabel.visible")
            result[30] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA;
            }, null, "rightLabel.wordWrap")
            result[31] = new feathers.binding.Binding(this, null, null, "toggleBtn.checked", "checked");
            result[32] = new feathers.binding.Binding(this, null, null, "toggleBtn.editable", "editable");
            result[33] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
            }, null, "toggleBtn.includeInLayout")
            result[34] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, 0, NaN, NaN, NaN, 0);
            }, null, "toggleBtn.layoutData")
            result[35] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TOGGLE;
            }, null, "toggleBtn.visible")
            result[36] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON == functionButtonVisible == true;
            }, null, "functionBtn.includeInLayout")
            result[37] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_functionBtnText;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "functionBtn.label")
            result[38] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, padding, NaN, NaN, NaN, 0);
            }, null, "functionBtn.layoutData")
            result[39] = new feathers.binding.Binding(this, function ():Boolean
            {
                return type == frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_BUTTON == functionButtonVisible == true;
            }, null, "functionBtn.visible")
            result[40] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(1, 1);
            }, null, "editIcon.layoutData")
            result[41] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.linkiconsmall;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "editIcon.textureName")
            result[42] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.MIDGREY);
            }, null, "selector.backgroundSkin")
            result[43] = new feathers.binding.Binding(this, null, null, "selector.height", "minItemHeight");
            result[44] = new feathers.binding.Binding(this, null, null, "selector.includeInLayout", "selectMode");
            result[45] = new feathers.binding.Binding(this, null, null, "selector.visible", "selectMode");
            result[46] = new feathers.binding.Binding(this, function ():Number
            {
                return editGroupWidth;
            }, null, "selector.width")
            result[47] = new feathers.binding.Binding(this, null, null, "_MenuListItem_Check1.isSelected", "isSelected");
            result[48] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, padding, NaN, 0);
            }, null, "_MenuListItem_Check1.layoutData")
            result[49] = new feathers.binding.Binding(this, null, null, "customLayoutContent.minHeight", "minItemHeight");
            return result;
        }

        public function get customLayoutContent():feathers.controls.LayoutGroup
        {
            return this._1777226238customLayoutContent;
        }

        public function get editIcon():frontend.components.TextureImage
        {
            return this._1601702307editIcon;
        }

        public function set editIcon(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1601702307editIcon;
            if (loc1 !== arg1) 
            {
                this._1601702307editIcon = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "editIcon", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get functionBtn():feathers.controls.Button
        {
            return this._1946492060functionBtn;
        }

        public function set functionBtn(arg1:feathers.controls.Button):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1946492060functionBtn;
            if (loc1 !== arg1) 
            {
                this._1946492060functionBtn = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "functionBtn", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get iconGroup():feathers.controls.LayoutGroup
        {
            return this._1412649594iconGroup;
        }

        public function set iconGroup(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1412649594iconGroup;
            if (loc1 !== arg1) 
            {
                this._1412649594iconGroup = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "iconGroup", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal const ICON_GROUP_WIDTH:Number=50 * SIGMALink.scaleFactor;

        internal static const editGroupWidth:Number=75 * SIGMALink.scaleFactor;

        internal var _1777226238customLayoutContent:feathers.controls.LayoutGroup;

        internal var _1601702307editIcon:frontend.components.TextureImage;

        internal var _1946492060functionBtn:feathers.controls.Button;

        internal var _1412649594iconGroup:feathers.controls.LayoutGroup;

        internal var _1723849517leftLabel:feathers.controls.Label;

        internal var _166888697leftLablGroup:feathers.controls.LayoutGroup;

        internal var _138659259leftSubLabel:feathers.controls.Label;

        internal var _3469783leftSubLabel2:feathers.controls.Label;

        internal var _1409862205rightGroup:feathers.controls.LayoutGroup;

        internal var _1405764040rightLabel:feathers.controls.Label;

        internal var _1191572447selector:feathers.controls.LayoutGroup;

        internal var _942316136toggleBtn:frontend.components.menuList.editors.base.OnOffToggleButton;

        internal var _398964322checkable:Boolean=false;

        internal var _742313895checked:Boolean=false;

        internal var _134069779clickCallback:Function;

        public var configCacheAttribute:String;

        public var converter:utils.converter.IConverter;

        internal var _1761778276customBackgroundSkin:starling.display.Quad;

        internal var _dataProvider:feathers.data.ListCollection;

        public var defaultValue:Object;

        public var defaultValues:Array;

        public var destination:String;

        internal var _1714331919displayText:Boolean=true;

        internal var _editable:Boolean=false;

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var functionButtonCallback:Function;

        internal var _functionButtonLabel:String="";

        internal var _249692184functionButtonVisible:Boolean=true;

        internal var _1186943550hasTouchEvents:Boolean=true;

        public var helperObject:Object;

        internal var _iconTexture:String;

        internal var _398301669isSelected:Boolean=false;

        internal var _2146088563itemWidth:Number;

        public var leftLabelAlignTop:Boolean=false;

        internal var _leftSubLabelText:String="";

        internal var _leftSubLabelText2:String="";

        internal var _maxChars:uint=0;

        public var destinationObject:Object;

        internal var _229163114maxRightLabelWidth:Number;

        public var maximum:Number;

        internal var _1973788148minItemHeight:Number;

        public var minimum:Number;

        public var minimumDifference:Number=1;

        public var onChanged:Function;

        internal var _806339567padding:Number;

        internal var _139960310preClickCallback:Function;

        internal var _346085435saveCompleteCallback:Function;

        public var saveToDbUseUpdate:Boolean=false;

        public var saveToDbUseUpdateObject:frontend.components.menuList.MenuListDbObject;

        internal var _selectMode:Boolean=false;

        public var showDownStateSkin:Boolean=true;

        internal var _text:String="";

        internal var _110371416title:String="";

        internal var _3575610type:String;

        public var unitString:String="";

        public var useConfigCache:Boolean=false;

        internal var _useLocalesForText:Boolean=true;

        internal var _1077721343useLocalesForTitle:Boolean=true;

        internal var _value:Object;

        internal var _1238976138_displaySubText:Boolean=false;

        internal var _246445336_displaySubText2:Boolean=false;

        internal var _949723250_functionBtnText:String="";

        internal var _initialized:Boolean=false;

        internal var _783677445_leftLabelText:String="";

        internal var _moving:Boolean=false;

        internal var editor:*;

        internal var editorClass:*;

        internal var _1695807979formattedValue:String="";

        internal var _114623138hasChild:Boolean=false;

        internal var hasDataProvider:Boolean=false;

        internal var _696608307hasIcon:Boolean=false;

        internal var icon:feathers.controls.ImageLoader;

        internal var selectedIndex:uint;

        internal var _1912202124showValue:Boolean=true;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        public var _MenuListItem_Check1:feathers.controls.Check;

        mx_internal var _watchers:Array;

        public var _MenuListItem_TextureImage1:frontend.components.TextureImage;

        mx_internal var _bindingsByDestination:Object;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


