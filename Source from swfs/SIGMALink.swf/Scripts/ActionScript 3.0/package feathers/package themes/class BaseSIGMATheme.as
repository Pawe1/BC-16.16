//class BaseSIGMATheme
package feathers.themes 
{
    import feathers.controls.*;
    import feathers.controls.popups.*;
    import feathers.controls.renderers.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.media.*;
    import feathers.skins.*;
    import feathers.system.*;
    import flash.geom.*;
    import flash.system.*;
    import flash.text.*;
    import flash.text.engine.*;
    import starling.core.*;
    import starling.display.*;
    import starling.textures.*;
    
    public class BaseSIGMATheme extends feathers.themes.StyleNameFunctionTheme
    {
        public function BaseSIGMATheme(arg1:Boolean=true)
        {
            super();
            this._scaleToDPI = arg1;
            var loc1:*=flash.system.Capabilities.version.toLowerCase();
            this.isDeskop = loc1.indexOf("win") > -1 || loc1.indexOf("mac") > -1;
            return;
        }

        protected function setVolumeSliderStyles(arg1:feathers.media.VolumeSlider):void
        {
            arg1.direction = feathers.layout.Direction.HORIZONTAL;
            arg1.trackLayoutMode = feathers.controls.TrackLayoutMode.SPLIT;
            arg1.showThumb = false;
            arg1.minWidth = this.volumeSliderMinimumTrackSkinTexture.width;
            arg1.minHeight = this.volumeSliderMinimumTrackSkinTexture.height;
            return;
        }

        protected function setVolumeSliderThumbStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=NaN;
            var loc2:*=null;
            loc1 = 6;
            loc2 = new starling.display.Quad(loc1, loc1);
            loc2.width = 0;
            loc2.height = 0;
            arg1.defaultSkin = loc2;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        public function get originalDPI():int
        {
            return this._originalDPI;
        }

        protected function setVolumeSliderMinimumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=null;
            loc1 = new feathers.controls.ImageLoader();
            loc1.scaleContent = false;
            loc1.source = this.volumeSliderMinimumTrackSkinTexture;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setVolumeSliderMaximumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=null;
            loc1 = new feathers.controls.ImageLoader();
            loc1.scaleContent = false;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            loc1.source = this.volumeSliderMaximumTrackSkinTexture;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        public function get scaleToDPI():Boolean
        {
            return this._scaleToDPI;
        }

        protected static function textRendererFactory():feathers.core.ITextRenderer
        {
            return new feathers.controls.text.TextBlockTextRenderer();
        }

        protected static function textEditorFactory():feathers.core.ITextEditor
        {
            return new feathers.controls.text.StageTextTextEditor();
        }

        protected static function textAreaTextEditorFactory():feathers.controls.text.ITextEditorViewPort
        {
            return new feathers.controls.text.TextFieldTextEditorViewPort();
        }

        protected static function stepperTextEditorFactory():feathers.controls.text.TextBlockTextEditor
        {
            return new feathers.controls.text.TextBlockTextEditor();
        }

        protected static function pickerListSpinnerListFactory():feathers.controls.SpinnerList
        {
            return new feathers.controls.SpinnerList();
        }

        protected static function scrollBarFactory():feathers.controls.SimpleScrollBar
        {
            return new feathers.controls.SimpleScrollBar();
        }

        protected static function popUpOverlayFactory():starling.display.DisplayObject
        {
            var loc1:*=new starling.display.Quad(100, 100, MODAL_OVERLAY_COLOR);
            loc1.alpha = MODAL_OVERLAY_ALPHA;
            return loc1;
        }

        public override function dispose():void
        {
            if (this.atlas) 
            {
                this.atlas.texture.root.onRestore = null;
                this.atlas.dispose();
                this.atlas = null;
            }
            super.dispose();
            return;
        }

        protected function initialize():void
        {
            this.initializeScale();
            this.initializeDimensions();
            this.initializeFonts();
            this.initializeTextures();
            this.initializeGlobals();
            this.initializeStage();
            this.initializeStyleProviders();
            return;
        }

        protected function initializeStage():void
        {
            starling.core.Starling.current.stage.color = PRIMARY_BACKGROUND_COLOR;
            starling.core.Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
            return;
        }

        protected function initializeGlobals():void
        {
            feathers.core.FeathersControl.defaultTextRendererFactory = textRendererFactory;
            feathers.core.FeathersControl.defaultTextEditorFactory = textEditorFactory;
            feathers.core.PopUpManager.overlayFactory = popUpOverlayFactory;
            feathers.controls.Callout.stagePadding = this.smallGutterSize;
            return;
        }

        protected function initializeScale():void
        {
            var loc1:*=starling.core.Starling.current;
            var loc2:*=1;
            if (loc1.supportHighResolutions) 
            {
                loc2 = loc1.nativeStage.contentsScaleFactor;
            }
            var loc3:*=feathers.system.DeviceCapabilities.dpi / (loc1.contentScaleFactor / loc2);
            this._originalDPI = loc3;
            if (this._scaleToDPI && !this.isDeskop) 
            {
                this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
            }
            this.scale = loc3 / this._originalDPI;
            this.stageTextScale = 1 / this.scale;
            return;
        }

        protected function initializeDimensions():void
        {
            return;
        }

        protected function initializeFonts():void
        {
            this.smallestFontSize = Math.round(FONT_SIZE_SMALLEST * this.scale);
            this.smallFontSize = Math.round(FONT_SIZE_SMALL * this.scale);
            this.regularFontSize = Math.round(FONT_SIZE_REGULAR * this.scale);
            this.largeFontSize = Math.round(FONT_SIZE_LARGE * this.scale);
            this.extraLargeFontSize = Math.round(FONT_SIZE_EXTRALARGE * this.scale);
            this.inputFontSize = Math.round(FONT_SIZE_INPUT * this.stageTextScale);
            this.scrollTextTextFormat = new flash.text.TextFormat("_sans", this.regularFontSize, TEXT_COLOR_DARK);
            this.scrollTextDisabledTextFormat = new flash.text.TextFormat("_sans", this.regularFontSize, TEXT_COLOR_DISABLED);
            this.regularFontDescription = new flash.text.engine.FontDescription(FONT_NAME, flash.text.engine.FontWeight.NORMAL, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.boldFontDescription = new flash.text.engine.FontDescription(FONT_NAME, flash.text.engine.FontWeight.BOLD, flash.text.engine.FontPosture.NORMAL, flash.text.engine.FontLookup.EMBEDDED_CFF, flash.text.engine.RenderingMode.CFF, flash.text.engine.CFFHinting.NONE);
            this.headerElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.extraLargeFontSize, TEXT_COLOR_DARK);
            this.headerDisabledElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.extraLargeFontSize, TEXT_COLOR_DISABLED);
            this.darkUIElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.regularFontSize, TEXT_COLOR_DARK);
            this.lightUIElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.regularFontSize, TEXT_COLOR_LIGHT);
            this.selectedUIElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.regularFontSize, TEXT_COLOR_SELECTED);
            this.lightUIDisabledElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.darkUIDisabledElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.regularFontSize, TEXT_COLOR_DARK_DISABLED);
            this.largeUIDarkElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.largeFontSize, TEXT_COLOR_DARK);
            this.largeUILightElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.largeFontSize, TEXT_COLOR_LIGHT);
            this.largeUISelectedElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.largeFontSize, TEXT_COLOR_SELECTED);
            this.largeUIDarkDisabledElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.largeFontSize, TEXT_COLOR_DARK_DISABLED);
            this.largeUILightDisabledElementFormat = new flash.text.engine.ElementFormat(this.boldFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            this.darkElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.regularFontSize, TEXT_COLOR_DARK);
            this.lightElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.regularFontSize, TEXT_COLOR_LIGHT);
            this.disabledElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.regularFontSize, TEXT_COLOR_DISABLED);
            this.smallLightElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.smallFontSize, TEXT_COLOR_LIGHT);
            this.smallDisabledElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.smallFontSize, TEXT_COLOR_DISABLED);
            this.largeDarkElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.largeFontSize, TEXT_COLOR_DARK);
            this.largeLightElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.largeFontSize, TEXT_COLOR_LIGHT);
            this.largeDisabledElementFormat = new flash.text.engine.ElementFormat(this.regularFontDescription, this.largeFontSize, TEXT_COLOR_DISABLED);
            return;
        }

        protected function initializeTextures():void
        {
            this.backgroundSkinTexture = this.atlas.getTexture("background-skin");
            this.backgroundListSkin = this.atlas.getTexture("background-list-skin");
            this.backgroundDisabledSkinTexture = this.atlas.getTexture("background-disabled-skin");
            this.backgroundInsetSkinTexture = this.atlas.getTexture("background-inset-skin");
            this.backgroundInsetDisabledSkinTexture = this.atlas.getTexture("background-inset-disabled-skin");
            this.backgroundInsetEnabledSkinTexture = this.atlas.getTexture("background-focused-skin");
            this.backgroundInsetFocusedSkinTexture = this.atlas.getTexture("background-focused-skin");
            this.backgroundInsetDangerSkinTexture = this.atlas.getTexture("background-inset-danger-skin");
            this.backgroundLightBorderSkinTexture = this.atlas.getTexture("background-light-border-skin");
            this.backgroundDarkBorderSkinTexture = this.atlas.getTexture("background-dark-border-skin");
            this.backgroundDangerBorderSkinTexture = this.atlas.getTexture("background-danger-border-skin");
            this.buttonUpSkinTexture = this.atlas.getTexture("button-up-skin");
            this.buttonDownSkinTexture = this.atlas.getTexture("button-down-skin");
            this.buttonDisabledSkinTexture = this.atlas.getTexture("button-disabled-skin");
            this.buttonSelectedUpSkinTexture = this.atlas.getTexture("toggle-button-selected-up-skin");
            this.buttonSelectedDisabledSkinTexture = this.atlas.getTexture("toggle-button-selected-disabled-skin");
            this.buttonCallToActionUpSkinTexture = this.atlas.getTexture("call-to-action-button-up-skin");
            this.buttonCallToActionDownSkinTexture = this.atlas.getTexture("call-to-action-button-down-skin");
            this.buttonDangerUpSkinTexture = this.atlas.getTexture("danger-button-up-skin");
            this.buttonDangerDownSkinTexture = this.atlas.getTexture("danger-button-down-skin");
            this.buttonBackUpSkinTexture = this.atlas.getTexture("back-button-up-skin");
            this.buttonBackDownSkinTexture = this.atlas.getTexture("back-button-down-skin");
            this.buttonBackDisabledSkinTexture = this.atlas.getTexture("back-button-disabled-skin");
            this.buttonForwardUpSkinTexture = this.atlas.getTexture("forward-button-up-skin");
            this.buttonForwardDownSkinTexture = this.atlas.getTexture("forward-button-down-skin");
            this.buttonForwardDisabledSkinTexture = this.atlas.getTexture("forward-button-disabled-skin");
            this.whiteButtonUpSkinTexture = this.atlas.getTexture("white-button-up-skin");
            this.whiteButtonDownSkinTexture = this.atlas.getTexture("white-button-down-skin");
            this.redButtonUpSkinTexture = this.atlas.getTexture("red-button-up-skin");
            this.redButtonDownSkinTexture = this.atlas.getTexture("red-button-down-skin");
            this.tabUpSkinTexture = starling.textures.Texture.fromTexture(this.atlas.getTexture("tab-up-skin"), TAB_SKIN_TEXTURE_REGION);
            this.tabDownSkinTexture = starling.textures.Texture.fromTexture(this.atlas.getTexture("tab-down-skin"), TAB_SKIN_TEXTURE_REGION);
            this.tabDisabledSkinTexture = starling.textures.Texture.fromTexture(this.atlas.getTexture("tab-disabled-skin"), TAB_SKIN_TEXTURE_REGION);
            this.tabSelectedUpSkinTexture = starling.textures.Texture.fromTexture(this.atlas.getTexture("tab-selected-up-skin"), TAB_SKIN_TEXTURE_REGION);
            this.tabSelectedDisabledSkinTexture = starling.textures.Texture.fromTexture(this.atlas.getTexture("tab-selected-disabled-skin"), TAB_SKIN_TEXTURE_REGION);
            this.pickerListButtonIconTexture = this.atlas.getTexture("picker-list-button-icon");
            this.pickerListButtonSelectedIconTexture = this.atlas.getTexture("picker-list-button-selected-icon");
            this.pickerListButtonIconDisabledTexture = this.atlas.getTexture("picker-list-button-disabled-icon");
            this.pickerListItemSelectedIconTexture = this.atlas.getTexture("picker-list-item-renderer-selected-icon");
            this.spinnerListSelectionOverlaySkinTexture = this.atlas.getTexture("spinner-list-selection-overlay-skin");
            this.checkUpIconTexture = this.atlas.getTexture("check-up-icon");
            this.checkDownIconTexture = this.atlas.getTexture("check-down-icon");
            this.checkDisabledIconTexture = this.atlas.getTexture("check-disabled-icon");
            this.checkSelectedUpIconTexture = this.atlas.getTexture("check-selected-up-icon");
            this.checkSelectedDownIconTexture = this.atlas.getTexture("check-selected-down-icon");
            this.checkSelectedDisabledIconTexture = this.atlas.getTexture("check-selected-disabled-icon");
            this.radioUpIconTexture = this.atlas.getTexture("radio-icon");
            this.radioDownIconTexture = this.atlas.getTexture("radio-icon");
            this.radioDisabledIconTexture = this.atlas.getTexture("radio-icon");
            this.radioSelectedUpIconTexture = this.atlas.getTexture("radio-selected-up-icon");
            this.radioSelectedDownIconTexture = this.atlas.getTexture("radio-selected-down-icon");
            this.radioSelectedDisabledIconTexture = this.atlas.getTexture("radio-selected-disabled-icon");
            this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-symbol");
            this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-symbol");
            this.searchIconTexture = this.atlas.getTexture("search-icon");
            this.searchIconDisabledTexture = this.atlas.getTexture("search-disabled-icon");
            this.itemRendererUpSkinTexture = this.atlas.getTexture("item-renderer-up-skin");
            this.itemRendererSelectedSkinTexture = this.atlas.getTexture("item-renderer-selected-up-skin");
            this.insetItemRendererUpSkinTexture = this.atlas.getTexture("inset-item-renderer-up-skin");
            this.insetItemRendererSelectedSkinTexture = this.atlas.getTexture("inset-item-renderer-selected-up-skin");
            this.insetItemRendererFirstUpSkinTexture = this.atlas.getTexture("first-inset-item-renderer-up-skin");
            this.insetItemRendererFirstSelectedSkinTexture = this.atlas.getTexture("first-inset-item-renderer-selected-up-skin");
            this.insetItemRendererLastUpSkinTexture = this.atlas.getTexture("last-inset-item-renderer-up-skin");
            this.insetItemRendererLastSelectedSkinTexture = this.atlas.getTexture("last-inset-item-renderer-selected-up-skin");
            this.insetItemRendererSingleUpSkinTexture = this.atlas.getTexture("single-inset-item-renderer-up-skin");
            this.insetItemRendererSingleSelectedSkinTexture = this.atlas.getTexture("single-inset-item-renderer-selected-up-skin");
            var loc1:*=this.atlas.getTexture("header-background-skin");
            var loc2:*=this.atlas.getTexture("header-popup-background-skin");
            this.headerBackgroundSkinTexture = starling.textures.Texture.fromTexture(loc1, HEADER_SKIN_TEXTURE_REGION);
            this.popUpHeaderBackgroundSkinTexture = starling.textures.Texture.fromTexture(loc2, HEADER_SKIN_TEXTURE_REGION);
            this.calloutTopArrowSkinTexture = this.atlas.getTexture("callout-arrow-top-skin");
            this.calloutRightArrowSkinTexture = this.atlas.getTexture("callout-arrow-right-skin");
            this.calloutBottomArrowSkinTexture = this.atlas.getTexture("callout-arrow-bottom-skin");
            this.calloutLeftArrowSkinTexture = this.atlas.getTexture("callout-arrow-left-skin");
            this.dangerCalloutTopArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-top-skin");
            this.dangerCalloutRightArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-right-skin");
            this.dangerCalloutBottomArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-bottom-skin");
            this.dangerCalloutLeftArrowSkinTexture = this.atlas.getTexture("danger-callout-arrow-left-skin");
            this.horizontalScrollBarThumbSkinTexture = this.atlas.getTexture("horizontal-simple-scroll-bar-thumb-skin");
            this.verticalScrollBarThumbSkinTexture = this.atlas.getTexture("vertical-simple-scroll-bar-thumb-skin");
            this.listDrillDownAccessoryTexture = this.atlas.getTexture("item-renderer-drill-down-accessory-icon");
            this.listDrillDownAccessorySelectedTexture = this.atlas.getTexture("item-renderer-drill-down-accessory-selected-icon");
            this.playPauseButtonPlayUpIconTexture = this.atlas.getTexture("play-pause-toggle-button-play-up-icon");
            this.playPauseButtonPlayDownIconTexture = this.atlas.getTexture("play-pause-toggle-button-play-down-icon");
            this.playPauseButtonPauseUpIconTexture = this.atlas.getTexture("play-pause-toggle-button-pause-up-icon");
            this.playPauseButtonPauseDownIconTexture = this.atlas.getTexture("play-pause-toggle-button-pause-down-icon");
            this.overlayPlayPauseButtonPlayUpIconTexture = this.atlas.getTexture("overlay-play-pause-toggle-button-play-up-icon");
            this.overlayPlayPauseButtonPlayDownIconTexture = this.atlas.getTexture("overlay-play-pause-toggle-button-play-down-icon");
            this.fullScreenToggleButtonEnterUpIconTexture = this.atlas.getTexture("full-screen-toggle-button-enter-up-icon");
            this.fullScreenToggleButtonEnterDownIconTexture = this.atlas.getTexture("full-screen-toggle-button-enter-down-icon");
            this.fullScreenToggleButtonExitUpIconTexture = this.atlas.getTexture("full-screen-toggle-button-exit-up-icon");
            this.fullScreenToggleButtonExitDownIconTexture = this.atlas.getTexture("full-screen-toggle-button-exit-down-icon");
            this.muteToggleButtonMutedUpIconTexture = this.atlas.getTexture("mute-toggle-button-muted-up-icon");
            this.muteToggleButtonMutedDownIconTexture = this.atlas.getTexture("mute-toggle-button-muted-down-icon");
            this.muteToggleButtonLoudUpIconTexture = this.atlas.getTexture("mute-toggle-button-loud-up-icon");
            this.muteToggleButtonLoudDownIconTexture = this.atlas.getTexture("mute-toggle-button-loud-down-icon");
            this.volumeSliderMinimumTrackSkinTexture = this.atlas.getTexture("volume-slider-minimum-track-skin");
            this.volumeSliderMaximumTrackSkinTexture = this.atlas.getTexture("volume-slider-maximum-track-skin");
            this.seekSliderProgressSkinTexture = this.atlas.getTexture("seek-slider-progress-skin");
            return;
        }

        protected function initializeStyleProviders():void
        {
            this.getStyleProviderForClass(feathers.controls.Alert).defaultStyleFunction = this.setAlertStyles;
            this.getStyleProviderForClass(feathers.controls.ButtonGroup).setFunctionForStyleName(feathers.controls.Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON, this.setAlertButtonGroupButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Header).setFunctionForStyleName(feathers.controls.Alert.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setPopUpHeaderStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE, this.setAlertMessageTextRendererStyles);
            this.getStyleProviderForClass(feathers.controls.Button).defaultStyleFunction = this.setButtonStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON, this.setCallToActionButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON, this.setDangerButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.Button.ALTERNATE_STYLE_NAME_BACK_BUTTON, this.setBackButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.Button.ALTERNATE_STYLE_NAME_FORWARD_BUTTON, this.setForwardButtonStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.Button.DEFAULT_CHILD_STYLE_NAME_LABEL, this.setButtonLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_QUIET_BUTTON_LABEL, this.setQuietButtonLabelStyles);
            this.getStyleProviderForClass(feathers.controls.ButtonGroup).defaultStyleFunction = this.setButtonGroupStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);
            this.getStyleProviderForClass(feathers.controls.ToggleButton).setFunctionForStyleName(feathers.controls.ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_BUTTON_GROUP_BUTTON_LABEL, this.setButtonGroupButtonLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Callout).defaultStyleFunction = this.setCalloutStyles;
            this.getStyleProviderForClass(feathers.controls.Check).defaultStyleFunction = this.setCheckStyles;
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.Check.DEFAULT_CHILD_STYLE_NAME_LABEL, this.setCheckLabelStyles);
            this.getStyleProviderForClass(feathers.controls.SpinnerList).setFunctionForStyleName(feathers.controls.DateTimeSpinner.DEFAULT_CHILD_STYLE_NAME_LIST, this.setDateTimeSpinnerListStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultListItemRenderer).setFunctionForStyleName(THEME_STYLE_NAME_DATE_TIME_SPINNER_LIST_ITEM_RENDERER, this.setDateTimeSpinnerListItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.Drawers).defaultStyleFunction = this.setDrawersStyles;
            this.getStyleProviderForClass(feathers.controls.GroupedList).defaultStyleFunction = this.setGroupedListStyles;
            this.getStyleProviderForClass(feathers.controls.GroupedList).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST, this.setInsetGroupedListStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER, this.setInsetGroupedListMiddleItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER, this.setInsetGroupedListFirstItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER, this.setInsetGroupedListLastItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER, this.setInsetGroupedListSingleItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).setFunctionForStyleName(feathers.controls.renderers.DefaultGroupedListItemRenderer.ALTERNATE_STYLE_NAME_DRILL_DOWN, this.setDrillDownItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListItemRenderer).setFunctionForStyleName(feathers.controls.renderers.DefaultGroupedListItemRenderer.ALTERNATE_STYLE_NAME_CHECK, this.setCheckItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.Header).defaultStyleFunction = this.setHeaderStyles;
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.Header.DEFAULT_CHILD_STYLE_NAME_TITLE, this.setHeaderTitleStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer).defaultStyleFunction = this.setGroupedListHeaderRendererStyles;
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(feathers.controls.GroupedList.DEFAULT_CHILD_STYLE_NAME_FOOTER_RENDERER, this.setGroupedListFooterRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER, this.setInsetGroupedListHeaderRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer).setFunctionForStyleName(feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER, this.setInsetGroupedListFooterRendererStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer.DEFAULT_CHILD_STYLE_NAME_CONTENT_LABEL, this.setGroupedListHeaderContentLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_GROUPED_LIST_FOOTER_CONTENT_LABEL, this.setGroupedListFooterContentLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(feathers.controls.Label.ALTERNATE_STYLE_NAME_HEADING, this.setHeadingLabelStyles);
            this.getStyleProviderForClass(feathers.controls.Label).setFunctionForStyleName(feathers.controls.Label.ALTERNATE_STYLE_NAME_DETAIL, this.setDetailLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.Label.DEFAULT_CHILD_STYLE_NAME_TEXT_RENDERER, this.setLabelTextRendererStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_HEADING_LABEL_TEXT_RENDERER, this.setHeadingLabelTextRendererStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_DETAIL_LABEL_TEXT_RENDERER, this.setDetailLabelTextRendererStyles);
            this.getStyleProviderForClass(feathers.controls.LayoutGroup).setFunctionForStyleName(feathers.controls.LayoutGroup.ALTERNATE_STYLE_NAME_TOOLBAR, this.setToolbarLayoutGroupStyles);
            this.getStyleProviderForClass(feathers.controls.List).defaultStyleFunction = this.setListStyles;
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultListItemRenderer).defaultStyleFunction = this.setItemRendererStyles;
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultListItemRenderer).setFunctionForStyleName(feathers.controls.renderers.DefaultListItemRenderer.ALTERNATE_STYLE_NAME_DRILL_DOWN, this.setDrillDownItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultListItemRenderer).setFunctionForStyleName(feathers.controls.renderers.DefaultListItemRenderer.ALTERNATE_STYLE_NAME_CHECK, this.setCheckItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.renderers.BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_LABEL, this.setItemRendererLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.renderers.BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_ACCESSORY_LABEL, this.setItemRendererAccessoryLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.renderers.BaseDefaultItemRenderer.DEFAULT_CHILD_STYLE_NAME_ICON_LABEL, this.setItemRendererIconLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_CHECK_ITEM_RENDERER_LABEL, this.setCheckItemRendererLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ICON_LABEL, this.setCheckItemRendererIconLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ACCESSORY_LABEL, this.setCheckItemRendererAccessoryLabelStyles);
            this.getStyleProviderForClass(feathers.controls.NumericStepper).defaultStyleFunction = this.setNumericStepperStyles;
            this.getStyleProviderForClass(feathers.controls.TextInput).setFunctionForStyleName(feathers.controls.NumericStepper.DEFAULT_CHILD_STYLE_NAME_TEXT_INPUT, this.setNumericStepperTextInputStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextEditor).setFunctionForStyleName(THEME_STYLE_NAME_NUMERIC_STEPPER_TEXT_INPUT_EDITOR, this.setNumericStepperTextInputEditorStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.NumericStepper.DEFAULT_CHILD_STYLE_NAME_DECREMENT_BUTTON, this.setNumericStepperButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.NumericStepper.DEFAULT_CHILD_STYLE_NAME_INCREMENT_BUTTON, this.setNumericStepperButtonStyles);
            this.getStyleProviderForClass(feathers.controls.PageIndicator).defaultStyleFunction = this.setPageIndicatorStyles;
            this.getStyleProviderForClass(feathers.controls.Panel).defaultStyleFunction = this.setPanelStyles;
            this.getStyleProviderForClass(feathers.controls.Header).setFunctionForStyleName(feathers.controls.Panel.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setPopUpHeaderStyles);
            this.getStyleProviderForClass(feathers.controls.PanelScreen).defaultStyleFunction = this.setPanelScreenStyles;
            this.getStyleProviderForClass(feathers.controls.Header).setFunctionForStyleName(feathers.controls.PanelScreen.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setPanelScreenHeaderStyles);
            this.getStyleProviderForClass(feathers.controls.PickerList).defaultStyleFunction = this.setPickerListStyles;
            this.getStyleProviderForClass(feathers.controls.List).setFunctionForStyleName(feathers.controls.PickerList.DEFAULT_CHILD_STYLE_NAME_LIST, this.setPickerListPopUpListStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setPickerListButtonStyles);
            this.getStyleProviderForClass(feathers.controls.ToggleButton).setFunctionForStyleName(feathers.controls.PickerList.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setPickerListButtonStyles);
            this.getStyleProviderForClass(feathers.controls.ProgressBar).defaultStyleFunction = this.setProgressBarStyles;
            this.getStyleProviderForClass(feathers.controls.Radio).defaultStyleFunction = this.setRadioStyles;
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.Radio.DEFAULT_CHILD_STYLE_NAME_LABEL, this.setRadioLabelStyles);
            this.getStyleProviderForClass(feathers.controls.ScrollContainer).defaultStyleFunction = this.setScrollContainerStyles;
            this.getStyleProviderForClass(feathers.controls.ScrollContainer).setFunctionForStyleName(feathers.controls.ScrollContainer.ALTERNATE_STYLE_NAME_TOOLBAR, this.setToolbarScrollContainerStyles);
            this.getStyleProviderForClass(feathers.controls.ScrollScreen).defaultStyleFunction = this.setScrollScreenStyles;
            this.getStyleProviderForClass(feathers.controls.ScrollText).defaultStyleFunction = this.setScrollTextStyles;
            this.getStyleProviderForClass(feathers.controls.SimpleScrollBar).defaultStyleFunction = this.setSimpleScrollBarStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB, this.setHorizontalSimpleScrollBarThumbStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB, this.setVerticalSimpleScrollBarThumbStyles);
            this.getStyleProviderForClass(feathers.controls.Slider).defaultStyleFunction = this.setSliderStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.Slider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK, this.setHorizontalSliderMinimumTrackStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK, this.setHorizontalSliderMaximumTrackStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK, this.setVerticalSliderMinimumTrackStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK, this.setVerticalSliderMaximumTrackStyles);
            this.getStyleProviderForClass(feathers.controls.SpinnerList).defaultStyleFunction = this.setSpinnerListStyles;
            this.getStyleProviderForClass(feathers.controls.renderers.DefaultListItemRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER, this.setSpinnerListItemRendererStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_LABEL, this.setSpinnerListItemRendererLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ICON_LABEL, this.setSpinnerListItemRendererIconLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ACCESSORY_LABEL, this.setSpinnerListItemRendererAccessoryLabelStyles);
            this.getStyleProviderForClass(feathers.controls.TabBar).defaultStyleFunction = this.setTabBarStyles;
            this.getStyleProviderForClass(feathers.controls.ToggleButton).setFunctionForStyleName(feathers.controls.TabBar.DEFAULT_CHILD_STYLE_NAME_TAB, this.setTabStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_TAB_LABEL, this.setTabLabelStyles);
            this.getStyleProviderForClass(feathers.controls.TextInput).defaultStyleFunction = this.setTextInputStyles;
            this.getStyleProviderForClass(feathers.controls.TextInput).setFunctionForStyleName(feathers.controls.TextInput.ALTERNATE_STYLE_NAME_SEARCH_TEXT_INPUT, this.setSearchTextInputStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.TextInput.DEFAULT_CHILD_STYLE_NAME_PROMPT, this.setTextInputPromptStyles);
            this.getStyleProviderForClass(feathers.controls.text.StageTextTextEditor).setFunctionForStyleName(feathers.controls.TextInput.DEFAULT_CHILD_STYLE_NAME_TEXT_EDITOR, this.setTextInputTextEditorStyles);
            this.getStyleProviderForClass(feathers.controls.TextCallout).setFunctionForStyleName(feathers.controls.TextInput.DEFAULT_CHILD_STYLE_NAME_ERROR_CALLOUT, this.setTextInputErrorCalloutStyles);
            this.getStyleProviderForClass(feathers.controls.TextArea).defaultStyleFunction = this.setTextAreaStyles;
            this.getStyleProviderForClass(feathers.controls.text.TextFieldTextEditorViewPort).setFunctionForStyleName(feathers.controls.TextArea.DEFAULT_CHILD_STYLE_NAME_TEXT_EDITOR, this.setTextAreaTextEditorStyles);
            this.getStyleProviderForClass(feathers.controls.TextCallout).setFunctionForStyleName(feathers.controls.TextArea.DEFAULT_CHILD_STYLE_NAME_ERROR_CALLOUT, this.setTextAreaErrorCalloutStyles);
            this.getStyleProviderForClass(feathers.controls.TextCallout).defaultStyleFunction = this.setTextCalloutStyles;
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.TextCallout.DEFAULT_CHILD_STYLE_NAME_TEXT_RENDERER, this.setTextCalloutTextRendererStyles);
            this.getStyleProviderForClass(feathers.controls.ToggleButton).defaultStyleFunction = this.setButtonStyles;
            this.getStyleProviderForClass(feathers.controls.ToggleButton).setFunctionForStyleName(feathers.controls.Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
            this.getStyleProviderForClass(feathers.controls.ToggleSwitch).defaultStyleFunction = this.setToggleSwitchStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
            this.getStyleProviderForClass(feathers.controls.ToggleButton).setFunctionForStyleName(feathers.controls.ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.controls.ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_TRACK, this.setToggleSwitchTrackStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_OFF_LABEL, this.setToggleSwitchOffLabelStyles);
            this.getStyleProviderForClass(feathers.controls.text.TextBlockTextRenderer).setFunctionForStyleName(feathers.controls.ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_LABEL, this.setToggleSwitchOnLabelStyles);
            this.getStyleProviderForClass(feathers.media.PlayPauseToggleButton).defaultStyleFunction = this.setPlayPauseToggleButtonStyles;
            this.getStyleProviderForClass(feathers.media.PlayPauseToggleButton).setFunctionForStyleName(feathers.media.PlayPauseToggleButton.ALTERNATE_STYLE_NAME_OVERLAY_PLAY_PAUSE_TOGGLE_BUTTON, this.setOverlayPlayPauseToggleButtonStyles);
            this.getStyleProviderForClass(feathers.media.FullScreenToggleButton).defaultStyleFunction = this.setFullScreenToggleButtonStyles;
            this.getStyleProviderForClass(feathers.media.MuteToggleButton).defaultStyleFunction = this.setMuteToggleButtonStyles;
            this.getStyleProviderForClass(feathers.media.SeekSlider).defaultStyleFunction = this.setSeekSliderStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.media.SeekSlider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSeekSliderThumbStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.media.SeekSlider.DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK, this.setSeekSliderMinimumTrackStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.media.SeekSlider.DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK, this.setSeekSliderMaximumTrackStyles);
            this.getStyleProviderForClass(feathers.media.VolumeSlider).defaultStyleFunction = this.setVolumeSliderStyles;
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.media.VolumeSlider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setVolumeSliderThumbStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.media.VolumeSlider.DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK, this.setVolumeSliderMinimumTrackStyles);
            this.getStyleProviderForClass(feathers.controls.Button).setFunctionForStyleName(feathers.media.VolumeSlider.DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK, this.setVolumeSliderMaximumTrackStyles);
            return;
        }

        protected function pageIndicatorNormalSymbolFactory():starling.display.DisplayObject
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.source = this.pageIndicatorNormalSkinTexture;
            return loc1;
        }

        protected function pageIndicatorSelectedSymbolFactory():starling.display.DisplayObject
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.source = this.pageIndicatorSelectedSkinTexture;
            return loc1;
        }

        protected function imageLoaderFactory():feathers.controls.ImageLoader
        {
            var loc1:*=new feathers.controls.ImageLoader();
            loc1.textureScale = this.scale;
            return loc1;
        }

        protected function setScrollerStyles(arg1:feathers.controls.Scroller):void
        {
            arg1.horizontalScrollBarFactory = scrollBarFactory;
            arg1.verticalScrollBarFactory = scrollBarFactory;
            return;
        }

        protected function setSimpleButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            var loc2:*;
            arg1.minHeight = loc2 = this.controlSize;
            arg1.minWidth = loc2;
            arg1.minTouchHeight = loc2 = this.gridSize;
            arg1.minTouchWidth = loc2;
            return;
        }

        protected function setAlertStyles(arg1:feathers.controls.Alert):void
        {
            this.setScrollerStyles(arg1);
            var loc1:*=new starling.display.Image(this.backgroundSkinTexture);
            loc1.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
            arg1.backgroundSkin = loc1;
            arg1.paddingTop = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.outerPadding = this.borderSize;
            arg1.gap = this.smallGutterSize;
            arg1.maxWidth = this.popUpFillSize;
            arg1.maxHeight = this.popUpFillSize;
            return;
        }

        protected function setAlertButtonGroupStyles(arg1:feathers.controls.ButtonGroup):void
        {
            arg1.direction = feathers.layout.Direction.HORIZONTAL;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            arg1.verticalAlign = feathers.layout.VerticalAlign.JUSTIFY;
            arg1.distributeButtonSizes = false;
            arg1.gap = this.smallGutterSize;
            arg1.padding = this.smallGutterSize;
            arg1.customButtonStyleName = THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON;
            return;
        }

        protected function setAlertButtonGroupButtonStyles(arg1:feathers.controls.Button):void
        {
            this.setButtonStyles(arg1);
            arg1.minWidth = 2 * this.controlSize;
            return;
        }

        protected function setAlertMessageTextRendererStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.wordWrap = true;
            arg1.elementFormat = this.lightElementFormat;
            return;
        }

        protected function setBaseButtonStyles(arg1:feathers.controls.Button):void
        {
            arg1.paddingTop = this.smallControlGutterSize;
            arg1.paddingBottom = this.smallControlGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = this.smallControlGutterSize;
            arg1.minGap = this.smallControlGutterSize;
            var loc1:*;
            arg1.minHeight = loc1 = this.controlSize;
            arg1.minWidth = loc1;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            if (arg1 is feathers.controls.ToggleButton) 
            {
                loc1.selectedTexture = this.buttonSelectedUpSkinTexture;
                loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.buttonSelectedDisabledSkinTexture);
            }
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            this.setBaseButtonStyles(arg1);
            return;
        }

        protected function setButtonLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.darkUIElementFormat;
            arg1.disabledElementFormat = this.darkUIDisabledElementFormat;
            return;
        }

        protected function setCallToActionButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonCallToActionUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonCallToActionDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            this.setBaseButtonStyles(arg1);
            return;
        }

        protected function setQuietButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new starling.display.Quad(this.controlSize, this.controlSize, 16711935);
            loc1.alpha = 0;
            arg1.defaultSkin = loc1;
            var loc2:*=new feathers.skins.ImageSkin(null);
            loc2.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonDownSkinTexture);
            loc2.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            arg1.downSkin = loc2;
            arg1.disabledSkin = loc2;
            if (arg1 is feathers.controls.ToggleButton) 
            {
                loc2.selectedTexture = this.buttonSelectedUpSkinTexture;
                feathers.controls.ToggleButton(arg1).defaultSelectedSkin = loc2;
            }
            loc2.scale9Grid = BUTTON_SCALE9_GRID;
            loc2.width = this.controlSize;
            loc2.height = this.controlSize;
            arg1.customLabelStyleName = THEME_STYLE_NAME_QUIET_BUTTON_LABEL;
            arg1.paddingTop = this.smallControlGutterSize;
            arg1.paddingBottom = this.smallControlGutterSize;
            arg1.paddingLeft = this.smallGutterSize;
            arg1.paddingRight = this.smallGutterSize;
            arg1.gap = this.smallControlGutterSize;
            arg1.minGap = this.smallControlGutterSize;
            var loc3:*;
            arg1.minHeight = loc3 = this.controlSize;
            arg1.minWidth = loc3;
            arg1.minTouchHeight = loc3 = this.gridSize;
            arg1.minTouchWidth = loc3;
            return;
        }

        protected function setQuietButtonLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.selectedElementFormat = this.darkUIElementFormat;
            arg1.setElementFormatForState(feathers.controls.ButtonState.DOWN, this.darkUIElementFormat);
            arg1.setElementFormatForState(feathers.controls.ButtonState.DISABLED, this.lightUIDisabledElementFormat);
            if (arg1.stateContext is feathers.controls.ToggleButton) 
            {
                arg1.setElementFormatForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.darkUIDisabledElementFormat);
            }
            return;
        }

        protected function setDangerButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonDangerUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonDangerDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            this.setBaseButtonStyles(arg1);
            return;
        }

        protected function setBackButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonBackUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonBackDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonBackDisabledSkinTexture);
            loc1.scale9Grid = BACK_BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            this.setBaseButtonStyles(arg1);
            arg1.paddingLeft = this.gutterSize + this.smallGutterSize;
            return;
        }

        protected function setForwardButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonForwardUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonForwardDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonForwardDisabledSkinTexture);
            loc1.scale9Grid = FORWARD_BUTTON_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            this.setBaseButtonStyles(arg1);
            arg1.paddingRight = this.gutterSize + this.smallGutterSize;
            return;
        }

        protected function setButtonGroupStyles(arg1:feathers.controls.ButtonGroup):void
        {
            arg1.minWidth = this.popUpFillSize;
            arg1.gap = this.smallGutterSize;
            return;
        }

        protected function setButtonGroupButtonStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.buttonUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.buttonDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.buttonDisabledSkinTexture);
            if (arg1 is feathers.controls.ToggleButton) 
            {
                loc1.selectedTexture = this.buttonSelectedUpSkinTexture;
                loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.buttonSelectedDisabledSkinTexture);
            }
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.defaultSkin = loc1;
            arg1.customLabelStyleName = THEME_STYLE_NAME_BUTTON_GROUP_BUTTON_LABEL;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = this.smallGutterSize;
            arg1.minGap = this.smallGutterSize;
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setButtonGroupButtonLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.largeUIDarkElementFormat;
            arg1.disabledElementFormat = this.largeUIDarkDisabledElementFormat;
            return;
        }

        protected function setCalloutStyles(arg1:feathers.controls.Callout):void
        {
            var loc1:*=new starling.display.Image(this.backgroundLightBorderSkinTexture);
            loc1.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
            loc1.width = this.calloutBackgroundMinSize;
            loc1.height = this.calloutBackgroundMinSize;
            arg1.backgroundSkin = loc1;
            var loc2:*=new starling.display.Image(this.calloutTopArrowSkinTexture);
            arg1.topArrowSkin = loc2;
            arg1.topArrowGap = this.calloutArrowOverlapGap;
            var loc3:*=new starling.display.Image(this.calloutRightArrowSkinTexture);
            arg1.rightArrowSkin = loc3;
            arg1.rightArrowGap = this.calloutArrowOverlapGap;
            var loc4:*=new starling.display.Image(this.calloutBottomArrowSkinTexture);
            arg1.bottomArrowSkin = loc4;
            arg1.bottomArrowGap = this.calloutArrowOverlapGap;
            var loc5:*=new starling.display.Image(this.calloutLeftArrowSkinTexture);
            arg1.leftArrowSkin = loc5;
            arg1.leftArrowGap = this.calloutArrowOverlapGap;
            arg1.padding = this.smallGutterSize;
            return;
        }

        protected function setDangerCalloutStyles(arg1:feathers.controls.Callout):void
        {
            var loc1:*=new starling.display.Image(this.backgroundDangerBorderSkinTexture);
            loc1.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
            loc1.width = this.calloutBackgroundMinSize;
            loc1.height = this.calloutBackgroundMinSize;
            arg1.backgroundSkin = loc1;
            var loc2:*=new starling.display.Image(this.dangerCalloutTopArrowSkinTexture);
            arg1.topArrowSkin = loc2;
            arg1.topArrowGap = this.calloutArrowOverlapGap;
            var loc3:*=new starling.display.Image(this.dangerCalloutRightArrowSkinTexture);
            arg1.rightArrowSkin = loc3;
            arg1.rightArrowGap = this.calloutArrowOverlapGap;
            var loc4:*=new starling.display.Image(this.dangerCalloutBottomArrowSkinTexture);
            arg1.bottomArrowSkin = loc4;
            arg1.bottomArrowGap = this.calloutArrowOverlapGap;
            var loc5:*=new starling.display.Image(this.dangerCalloutLeftArrowSkinTexture);
            arg1.leftArrowSkin = loc5;
            arg1.leftArrowGap = this.calloutArrowOverlapGap;
            arg1.padding = this.smallGutterSize;
            return;
        }

        protected function setPickerListPopUpListStyles(arg1:feathers.controls.List):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (feathers.system.DeviceCapabilities.isTablet(starling.core.Starling.current.nativeStage)) 
            {
                arg1.minWidth = this.popUpFillSize;
                arg1.maxHeight = this.popUpFillSize;
            }
            else 
            {
                loc1 = new starling.display.Image(this.backgroundSkinTexture);
                loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
                loc1.width = this.gridSize;
                loc1.height = this.gridSize;
                arg1.backgroundSkin = loc1;
                arg1.padding = this.smallGutterSize;
                loc2 = new feathers.layout.VerticalLayout();
                loc2.horizontalAlign = feathers.layout.HorizontalAlign.JUSTIFY;
                loc2.requestedRowCount = 4;
                arg1.layout = loc2;
            }
            arg1.customItemRendererStyleName = feathers.controls.renderers.DefaultListItemRenderer.ALTERNATE_STYLE_NAME_CHECK;
            return;
        }

        
        {
            FONT_SIZE_EXTRALARGE = 36;
            FONT_SIZE_INPUT = 24;
            FONT_SIZE_LARGE = 28;
            FONT_SIZE_REGULAR = 24;
            FONT_SIZE_SMALL = 20;
            FONT_SIZE_SMALLEST = 18;
        }

        protected function setCheckLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            return;
        }

        protected function setDateTimeSpinnerListStyles(arg1:feathers.controls.SpinnerList):void
        {
            this.setSpinnerListStyles(arg1);
            arg1.customItemRendererStyleName = THEME_STYLE_NAME_DATE_TIME_SPINNER_LIST_ITEM_RENDERER;
            return;
        }

        protected function setDateTimeSpinnerListItemRendererStyles(arg1:feathers.controls.renderers.DefaultListItemRenderer):void
        {
            this.setSpinnerListItemRendererStyles(arg1);
            arg1.accessoryPosition = feathers.layout.RelativePosition.LEFT;
            arg1.gap = this.smallGutterSize;
            arg1.minGap = this.smallGutterSize;
            arg1.accessoryGap = this.smallGutterSize;
            arg1.minAccessoryGap = this.smallGutterSize;
            return;
        }

        protected function setDrawersStyles(arg1:feathers.controls.Drawers):void
        {
            var loc1:*=new starling.display.Quad(10, 10, DRAWER_OVERLAY_COLOR);
            loc1.alpha = DRAWER_OVERLAY_ALPHA;
            arg1.overlaySkin = loc1;
            var loc2:*=new starling.display.Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
            arg1.topDrawerDivider = loc2;
            var loc3:*=new starling.display.Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
            arg1.rightDrawerDivider = loc3;
            var loc4:*=new starling.display.Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
            arg1.bottomDrawerDivider = loc4;
            var loc5:*=new starling.display.Quad(this.borderSize, this.borderSize, DRAWER_OVERLAY_COLOR);
            arg1.leftDrawerDivider = loc5;
            return;
        }

        protected function setGroupedListStyles(arg1:feathers.controls.GroupedList):void
        {
            this.setScrollerStyles(arg1);
            var loc1:*=new starling.display.Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
            arg1.backgroundSkin = loc1;
            return;
        }

        protected function setGroupedListHeaderRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer):void
        {
            arg1.backgroundSkin = new starling.display.Quad(1, 1, GROUPED_LIST_HEADER_BACKGROUND_COLOR);
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.smallGutterSize + this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            return;
        }

        protected function setGroupedListFooterRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer):void
        {
            arg1.backgroundSkin = new starling.display.Quad(1, 1, GROUPED_LIST_FOOTER_BACKGROUND_COLOR);
            arg1.customContentLabelStyleName = THEME_STYLE_NAME_GROUPED_LIST_FOOTER_CONTENT_LABEL;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            var loc1:*;
            arg1.paddingBottom = loc1 = this.smallGutterSize;
            arg1.paddingTop = loc1;
            arg1.paddingLeft = this.smallGutterSize + this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            return;
        }

        protected function setGroupedListHeaderContentLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            return;
        }

        protected function setGroupedListFooterContentLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setInsetGroupedListStyles(arg1:feathers.controls.GroupedList):void
        {
            arg1.customItemRendererStyleName = feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER;
            arg1.customFirstItemRendererStyleName = feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER;
            arg1.customLastItemRendererStyleName = feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER;
            arg1.customSingleItemRendererStyleName = feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER;
            arg1.customHeaderRendererStyleName = feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER;
            arg1.customFooterRendererStyleName = feathers.controls.GroupedList.ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER;
            var loc1:*=new feathers.layout.VerticalLayout();
            loc1.useVirtualLayout = true;
            loc1.padding = this.smallGutterSize;
            loc1.gap = 0;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.JUSTIFY;
            loc1.verticalAlign = feathers.layout.VerticalAlign.TOP;
            arg1.layout = loc1;
            return;
        }

        protected function setInsetGroupedListItemRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListItemRenderer, arg2:starling.textures.Texture, arg3:starling.textures.Texture, arg4:flash.geom.Rectangle):void
        {
            var loc1:*=new feathers.skins.ImageSkin(arg2);
            loc1.selectedTexture = arg3;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, arg3);
            loc1.scale9Grid = arg4;
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.defaultSkin = loc1;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize + this.smallGutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = this.gutterSize;
            arg1.minGap = this.gutterSize;
            arg1.iconPosition = feathers.layout.RelativePosition.LEFT;
            arg1.accessoryGap = Number.POSITIVE_INFINITY;
            arg1.minAccessoryGap = this.gutterSize;
            arg1.accessoryPosition = feathers.layout.RelativePosition.RIGHT;
            var loc2:*;
            arg1.minHeight = loc2 = this.gridSize;
            arg1.minWidth = loc2;
            arg1.minTouchHeight = loc2 = this.gridSize;
            arg1.minTouchWidth = loc2;
            return;
        }

        protected function setInsetGroupedListMiddleItemRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListItemRenderer):void
        {
            this.setInsetGroupedListItemRendererStyles(arg1, this.insetItemRendererUpSkinTexture, this.insetItemRendererSelectedSkinTexture, INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID);
            return;
        }

        protected function setInsetGroupedListFirstItemRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListItemRenderer):void
        {
            this.setInsetGroupedListItemRendererStyles(arg1, this.insetItemRendererFirstUpSkinTexture, this.insetItemRendererFirstSelectedSkinTexture, INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
            return;
        }

        protected function setInsetGroupedListLastItemRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListItemRenderer):void
        {
            this.setInsetGroupedListItemRendererStyles(arg1, this.insetItemRendererLastUpSkinTexture, this.insetItemRendererLastSelectedSkinTexture, INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
            return;
        }

        protected function setInsetGroupedListSingleItemRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListItemRenderer):void
        {
            this.setInsetGroupedListItemRendererStyles(arg1, this.insetItemRendererSingleUpSkinTexture, this.insetItemRendererSingleSelectedSkinTexture, INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
            return;
        }

        protected function setInsetGroupedListHeaderRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer):void
        {
            var loc1:*=new starling.display.Quad(1, 1, 16711935);
            loc1.alpha = 0;
            arg1.backgroundSkin = loc1;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize + this.smallGutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            return;
        }

        protected function setInsetGroupedListFooterRendererStyles(arg1:feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer):void
        {
            var loc1:*=new starling.display.Quad(1, 1, 16711935);
            loc1.alpha = 0;
            arg1.backgroundSkin = loc1;
            arg1.customContentLabelStyleName = THEME_STYLE_NAME_GROUPED_LIST_FOOTER_CONTENT_LABEL;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize + this.smallGutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            return;
        }

        protected function setHeaderStyles(arg1:feathers.controls.Header):void
        {
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            arg1.padding = this.smallGutterSize;
            arg1.gap = this.smallGutterSize;
            arg1.titleGap = this.smallGutterSize;
            var loc1:*=new starling.display.Image(this.headerBackgroundSkinTexture);
            loc1.tileGrid = new flash.geom.Rectangle();
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.backgroundSkin = loc1;
            return;
        }

        protected function setHeaderTitleStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.headerElementFormat;
            arg1.disabledElementFormat = this.headerDisabledElementFormat;
            return;
        }

        protected function setLabelTextRendererStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setHeadingLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.customTextRendererStyleName = THEME_STYLE_NAME_HEADING_LABEL_TEXT_RENDERER;
            return;
        }

        protected function setHeadingLabelTextRendererStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.largeLightElementFormat;
            arg1.disabledElementFormat = this.largeDisabledElementFormat;
            return;
        }

        protected function setDetailLabelStyles(arg1:feathers.controls.Label):void
        {
            arg1.customTextRendererStyleName = THEME_STYLE_NAME_DETAIL_LABEL_TEXT_RENDERER;
            return;
        }

        protected function setDetailLabelTextRendererStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.smallLightElementFormat;
            arg1.disabledElementFormat = this.smallDisabledElementFormat;
            return;
        }

        protected function setToolbarLayoutGroupStyles(arg1:feathers.controls.LayoutGroup):void
        {
            var loc2:*=null;
            if (!arg1.layout) 
            {
                loc2 = new feathers.layout.HorizontalLayout();
                loc2.padding = this.smallGutterSize;
                loc2.gap = this.smallGutterSize;
                loc2.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                arg1.layout = loc2;
            }
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            var loc1:*=new starling.display.Image(this.headerBackgroundSkinTexture);
            loc1.tileGrid = new flash.geom.Rectangle();
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.backgroundSkin = loc1;
            return;
        }

        protected function setListStyles(arg1:feathers.controls.List):void
        {
            this.setScrollerStyles(arg1);
            var loc1:*=new starling.display.Quad(this.gridSize, this.gridSize, LIST_BACKGROUND_COLOR);
            arg1.backgroundSkin = loc1;
            return;
        }

        protected function setItemRendererStyles(arg1:feathers.controls.renderers.BaseDefaultItemRenderer):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.itemRendererUpSkinTexture);
            loc1.selectedTexture = this.itemRendererSelectedSkinTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.itemRendererSelectedSkinTexture);
            loc1.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.defaultSkin = loc1;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = this.gutterSize;
            arg1.minGap = this.gutterSize;
            arg1.iconPosition = feathers.layout.RelativePosition.LEFT;
            arg1.accessoryGap = Number.POSITIVE_INFINITY;
            arg1.minAccessoryGap = this.gutterSize;
            arg1.accessoryPosition = feathers.layout.RelativePosition.RIGHT;
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setDrillDownItemRendererStyles(arg1:feathers.controls.renderers.DefaultListItemRenderer):void
        {
            this.setItemRendererStyles(arg1);
            arg1.itemHasAccessory = false;
            var loc1:*=new feathers.skins.ImageSkin(this.listDrillDownAccessoryTexture);
            loc1.selectedTexture = this.listDrillDownAccessorySelectedTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.listDrillDownAccessorySelectedTexture);
            arg1.defaultAccessory = loc1;
            return;
        }

        protected function setCheckItemRendererStyles(arg1:feathers.controls.renderers.BaseDefaultItemRenderer):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.itemRendererUpSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.itemRendererSelectedSkinTexture);
            loc1.scale9Grid = ITEM_RENDERER_SCALE9_GRID;
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.defaultSkin = loc1;
            var loc2:*=new feathers.controls.ImageLoader();
            loc2.source = this.pickerListItemSelectedIconTexture;
            arg1.defaultSelectedIcon = loc2;
            loc2.validate();
            var loc3:*=new starling.display.Quad(loc2.width, loc2.height, 16711935);
            loc3.alpha = 0;
            arg1.defaultIcon = loc3;
            arg1.customLabelStyleName = THEME_STYLE_NAME_CHECK_ITEM_RENDERER_LABEL;
            arg1.customIconLabelStyleName = THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ICON_LABEL;
            arg1.customAccessoryLabelStyleName = THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ACCESSORY_LABEL;
            arg1.itemHasIcon = false;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = Number.POSITIVE_INFINITY;
            arg1.minGap = this.gutterSize;
            arg1.iconPosition = feathers.layout.RelativePosition.RIGHT;
            arg1.accessoryGap = this.smallGutterSize;
            arg1.minAccessoryGap = this.smallGutterSize;
            arg1.accessoryPosition = feathers.layout.RelativePosition.BOTTOM;
            arg1.layoutOrder = feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON;
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setItemRendererLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.largeLightElementFormat;
            arg1.disabledElementFormat = this.largeDisabledElementFormat;
            arg1.selectedElementFormat = this.largeDarkElementFormat;
            arg1.setElementFormatForState(feathers.controls.ButtonState.DOWN, this.largeDarkElementFormat);
            return;
        }

        protected function setItemRendererAccessoryLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            arg1.selectedElementFormat = this.darkElementFormat;
            arg1.setElementFormatForState(feathers.controls.ButtonState.DOWN, this.darkElementFormat);
            return;
        }

        protected function setItemRendererIconLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            arg1.selectedElementFormat = this.darkElementFormat;
            arg1.setElementFormatForState(feathers.controls.ButtonState.DOWN, this.darkElementFormat);
            return;
        }

        protected function setCheckItemRendererLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.largeLightElementFormat;
            arg1.disabledElementFormat = this.largeDisabledElementFormat;
            arg1.setElementFormatForState(feathers.controls.ButtonState.DOWN, this.largeDarkElementFormat);
            return;
        }

        protected function setCheckItemRendererAccessoryLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setCheckItemRendererIconLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setNumericStepperStyles(arg1:feathers.controls.NumericStepper):void
        {
            arg1.buttonLayoutMode = feathers.controls.StepperButtonLayoutMode.SPLIT_HORIZONTAL;
            arg1.incrementButtonLabel = "+";
            arg1.decrementButtonLabel = "-";
            return;
        }

        protected function setNumericStepperTextInputStyles(arg1:feathers.controls.TextInput):void
        {
            var loc1:*=new starling.display.Image(this.backgroundSkinTexture);
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.controlSize;
            arg1.backgroundSkin = loc1;
            var loc2:*=new starling.display.Image(this.backgroundDisabledSkinTexture);
            loc2.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc2.width = this.controlSize;
            loc2.height = this.controlSize;
            arg1.backgroundDisabledSkin = loc2;
            var loc3:*=new starling.display.Image(this.backgroundInsetFocusedSkinTexture);
            loc3.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc3.width = this.controlSize;
            loc3.height = this.controlSize;
            arg1.backgroundFocusedSkin = loc3;
            var loc4:*=new starling.display.Image(this.backgroundInsetFocusedSkinTexture);
            loc4.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc4.width = this.controlSize;
            loc4.height = this.controlSize;
            arg1.backgroundEnabledSkin = loc4;
            arg1.textEditorFactory = stepperTextEditorFactory;
            arg1.customTextEditorStyleName = THEME_STYLE_NAME_NUMERIC_STEPPER_TEXT_INPUT_EDITOR;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            arg1.gap = this.smallControlGutterSize;
            arg1.paddingTop = this.smallControlGutterSize;
            arg1.paddingRight = this.smallGutterSize;
            arg1.paddingBottom = this.smallControlGutterSize;
            arg1.paddingLeft = this.smallGutterSize;
            arg1.isEditable = false;
            arg1.isSelectable = false;
            return;
        }

        protected function setNumericStepperTextInputEditorStyles(arg1:feathers.controls.text.TextBlockTextEditor):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            arg1.textAlign = feathers.controls.text.TextBlockTextEditor.TEXT_ALIGN_CENTER;
            return;
        }

        protected function setNumericStepperButtonStyles(arg1:feathers.controls.Button):void
        {
            this.setButtonStyles(arg1);
            arg1.keepDownStateOnRollOut = true;
            return;
        }

        protected function setPageIndicatorStyles(arg1:feathers.controls.PageIndicator):void
        {
            arg1.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
            arg1.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
            arg1.gap = this.smallGutterSize;
            arg1.padding = this.smallGutterSize;
            arg1.minTouchWidth = this.smallControlSize * 2;
            arg1.minTouchHeight = this.smallControlSize * 2;
            return;
        }

        protected function setPanelStyles(arg1:feathers.controls.Panel):void
        {
            this.setScrollerStyles(arg1);
            var loc1:*=new starling.display.Image(this.backgroundLightBorderSkinTexture);
            loc1.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
            arg1.backgroundSkin = loc1;
            arg1.padding = this.smallGutterSize;
            arg1.outerPadding = this.borderSize;
            return;
        }

        protected function setPopUpHeaderStyles(arg1:feathers.controls.Header):void
        {
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            arg1.padding = this.smallGutterSize;
            arg1.gap = this.smallGutterSize;
            arg1.titleGap = this.smallGutterSize;
            var loc1:*=new starling.display.Image(this.popUpHeaderBackgroundSkinTexture);
            loc1.tileGrid = new flash.geom.Rectangle();
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.backgroundSkin = loc1;
            return;
        }

        protected function setPanelScreenStyles(arg1:feathers.controls.PanelScreen):void
        {
            this.setScrollerStyles(arg1);
            return;
        }

        protected function setPanelScreenHeaderStyles(arg1:feathers.controls.Header):void
        {
            this.setHeaderStyles(arg1);
            arg1.useExtraPaddingForOSStatusBar = true;
            return;
        }

        protected function setPickerListStyles(arg1:feathers.controls.PickerList):void
        {
            if (feathers.system.DeviceCapabilities.isTablet(starling.core.Starling.current.nativeStage)) 
            {
                arg1.popUpContentManager = new feathers.controls.popups.CalloutPopUpContentManager();
            }
            else 
            {
                arg1.listFactory = pickerListSpinnerListFactory;
                arg1.popUpContentManager = new feathers.controls.popups.BottomDrawerPopUpContentManager();
            }
            return;
        }

        protected function setPickerListButtonStyles(arg1:feathers.controls.Button):void
        {
            this.setButtonStyles(arg1);
            var loc1:*=new feathers.skins.ImageSkin(this.pickerListButtonIconTexture);
            loc1.selectedTexture = this.pickerListButtonSelectedIconTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.pickerListButtonIconDisabledTexture);
            arg1.defaultIcon = loc1;
            arg1.gap = Number.POSITIVE_INFINITY;
            arg1.minGap = this.gutterSize;
            arg1.iconPosition = feathers.layout.RelativePosition.RIGHT;
            return;
        }

        protected function setProgressBarStyles(arg1:feathers.controls.ProgressBar):void
        {
            var loc1:*=new starling.display.Image(this.backgroundSkinTexture);
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            if (arg1.direction != feathers.layout.Direction.VERTICAL) 
            {
                loc1.width = this.wideControlSize;
                loc1.height = this.smallControlSize;
            }
            else 
            {
                loc1.width = this.smallControlSize;
                loc1.height = this.wideControlSize;
            }
            arg1.backgroundSkin = loc1;
            var loc2:*=new starling.display.Image(this.backgroundDisabledSkinTexture);
            loc2.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            if (arg1.direction != feathers.layout.Direction.VERTICAL) 
            {
                loc2.width = this.wideControlSize;
                loc2.height = this.smallControlSize;
            }
            else 
            {
                loc2.width = this.smallControlSize;
                loc2.height = this.wideControlSize;
            }
            arg1.backgroundDisabledSkin = loc2;
            var loc3:*=new starling.display.Image(this.buttonUpSkinTexture);
            loc3.scale9Grid = BUTTON_SCALE9_GRID;
            if (arg1.direction != feathers.layout.Direction.VERTICAL) 
            {
                loc3.width = this.smallControlSize;
                loc3.height = this.smallControlSize;
            }
            else 
            {
                loc3.width = this.smallControlSize;
                loc3.height = this.smallControlSize;
            }
            arg1.fillSkin = loc3;
            var loc4:*=new starling.display.Image(this.buttonDisabledSkinTexture);
            loc4.scale9Grid = BUTTON_SCALE9_GRID;
            if (arg1.direction != feathers.layout.Direction.VERTICAL) 
            {
                loc4.width = this.smallControlSize;
                loc4.height = this.smallControlSize;
            }
            else 
            {
                loc4.width = this.smallControlSize;
                loc4.height = this.smallControlSize;
            }
            arg1.fillDisabledSkin = loc4;
            return;
        }

        protected function setRadioStyles(arg1:feathers.controls.Radio):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.radioUpIconTexture);
            loc1.selectedTexture = this.radioSelectedUpIconTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.radioDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.radioDisabledIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, this.radioSelectedDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.radioSelectedDisabledIconTexture);
            loc1.width = this.checkSize;
            loc1.height = this.checkSize;
            arg1.defaultIcon = loc1;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.gap = this.smallControlGutterSize;
            arg1.minGap = this.smallControlGutterSize;
            arg1.minWidth = this.checkSize;
            arg1.minHeight = this.checkSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setRadioLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            return;
        }

        protected function setScrollContainerStyles(arg1:feathers.controls.ScrollContainer):void
        {
            this.setScrollerStyles(arg1);
            return;
        }

        protected function setToolbarScrollContainerStyles(arg1:feathers.controls.ScrollContainer):void
        {
            var loc2:*=null;
            this.setScrollerStyles(arg1);
            if (!arg1.layout) 
            {
                loc2 = new feathers.layout.HorizontalLayout();
                loc2.padding = this.smallGutterSize;
                loc2.gap = this.smallGutterSize;
                loc2.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
                arg1.layout = loc2;
            }
            arg1.minWidth = this.gridSize;
            arg1.minHeight = this.gridSize;
            var loc1:*=new starling.display.Image(this.headerBackgroundSkinTexture);
            loc1.tileGrid = new flash.geom.Rectangle();
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.backgroundSkin = loc1;
            return;
        }

        protected function setScrollScreenStyles(arg1:feathers.controls.ScrollScreen):void
        {
            this.setScrollerStyles(arg1);
            return;
        }

        protected function setScrollTextStyles(arg1:feathers.controls.ScrollText):void
        {
            this.setScrollerStyles(arg1);
            arg1.textFormat = this.scrollTextTextFormat;
            arg1.disabledTextFormat = this.scrollTextDisabledTextFormat;
            arg1.padding = this.gutterSize;
            arg1.paddingRight = this.gutterSize + this.smallGutterSize;
            return;
        }

        protected function setSimpleScrollBarStyles(arg1:feathers.controls.SimpleScrollBar):void
        {
            if (arg1.direction != feathers.layout.Direction.HORIZONTAL) 
            {
                arg1.paddingTop = this.scrollBarGutterSize;
                arg1.paddingRight = this.scrollBarGutterSize;
                arg1.paddingBottom = this.scrollBarGutterSize;
                arg1.customThumbStyleName = THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
            }
            else 
            {
                arg1.paddingRight = this.scrollBarGutterSize;
                arg1.paddingBottom = this.scrollBarGutterSize;
                arg1.paddingLeft = this.scrollBarGutterSize;
                arg1.customThumbStyleName = THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
            }
            return;
        }

        protected function setHorizontalSimpleScrollBarThumbStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new starling.display.Image(this.horizontalScrollBarThumbSkinTexture);
            loc1.scale9Grid = HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID;
            loc1.width = this.smallGutterSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setVerticalSimpleScrollBarThumbStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new starling.display.Image(this.verticalScrollBarThumbSkinTexture);
            loc1.scale9Grid = VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID;
            loc1.height = this.smallGutterSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setSliderStyles(arg1:feathers.controls.Slider):void
        {
            arg1.trackLayoutMode = feathers.controls.TrackLayoutMode.SPLIT;
            if (arg1.direction != feathers.layout.Direction.VERTICAL) 
            {
                arg1.customMinimumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
                arg1.customMaximumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
                arg1.minHeight = this.controlSize;
            }
            else 
            {
                arg1.customMinimumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
                arg1.customMaximumTrackStyleName = THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
                arg1.minWidth = this.controlSize;
            }
            return;
        }

        protected function setHorizontalSliderMinimumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundSkinTexture);
            loc1.disabledTexture = this.backgroundDisabledSkinTexture;
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.wideControlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setHorizontalSliderMaximumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundSkinTexture);
            loc1.disabledTexture = this.backgroundDisabledSkinTexture;
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.wideControlSize;
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setVerticalSliderMinimumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundSkinTexture);
            loc1.disabledTexture = this.backgroundDisabledSkinTexture;
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.wideControlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setVerticalSliderMaximumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundSkinTexture);
            loc1.disabledTexture = this.backgroundDisabledSkinTexture;
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.controlSize;
            loc1.height = this.wideControlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setSpinnerListStyles(arg1:feathers.controls.SpinnerList):void
        {
            this.setScrollerStyles(arg1);
            var loc1:*=new starling.display.Image(this.backgroundSkinTexture);
            loc1.scale9Grid = SMALL_BACKGROUND_SCALE9_GRID;
            arg1.backgroundSkin = loc1;
            var loc2:*=new starling.display.Image(this.spinnerListSelectionOverlaySkinTexture);
            loc2.scale9Grid = SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID;
            arg1.selectionOverlaySkin = loc2;
            arg1.customItemRendererStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER;
            arg1.paddingTop = this.borderSize;
            arg1.paddingBottom = this.borderSize;
            return;
        }

        protected function setSpinnerListItemRendererStyles(arg1:feathers.controls.renderers.DefaultListItemRenderer):void
        {
            var loc1:*=new starling.display.Quad(1, 1, 16711935);
            loc1.alpha = 0;
            arg1.defaultSkin = loc1;
            arg1.customLabelStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_LABEL;
            arg1.customIconLabelStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ICON_LABEL;
            arg1.customAccessoryLabelStyleName = THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ACCESSORY_LABEL;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = this.gutterSize;
            arg1.minGap = this.gutterSize;
            arg1.iconPosition = feathers.layout.RelativePosition.LEFT;
            arg1.accessoryGap = Number.POSITIVE_INFINITY;
            arg1.minAccessoryGap = this.gutterSize;
            arg1.accessoryPosition = feathers.layout.RelativePosition.RIGHT;
            arg1.minHeight = this.gridSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setSpinnerListItemRendererLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.largeLightElementFormat;
            arg1.disabledElementFormat = this.largeDisabledElementFormat;
            return;
        }

        protected function setSpinnerListItemRendererIconLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setSpinnerListItemRendererAccessoryLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setTabBarStyles(arg1:feathers.controls.TabBar):void
        {
            arg1.distributeTabSizes = true;
            return;
        }

        protected function setTabStyles(arg1:feathers.controls.ToggleButton):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.tabUpSkinTexture);
            loc1.selectedTexture = this.tabSelectedUpSkinTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.tabDownSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.tabDisabledSkinTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.tabSelectedDisabledSkinTexture);
            loc1.scale9Grid = TAB_SCALE9_GRID;
            loc1.width = this.gridSize;
            loc1.height = this.gridSize;
            arg1.defaultSkin = loc1;
            arg1.customLabelStyleName = THEME_STYLE_NAME_TAB_LABEL;
            arg1.paddingTop = this.smallGutterSize;
            arg1.paddingBottom = this.smallGutterSize;
            arg1.paddingLeft = this.gutterSize;
            arg1.paddingRight = this.gutterSize;
            arg1.gap = this.smallGutterSize;
            arg1.minGap = this.smallGutterSize;
            var loc2:*;
            arg1.minHeight = loc2 = this.gridSize;
            arg1.minWidth = loc2;
            arg1.minTouchHeight = loc2 = this.gridSize;
            arg1.minTouchWidth = loc2;
            return;
        }

        protected function setTabLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            arg1.selectedElementFormat = this.darkUIElementFormat;
            return;
        }

        protected function setTextAreaStyles(arg1:feathers.controls.TextArea):void
        {
            this.setScrollerStyles(arg1);
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundInsetSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.DISABLED, this.backgroundDisabledSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.FOCUSED, this.backgroundInsetFocusedSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.ERROR, this.backgroundInsetDangerSkinTexture);
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.wideControlSize;
            loc1.height = this.wideControlSize;
            arg1.backgroundSkin = loc1;
            arg1.textEditorFactory = textAreaTextEditorFactory;
            return;
        }

        protected function setTextAreaTextEditorStyles(arg1:feathers.controls.text.TextFieldTextEditorViewPort):void
        {
            arg1.textFormat = this.scrollTextTextFormat;
            arg1.disabledTextFormat = this.scrollTextDisabledTextFormat;
            arg1.padding = this.smallGutterSize;
            return;
        }

        protected function setTextAreaErrorCalloutStyles(arg1:feathers.controls.TextCallout):void
        {
            this.setDangerCalloutStyles(arg1);
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.verticalAlign = feathers.layout.VerticalAlign.TOP;
            return;
        }

        protected function setTextCalloutStyles(arg1:feathers.controls.TextCallout):void
        {
            this.setCalloutStyles(arg1);
            return;
        }

        protected function setTextCalloutTextRendererStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            return;
        }

        protected function setBaseTextInputStyles(arg1:feathers.controls.TextInput):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundInsetSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.DISABLED, this.backgroundInsetDisabledSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.ENABLED, this.backgroundInsetEnabledSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.FOCUSED, this.backgroundInsetFocusedSkinTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.ERROR, this.backgroundInsetDangerSkinTexture);
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.wideControlSize;
            loc1.height = this.controlSize;
            arg1.backgroundSkin = loc1;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            arg1.gap = this.smallControlGutterSize;
            arg1.paddingTop = this.smallControlGutterSize;
            arg1.paddingRight = this.smallGutterSize;
            arg1.paddingBottom = this.smallControlGutterSize;
            arg1.paddingLeft = this.smallGutterSize;
            arg1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            return;
        }

        protected function setTextInputStyles(arg1:feathers.controls.TextInput):void
        {
            this.setBaseTextInputStyles(arg1);
            return;
        }

        protected function setTextInputTextEditorStyles(arg1:feathers.controls.text.StageTextTextEditor):void
        {
            arg1.fontFamily = FONT_NAME_ARIAL;
            arg1.fontSize = this.regularFontSize;
            arg1.color = TEXT_COLOR_DARK;
            arg1.disabledColor = TEXT_COLOR_DISABLED;
            return;
        }

        protected function setTextInputPromptStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightElementFormat;
            arg1.disabledElementFormat = this.disabledElementFormat;
            return;
        }

        protected function setTextInputErrorCalloutStyles(arg1:feathers.controls.TextCallout):void
        {
            this.setDangerCalloutStyles(arg1);
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.verticalAlign = feathers.layout.VerticalAlign.TOP;
            return;
        }

        protected function setSearchTextInputStyles(arg1:feathers.controls.TextInput):void
        {
            this.setBaseTextInputStyles(arg1);
            var loc1:*=new feathers.skins.ImageSkin(this.searchIconTexture);
            loc1.setTextureForState(feathers.controls.TextInputState.DISABLED, this.searchIconDisabledTexture);
            arg1.defaultIcon = loc1;
            return;
        }

        protected function setToggleSwitchStyles(arg1:feathers.controls.ToggleSwitch):void
        {
            arg1.trackLayoutMode = feathers.controls.TrackLayoutMode.SINGLE;
            return;
        }

        protected function setToggleSwitchTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.backgroundSkinTexture);
            loc1.disabledTexture = this.backgroundDisabledSkinTexture;
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = Math.round(this.controlSize * 2.5);
            loc1.height = this.controlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            return;
        }

        protected function setToggleSwitchOffLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.lightUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            return;
        }

        protected function setToggleSwitchOnLabelStyles(arg1:feathers.controls.text.TextBlockTextRenderer):void
        {
            arg1.elementFormat = this.selectedUIElementFormat;
            arg1.disabledElementFormat = this.lightUIDisabledElementFormat;
            return;
        }

        protected function setPlayPauseToggleButtonStyles(arg1:feathers.media.PlayPauseToggleButton):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.playPauseButtonPlayUpIconTexture);
            loc1.selectedTexture = this.playPauseButtonPauseUpIconTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.playPauseButtonPlayDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, this.playPauseButtonPauseDownIconTexture);
            arg1.defaultIcon = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setOverlayPlayPauseToggleButtonStyles(arg1:feathers.media.PlayPauseToggleButton):void
        {
            var loc1:*=new feathers.skins.ImageSkin(null);
            loc1.setTextureForState(feathers.controls.ButtonState.UP, this.overlayPlayPauseButtonPlayUpIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.HOVER, this.overlayPlayPauseButtonPlayUpIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.overlayPlayPauseButtonPlayDownIconTexture);
            arg1.defaultIcon = loc1;
            arg1.hasLabelTextRenderer = false;
            var loc2:*=new starling.display.Quad(1, 1, VIDEO_OVERLAY_COLOR);
            loc2.alpha = VIDEO_OVERLAY_ALPHA;
            arg1.upSkin = loc2;
            arg1.hoverSkin = loc2;
            return;
        }

        protected function setFullScreenToggleButtonStyles(arg1:feathers.media.FullScreenToggleButton):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.fullScreenToggleButtonEnterUpIconTexture);
            loc1.selectedTexture = this.fullScreenToggleButtonExitUpIconTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.fullScreenToggleButtonEnterDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, this.fullScreenToggleButtonExitDownIconTexture);
            arg1.defaultIcon = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setMuteToggleButtonStyles(arg1:feathers.media.MuteToggleButton):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.muteToggleButtonLoudUpIconTexture);
            loc1.selectedTexture = this.muteToggleButtonMutedUpIconTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.muteToggleButtonLoudDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, this.muteToggleButtonMutedDownIconTexture);
            arg1.defaultIcon = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.showVolumeSliderOnHover = false;
            arg1.minWidth = this.controlSize;
            arg1.minHeight = this.controlSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setSeekSliderStyles(arg1:feathers.media.SeekSlider):void
        {
            arg1.trackLayoutMode = feathers.controls.TrackLayoutMode.SPLIT;
            arg1.showThumb = false;
            if (arg1.direction != feathers.layout.Direction.VERTICAL) 
            {
                arg1.minWidth = this.controlSize;
                arg1.minHeight = this.smallControlSize;
            }
            else 
            {
                arg1.minWidth = this.smallControlSize;
                arg1.minHeight = this.controlSize;
            }
            var loc1:*=new starling.display.Image(this.seekSliderProgressSkinTexture);
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.smallControlSize;
            loc1.height = this.smallControlSize;
            arg1.progressSkin = loc1;
            return;
        }

        protected function setSeekSliderThumbStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=6;
            arg1.defaultSkin = new starling.display.Quad(loc1, loc1);
            arg1.hasLabelTextRenderer = false;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setCheckStyles(arg1:feathers.controls.Check):void
        {
            var loc1:*=new feathers.skins.ImageSkin(this.checkUpIconTexture);
            loc1.selectedTexture = this.checkSelectedUpIconTexture;
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN, this.checkDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED, this.checkDisabledIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DOWN_AND_SELECTED, this.checkSelectedDownIconTexture);
            loc1.setTextureForState(feathers.controls.ButtonState.DISABLED_AND_SELECTED, this.checkSelectedDisabledIconTexture);
            loc1.scale9Grid = CHECK_SKIN_TEXTURE_REGION;
            loc1.width = this.checkSize;
            loc1.height = this.checkSize;
            arg1.defaultIcon = loc1;
            arg1.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            arg1.gap = this.smallControlGutterSize;
            arg1.minGap = this.smallControlGutterSize;
            arg1.minWidth = this.checkSize;
            arg1.minHeight = this.checkSize;
            arg1.minTouchWidth = this.gridSize;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setSeekSliderMinimumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new starling.display.Image(this.buttonUpSkinTexture);
            loc1.scale9Grid = BUTTON_SCALE9_GRID;
            loc1.width = this.wideControlSize;
            loc1.height = this.smallControlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected function setSeekSliderMaximumTrackStyles(arg1:feathers.controls.Button):void
        {
            var loc1:*=new starling.display.Image(this.backgroundSkinTexture);
            loc1.scale9Grid = DEFAULT_BACKGROUND_SCALE9_GRID;
            loc1.width = this.wideControlSize;
            loc1.height = this.smallControlSize;
            arg1.defaultSkin = loc1;
            arg1.hasLabelTextRenderer = false;
            arg1.minTouchHeight = this.gridSize;
            return;
        }

        protected static const THEME_STYLE_NAME_CHECK_ITEM_RENDERER_LABEL:String="metal-works-mobile-check-item-renderer-label";

        public static const FONT_EUROSTILE_OBLIQUECFF:Class=feathers.themes.BaseSIGMATheme_FONT_EUROSTILE_OBLIQUECFF;

        public static const FONT_EUROSTILE_VALUESCFF:Class=feathers.themes.BaseSIGMATheme_FONT_EUROSTILE_VALUESCFF;

        public static const FONT_NAME:String="Eurostile";

        public static const FONT_NAME_ARIAL:String="Arial";

        public static const FONT_NAME_ARIAL_BOLD:String="ArialBold";

        public static const FONT_NAME_EURO_OBLIQUE:String="EurostileOblique";

        public static const FONT_NAME_VALUES:String="EurostileValues";

        public static const ORIGINAL_DPI_IPAD_RETINA:int=264;

        public static const ORIGINAL_DPI_IPHONE_RETINA:int=326;

        protected static const BACK_BUTTON_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(13, 0, 1, 28);

        protected static const BUTTON_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(4, 4, 1, 20);

        protected static const CHECK_SKIN_TEXTURE_REGION:flash.geom.Rectangle=new flash.geom.Rectangle(1, 1, 30, 30);

        protected static const DARK_DISABLED_TEXT_COLOR:uint=3683376;

        protected static const DEFAULT_BACKGROUND_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(4, 4, 1, 1);

        protected static const DRAWER_OVERLAY_ALPHA:Number=0.4;

        protected static const DRAWER_OVERLAY_COLOR:uint=2696222;

        protected static const FORWARD_BUTTON_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(3, 0, 1, 28);

        protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint=3025446;

        protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint=3025446;

        protected static const HEADER_SKIN_TEXTURE_REGION:flash.geom.Rectangle=new flash.geom.Rectangle(1, 1, 128, 64);

        protected static const HORIZONTAL_SCROLL_BAR_THUMB_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(4, 0, 4, 5);

        protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(7, 7, 1, 35);

        protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(7, 2, 1, 35);

        protected static const INSET_ITEM_RENDERER_MIDDLE_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(2, 2, 1, 40);

        protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(7, 7, 1, 30);

        protected static const ITEM_RENDERER_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(1, 1, 1, 42);

        protected static const LIST_BACKGROUND_COLOR:uint=15396337;

        protected static const MODAL_OVERLAY_ALPHA:Number=0.8;

        protected static const NUMBER_TEXT_COLOR:uint=13046322;

        protected static const PRIMARY_BACKGROUND_COLOR:uint=4866359;

        protected static const SELECTED_TEXT_COLOR:uint=16750848;

        protected static const SMALL_BACKGROUND_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(2, 2, 1, 1);

        protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(8, 0, 8, 88);

        protected static const TAB_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(11, 11, 1, 22);

        protected static const TAB_SKIN_TEXTURE_REGION:flash.geom.Rectangle=new flash.geom.Rectangle(1, 0, 22, 44);

        protected static const TEXT_COLOR_DARK:uint=3028545;

        protected static const TEXT_COLOR_DARK_DISABLED:uint=15396337;

        protected static const TEXT_COLOR_DISABLED:uint=9079434;

        protected static const TEXT_COLOR_LIGHT:uint=8488589;

        protected static const TEXT_COLOR_RED:uint=13046322;

        protected static const TEXT_COLOR_SELECTED:uint=16750848;

        protected static const THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON:String="metal-works-mobile-alert-button-group-button";

        protected static const THEME_STYLE_NAME_BUTTON_GROUP_BUTTON_LABEL:String="metal-works-mobile-button-group-button-label";

        protected static const THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ACCESSORY_LABEL:String="metal-works-mobile-check-item-renderer-accessory-label";

        protected static const THEME_STYLE_NAME_CHECK_ITEM_RENDERER_ICON_LABEL:String="metal-works-mobile-check-item-renderer-icon-label";

        protected static const THEME_STYLE_NAME_DATE_TIME_SPINNER_LIST_ITEM_RENDERER:String="metal-works-mobile-date-time-spinner-list-item-renderer";

        protected static const THEME_STYLE_NAME_DETAIL_LABEL_TEXT_RENDERER:String="metal-works-mobile-detail-label-text-renderer";

        protected static const THEME_STYLE_NAME_GROUPED_LIST_FOOTER_CONTENT_LABEL:String="metal-works-mobile-grouped-list-footer-content-label";

        protected static const THEME_STYLE_NAME_HEADING_LABEL_TEXT_RENDERER:String="metal-works-mobile-heading-label-text-renderer";

        protected static const THEME_STYLE_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String="metal-works-mobile-horizontal-simple-scroll-bar-thumb";

        protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String="metal-works-mobile-horizontal-slider-maximum-track";

        protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String="metal-works-mobile-horizontal-slider-minimum-track";

        protected static const THEME_STYLE_NAME_NUMERIC_STEPPER_TEXT_INPUT_EDITOR:String="metal-works-mobile-numeric-stepper-text-input-editor";

        protected static const THEME_STYLE_NAME_QUIET_BUTTON_LABEL:String="metal-works-mobile-quiet-button-label";

        protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER:String="metal-works-mobile-spinner-list-item-renderer";

        protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ACCESSORY_LABEL:String="metal-works-mobile-spinner-list-item-renderer-accessory-label";

        protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_ICON_LABEL:String="metal-works-mobile-spinner-list-item-renderer-icon-label";

        protected static const THEME_STYLE_NAME_SPINNER_LIST_ITEM_RENDERER_LABEL:String="metal-works-mobile-spinner-list-item-renderer-label";

        protected static const THEME_STYLE_NAME_TAB_LABEL:String="metal-works-mobile-tab-label";

        protected static const THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String="metal-works-mobile-vertical-simple-scroll-bar-thumb";

        protected static const THEME_STYLE_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String="metal-works-mobile-vertical-slider-maximum-track";

        protected static const THEME_STYLE_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String="metal-works-mobile-vertical-slider-minimum-track";

        protected static const VERTICAL_SCROLL_BAR_THUMB_SCALE9_GRID:flash.geom.Rectangle=new flash.geom.Rectangle(0, 4, 5, 4);

        protected static const VIDEO_OVERLAY_ALPHA:Number=0.2;

        protected static const VIDEO_OVERLAY_COLOR:uint=1710102;

        public static const FONT_ARIAL:Class=feathers.themes.BaseSIGMATheme_FONT_ARIAL;

        public static const FONT_ARIAL_BOLD:Class=feathers.themes.BaseSIGMATheme_FONT_ARIAL_BOLD;

        public static const FONT_ARIAL_ITALIC:Class=feathers.themes.BaseSIGMATheme_FONT_ARIAL_ITALIC;

        public static const FONT_EUROSTILE:Class=feathers.themes.BaseSIGMATheme_FONT_EUROSTILE;

        public static const FONT_EUROSTILE_BOLD:Class=feathers.themes.BaseSIGMATheme_FONT_EUROSTILE_BOLD;

        public static const FONT_EUROSTILE_OBLIQUE:Class=feathers.themes.BaseSIGMATheme_FONT_EUROSTILE_OBLIQUE;

        protected static const MODAL_OVERLAY_COLOR:uint=2696222;

        protected var insetItemRendererSelectedSkinTexture:starling.textures.Texture;

        protected var insetItemRendererSingleSelectedSkinTexture:starling.textures.Texture;

        protected var insetItemRendererSingleUpSkinTexture:starling.textures.Texture;

        protected var insetItemRendererUpSkinTexture:starling.textures.Texture;

        protected var itemRendererSelectedSkinTexture:starling.textures.Texture;

        protected var itemRendererUpSkinTexture:starling.textures.Texture;

        protected var largeDarkElementFormat:flash.text.engine.ElementFormat;

        protected var largeDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var largeFontSize:int;

        protected var largeLightElementFormat:flash.text.engine.ElementFormat;

        protected var largeUIDarkDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var largeUIDarkElementFormat:flash.text.engine.ElementFormat;

        protected var largeUILightDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var largeUILightElementFormat:flash.text.engine.ElementFormat;

        protected var largeUISelectedElementFormat:flash.text.engine.ElementFormat;

        protected var lightElementFormat:flash.text.engine.ElementFormat;

        protected var lightUIDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var lightUIElementFormat:flash.text.engine.ElementFormat;

        protected var listDrillDownAccessorySelectedTexture:starling.textures.Texture;

        protected var listDrillDownAccessoryTexture:starling.textures.Texture;

        protected var muteToggleButtonLoudDownIconTexture:starling.textures.Texture;

        protected var muteToggleButtonLoudUpIconTexture:starling.textures.Texture;

        protected var muteToggleButtonMutedDownIconTexture:starling.textures.Texture;

        protected var muteToggleButtonMutedUpIconTexture:starling.textures.Texture;

        protected var overlayPlayPauseButtonPlayDownIconTexture:starling.textures.Texture;

        protected var overlayPlayPauseButtonPlayUpIconTexture:starling.textures.Texture;

        protected var pageIndicatorNormalSkinTexture:starling.textures.Texture;

        protected var pageIndicatorSelectedSkinTexture:starling.textures.Texture;

        protected var pickerListButtonIconDisabledTexture:starling.textures.Texture;

        protected var pickerListButtonIconTexture:starling.textures.Texture;

        protected var pickerListButtonSelectedIconTexture:starling.textures.Texture;

        protected var pickerListItemSelectedIconTexture:starling.textures.Texture;

        protected var playPauseButtonPauseDownIconTexture:starling.textures.Texture;

        protected var playPauseButtonPauseUpIconTexture:starling.textures.Texture;

        protected var playPauseButtonPlayDownIconTexture:starling.textures.Texture;

        protected var playPauseButtonPlayUpIconTexture:starling.textures.Texture;

        protected var popUpFillSize:int;

        protected var popUpHeaderBackgroundSkinTexture:starling.textures.Texture;

        protected var radioDisabledIconTexture:starling.textures.Texture;

        protected var radioDownIconTexture:starling.textures.Texture;

        protected var radioSelectedDisabledIconTexture:starling.textures.Texture;

        protected var buttonForwardDownSkinTexture:starling.textures.Texture;

        protected var radioSelectedUpIconTexture:starling.textures.Texture;

        protected var radioUpIconTexture:starling.textures.Texture;

        protected var redButtonDownSkinTexture:starling.textures.Texture;

        protected var redButtonUpSkinTexture:starling.textures.Texture;

        protected var regularFontDescription:flash.text.engine.FontDescription;

        protected var regularFontSize:int;

        protected var scrollBarGutterSize:int;

        protected var scrollTextDisabledTextFormat:flash.text.TextFormat;

        protected var scrollTextTextFormat:flash.text.TextFormat;

        protected var searchIconDisabledTexture:starling.textures.Texture;

        protected var searchIconTexture:starling.textures.Texture;

        protected var seekSliderProgressSkinTexture:starling.textures.Texture;

        protected var selectedUIElementFormat:flash.text.engine.ElementFormat;

        protected var smallControlGutterSize:int;

        protected var smallControlSize:int;

        protected var smallDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var smallFontSize:int;

        protected var smallGutterSize:int;

        protected var smallLightElementFormat:flash.text.engine.ElementFormat;

        protected var spinnerListSelectionOverlaySkinTexture:starling.textures.Texture;

        protected var stageTextScale:Number=1;

        protected var tabDisabledSkinTexture:starling.textures.Texture;

        protected var tabDownSkinTexture:starling.textures.Texture;

        protected var tabSelectedDisabledSkinTexture:starling.textures.Texture;

        protected var tabSelectedUpSkinTexture:starling.textures.Texture;

        protected var tabUpSkinTexture:starling.textures.Texture;

        protected var verticalScrollBarThumbSkinTexture:starling.textures.Texture;

        protected var volumeSliderMaximumTrackSkinTexture:starling.textures.Texture;

        protected var volumeSliderMinimumTrackSkinTexture:starling.textures.Texture;

        protected var whiteButtonDownSkinTexture:starling.textures.Texture;

        protected var whiteButtonUpSkinTexture:starling.textures.Texture;

        protected var wideControlSize:int;

        public var isDeskop:Boolean=false;

        protected var _originalDPI:int;

        public var scale:Number=1;

        protected var _scaleToDPI:Boolean;

        protected var atlas:starling.textures.TextureAtlas;

        protected var backgroundDangerBorderSkinTexture:starling.textures.Texture;

        protected var backgroundDarkBorderSkinTexture:starling.textures.Texture;

        protected var backgroundDisabledSkinTexture:starling.textures.Texture;

        protected var backgroundInsetDangerSkinTexture:starling.textures.Texture;

        protected var backgroundInsetDisabledSkinTexture:starling.textures.Texture;

        protected var backgroundInsetEnabledSkinTexture:starling.textures.Texture;

        protected var backgroundInsetFocusedSkinTexture:starling.textures.Texture;

        protected var backgroundInsetSkinTexture:starling.textures.Texture;

        protected var backgroundLightBorderSkinTexture:starling.textures.Texture;

        protected var backgroundListSkin:starling.textures.Texture;

        protected var backgroundSkinTexture:starling.textures.Texture;

        protected static var FONT_SIZE_EXTRALARGE:uint=36;

        protected static var FONT_SIZE_INPUT:uint=24;

        protected static var FONT_SIZE_LARGE:uint=28;

        protected static var FONT_SIZE_REGULAR:uint=24;

        protected static var FONT_SIZE_SMALL:uint=20;

        protected static var FONT_SIZE_SMALLEST:uint=18;

        protected var boldFontDescription:flash.text.engine.FontDescription;

        protected var borderSize:int;

        protected var buttonBackDisabledSkinTexture:starling.textures.Texture;

        protected var buttonBackDownSkinTexture:starling.textures.Texture;

        protected var buttonBackUpSkinTexture:starling.textures.Texture;

        protected var buttonCallToActionDownSkinTexture:starling.textures.Texture;

        protected var buttonCallToActionUpSkinTexture:starling.textures.Texture;

        protected var buttonDangerDownSkinTexture:starling.textures.Texture;

        protected var buttonDangerUpSkinTexture:starling.textures.Texture;

        protected var buttonDisabledSkinTexture:starling.textures.Texture;

        protected var buttonDownSkinTexture:starling.textures.Texture;

        protected var buttonForwardDisabledSkinTexture:starling.textures.Texture;

        protected var checkSelectedUpIconTexture:starling.textures.Texture;

        protected var buttonForwardUpSkinTexture:starling.textures.Texture;

        protected var buttonSelectedDisabledSkinTexture:starling.textures.Texture;

        protected var buttonSelectedUpSkinTexture:starling.textures.Texture;

        protected var buttonUpSkinTexture:starling.textures.Texture;

        protected var calloutArrowOverlapGap:int;

        protected var calloutBackgroundMinSize:int;

        protected var calloutBottomArrowSkinTexture:starling.textures.Texture;

        protected var calloutLeftArrowSkinTexture:starling.textures.Texture;

        protected var calloutRightArrowSkinTexture:starling.textures.Texture;

        protected var calloutTopArrowSkinTexture:starling.textures.Texture;

        protected var checkDisabledIconTexture:starling.textures.Texture;

        protected var checkDownIconTexture:starling.textures.Texture;

        protected var checkSelectedDisabledIconTexture:starling.textures.Texture;

        protected var checkSelectedDownIconTexture:starling.textures.Texture;

        protected var checkSize:int;

        protected var checkUpIconTexture:starling.textures.Texture;

        protected var controlSize:int;

        protected var radioSelectedDownIconTexture:starling.textures.Texture;

        protected var dangerCalloutBottomArrowSkinTexture:starling.textures.Texture;

        protected var dangerCalloutLeftArrowSkinTexture:starling.textures.Texture;

        protected var dangerCalloutRightArrowSkinTexture:starling.textures.Texture;

        protected var dangerCalloutTopArrowSkinTexture:starling.textures.Texture;

        protected var darkElementFormat:flash.text.engine.ElementFormat;

        protected var darkLabelElementFormat:flash.text.engine.ElementFormat;

        protected var darkUIDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var darkUIElementFormat:flash.text.engine.ElementFormat;

        protected var disabledDarkLabelElementFormat:flash.text.engine.ElementFormat;

        protected var disabledElementFormat:flash.text.engine.ElementFormat;

        protected var extraLargeFontSize:int;

        protected var extraLargeValueFontSize:int;

        protected var fullScreenToggleButtonEnterDownIconTexture:starling.textures.Texture;

        protected var fullScreenToggleButtonEnterUpIconTexture:starling.textures.Texture;

        protected var fullScreenToggleButtonExitDownIconTexture:starling.textures.Texture;

        protected var fullScreenToggleButtonExitUpIconTexture:starling.textures.Texture;

        protected var gridSize:int;

        protected var gutterSize:int;

        protected var headerBackgroundSkinTexture:starling.textures.Texture;

        protected var headerDisabledElementFormat:flash.text.engine.ElementFormat;

        protected var smallestFontSize:int;

        protected var headerElementFormat:flash.text.engine.ElementFormat;

        protected var horizontalScrollBarThumbSkinTexture:starling.textures.Texture;

        protected var inputFontSize:int;

        protected var insetItemRendererFirstSelectedSkinTexture:starling.textures.Texture;

        protected var insetItemRendererFirstUpSkinTexture:starling.textures.Texture;

        protected var insetItemRendererLastSelectedSkinTexture:starling.textures.Texture;

        protected var insetItemRendererLastUpSkinTexture:starling.textures.Texture;
    }
}


