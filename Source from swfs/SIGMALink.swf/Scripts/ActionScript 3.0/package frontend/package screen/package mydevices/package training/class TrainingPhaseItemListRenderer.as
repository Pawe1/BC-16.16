//class TrainingPhaseItemListRenderer
package frontend.screen.mydevices.training 
{
    import backend.utils.*;
    import core.general.*;
    import core.training.*;
    import core.training.type.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.*;
    import frontend.components.*;
    import frontend.formatter.*;
    import starling.display.*;
    import utils.format.*;
    
    public class TrainingPhaseItemListRenderer extends feathers.controls.renderers.DefaultListItemRenderer
    {
        public function TrainingPhaseItemListRenderer()
        {
            super();
            hasLabelTextRenderer = false;
            styleProvider = null;
            height = ROW_HEIGHT;
            defaultSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        internal function getSimpleLabelText(arg1:feathers.controls.Label, arg2:feathers.controls.Label, arg3:int, arg4:int, arg5:core.training.type.PhaseTarget, arg6:core.training.type.PhaseControl):void
        {
            var loc1:*=arg6;
            switch (loc1) 
            {
                case core.training.type.PhaseControl.PULSE:
                {
                    arg1.text = arg4.toString();
                    break;
                }
                case core.training.type.PhaseControl.TIME:
                {
                    arg1.text = arg3.toString() + "-" + arg4.toString();
                    break;
                }
            }
            loc1 = arg5;
            switch (loc1) 
            {
                case core.training.type.PhaseTarget.HEARTFREQUENCY:
                {
                    arg2.text = backend.utils.DataUtils.unitStringHeartrate;
                    arg2.paddingRight = 0;
                    break;
                }
                case core.training.type.PhaseTarget.PERCENT_MAX_HEARTFREQUENCY:
                {
                    arg2.text = "%";
                    arg2.paddingRight = 17 * SIGMALink.scaleFactor;
                    break;
                }
            }
            return;
        }

        protected override function commitData():void
        {
            super.commitData();
            if (!data) 
            {
                return;
            }
            if (!(data is core.training.TrainingPhase)) 
            {
                return;
            }
            var loc1:*=data as core.training.TrainingPhase;
            var loc2:*;
            this._intervallCountLabel.includeInLayout = loc2 = false;
            this._intervallCountLabel.visible = loc2;
            this._durationLabel1.includeInLayout = loc2 = false;
            this._durationLabel1.visible = loc2;
            this._minuteUnitLabel1.includeInLayout = loc2 = false;
            this._minuteUnitLabel1.visible = loc2;
            this._durationLabel2.includeInLayout = loc2 = false;
            this._durationLabel2.visible = loc2;
            this._minuteUnitLabel2.includeInLayout = loc2 = false;
            this._minuteUnitLabel2.visible = loc2;
            this._subGroupVRightH1.includeInLayout = loc2 = true;
            this._subGroupVRightH1.visible = loc2;
            this._subGroupVRightH2.includeInLayout = loc2 = false;
            this._subGroupVRightH2.visible = loc2;
            this._loadRecoveryImage1.includeInLayout = loc2 = false;
            this._loadRecoveryImage1.visible = loc2;
            this._bpmLabel1.includeInLayout = loc2 = false;
            this._bpmLabel1.visible = loc2;
            this._loadRecoveryImage2.includeInLayout = loc2 = false;
            this._loadRecoveryImage2.visible = loc2;
            this._bpmLabel2.includeInLayout = loc2 = false;
            this._bpmLabel2.visible = loc2;
            this._durationLabel1.text = "";
            this._durationLabel2.text = "";
            this._bpmLabel1.text = "";
            this._bpmLabel2.text = "";
            loc2 = loc1.type;
            switch (loc2) 
            {
                case core.training.type.PhaseCategory.INTERVAL:
                {
                    this._phaseImage.textureName = frontend.Textures.reloadicon;
                    this._intervallCountLabel.visible = true;
                    this._intervallCountLabel.includeInLayout = true;
                    this._intervallCountLabel.text = loc1.iterations.toString();
                    if (loc1.loadPhaseControl == core.training.type.PhaseControl.TIME) 
                    {
                        this._durationLabel1.includeInLayout = loc2 = true;
                        this._durationLabel1.visible = loc2;
                        this._durationLabel1.text = this._timeFormatter.format(loc1.loadDuration);
                        this._minuteUnitLabel1.includeInLayout = loc2 = true;
                        this._minuteUnitLabel1.visible = loc2;
                    }
                    if (loc1.recoveryPhaseControl == core.training.type.PhaseControl.TIME) 
                    {
                        this._durationLabel2.includeInLayout = loc2 = true;
                        this._durationLabel2.visible = loc2;
                        this._durationLabel2.text = this._timeFormatter.format(loc1.recoveryDuration);
                        this._minuteUnitLabel2.includeInLayout = loc2 = true;
                        this._minuteUnitLabel2.visible = loc2;
                    }
                    this._subGroupVRightH2.includeInLayout = loc2 = true;
                    this._subGroupVRightH2.visible = loc2;
                    this._loadRecoveryImage1.includeInLayout = loc2 = loc1.loadPhaseControl == core.training.type.PhaseControl.PULSE;
                    this._loadRecoveryImage1.visible = loc2;
                    this._loadRecoveryImage2.includeInLayout = loc2 = loc1.recoveryPhaseControl == core.training.type.PhaseControl.PULSE;
                    this._loadRecoveryImage2.visible = loc2;
                    this._loadRecoveryImage1.textureName = frontend.Textures.iconup;
                    this._loadRecoveryImage2.textureName = frontend.Textures.icondown;
                    this._bpmLabel1.includeInLayout = loc2 = true;
                    this._bpmLabel1.visible = loc2;
                    this._bpmLabel2.includeInLayout = loc2 = true;
                    this._bpmLabel2.visible = loc2;
                    this.getSimpleLabelText(this._bpmLabel1, this._bpmUnitLabel1, loc1.loadTargetMin, loc1.loadTargetMax, loc1.loadTargetType, loc1.loadPhaseControl);
                    this.getSimpleLabelText(this._bpmLabel2, this._bpmUnitLabel2, loc1.recoveryTargetMin, loc1.recoveryTargetMax, loc1.recoveryTargetType, loc1.recoveryPhaseControl);
                    break;
                }
                case core.training.type.PhaseCategory.SIMPLE:
                {
                    this._phaseImage.textureName = frontend.Textures.pfeilrechts;
                    this._intervallCountLabel.text = "";
                    if (loc1.loadPhaseControl == core.training.type.PhaseControl.TIME) 
                    {
                        this._durationLabel1.includeInLayout = loc2 = true;
                        this._durationLabel1.visible = loc2;
                        this._durationLabel1.text = this._timeFormatter.format(loc1.loadDuration);
                        this._minuteUnitLabel1.includeInLayout = loc2 = true;
                        this._minuteUnitLabel1.visible = loc2;
                    }
                    this._loadRecoveryImage1.includeInLayout = loc2 = loc1.loadPhaseControl == core.training.type.PhaseControl.PULSE;
                    this._loadRecoveryImage1.visible = loc2;
                    this._loadRecoveryImage1.textureName = loc1.loadRecovery != core.training.type.PhaseLoadRecovery.LOAD ? frontend.Textures.icondown : frontend.Textures.iconup;
                    this._bpmLabel1.includeInLayout = loc2 = true;
                    this._bpmLabel1.visible = loc2;
                    this.getSimpleLabelText(this._bpmLabel1, this._bpmUnitLabel1, loc1.loadTargetMin, loc1.loadTargetMax, loc1.loadTargetType, loc1.loadPhaseControl);
                    break;
                }
            }
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this._timeFormatter = new frontend.formatter.TimeFormatter();
            this._timeFormatter.inputType = utils.format.TimeFormatterConstants.INPUT_HUNDREDTHSSECONDS;
            this._timeFormatter.formatString = "MM:SS";
            this._vLayout = new feathers.layout.VerticalLayout();
            this._vLayout.gap = 5;
            this._vLayout.verticalAlign = VERTICAL_ALIGN_MIDDLE;
            this._vLayout.horizontalAlign = HORIZONTAL_ALIGN_RIGHT;
            this._hLayout = new feathers.layout.HorizontalLayout();
            this._hLayout.gap = 2;
            this._hLayout.horizontalAlign = HORIZONTAL_ALIGN_CENTER;
            this._hLayout.verticalAlign = VERTICAL_ALIGN_MIDDLE;
            this._group = new feathers.controls.LayoutGroup();
            this._group.width = SIGMALink.appWidth;
            this._group.height = ROW_HEIGHT;
            this._group.layout = new feathers.layout.AnchorLayout();
            addChild(this._group);
            this._subGroupLeft = new feathers.controls.LayoutGroup();
            this._subGroupLeft.height = ROW_HEIGHT;
            this._subGroupLeft.layout = new feathers.layout.AnchorLayout();
            this._subGroupLeft.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, 0);
            this._group.addChild(this._subGroupLeft);
            this._phaseImage = new frontend.components.TextureImage();
            this._phaseImage.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._subGroupLeft.addChild(this._phaseImage);
            this._intervallCountLabel = new feathers.controls.Label();
            this._intervallCountLabel.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, 0, 0);
            this._intervallCountLabel.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER_SMALL;
            this._subGroupLeft.addChild(this._intervallCountLabel);
            this._subGroupMid = new feathers.controls.LayoutGroup();
            this._subGroupMid.height = ROW_HEIGHT;
            this._subGroupMid.layout = new feathers.layout.AnchorLayout();
            this._subGroupMid.layoutData = new feathers.layout.AnchorLayoutData(NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.COL_WIDTH + frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._subGroupMid);
            this._subGroupVMid = new feathers.controls.LayoutGroup();
            this._subGroupVMid.layout = this._vLayout;
            this._subGroupVMid.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            this._subGroupMid.addChild(this._subGroupVMid);
            this._subGroupVMidH1 = new feathers.controls.LayoutGroup();
            this._subGroupVMidH1.layout = this._hLayout;
            this._subGroupVMid.addChild(this._subGroupVMidH1);
            this._durationLabel1 = new feathers.controls.Label();
            this._durationLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVMidH1.addChild(this._durationLabel1);
            this._minuteUnitLabel1 = new feathers.controls.Label();
            this._minuteUnitLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minuteUnitLabel1.text = frontend.Locales.getString("UNIT_MINUTES");
            this._subGroupVMidH1.addChild(this._minuteUnitLabel1);
            this._subGroupVMidH2 = new feathers.controls.LayoutGroup();
            this._subGroupVMidH2.layout = this._hLayout;
            this._subGroupVMid.addChild(this._subGroupVMidH2);
            this._durationLabel2 = new feathers.controls.Label();
            this._durationLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVMidH2.addChild(this._durationLabel2);
            this._minuteUnitLabel2 = new feathers.controls.Label();
            this._minuteUnitLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._minuteUnitLabel2.text = frontend.Locales.getString("UNIT_MINUTES");
            this._subGroupVMidH2.addChild(this._minuteUnitLabel2);
            this._subGroupRight = new feathers.controls.LayoutGroup();
            this._subGroupRight.height = ROW_HEIGHT;
            this._subGroupRight.layout = new feathers.layout.AnchorLayout();
            this._subGroupRight.layoutData = new feathers.layout.AnchorLayoutData(NaN, frontend.screen.mydevices.training.TrainingPhaseItemListRenderer.PADDING, NaN, NaN, NaN, 0);
            this._group.addChild(this._subGroupRight);
            this._subGroupVRight = new feathers.controls.LayoutGroup();
            this._subGroupVRight.layout = this._vLayout;
            this._subGroupVRight.layoutData = new feathers.layout.AnchorLayoutData(NaN, NaN, NaN, NaN, NaN, 0);
            this._subGroupRight.addChild(this._subGroupVRight);
            this._subGroupVRightH1 = new feathers.controls.LayoutGroup();
            this._subGroupVRightH1.layout = this._hLayout;
            this._subGroupVRight.addChild(this._subGroupVRightH1);
            this._loadRecoveryImage1 = new frontend.components.TextureImage();
            this._loadRecoveryImage1.scale = 0.3;
            this._subGroupVRightH1.addChild(this._loadRecoveryImage1);
            this._bpmLabel1 = new feathers.controls.Label();
            this._bpmLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVRightH1.addChild(this._bpmLabel1);
            this._bpmUnitLabel1 = new feathers.controls.Label();
            this._bpmUnitLabel1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._subGroupVRightH1.addChild(this._bpmUnitLabel1);
            this._subGroupVRightH2 = new feathers.controls.LayoutGroup();
            this._subGroupVRightH2.layout = this._hLayout;
            this._subGroupVRight.addChild(this._subGroupVRightH2);
            this._loadRecoveryImage2 = new frontend.components.TextureImage();
            this._loadRecoveryImage2.scale = 0.3;
            this._subGroupVRightH2.addChild(this._loadRecoveryImage2);
            this._bpmLabel2 = new feathers.controls.Label();
            this._bpmLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_NUMBER;
            this._subGroupVRightH2.addChild(this._bpmLabel2);
            this._bpmUnitLabel2 = new feathers.controls.Label();
            this._bpmUnitLabel2.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_SMALLLISTLABEL;
            this._subGroupVRightH2.addChild(this._bpmUnitLabel2);
            var loc1:*=new starling.display.Quad(SIGMALink.appWidth, 1, core.general.Colors.LIGHTGREY);
            addChild(loc1);
            return;
        }

        protected override function draw():void
        {
            super.draw();
            if (isInvalid(INVALIDATION_FLAG_SIZE)) 
            {
                this.commitData();
            }
            return;
        }

        public static const COL_WIDTH:Number=SIGMALink.appWidth / 3;

        public static const PADDING:Number=17 * SIGMALink.scaleFactor;

        internal static const ROW_HEIGHT:Number=100 * SIGMALink.scaleFactor;

        internal var _bpmLabel1:feathers.controls.Label;

        internal var _bpmLabel2:feathers.controls.Label;

        internal var _bpmUnitLabel1:feathers.controls.Label;

        internal var _bpmUnitLabel2:feathers.controls.Label;

        internal var _durationLabel1:feathers.controls.Label;

        internal var _durationLabel2:feathers.controls.Label;

        internal var _group:feathers.controls.LayoutGroup;

        internal var _hLayout:feathers.layout.HorizontalLayout;

        internal var _intervallCountLabel:feathers.controls.Label;

        internal var _loadRecoveryImage1:frontend.components.TextureImage;

        internal var _loadRecoveryImage2:frontend.components.TextureImage;

        internal var _subGroupVMidH1:feathers.controls.LayoutGroup;

        internal var _subGroupVMidH2:feathers.controls.LayoutGroup;

        internal var _subGroupVRight:feathers.controls.LayoutGroup;

        internal var _subGroupVRightH1:feathers.controls.LayoutGroup;

        internal var _subGroupVRightH2:feathers.controls.LayoutGroup;

        internal var _timeFormatter:frontend.formatter.TimeFormatter;

        internal var _vLayout:feathers.layout.VerticalLayout;

        internal var _subGroupLeft:feathers.controls.LayoutGroup;

        internal var _phaseImage:frontend.components.TextureImage;

        internal var _minuteUnitLabel2:feathers.controls.Label;

        internal var _minuteUnitLabel1:feathers.controls.Label;

        internal var _subGroupRight:feathers.controls.LayoutGroup;

        internal var _subGroupVMid:feathers.controls.LayoutGroup;

        internal var _subGroupMid:feathers.controls.LayoutGroup;
    }
}


