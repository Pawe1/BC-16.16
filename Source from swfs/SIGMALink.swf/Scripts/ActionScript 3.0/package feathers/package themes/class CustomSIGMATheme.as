//class CustomSIGMATheme
package feathers.themes 
{
    import feathers.controls.*;
    import feathers.controls.popups.*;
    import feathers.controls.text.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.system.*;
    import flash.text.engine.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class CustomSIGMATheme extends feathers.themes.BaseSIGMATheme
    {
        public function CustomSIGMATheme(arg1:Boolean=true)
        {
            super(arg1);
            return;
        }

        protected function setButtonLabelRedAlignRightStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.whiteButtonElementFormat;
            arg1.disabledElementFormat = this.disabledWhiteButtonElementFormat;
            arg1.textAlign = feathers.layout.HorizontalAlign.RIGHT;
            arg1.width = (arg1.stateContext as feathers.controls.Button).width - (arg1.stateContext as feathers.controls.Button).paddingLeft - (arg1.stateContext as feathers.controls.Button).paddingRight;
            return;
        }

        protected function setButtonLabelRedStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.whiteButtonElementFormat;
            arg1.disabledElementFormat = this.disabledWhiteButtonElementFormat;
            return;
        }

        protected override function setButtonLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.buttonElementFormat;
            arg1.disabledElementFormat = this.disabledButtonElementFormat;
            return;
        }

        protected function setSmallListLabelBoldStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.smallListLabelBoldElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledSmallListLabelElementFormat;
            return;
        }

        protected function setSmallListLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.smallListLabelElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledSmallListLabelElementFormat;
            return;
        }

        protected function setSmallWhiteLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.smallWhiteLabelElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledSmallWhiteLabelElementFormat;
            return;
        }

        protected function setBigListLabelItalicStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.bigListLabelItalicElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledBigListLabelItalicElementFormat;
            return;
        }

        protected function setBigListLabelWhiteStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.bigListLabelWhiteElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledBigListLabelWhiteElementFormat;
            return;
        }

        protected function setBigListLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.bigListLabelElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledBigListLabelElementFormat;
            return;
        }

        protected function setTextTabBarLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            arg1.selectedElementFormat = this.darkUIElementFormat;
            return;
        }

        protected override function initializeStyleProviders():void
        {
            super.initializeStyleProviders();
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(BUTTON_STYLE_REDBUTTON, this.setRedButtonStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(TEXT_STYLE_BUTTONLABEL_WHITE, this.setButtonLabelWhiteStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(BUTTON_STYLE_WHITEBUTTON, this.setWhiteButtonStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(TEXT_STYLE_BUTTONLABEL_RED, this.setButtonLabelRedStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(TEXT_STYLE_BUTTONLABEL_RED_ALIGN_RIGHT, this.setButtonLabelRedAlignRightStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_LIGHT, this.setLightLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NORMAL, this.setNormalLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NORMAL_RED, this.setNormalRedLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_MENUITEM, this.setMenuLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NUMBER, this.setNumberLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NUMBER_WHITE, this.setNumberWhiteLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NUMBER_SMALL, this.setNumberSmallLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_MENUVALUE, this.setMenuValueLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_MENUSUBITEM, this.setMenuSubLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NAVIITEM, this.setNaviLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_DASHBOARD_SHORTCUT_LABEL, this.setDashboardShortcutLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_DASHBOARD_SHORTCUT_VALUE, this.setDashboardShortcutValueStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_DASHBOARD_OPTION_TITLE, this.setDashboardOptionTitleStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_DASHBOARD_OPTION_TEXT, this.setDashboardOptionTextStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_BIGLISTLABEL, this.setBigListLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_BIGLISTLABEL_ITALIC, this.setBigListLabelItalicStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_BIGLISTLABEL_WHITE, this.setBigListLabelWhiteStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SMALLLISTLABEL, this.setSmallListLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SMALLLISTLABEL_BOLD, this.setSmallListLabelBoldStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SMALLWHITELABEL, this.setSmallWhiteLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_WHITELABEL, this.setWhiteLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_DARKLABEL, this.setDarkLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_WHITELABEL_ARIAL, this.setWhiteLabelArialStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_POPUP_TITLE, this.setPopupTitleStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_RED_POPUP_TITLE, this.setRedPopupTitleStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(EUROSTILE_WHITE_ITALIC, this.setEurostileWhiteItalicStyle);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_NORMAL_BOLD, this.setNormalBoldStyle);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_BRONZE, this.setBronzeLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SILVER, this.setSilverLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_GOLD, this.setGoldLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SLEEP_WAKE_UP, this.setSleepWakeUpLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SLEEP_WAKE_UP_SMALL, this.setSleepWakeUpSmallLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SLEEP_LIGHT, this.setSleepLightLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SLEEP_LIGHT_SMALL, this.setSleepLightSmallLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SLEEP_DEEP, this.setSleepDeepLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(TEXT_STYLE_SLEEP_DEEP_SMALL, this.setSleepDeepSmallLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(TABBAR_SELECTED_STYLE_TEXT, this.setSelectedTabStyle);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(TABBAR_NORMAL_STYLE_TEXT, this.setNormalTabStyle);
            return;
        }

        protected function setDashboardOptionTextStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.dashboardOptionTextElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledDashboardOptionTextElementFormat;
            return;
        }

        protected function setDashboardOptionTitleStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.dashboardOptionTitleElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledDashboardOptionTitleElementFormat;
            return;
        }

        protected function setDashboardShortcutValueStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.dashboardShortcutValueElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledDashboardShortcutValueElementFormat;
            return;
        }

        protected function setDashboardShortcutLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.dashboardShortcutElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledDashboardShortcutElementFormat;
            return;
        }

        protected function setNaviLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.naviElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNaviElementFormat;
            return;
        }

        protected function setMenuSubLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.menuSubElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledMenuSubElementFormat;
            return;
        }

        protected function setMenuValueLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.menuValueElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledMenuValueElementFormat;
            return;
        }

        protected function setNumberSmallLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.numberSmallElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNumberSmallElementFormat;
            arg1.textRendererProperties.textAlign = feathers.layout.HorizontalAlign.RIGHT;
            return;
        }

        protected function setNumberWhiteLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.numberWhiteElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNumberWhiteElementFormat;
            arg1.textRendererProperties.textAlign = feathers.layout.HorizontalAlign.RIGHT;
            return;
        }

        protected function setNumberLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.numberElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNumberElementFormat;
            arg1.textRendererProperties.textAlign = feathers.layout.HorizontalAlign.RIGHT;
            return;
        }

        protected function setNormalRedLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.normalFontRedFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontRedFormat;
            return;
        }

        protected function setSleepWakeUpLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.sleepWakeUpFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalBoldElementFormat;
            return;
        }

        protected function setSleepDeepSmallLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.sleepDeepSmallFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setSleepLightSmallLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.sleepLightSmallFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setSleepWakeUpSmallLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.sleepWakeUpSmallFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setSleepDeepLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.sleepDeepFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalBoldElementFormat;
            return;
        }

        protected function setButtonLabelWhiteStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.redButtonElementFormat;
            arg1.disabledElementFormat = this.disabledRedButtonElementFormat;
            return;
        }

        protected function setSleepLightLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.sleepLightFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalBoldElementFormat;
            return;
        }

        protected function setWhiteLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.whiteLabelElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledWhiteLabelElementFormat;
            return;
        }

        protected function setDarkLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.darkLabelElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledDarkLabelElementFormat;
            return;
        }

        protected function setWhiteLabelArialStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.whiteLabelArialElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledWhiteLabelArialElementFormat;
            return;
        }

        protected function setPopupTitleStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.popupTitleElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledPopupTitleElementFormat;
            return;
        }

        protected function setRedPopupTitleStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.redPopupTitleElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledRedPopupTitleElementFormat;
            return;
        }

        protected function setEurostileWhiteItalicStyle(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.eurostileWhiteItalicElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledEurostileWhiteItalicElementFormat;
            return;
        }

        protected function setNormalBoldStyle(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.normalBoldElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalBoldElementFormat;
            return;
        }

        public function loadScaledImage(arg1:String):starling.display.Image
        {
            if (!this.hasOwnProperty(arg1)) 
            {
                return null;
            }
            var loc1:*=new starling.display.Image(this[arg1]);
            loc1.scaleX = this.scale;
            loc1.scaleY = this.scale;
            return loc1;
        }

        protected override function initializeDimensions():void
        {
            if (isDeskop) 
            {
                this.gridSize = Math.round(48 * this.scale);
                this.smallGutterSize = Math.round(24 * this.scale);
                this.smallControlGutterSize = Math.round(15 * this.scale);
                this.gutterSize = Math.round(30 * this.scale);
                this.controlSize = Math.round(30 * this.scale);
                this.checkSize = Math.round(24 * this.scale);
                this.smallControlSize = Math.round(12 * this.scale);
                this.scrollBarGutterSize = Math.round(8 * this.scale);
                this.popUpFillSize = Math.round(1 * this.scale);
                this.calloutBackgroundMinSize = Math.round(1 * this.scale);
                this.wideControlSize = this.gridSize * 3 + this.gutterSize * 2;
                this.borderSize = Math.round(2 * this.scale);
            }
            else 
            {
                this.gridSize = Math.round(88 * this.scale);
                this.smallGutterSize = Math.round(11 * this.scale);
                this.gutterSize = Math.round(22 * this.scale);
                this.controlSize = Math.round(68 * this.scale);
                this.checkSize = Math.round(48 * this.scale);
                this.smallControlSize = Math.round(22 * this.scale);
                this.popUpFillSize = Math.round(552 * this.scale);
                this.calloutBackgroundMinSize = Math.round(11 * this.scale);
                this.scrollBarGutterSize = Math.round(4 * this.scale);
                this.wideControlSize = this.gridSize * 3 + this.gutterSize * 2;
                this.borderSize = Math.round(2 * this.scale);
            }
            return;
        }

        public function loadUnscaledImage(arg1:String):starling.display.Image
        {
            if (!this.hasOwnProperty(arg1)) 
            {
                return null;
            }
            var loc1:*=new starling.display.Image(this[arg1]);
            return loc1;
        }

        public function getAtlas():starling.textures.TextureAtlas
        {
            return atlas;
        }

        protected override function initializeTextures():void
        {
            super.initializeTextures();
            this.redButtonUpSkinTextures = this.atlas.getTexture("red-button-up-skin");
            this.redButtonDownSkinTextures = this.atlas.getTexture("red-button-down-skin");
            this.whiteButtonUpSkinTextures = this.atlas.getTexture("white-button-up-skin");
            this.whiteButtonDownSkinTextures = this.atlas.getTexture("white-button-down-skin");
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.loadCustomTextures();
            return;
        }

        protected function loadCustomTextures():void
        {
            this.customProgressSkinTexture = this.atlas.getTexture("customProgress");
            this.customBusyIndicatorSkinTexture = this.atlas.getTexture("customBusyIndicator");
            return;
        }

        protected override function initializeScale():void
        {
            var loc1:*=starling.core.Starling.current;
            var loc2:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc2 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc3:*=feathers.system.DeviceCapabilities.dpi / (loc1.contentScaleFactor / loc2);
            this._originalDPI = loc3;
            if (_scaleToDPI && !isDeskop) 
            {
                _originalDPI = ORIGINAL_DPI_IPAD_RETINA;
            }
            scale = loc3 / _originalDPI;
            stageTextScale = 1 / scale;
            GLOBAL_SCALE = this.scale;
            return;
        }

        protected override function initializeFonts():void
        {
            if (isDeskop) 
            {
                FONT_SIZE_EXTRALARGEVALUE = 30;
                FONT_SIZE_EXTRALARGE = 26;
                FONT_SIZE_LARGE = 24;
                FONT_SIZE_REGULAR = 18;
                FONT_SIZE_INPUT = 18;
                FONT_SIZE_NORMAL = 18;
                FONT_SIZE_SMALL = 10;
            }
            else 
            {
                FONT_SIZE_EXTRALARGEVALUE = 75;
                FONT_SIZE_EXTRALARGE = 36;
                FONT_SIZE_LARGE = 28;
                FONT_SIZE_REGULAR = 24;
                FONT_SIZE_INPUT = 24;
                FONT_SIZE_NORMAL = 22;
                FONT_SIZE_SMALL = 20;
            }
            super.initializeFonts();
            this.extraLargeValueFontSize = Math.round(FONT_SIZE_EXTRALARGEVALUE * this.scale);
            this.megaLargeFontSize = Math.round(FONT_SIZE_MEGALARGE * this.scale);
            this.numberFontSize = Math.round(FONT_SIZE_NUMBER * this.scale);
            this.numberFontSizeRegular = Math.round(FONT_SIZE_NUMBER_REGULAR * this.scale);
            this.numberSmallFontSize = Math.round(FONT_SIZE_NUMBER_SMALL * this.scale);
            this.normalFontSize = Math.round(FONT_SIZE_NORMAL * this.scale);
            this.smallFontSize = Math.round(FONT_SIZE_SMALL * this.scale);
            this.normalFontDescription = new flash.text.engine.FontDescription(FONT_NAME_ARIAL, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.normalBoldFontDescription = new flash.text.engine.FontDescription(FONT_NAME_ARIAL_BOLD, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.numberFontDescription = new flash.text.engine.FontDescription(FONT_NAME_VALUES, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.obliqueFontDescription = new flash.text.engine.FontDescription(FONT_NAME_EURO_OBLIQUE, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.eurostileFontDescription = new flash.text.engine.FontDescription(FONT_NAME, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.eurostileBoldFontDescription = new flash.text.engine.FontDescription(FONT_NAME, flash.text.engine.FontWeight.BOLD, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.eurostileObliqueFontDescription = new flash.text.engine.FontDescription(FONT_NAME_EURO_OBLIQUE, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.eurostileObliqueBoldFontDescription = new flash.text.engine.FontDescription(FONT_NAME_EURO_OBLIQUE, flash.text.engine.FontWeight.BOLD, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.normalFontFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.normalFontSize, TEXT_COLOR_NORMAL);
            this.disabledNormalFontFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.normalFontSize, TEXT_COLOR_DISABLED);
            this.bronzeFontFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_BRONZE);
            this.silverFontFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_SILVER);
            this.goldFontFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_GOLD);
            this.lightFontFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.normalFontSize, TEXT_COLOR_LIGHT);
            this.disabledLightFontFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.normalFontSize, TEXT_COLOR_DISABLED);
            this.normalFontRedFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.normalFontSize, TEXT_COLOR_RED);
            this.disabledNormalFontRedFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.normalFontSize, TEXT_COLOR_DISABLED);
            this.menuElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_MENU);
            this.disabledMenuElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.numberElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.numberFontSize, NUMBER_TEXT_COLOR);
            this.disabledNumberElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.numberFontSize, TEXT_COLOR_DISABLED);
            this.numberWhiteElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.numberFontSizeRegular, TEXT_COLOR_WHITE);
            this.disabledNumberWhiteElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.numberFontSizeRegular, TEXT_COLOR_DISABLED);
            this.numberSmallElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.numberSmallFontSize, NUMBER_TEXT_COLOR);
            this.disabledNumberSmallElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.numberSmallFontSize, TEXT_COLOR_DISABLED);
            this.menuValueElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_MENU_VALUE);
            this.disabledMenuValueElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.menuSubElementFormat = new flash.text.engine.ElementFormat(this.obliqueFontDescription, this.regularFontSize, TEXT_COLOR_MENU_SUB);
            this.disabledMenuSubElementFormat = new flash.text.engine.ElementFormat(this.obliqueFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.naviElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_NAVI);
            this.disabledNaviElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.dashboardShortcutElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DASHBOARD_SHORTCUT);
            this.disabledDashboardShortcutElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.dashboardShortcutValueElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.extraLargeValueFontSize, TEXT_COLOR_DASHBOARD_SHORTCUT);
            this.disabledDashboardShortcutValueElementFormat = new flash.text.engine.ElementFormat(this.numberFontDescription, this.extraLargeValueFontSize, TEXT_COLOR_DISABLED);
            this.dashboardOptionTitleElementFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_DASHBOARD_SHORTCUT);
            this.disabledDashboardOptionTitleElementFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.dashboardOptionTextElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DASHBOARD_OPTION);
            this.disabledDashboardOptionTextElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.buttonElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, FONT_SIZE_REGULAR * scale, TEXT_COLOR_BUTTON);
            this.disabledButtonElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.redButtonElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_WHITE);
            this.disabledRedButtonElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.whiteButtonElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_RED);
            this.disabledWhiteButtonElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.headlineLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileBoldFontDescription, this.largeFontSize, TEXT_COLOR_HEADLINE);
            this.disabledHeadlineLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileBoldFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.bigListLabelElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_BIGLISTLABEL);
            this.disabledBigListLabelElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.bigListLabelWhiteElementFormat = new flash.text.engine.ElementFormat(this.eurostileFontDescription, this.largeFontSize, TEXT_COLOR_BIGLISTLABEL_WHITE);
            this.disabledBigListLabelWhiteElementFormat = new flash.text.engine.ElementFormat(this.eurostileFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.bigListLabelItalicElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.largeFontSize, TEXT_COLOR_DARK);
            this.disabledBigListLabelItalicElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.smallListLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.smallFontSize, TEXT_COLOR_SMALLLISTLABEL);
            this.smallListLabelBoldElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueBoldFontDescription, this.regularFontSize, TEXT_COLOR_SMALLLISTLABEL);
            this.disabledSmallListLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.smallFontSize, TEXT_COLOR_DISABLED);
            this.smallWhiteLabelElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.smallestFontSize, TEXT_COLOR_WHITE);
            this.disabledSmallWhiteLabelElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.smallestFontSize, TEXT_COLOR_LIGHT);
            this.whiteLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileFontDescription, this.regularFontSize, TEXT_COLOR_WHITE);
            this.disabledWhiteLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileFontDescription, this.regularFontSize, TEXT_COLOR_DARK_DISABLED);
            this.whiteLabelArialElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_WHITE);
            this.disabledWhiteLabelArialElementFormat = new flash.text.engine.ElementFormat(this.normalFontDescription, this.regularFontSize, TEXT_COLOR_DARK_DISABLED);
            this.darkLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileFontDescription, this.regularFontSize, TEXT_COLOR_DARK);
            this.disabledDarkLabelElementFormat = new flash.text.engine.ElementFormat(this.eurostileFontDescription, this.regularFontSize, TEXT_COLOR_DARK_DISABLED);
            this.popupTitleElementFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.extraLargeFontSize, TEXT_COLOR_RED);
            this.disabledPopupTitleElementFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.extraLargeFontSize, TEXT_COLOR_DISABLED);
            this.redPopupTitleElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueBoldFontDescription, this.extraLargeFontSize, TEXT_COLOR_WHITE);
            this.disabledRedPopupTitleElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueBoldFontDescription, this.extraLargeFontSize, TEXT_COLOR_DISABLED);
            this.eurostileWhiteItalicElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.extraLargeFontSize, TEXT_COLOR_WHITE);
            this.disabledEurostileWhiteItalicElementFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.extraLargeFontSize, TEXT_COLOR_DISABLED);
            this.normalBoldElementFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_DARK);
            this.disabledNormalBoldElementFormat = new flash.text.engine.ElementFormat(this.normalBoldFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.sleepWakeUpFontFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueBoldFontDescription, this.largeFontSize, TEXT_COLOR_SLEEP_WAKE_UP);
            this.sleepLightFontFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueBoldFontDescription, this.largeFontSize, TEXT_COLOR_SLEEP_LIGHT);
            this.sleepDeepFontFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueBoldFontDescription, this.largeFontSize, TEXT_COLOR_SLEEP_DEEP);
            this.sleepWakeUpSmallFontFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.smallFontSize, TEXT_COLOR_SLEEP_WAKE_UP);
            this.sleepLightSmallFontFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.smallFontSize, TEXT_COLOR_SLEEP_LIGHT);
            this.sleepDeepSmallFontFormat = new flash.text.engine.ElementFormat(this.eurostileObliqueFontDescription, this.smallFontSize, TEXT_COLOR_SLEEP_DEEP);
            return;
        }

        protected function setMenuLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.menuElementFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledMenuElementFormat;
            return;
        }

        protected function setNormalLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.normalFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setBronzeLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.bronzeFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setSilverLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.silverFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setGoldLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.goldFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledNormalFontFormat;
            return;
        }

        protected function setLightLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.textRendererProperties.elementFormat = this.lightFontFormat;
            arg1.textRendererProperties.disabledElementFormat = this.disabledLightFontFormat;
            return;
        }

        protected static function customPickerListSpinnerListFactory():feathers.controls.SpinnerList
        {
            var loc1:*=new feathers.controls.SpinnerList();
            var loc2:*=new feathers.layout.VerticalSpinnerLayout();
            loc2.requestedRowCount = 6;
            loc1.layout = loc2;
            return loc1;
        }

        public static function scaler(arg1:Number):Number
        {
            return arg1 * GLOBAL_SCALE;
        }

        
        {
            FONT_SIZE_EXTRALARGEVALUE = 90;
            FONT_SIZE_MEGALARGE = 150;
            FONT_SIZE_NORMAL = 22;
            FONT_SIZE_NUMBER = 40;
            FONT_SIZE_NUMBER_REGULAR = 30;
            FONT_SIZE_NUMBER_SMALL = 22;
        }

        protected override function setCalloutStyles(arg1:feathers.controls.Callout):void
        {
            var loc1:*=new starling.display.Image(backgroundLightBorderSkinTexture);
            loc1.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
            loc1.width = calloutBackgroundMinSize;
            loc1.height = calloutBackgroundMinSize;
            arg1.backgroundSkin = loc1;
            var loc2:*=new starling.display.Image(calloutTopArrowSkinTexture);
            arg1.topArrowSkin = loc2;
            arg1.topArrowGap = calloutArrowOverlapGap;
            var loc3:*=new starling.display.Image(calloutRightArrowSkinTexture);
            arg1.rightArrowSkin = loc3;
            arg1.rightArrowGap = calloutArrowOverlapGap;
            var loc4:*=new starling.display.Image(calloutBottomArrowSkinTexture);
            arg1.bottomArrowSkin = loc4;
            arg1.bottomArrowGap = calloutArrowOverlapGap;
            var loc5:*=new starling.display.Image(calloutLeftArrowSkinTexture);
            arg1.leftArrowSkin = loc5;
            arg1.leftArrowGap = calloutArrowOverlapGap;
            arg1.padding = 1 * scale;
            return;
        }

        protected override function setPickerListStyles(arg1:feathers.controls.PickerList):void
        {
            var loc1:*=null;
            if (isDeskop) 
            {
                arg1.popUpContentManager = new feathers.controls.popups.CalloutPopUpContentManager();
            }
            else 
            {
                arg1.listFactory = customPickerListSpinnerListFactory;
                loc1 = new feathers.controls.popups.BottomDrawerPopUpContentManager();
                arg1.popUpContentManager = loc1;
            }
            return;
        }

        protected override function setPickerListButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(whiteButtonUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, whiteButtonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, whiteButtonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.UP_AND_SELECTED, whiteButtonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.HOVER_AND_SELECTED, whiteButtonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, buttonDisabledSkinTexture);
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = controlSize;
            loc1.height = controlSize;
            arg1.defaultSkin = loc1;
            arg1.customLabelStyleName = TEXT_STYLE_BUTTONLABEL_RED_ALIGN_RIGHT;
            setBaseButtonStyles(arg1);
            return;
        }

        protected function setNormalTabStyle(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.darkLabelElementFormat;
            arg1.disabledElementFormat = this.disabledDarkLabelElementFormat;
            return;
        }

        protected function setSelectedTabStyle(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.whiteLabelElementFormat;
            arg1.disabledElementFormat = this.disabledWhiteLabelElementFormat;
            return;
        }

        protected function setWhiteButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.whiteButtonUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.whiteButtonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            if (arg1 is feathers.controls.ToggleButton) 
            {
                loc1.selectedTexture = this.whiteButtonUpSkinTexture;
                loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.buttonSelectedDisabledSkinTexture);
            }
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            arg1.customLabelStyleName = TEXT_STYLE_BUTTONLABEL_RED;
            this.setBaseButtonStyles(arg1);
            return;
        }

        protected function setRedButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.redButtonUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.redButtonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            if (arg1 is feathers.controls.ToggleButton) 
            {
                loc1.selectedTexture = this.redButtonUpSkinTexture;
                loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.buttonSelectedDisabledSkinTexture);
            }
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            arg1.customLabelStyleName = TEXT_STYLE_BUTTONLABEL_WHITE;
            this.setBaseButtonStyles(arg1);
            return;
        }

        protected override function setCheckLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.darkElementFormat;
            arg1.disabledElementFormat = this.disabledDarkLabelElementFormat;
            return;
        }

        public static const TEXT_STYLE_DASHBOARD_OPTION_TEXT:String="DASHBOARD_OPTION_TEXT";

        public static const TEXT_STYLE_DASHBOARD_OPTION_TITLE:String="DASHBOARD_OPTION_TITLE";

        public static const TEXT_STYLE_DASHBOARD_SHORTCUT_LABEL:String="DASHBOARD_SHORTCUT_LABEL";

        public static const TEXT_STYLE_GOLD:String="textStyleGold";

        public static const TEXT_STYLE_LIGHT:String="LIGHT";

        public static const TEXT_STYLE_MENUITEM:String="MENUITEM";

        public static const TEXT_STYLE_MENUSUBITEM:String="MENUSUBITEM";

        public static const TEXT_STYLE_MENUVALUE:String="MENUVALUE";

        public static const TEXT_STYLE_NAVIITEM:String="NAVIITEM";

        public static const TEXT_STYLE_NORMAL:String="NORMAL";

        public static const TEXT_STYLE_NORMAL_BOLD:String="NORMAL_BOLD";

        public static const TEXT_STYLE_NORMAL_RED:String="NORMAL_RED";

        public static const TEXT_STYLE_NUMBER:String="NUMBERITEM";

        public static const TEXT_STYLE_NUMBER_SMALL:String="NUMBERITEMSMALL";

        public static const TEXT_STYLE_NUMBER_WHITE:String="NUMBERITEMWHITE";

        public static const TEXT_STYLE_POPUP_TITLE:String="POPUP_TITLE";

        public static const TEXT_STYLE_RED_POPUP_TITLE:String="RED_POPUP_TITLE";

        public static const TEXT_STYLE_SILVER:String="textStyleSilver";

        public static const TEXT_STYLE_SLEEP_DEEP:String="textStyleSleepDeep";

        public static const TEXT_STYLE_SLEEP_DEEP_SMALL:String="textStyleSleepDeepSmall";

        public static const TEXT_STYLE_SLEEP_LIGHT:String="textStyleSleepLight";

        public static const TEXT_STYLE_SLEEP_LIGHT_SMALL:String="textStyleSleepLightSmall";

        public static const TEXT_STYLE_SLEEP_WAKE_UP:String="textStyleSleepWakeUp";

        public static const TEXT_STYLE_SLEEP_WAKE_UP_SMALL:String="textStyleSleepWakeUpSmall";

        public static const TEXT_STYLE_SMALLLISTLABEL:String="SMALLLISTLABEL";

        public static const TEXT_STYLE_SMALLLISTLABEL_BOLD:String="SMALLLISTLABEL_BOLD";

        public static const TEXT_STYLE_SMALLWHITELABEL:String="SMALLWHITELABEL";

        public static const TEXT_STYLE_WHITELABEL:String="WHITELABEL";

        public static const TEXT_STYLE_WHITELABEL_ARIAL:String="WHITELABEL_ARIAL";

        protected static const TEXT_COLOR_BIGLISTLABEL:uint=3028545;

        protected static const TEXT_COLOR_BIGLISTLABEL_WHITE:uint=16777215;

        protected static const TEXT_COLOR_BRONZE:uint=13875593;

        protected static const TEXT_COLOR_BUTTON:uint=16777215;

        protected static const TEXT_COLOR_DASHBOARD_OPTION:uint=9737364;

        protected static const TEXT_COLOR_DASHBOARD_SHORTCUT:uint=13046322;

        protected static const TEXT_COLOR_GOLD:uint=14666829;

        protected static const TEXT_COLOR_GREEN:uint=10208573;

        protected static const TEXT_COLOR_HEADLINE:uint=12597547;

        protected static const TEXT_COLOR_MENU:uint=3028545;

        protected static const TEXT_COLOR_MENU_SUB:uint=9737364;

        protected static const TEXT_COLOR_MENU_VALUE:uint=13046322;

        protected static const TEXT_COLOR_NAVI:uint=16777215;

        protected static const TEXT_COLOR_NORMAL:uint=3028545;

        protected static const TEXT_COLOR_SILVER:uint=12303810;

        protected static const TEXT_COLOR_SLEEP_DEEP:uint=10341944;

        protected static const TEXT_COLOR_SLEEP_LIGHT:uint=39322;

        protected static const TEXT_COLOR_SLEEP_WAKE_UP:uint=16672873;

        protected static const TEXT_COLOR_SMALLLISTLABEL:uint=3028545;

        protected static const TEXT_COLOR_WHITE:uint=16777215;

        protected static const TEXT_COLOR_WHITE_BUTTON:uint=3028545;

        public static const TEXT_STYLE_DASHBOARD_SHORTCUT_VALUE:String="DASHBOARD_SHORTCUT_VALUE";

        public static const BUTTON_STYLE_REDBUTTON:String="REDBUTTON";

        public static const BUTTON_STYLE_WHITEBUTTON:String="WHITEBUTTON";

        public static const EUROSTILE_WHITE_ITALIC:String="eurostileWhiteItalic";

        public static const TABBAR_NORMAL_STYLE_TEXT:String="TEXT_TABBBAR_NORMAL";

        public static const TABBAR_SELECTED_STYLE_TEXT:String="TEXT_TABBBAR_SELECTED";

        public static const TABBAR_STYLE_TEXT:String="TEXT_TABBAR";

        public static const TEXT_STYLE_BIGLISTLABEL:String="BIGLISTLABEL";

        public static const TEXT_STYLE_BIGLISTLABEL_ITALIC:String="BIGLISTLABEL_ITALIC";

        public static const TEXT_STYLE_BIGLISTLABEL_WHITE:String="BIGLISTLABELWHITE";

        public static const TEXT_STYLE_BRONZE:String="textStyleBronze";

        public static const TEXT_STYLE_BUTTONLABEL:String="BUTTONLABEL";

        public static const TEXT_STYLE_BUTTONLABEL_RED:String="BUTTONLABEL_RED";

        public static const TEXT_STYLE_BUTTONLABEL_RED_ALIGN_RIGHT:String="BUTTONLABEL_RED_ALIGN_RIGHT";

        public static const TEXT_STYLE_BUTTONLABEL_WHITE:String="BUTTONLABEL_WHITE";

        public static const TEXT_STYLE_DARKLABEL:String="DARKLABEL";

        public var customBusyIndicatorSkinTexture:starling.textures.Texture;

        public var customProgressSkinTexture:starling.textures.Texture;

        protected var bigListLabelElementFormat:flash.text.engine.ElementFormat;

        protected var bigListLabelItalicElementFormat:flash.text.engine.ElementFormat;

        protected var bigListLabelWhiteElementFormat:flash.text.engine.ElementFormat;

        protected var bronzeFontFormat:flash.text.engine.ElementFormat;

        protected var buttonElementFormat:flash.text.engine.ElementFormat;

        protected var dashboardOptionTextElementFormat:flash.text.engine.ElementFormat;

        protected var dashboardOptionTitleElementFormat:flash.text.engine.ElementFormat;

        protected var dashboardShortcutElementFormat:flash.text.engine.ElementFormat;

        protected var dashboardShortcutValueElementFormat:flash.text.engine.ElementFormat;

        protected var disabledBigListLabelElementFormat:flash.text.engine.ElementFormat;

        protected var disabledBigListLabelItalicElementFormat:flash.text.engine.ElementFormat;

        protected var disabledBigListLabelWhiteElementFormat:flash.text.engine.ElementFormat;

        protected var disabledButtonElementFormat:flash.text.engine.ElementFormat;

        protected var disabledDashboardOptionTextElementFormat:flash.text.engine.ElementFormat;

        protected var disabledDashboardOptionTitleElementFormat:flash.text.engine.ElementFormat;

        protected var disabledDashboardShortcutElementFormat:flash.text.engine.ElementFormat;

        protected var disabledDashboardShortcutValueElementFormat:flash.text.engine.ElementFormat;

        protected var disabledEurostileWhiteItalicElementFormat:flash.text.engine.ElementFormat;

        protected var disabledHeadlineLabelElementFormat:flash.text.engine.ElementFormat;

        protected var disabledLightFontFormat:flash.text.engine.ElementFormat;

        protected var disabledMenuElementFormat:flash.text.engine.ElementFormat;

        protected var disabledMenuSubElementFormat:flash.text.engine.ElementFormat;

        protected var disabledMenuValueElementFormat:flash.text.engine.ElementFormat;

        protected var disabledNaviElementFormat:flash.text.engine.ElementFormat;

        protected var disabledNormalBoldElementFormat:flash.text.engine.ElementFormat;

        protected var disabledNormalFontRedFormat:flash.text.engine.ElementFormat;

        protected var disabledNumberElementFormat:flash.text.engine.ElementFormat;

        protected var disabledNumberSmallElementFormat:flash.text.engine.ElementFormat;

        protected var disabledNumberWhiteElementFormat:flash.text.engine.ElementFormat;

        protected var disabledPopupTitleElementFormat:flash.text.engine.ElementFormat;

        protected var disabledRedButtonElementFormat:flash.text.engine.ElementFormat;

        protected var disabledRedPopupTitleElementFormat:flash.text.engine.ElementFormat;

        protected var disabledSmallListLabelElementFormat:flash.text.engine.ElementFormat;

        protected var disabledSmallWhiteLabelElementFormat:flash.text.engine.ElementFormat;

        protected var disabledWhiteButtonElementFormat:flash.text.engine.ElementFormat;

        protected var disabledWhiteLabelArialElementFormat:flash.text.engine.ElementFormat;

        protected var disabledWhiteLabelElementFormat:flash.text.engine.ElementFormat;

        protected var eurostileBoldFontDescription:flash.text.engine.FontDescription;

        protected var eurostileFontDescription:flash.text.engine.FontDescription;

        protected var eurostileObliqueBoldFontDescription:flash.text.engine.FontDescription;

        protected var eurostileObliqueFontDescription:flash.text.engine.FontDescription;

        protected var eurostileWhiteItalicElementFormat:flash.text.engine.ElementFormat;

        protected var goldFontFormat:flash.text.engine.ElementFormat;

        protected var headlineLabelElementFormat:flash.text.engine.ElementFormat;

        protected var lightFontFormat:flash.text.engine.ElementFormat;

        protected var megaLargeFontSize:int;

        protected var menuElementFormat:flash.text.engine.ElementFormat;

        protected var menuSubElementFormat:flash.text.engine.ElementFormat;

        protected var whiteButtonElementFormat:flash.text.engine.ElementFormat;

        protected var numberFontSize:int;

        protected var numberFontDescription:flash.text.engine.FontDescription;

        protected var numberElementFormat:flash.text.engine.ElementFormat;

        protected var normalFontSize:int;

        protected var normalFontRedFormat:flash.text.engine.ElementFormat;

        protected var normalFontFormat:flash.text.engine.ElementFormat;

        protected var normalFontDescription:flash.text.engine.FontDescription;

        protected var normalBoldFontDescription:flash.text.engine.FontDescription;

        protected var whiteLabelFontDescription:flash.text.engine.FontDescription;

        protected var whiteLabelElementFormat:flash.text.engine.ElementFormat;

        protected var whiteLabelArialFontDescription:flash.text.engine.FontDescription;

        public static var GLOBAL_SCALE:Number;

        protected var whiteLabelArialElementFormat:flash.text.engine.ElementFormat;

        protected var whiteButtonUpSkinTextures:starling.textures.Texture;

        protected var whiteButtonDownSkinTextures:starling.textures.Texture;

        protected var smallWhiteLabelElementFormat:flash.text.engine.ElementFormat;

        protected static var FONT_SIZE_EXTRALARGEVALUE:uint=90;

        protected var disabledNormalFontFormat:flash.text.engine.ElementFormat;

        protected static var FONT_SIZE_NORMAL:uint=22;

        protected static var FONT_SIZE_NUMBER:uint=40;

        protected static var FONT_SIZE_NUMBER_REGULAR:uint=30;

        protected static var FONT_SIZE_NUMBER_SMALL:uint=22;

        protected var smallListLabelElementFormat:flash.text.engine.ElementFormat;

        protected var smallListLabelBoldElementFormat:flash.text.engine.ElementFormat;

        protected var sleepWakeUpSmallFontFormat:flash.text.engine.ElementFormat;

        protected var sleepWakeUpFontFormat:flash.text.engine.ElementFormat;

        protected var sleepLightSmallFontFormat:flash.text.engine.ElementFormat;

        protected var sleepLightFontFormat:flash.text.engine.ElementFormat;

        protected var sleepDeepSmallFontFormat:flash.text.engine.ElementFormat;

        protected var sleepDeepFontFormat:flash.text.engine.ElementFormat;

        protected var silverFontFormat:flash.text.engine.ElementFormat;

        protected var redPopupTitleElementFormat:flash.text.engine.ElementFormat;

        protected var redButtonUpSkinTextures:starling.textures.Texture;

        protected var normalBoldElementFormat:flash.text.engine.ElementFormat;

        protected var redButtonElementFormat:flash.text.engine.ElementFormat;

        protected var redButtonDownSkinTextures:starling.textures.Texture;

        protected var popupTitleFontDescription:flash.text.engine.FontDescription;

        protected var popupTitleElementFormat:flash.text.engine.ElementFormat;

        protected var obliqueFontDescription:flash.text.engine.FontDescription;

        protected var numberWhiteElementFormat:flash.text.engine.ElementFormat;

        protected var numberSmallFontSize:int;

        protected var numberSmallElementFormat:flash.text.engine.ElementFormat;

        protected var numberFontSizeRegular:int;

        protected var naviElementFormat:flash.text.engine.ElementFormat;

        protected var menuValueElementFormat:flash.text.engine.ElementFormat;

        protected static var FONT_SIZE_MEGALARGE:uint=150;
    }
}


