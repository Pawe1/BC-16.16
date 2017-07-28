//class TimeEditor
package frontend.components.menuList.editors 
{
    import __AS3__.vec.*;
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.menuList.editors.base.*;
    import frontend.formatter.*;
    import starling.display.*;
    import starling.events.*;
    
    public class TimeEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function TimeEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            this.checkFormatString();
            this.initValues();
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.gap = 8 * SIGMALink.scaleFactor;
            loc2 = new feathers.controls.LayoutGroup();
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            if (this.hours) 
            {
                this.hoursDP = this.generateDP(this.hoursMax);
                loc3 = new feathers.controls.SpinnerList();
                loc3.dataProvider = this.hoursDP;
                loc3.itemRendererProperties.labelField = "label";
                loc3.addEventListener(starling.events.Event.CHANGE, this.onHoursSpinnerValueChanged);
                this.selectDefault(loc3, this.hoursDP, this.hoursValue);
                loc2.addChild(loc3);
            }
            if (this.minutes) 
            {
                if (loc2.numChildren > 0) 
                {
                    loc2.addChild(this.createDelimiter(":"));
                }
                this.minutesDP = this.generateDP(this.minutesMax);
                loc4 = new feathers.controls.SpinnerList();
                loc4.dataProvider = this.minutesDP;
                loc4.itemRendererProperties.labelField = "label";
                loc4.addEventListener(starling.events.Event.CHANGE, this.onMinutesSpinnerValueChanged);
                this.selectDefault(loc4, this.minutesDP, this.minutesValue);
                loc2.addChild(loc4);
            }
            if (this.seconds) 
            {
                if (loc2.numChildren > 0) 
                {
                    loc2.addChild(this.createDelimiter(":"));
                }
                this.secondsDP = this.generateDP(this.secondsMax);
                loc5 = new feathers.controls.SpinnerList();
                loc5.dataProvider = this.secondsDP;
                loc5.itemRendererProperties.labelField = "label";
                loc5.addEventListener(starling.events.Event.CHANGE, this.onSecondsSpinnerValueChanged);
                this.selectDefault(loc5, this.secondsDP, this.secondsValue);
                loc2.addChild(loc5);
            }
            if (this.decimal) 
            {
                if (loc2.numChildren > 0) 
                {
                    loc2.addChild(this.createDelimiter("."));
                }
                this.decimalDP = this.generateDP(this.decimalMax);
                loc6 = new feathers.controls.SpinnerList();
                loc6.dataProvider = this.decimalDP;
                loc6.itemRendererProperties.labelField = "label";
                loc6.addEventListener(starling.events.Event.CHANGE, this.onDecimalSpinnerValueChanged);
                this.selectDefault(loc6, this.decimalDP, this.decimalValue);
                loc2.addChild(loc6);
            }
            return loc2;
        }

        internal function checkFormatString():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (this.formatter.formatString) 
            {
                this.maxValue = 0;
                loc1 = (this.formatter.formatString as String).split(":");
                loc3 = loc1.length;
                loc2 = 0;
                while (loc2 < loc3) 
                {
                    var loc4:*=loc1[loc2];
                    switch (loc4) 
                    {
                        case "H":
                        {
                            this.hours = true;
                            this.hoursMax = 9;
                            this.maxValue = this.maxValue + this.hoursMax * 3600;
                            break;
                        }
                        case "MM":
                        {
                            this.minutes = true;
                            this.minutesMax = 59;
                            this.maxValue = this.maxValue + this.minutesMax * 60;
                            break;
                        }
                        case "SS":
                        {
                            this.seconds = true;
                            this.secondsMax = 59;
                            this.maxValue = this.maxValue + this.secondsMax;
                            break;
                        }
                        case "SS.t":
                        {
                            this.seconds = true;
                            this.secondsMax = 59;
                            this.maxValue = this.maxValue + this.secondsMax;
                            this.decimal = true;
                            this.decimalMax = 9;
                            this.maxValue = this.maxValue + 0.9;
                            break;
                        }
                        case "SS.th":
                        {
                            this.seconds = true;
                            this.secondsMax = 59;
                            this.maxValue = this.maxValue + this.secondsMax;
                            this.decimal = true;
                            this.decimalMax = 99;
                            this.maxValue = this.maxValue + 0.99;
                            break;
                        }
                    }
                    ++loc2;
                }
            }
            return;
        }

        internal function createDelimiter(arg1:String):feathers.controls.Label
        {
            var loc1:*=new feathers.controls.Label();
            loc1.text = arg1;
            loc1.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_LIGHT;
            return loc1;
        }

        internal function generateDP(arg1:int):feathers.data.ListCollection
        {
            var loc2:*=0;
            var loc1:*=new Vector.<Object>();
            var loc3:*=arg1 + 1;
            loc2 = 0;
            while (loc2 < loc3) 
            {
                if (loc2 < 10 && arg1 >= 10) 
                {
                    loc1.push({"label":"0" + loc2.toString(), "data":loc2});
                }
                else 
                {
                    loc1.push({"label":loc2.toString(), "data":loc2});
                }
                ++loc2;
            }
            return new feathers.data.ListCollection(loc1);
        }

        internal function selectDefault(arg1:feathers.controls.SpinnerList, arg2:feathers.data.ListCollection, arg3:int):void
        {
            var loc1:*=0;
            if (arg2) 
            {
                loc1 = 0;
                while (loc1 < arg2.data.length) 
                {
                    if (arg2.data[loc1].data == arg3) 
                    {
                        arg1.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = backend.utils.DataUtils.countdownFormatter.format(rawValue);
            super.saveValue();
            return;
        }

        internal function onHoursSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.hoursValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function onMinutesSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.minutesValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function onSecondsSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.secondsValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function onDecimalSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            this.decimalValue = loc1.selectedItem.data;
            this.validateValueAndLabel();
            return;
        }

        internal function initValues():void
        {
            this.hoursMax = this.maxValue / 3600;
            this.minutesMax = (this.maxValue - this.hoursMax * 3600) / 60;
            this.secondsMax = this.maxValue - this.hoursMax * 3600 - this.minutesMax * 60;
            var loc1:*=parseFloat((this.maxValue - this.hoursMax * 3600 - this.minutesMax * 60 - this.secondsMax).toFixed(3));
            var loc2:*=1;
            while (loc1 % loc2 > 0) 
            {
                loc1 = loc1 * 10;
            }
            this.decimalMax = loc1;
            var loc3:*=parseInt(rawValue.toString()) / 100;
            this.hoursValue = parseInt(loc3.toString()) / 3600;
            this.minutesValue = (parseInt(loc3.toString()) - this.hoursValue * 3600) / 60;
            this.secondsValue = parseInt(loc3.toString()) - this.hoursValue * 3600 - this.minutesValue * 60;
            this.decimalValue = parseFloat(loc3.toString()) - this.hoursValue * 3600 - this.minutesValue * 60 - this.secondsValue;
            return;
        }

        internal function validateValueAndLabel():void
        {
            var loc3:*=NaN;
            this.labelValue = "";
            var loc1:*=[];
            var loc2:*=0;
            if (this.hours) 
            {
                loc2 = loc2 + this.hoursValue * 3600;
            }
            if (this.minutes) 
            {
                loc2 = loc2 + this.minutesValue * 60;
            }
            if (this.seconds) 
            {
                loc2 = loc2 + this.secondsValue;
            }
            if (this.decimal) 
            {
                loc3 = this.decimalValue / 100;
                loc2 = loc2 + loc3;
            }
            loc2 = loc2 * 100;
            rawValue = loc2;
            this.labelValue = backend.utils.DataUtils.countdownFormatter.format(loc2);
            return;
        }

        public var formatter:frontend.formatter.TimeFormatter;

        public var maxValue:Number=35999.9;

        internal var decimal:Boolean=false;

        internal var decimalDP:feathers.data.ListCollection;

        internal var decimalMax:int=99;

        internal var decimalValue:int=0;

        internal var hours:Boolean=false;

        internal var hoursDP:feathers.data.ListCollection;

        internal var hoursMax:int=9;

        internal var hoursValue:int=0;

        internal var labelValue:String="";

        internal var minutes:Boolean=false;

        internal var minutesDP:feathers.data.ListCollection;

        internal var minutesMax:int=59;

        internal var minutesValue:int=0;

        internal var seconds:Boolean=false;

        internal var secondsDP:feathers.data.ListCollection;

        internal var secondsMax:int=59;

        internal var secondsValue:int=0;
    }
}


