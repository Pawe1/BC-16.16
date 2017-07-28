//class AddDeviceSetName
package frontend.screen.mydevices 
{
    import backend.utils.dbUtils.*;
    import core.general.*;
    import core.units.*;
    import core.units.interfaces.*;
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
    import frontend.components.button.*;
    import frontend.components.core.*;
    import frontend.components.menuList.*;
    import frontend.screen.component.*;
    import frontend.screen.component.devices.*;
    import handler.*;
    import helper.*;
    import mx.core.*;
    import service.*;
    import service.cloud.*;
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
    
    public class AddDeviceSetName extends frontend.screen.component.CustomScreen implements feathers.binding.IBindingClient
    {
        public function AddDeviceSetName()
        {
            var bindings:Array;
            var watchers:Array;
            var target:Object;
            var i:uint;
            var watcherSetupUtilClass:Object;

            var loc1:*;
            target = null;
            watcherSetupUtilClass = null;
            this._275390105_infoLabel = utils.LanguageManager.getString("ADDDEVICE.INFOTEXT_DEVICE_ADDED");
            this.mx_internal::_bindings = [];
            this.mx_internal::_watchers = [];
            this.mx_internal::_bindingsByDestination = {};
            this.mx_internal::_bindingsBeginWithWord = {};
            super();
            bindings = this._AddDeviceSetName_bindingsSetup();
            watchers = [];
            target = this;
            if (_watcherSetupUtil == null) 
            {
                watcherSetupUtilClass = flash.utils.getDefinitionByName("_frontend_screen_mydevices_AddDeviceSetNameWatcherSetupUtil");
                var loc2:*;
                (loc2 = watcherSetupUtilClass)["init"]();
            }
            _watcherSetupUtil.setup(this, function (arg1:String):*
            {
                return target[arg1];
            }, function (arg1:String):*
            {
                return AddDeviceSetName[arg1];
            }, bindings, watchers)
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            this.allowCaching = false;
            this.hasBackwardNavigation = false;
            this.mxmlContent = [this._AddDeviceSetName_LayoutGroup1_i(), this._AddDeviceSetName_Footer1_i()];
            this.addEventListener("addedToStage", this.___AddDeviceSetName_CustomScreen1_addedToStage);
            this.addEventListener("removedFromStage", this.___AddDeviceSetName_CustomScreen1_removedFromStage);
            i = 0;
            while (i < bindings.length) 
            {
                feathers.binding.Binding(bindings[i]).execute();
                ++i;
            }
            return;
        }

        internal function _AddDeviceSetName_LayoutGroup5_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._AddDeviceSetName_LayoutGroup6_i()];
            loc1.id = "_AddDeviceSetName_LayoutGroup5";
            this._AddDeviceSetName_LayoutGroup5 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_LayoutGroup5", this._AddDeviceSetName_LayoutGroup5);
            return loc1;
        }

        internal function _AddDeviceSetName_LayoutGroup6_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.id = "loader";
            this.loader = loc1;
            feathers.binding.BindingManager.executeBindings(this, "loader", this.loader);
            return loc1;
        }

        internal function _AddDeviceSetName_Footer1_i():frontend.screen.component.Footer
        {
            var loc1:*=new frontend.screen.component.Footer();
            loc1.forceRightButton = true;
            loc1.showBackButton = false;
            loc1.mxmlContent = [this._AddDeviceSetName_IconButton1_i()];
            loc1.id = "footer";
            this.footer = loc1;
            feathers.binding.BindingManager.executeBindings(this, "footer", this.footer);
            return loc1;
        }

        internal function _AddDeviceSetName_IconButton1_i():frontend.components.button.IconButton
        {
            var loc1:*=new frontend.components.button.IconButton();
            loc1.isEnabled = false;
            loc1.id = "_AddDeviceSetName_IconButton1";
            this._AddDeviceSetName_IconButton1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_IconButton1", this._AddDeviceSetName_IconButton1);
            return loc1;
        }

        public function ___AddDeviceSetName_CustomScreen1_addedToStage(arg1:starling.events.Event):void
        {
            this.onAddetToStage(arg1);
            return;
        }

        public function ___AddDeviceSetName_CustomScreen1_removedFromStage(arg1:starling.events.Event):void
        {
            this.onRemovedFromStage(arg1);
            return;
        }

        internal function _AddDeviceSetName_bindingsSetup():Array
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
                var loc1:*=utils.LanguageManager.getString("DEVICES.ADD_DEVICE");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "this.title")
            result[2] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.containerHeight;
            }, null, "_AddDeviceSetName_LayoutGroup1.height")
            result[3] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AddDeviceSetName_LayoutGroup1.width")
            result[4] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_AddDeviceSetName_LayoutGroup2.backgroundSkin")
            result[5] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.ROW_HEIGHT;
            }, null, "_AddDeviceSetName_LayoutGroup2.height")
            result[6] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_AddDeviceSetName_LayoutGroup2.layout")
            result[7] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AddDeviceSetName_LayoutGroup2.width")
            result[8] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ICON_PADDING_LEFT, NaN, 0);
            }, null, "_AddDeviceSetName_TextureImage1.layoutData")
            result[9] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_deviceTexture;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_TextureImage1.textureName")
            result[10] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.VerticalLayout();
            }, null, "_AddDeviceSetName_LayoutGroup3.layout")
            result[11] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NAME_PADDING_LEFT, NaN, 0);
            }, null, "_AddDeviceSetName_LayoutGroup3.layoutData")
            result[12] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_Label1.styleName")
            result[13] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_deviceName;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_Label1.text")
            result[14] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUSUBITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_Label2.styleName")
            result[15] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=_infoLabel;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_Label2.text")
            result[16] = new feathers.binding.Binding(this, function ():Object
            {
                return unit.externalName;
            }, null, "_AddDeviceSetName_MenuListItem1.defaultValue")
            result[17] = new feathers.binding.Binding(this, function ():Number
            {
                return frontend.components.menuList.MenuList.SMALLER_ROW_HEIGHT;
            }, null, "_AddDeviceSetName_MenuListItem1.minItemHeight")
            result[18] = new feathers.binding.Binding(this, function ():frontend.components.menuList.MenuListDbObject
            {
                return _saveNameObj;
            }, null, "_AddDeviceSetName_MenuListItem1.saveToDbUseUpdateObject")
            result[19] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_MenuListItem1.type")
            result[20] = new feathers.binding.Binding(this, function ():Number
            {
                return 75 * SIGMALink.scaleFactor;
            }, null, "_AddDeviceSetName_Spacer1.height")
            result[21] = new feathers.binding.Binding(this, function ():starling.display.DisplayObject
            {
                return new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }, null, "_AddDeviceSetName_LayoutGroup4.backgroundSkin")
            result[22] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showConfirmPairingText;
            }, null, "_AddDeviceSetName_LayoutGroup4.includeInLayout")
            result[23] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_AddDeviceSetName_LayoutGroup4.layout")
            result[24] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showConfirmPairingText;
            }, null, "_AddDeviceSetName_LayoutGroup4.visible")
            result[25] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AddDeviceSetName_LayoutGroup4.width")
            result[26] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, ICON_PADDING_LEFT, 0, 0);
            }, null, "attentionImage.layoutData")
            result[27] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.attentionbig;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "attentionImage.textureName")
            result[28] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, ICON_PADDING_LEFT, NaN, INFO_TEXT_LEFT, 0, 0);
            }, null, "infoText.layoutData")
            result[29] = new feathers.binding.Binding(this, function ():Number
            {
                return 20 * SIGMALink.scaleFactor;
            }, null, "infoText.padding")
            result[30] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=feathers.themes.CustomSIGMATheme.TEXT_STYLE_MENUITEM;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "infoText.styleName")
            result[31] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=utils.LanguageManager.getString("PLEASE_CONFIRM_PAIRING_REQUEST");
                return loc1 != undefined ? String(loc1) : null;
            }, null, "infoText.text")
            result[32] = new feathers.binding.Binding(this, function ():Number
            {
                return INFO_TEXT_WIDTH;
            }, null, "infoText.width")
            result[33] = new feathers.binding.Binding(this, function ():Number
            {
                return 75 * SIGMALink.scaleFactor;
            }, null, "_AddDeviceSetName_Spacer2.height")
            result[34] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showConfirmPairingText;
            }, null, "_AddDeviceSetName_LayoutGroup5.includeInLayout")
            result[35] = new feathers.binding.Binding(this, function ():feathers.layout.ILayout
            {
                return new feathers.layout.AnchorLayout();
            }, null, "_AddDeviceSetName_LayoutGroup5.layout")
            result[36] = new feathers.binding.Binding(this, function ():Boolean
            {
                return _showConfirmPairingText;
            }, null, "_AddDeviceSetName_LayoutGroup5.visible")
            result[37] = new feathers.binding.Binding(this, function ():Number
            {
                return SIGMALink.appWidth;
            }, null, "_AddDeviceSetName_LayoutGroup5.width")
            result[38] = new feathers.binding.Binding(this, function ():feathers.layout.ILayoutData
            {
                return new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            }, null, "loader.layoutData")
            result[39] = new feathers.binding.Binding(this, function ():String
            {
                var loc1:*=frontend.Textures.saveiconwhite;
                return loc1 != undefined ? String(loc1) : null;
            }, null, "_AddDeviceSetName_IconButton1.image")
            result[40] = new feathers.binding.Binding(this, function ():Function
            {
                return nextStepSaveUnit;
            }, null, "_AddDeviceSetName_IconButton1.touchHandler")
            return result;
        }

        public function get attentionImage():frontend.components.TextureImage
        {
            return this._1422826205attentionImage;
        }

        public function set attentionImage(arg1:frontend.components.TextureImage):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1422826205attentionImage;
            if (loc1 !== arg1) 
            {
                this._1422826205attentionImage = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "attentionImage", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        public function get footer():frontend.screen.component.Footer
        {
            return this._1268861541footer;
        }

        public function set footer(arg1:frontend.screen.component.Footer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1268861541footer;
            if (loc1 !== arg1) 
            {
                this._1268861541footer = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "footer", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _AddDeviceSetName_TextureImage1_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "_AddDeviceSetName_TextureImage1";
            this._AddDeviceSetName_TextureImage1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_TextureImage1", this._AddDeviceSetName_TextureImage1);
            return loc1;
        }

        public function get infoText():feathers.controls.Label
        {
            return this._177936123infoText;
        }

        public function set infoText(arg1:feathers.controls.Label):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._177936123infoText;
            if (loc1 !== arg1) 
            {
                this._177936123infoText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "infoText", loc1, arg1, this);
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

        public function set unit(arg1:core.units.Unit):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this.unit;
            if (loc1 !== arg1) 
            {
                this._3594628unit = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "unit", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _deviceName():String
        {
            return this._1869301664_deviceName;
        }

        public function get unit():core.units.Unit
        {
            return this._unit;
        }

        internal function set _3594628unit(arg1:core.units.Unit):void
        {
            this._unit = arg1;
            this._deviceName = arg1.externalName;
            this._infoLabel = utils.LanguageManager.getString("ADDDEVICE.INFOTEXT_DEVICE_ADDED").replace("##DEVICENAME##", this.unit.type.getLabel());
            this._deviceTexture = frontend.Textures.getUnitTexture(arg1.type);
            this._showConfirmPairingText = this.unitUseBlePairingWithResponse && handler.CommunicationHandling.getInstance().waitForPairingRequest && handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_BLE;
            this.validateDBObjects();
            return;
        }

        internal function set _deviceName(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1869301664_deviceName;
            if (loc1 !== arg1) 
            {
                this._1869301664_deviceName = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_deviceName", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _deviceTexture():String
        {
            return this._975205350_deviceTexture;
        }

        internal function set _deviceTexture(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._975205350_deviceTexture;
            if (loc1 !== arg1) 
            {
                this._975205350_deviceTexture = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_deviceTexture", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _infoLabel():String
        {
            return this._275390105_infoLabel;
        }

        internal function get _saveNameObj():frontend.components.menuList.MenuListDbObject
        {
            return this._1790552176_saveNameObj;
        }

        internal function set _saveNameObj(arg1:frontend.components.menuList.MenuListDbObject):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._1790552176_saveNameObj;
            if (loc1 !== arg1) 
            {
                this._1790552176_saveNameObj = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_saveNameObj", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function get _showConfirmPairingText():Boolean
        {
            return this._41598513_showConfirmPairingText;
        }

        internal function set _showConfirmPairingText(arg1:Boolean):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._41598513_showConfirmPairingText;
            if (loc1 !== arg1) 
            {
                this._41598513_showConfirmPairingText = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_showConfirmPairingText", loc1, arg1, this);
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
            AddDeviceSetName._watcherSetupUtil = arg1;
            return;
        }

        internal function get unitUseBlePairingWithResponse():Boolean
        {
            return this.unit && this.unit is core.units.interfaces.IBLEDeviceInfo && !(this.unit is core.units.interfaces.IBLESimplePairing);
        }

        protected function onRemovedFromStage(arg1:starling.events.Event):void
        {
            handler.CommunicationHandling.getInstance().stopCommunication();
            if (this.unitUseBlePairingWithResponse) 
            {
                if (helper.Capabilities_helper.isIOS()) 
                {
                    flash.desktop.NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, this.onActivate);
                    flash.desktop.NativeApplication.nativeApplication.removeEventListener(flash.events.Event.DEACTIVATE, this.onDeactivate);
                    handler.CommunicationHandling.getInstance().removeEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onDeviceNotPairedIos);
                    flash.utils.clearTimeout(this._onDevicePairedTimer);
                }
                else 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.DeviceCommunicationHandler.EVENT_BLE_DEVICE_PAIRED, this.onDevicePaired);
                    handler.DeviceCommunicationHandlerLink.getInstance().removeEventListener(service.DeviceCommunicationHandler.EVENT_BLE_DEVICE_NOT_PAIRED, this.onDeviceNotPairedAndroid);
                }
            }
            if (!this._saveUnit) 
            {
                this.unit.isDeleted = true;
                this.unit.modificationDate = new Date().time;
                handler.AppDeviceHandler.getInstance().saveUnit(new backend.utils.dbUtils.DBUtilObject(this.unit, this.onDeleteUnitComplete, this.onDeleteUnitComplete, null, false));
            }
            return;
        }

        internal function validateDBObjects():void
        {
            this._saveNameObj = new frontend.components.menuList.MenuListDbObject();
            this._saveNameObj.keyField = "GUID";
            this._saveNameObj.keyValue = this.unit.GUID;
            this._saveNameObj.updateField = core.units.Unit.col_externalName;
            this._saveNameObj.table = core.units.Unit.table_name;
            this._saveNameObj.updateModificationDate = true;
            this._saveNameObj.completeCallback = this.onNameChanged;
            return;
        }

        internal function onNameChanged(arg1:Object):void
        {
            var loc1:*;
            this._deviceName = loc1 = arg1 as String;
            this.unit.externalName = loc1;
            this._infoLabel = utils.LanguageManager.getString("ADDDEVICE.INFOTEXT_DEVICE_ADDED").replace("##DEVICENAME##", this.unit.type.getLabel());
            return;
        }

        protected function onInfoTextBoxComplete(arg1:starling.events.Event):void
        {
            var loc1:*=40 * SIGMALink.scaleFactor;
            (arg1.currentTarget as feathers.controls.LayoutGroup).height = Math.max(this.infoText.height, this.attentionImage.height) + loc1;
            return;
        }

        internal function nextStepSaveUnit(arg1:starling.events.TouchEvent):void
        {
            this._saveUnit = true;
            handler.CommunicationHandling.getInstance().stopCommunication();
            handler.NotificationHandler.getInstance().showNotificationSettingsForUnit = this.unit;
            handler.NotificationHandler.getInstance().loadUnitsForNotifications();
            if (this.initialAppStart) 
            {
                hasBackwardNavigation = true;
                handler.ViewHandler.getInstance().goBack();
            }
            else 
            {
                handler.AppDeviceHandler.getInstance().dispatchEvent(new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.RELOAD));
                handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
                handler.ViewHandler.getInstance().showScreen(handler.ViewHandler.VIEW_DEVICE_VIEW, {"unit":this.unit}, handler.ViewHandler.slideToLeftTransition());
            }
            return;
        }

        protected function onAddetToStage(arg1:starling.events.Event):void
        {
            if (this.unitUseBlePairingWithResponse && handler.DeviceCommunicationHandlerLink.getInstance().connectionMode == service.DeviceCommunicationHandler.CONNECTION_MODE_BLE) 
            {
                this.addLoader();
                this.footer.buttonsEnabled = false;
                if (helper.Capabilities_helper.isIOS()) 
                {
                    this._bondingRequestShown = false;
                    flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, this.onActivate);
                    flash.desktop.NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, this.onDeactivate);
                }
                else 
                {
                    handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.DeviceCommunicationHandler.EVENT_BLE_DEVICE_PAIRED, this.onDevicePaired);
                    handler.DeviceCommunicationHandlerLink.getInstance().addEventListener(service.DeviceCommunicationHandler.EVENT_BLE_DEVICE_NOT_PAIRED, this.onDeviceNotPairedAndroid);
                }
            }
            else 
            {
                this.enableButtons();
            }
            return;
        }

        internal function onActivate(arg1:flash.events.Event):void
        {
            if (this._bondingRequestShown) 
            {
                handler.CommunicationHandling.getInstance().addEventListener(handler.CommunicationHandling.COMMUNICATION_ERROR, this.onDeviceNotPairedIos);
                this._onDevicePairedTimer = flash.utils.setTimeout(this.onDevicePaired, ENABLE_FOOTER_BUTTONS_DELAY);
            }
            return;
        }

        internal function onDeactivate(arg1:flash.events.Event):void
        {
            this._bondingRequestShown = true;
            flash.utils.clearTimeout(this._onDevicePairedTimer);
            return;
        }

        internal function onDevicePaired(arg1:flash.events.Event=null):void
        {
            this.attentionImage.textureName = frontend.Textures.bigok;
            this.loader.removeChildren();
            this.enableButtons();
            return;
        }

        internal function onDeviceNotPairedAndroid(arg1:flash.events.Event):void
        {
            this.deleteUnitAndGoBack();
            return;
        }

        internal function onDeviceNotPairedIos(arg1:starling.events.Event):void
        {
            flash.utils.clearTimeout(this._onDevicePairedTimer);
            this.deleteUnitAndGoBack();
            return;
        }

        internal function deleteUnitAndGoBack():void
        {
            this.unit.isDeleted = true;
            this.unit.modificationDate = new Date().time;
            handler.AppDeviceHandler.getInstance().saveUnit(new backend.utils.dbUtils.DBUtilObject(this.unit, this.onDeleteUnitComplete, this.onDeleteUnitComplete, null, true));
            return;
        }

        internal function onDeleteUnitComplete(arg1:backend.utils.dbUtils.DBUtilEvent):void
        {
            handler.AppDeviceHandler.getInstance().dispatchEvent(new frontend.screen.component.devices.DeviceListEvent(frontend.screen.component.devices.DeviceListEvent.RELOAD));
            handler.AppDeviceHandler.getInstance().dispatchEvent(new service.cloud.CloudEvent(service.cloud.CloudEvent.DATA_CHANGED));
            if (arg1.data == true) 
            {
                this.loader.removeChildren();
                hasBackwardNavigation = true;
                handler.ViewHandler.getInstance().goBack();
            }
            return;
        }

        internal function enableButtons():void
        {
            this.footer.buttonsEnabled = true;
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

        internal function _AddDeviceSetName_LayoutGroup1_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.layout = this._AddDeviceSetName_VerticalLayout1_c();
            loc1.mxmlContent = [this._AddDeviceSetName_LayoutGroup2_i(), this._AddDeviceSetName_MenuListItem1_i(), this._AddDeviceSetName_Spacer1_i(), this._AddDeviceSetName_LayoutGroup4_i(), this._AddDeviceSetName_Spacer2_i(), this._AddDeviceSetName_LayoutGroup5_i()];
            loc1.id = "_AddDeviceSetName_LayoutGroup1";
            this._AddDeviceSetName_LayoutGroup1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_LayoutGroup1", this._AddDeviceSetName_LayoutGroup1);
            return loc1;
        }

        internal function _AddDeviceSetName_VerticalLayout1_c():feathers.layout.VerticalLayout
        {
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.gap = 1;
            loc1.useVirtualLayout = true;
            return loc1;
        }

        internal function _AddDeviceSetName_LayoutGroup2_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._AddDeviceSetName_TextureImage1_i(), this._AddDeviceSetName_LayoutGroup3_i()];
            loc1.id = "_AddDeviceSetName_LayoutGroup2";
            this._AddDeviceSetName_LayoutGroup2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_LayoutGroup2", this._AddDeviceSetName_LayoutGroup2);
            return loc1;
        }

        internal function set _infoLabel(arg1:String):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=this._275390105_infoLabel;
            if (loc1 !== arg1) 
            {
                this._275390105_infoLabel = arg1;
                loc2 = feathers.events.PropertyChangeEventData.fromPool(feathers.events.PropertyChangeEventData.KIND_UPDATE, "_infoLabel", loc1, arg1, this);
                loc3 = starling.events.EventDispatcher(this);
                if (loc3.hasEventListener("propertyChange")) 
                {
                    loc3.dispatchEventWith("propertyChange", false, loc2);
                }
                feathers.events.PropertyChangeEventData.toPool(loc2);
            }
            return;
        }

        internal function _AddDeviceSetName_LayoutGroup3_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._AddDeviceSetName_Label1_i(), this._AddDeviceSetName_Label2_i()];
            loc1.id = "_AddDeviceSetName_LayoutGroup3";
            this._AddDeviceSetName_LayoutGroup3 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_LayoutGroup3", this._AddDeviceSetName_LayoutGroup3);
            return loc1;
        }

        internal function _AddDeviceSetName_Label1_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_AddDeviceSetName_Label1";
            this._AddDeviceSetName_Label1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_Label1", this._AddDeviceSetName_Label1);
            return loc1;
        }

        internal function _AddDeviceSetName_Label2_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.id = "_AddDeviceSetName_Label2";
            this._AddDeviceSetName_Label2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_Label2", this._AddDeviceSetName_Label2);
            return loc1;
        }

        internal function _AddDeviceSetName_MenuListItem1_i():frontend.components.menuList.MenuListItem
        {
            var loc1:*=new frontend.components.menuList.MenuListItem();
            loc1.editable = true;
            loc1.saveToDbUseUpdate = true;
            loc1.text = "DEVICE_SETTING.EXTERNAL_NAME";
            loc1.title = "DEVICE_SETTING.EXTERNAL_NAMEE";
            loc1.useConfigCache = false;
            loc1.useLocalesForText = true;
            loc1.useLocalesForTitle = true;
            loc1.id = "_AddDeviceSetName_MenuListItem1";
            this._AddDeviceSetName_MenuListItem1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_MenuListItem1", this._AddDeviceSetName_MenuListItem1);
            return loc1;
        }

        internal function _AddDeviceSetName_Spacer1_i():frontend.components.core.Spacer
        {
            var loc1:*=new frontend.components.core.Spacer();
            loc1.id = "_AddDeviceSetName_Spacer1";
            this._AddDeviceSetName_Spacer1 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_Spacer1", this._AddDeviceSetName_Spacer1);
            return loc1;
        }

        internal function _AddDeviceSetName_LayoutGroup4_i():feathers.controls.LayoutGroup
        {
            var loc1:*=new feathers.controls.LayoutGroup();
            loc1.mxmlContent = [this._AddDeviceSetName_TextureImage2_i(), this._AddDeviceSetName_Label3_i()];
            loc1.addEventListener("creationComplete", this.___AddDeviceSetName_LayoutGroup4_creationComplete);
            loc1.id = "_AddDeviceSetName_LayoutGroup4";
            this._AddDeviceSetName_LayoutGroup4 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_LayoutGroup4", this._AddDeviceSetName_LayoutGroup4);
            return loc1;
        }

        internal function _AddDeviceSetName_TextureImage2_i():frontend.components.TextureImage
        {
            var loc1:*=new frontend.components.TextureImage();
            loc1.id = "attentionImage";
            this.attentionImage = loc1;
            feathers.binding.BindingManager.executeBindings(this, "attentionImage", this.attentionImage);
            return loc1;
        }

        internal function _AddDeviceSetName_Label3_i():feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.wordWrap = true;
            loc1.id = "infoText";
            this.infoText = loc1;
            feathers.binding.BindingManager.executeBindings(this, "infoText", this.infoText);
            return loc1;
        }

        public function ___AddDeviceSetName_LayoutGroup4_creationComplete(arg1:starling.events.Event):void
        {
            this.onInfoTextBoxComplete(arg1);
            return;
        }

        internal function _AddDeviceSetName_Spacer2_i():frontend.components.core.Spacer
        {
            var loc1:*=new frontend.components.core.Spacer();
            loc1.id = "_AddDeviceSetName_Spacer2";
            this._AddDeviceSetName_Spacer2 = loc1;
            feathers.binding.BindingManager.executeBindings(this, "_AddDeviceSetName_Spacer2", this._AddDeviceSetName_Spacer2);
            return loc1;
        }

        internal static const ENABLE_FOOTER_BUTTONS_DELAY:uint=2000;

        internal static const ICON_PADDING_LEFT:Number=15 * SIGMALink.scaleFactor;

        internal static const INFO_IMAGE_WIDTH:uint=210 * SIGMALink.scaleFactor;

        internal static const INFO_TEXT_LEFT:Number=SIGMALink.appWidth - (SIGMALink.appWidth - INFO_IMAGE_WIDTH);

        internal static const INFO_TEXT_WIDTH:Number=SIGMALink.appWidth - INFO_IMAGE_WIDTH;

        internal static const NAME_PADDING_LEFT:Number=120 * SIGMALink.scaleFactor;

        public var _AddDeviceSetName_LayoutGroup4:feathers.controls.LayoutGroup;

        public var _AddDeviceSetName_LayoutGroup5:feathers.controls.LayoutGroup;

        public var _AddDeviceSetName_MenuListItem1:frontend.components.menuList.MenuListItem;

        public var _AddDeviceSetName_Spacer1:frontend.components.core.Spacer;

        public var _AddDeviceSetName_Spacer2:frontend.components.core.Spacer;

        internal var _1422826205attentionImage:frontend.components.TextureImage;

        internal var _1268861541footer:frontend.screen.component.Footer;

        internal var _177936123infoText:feathers.controls.Label;

        internal var _1097519085loader:feathers.controls.LayoutGroup;

        public var initialAppStart:Boolean=false;

        internal var _unit:core.units.Unit;

        internal var _bondingRequestShown:Boolean=false;

        internal var _1869301664_deviceName:String="";

        internal var _975205350_deviceTexture:String="unknown";

        internal var _275390105_infoLabel:String;

        internal var _onDevicePairedTimer:uint;

        internal var _1790552176_saveNameObj:frontend.components.menuList.MenuListDbObject;

        internal var _saveUnit:Boolean=false;

        internal var _41598513_showConfirmPairingText:Boolean=false;

        internal var movieClip:starling.display.MovieClip;

        mx_internal var _bindingsByDestination:Object;

        mx_internal var _bindingsBeginWithWord:Object;

        mx_internal var _bindings:Array;

        mx_internal var _watchers:Array;

        public var _AddDeviceSetName_IconButton1:frontend.components.button.IconButton;

        public var _AddDeviceSetName_Label1:feathers.controls.Label;

        public var _AddDeviceSetName_Label2:feathers.controls.Label;

        public var _AddDeviceSetName_LayoutGroup1:feathers.controls.LayoutGroup;

        public var _AddDeviceSetName_LayoutGroup2:feathers.controls.LayoutGroup;

        public var _AddDeviceSetName_LayoutGroup3:feathers.controls.LayoutGroup;

        public var _AddDeviceSetName_TextureImage1:frontend.components.TextureImage;

        internal static var _watcherSetupUtil:feathers.binding.IWatcherSetupUtil;
    }
}


