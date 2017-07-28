//class DateTimeSpinner
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.controls.renderers.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.math.*;
    import flash.globalization.*;
    import starling.events.*;
    
    public class DateTimeSpinner extends feathers.core.FeathersControl
    {
        public function DateTimeSpinner()
        {
            var loc1:*=0;
            super();
            if (DAYS_IN_MONTH.length === 0) 
            {
                HELPER_DATE.setFullYear(2015);
                loc1 = MIN_MONTH_VALUE;
                while (loc1 <= MAX_MONTH_VALUE) 
                {
                    HELPER_DATE.setMonth(loc1 + 1, -1);
                    DAYS_IN_MONTH[loc1] = HELPER_DATE.date + 1;
                    ++loc1;
                }
                DAYS_IN_MONTH.fixed = true;
            }
            return;
        }

        public function set editingMode(arg1:String):void
        {
            if (this._editingMode == arg1) 
            {
                return;
            }
            this._editingMode = arg1;
            this.invalidate(INVALIDATION_FLAG_EDITING_MODE);
            return;
        }

        public function set customItemRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customItemRendererStyleName === arg1) 
            {
                return;
            }
            this._customItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_SPINNER_LIST_FACTORY);
            return;
        }

        public function get listFactory():Function
        {
            return this._listFactory;
        }

        public function set listFactory(arg1:Function):void
        {
            if (this._listFactory == arg1) 
            {
                return;
            }
            this._listFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public function get todayLabel():String
        {
            return this._todayLabel;
        }

        public function get customListStyleName():String
        {
            return this._customListStyleName;
        }

        public function set customListStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customListStyleName === arg1) 
            {
                return;
            }
            this._customListStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_SPINNER_LIST_FACTORY);
            return;
        }

        public function set todayLabel(arg1:String):void
        {
            if (this._todayLabel == arg1) 
            {
                return;
            }
            this._todayLabel = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get customItemRendererStyleName():String
        {
            return this._customItemRendererStyleName;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return DateTimeSpinner.globalStyleProvider;
        }

        public function get scrollDuration():Number
        {
            return this._scrollDuration;
        }

        public function get locale():String
        {
            return this._locale;
        }

        public function set locale(arg1:String):void
        {
            if (this._locale == arg1) 
            {
                return;
            }
            this._locale = arg1;
            this._formatter = null;
            this.invalidate(INVALIDATION_FLAG_LOCALE);
            return;
        }

        public function set scrollDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._scrollDuration === arg1) 
            {
                return;
            }
            this._scrollDuration = arg1;
            return;
        }

        public function get value():Date
        {
            return this._value;
        }

        public function set value(arg1:Date):void
        {
            var loc1:*=arg1.time;
            if (this._minimum && this._minimum.time > loc1) 
            {
                loc1 = this._minimum.time;
            }
            if (this._maximum && this._maximum.time < loc1) 
            {
                loc1 = this._maximum.time;
            }
            if (this._value && this._value.time === loc1) 
            {
                return;
            }
            this._value = new Date(loc1);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected static function defaultListFactory():feathers.controls.SpinnerList
        {
            return new feathers.controls.SpinnerList();
        }

        public function get minimum():Date
        {
            return this._minimum;
        }

        public function set minimum(arg1:Date):void
        {
            if (this._minimum == arg1) 
            {
                return;
            }
            this._minimum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshValidRanges():void
        {
            var loc1:*=this._minYear;
            var loc2:*=this._maxYear;
            var loc3:*=this._minMonth;
            var loc4:*=this._maxMonth;
            var loc5:*=this._minDate;
            var loc6:*=this._maxDate;
            var loc7:*=this._minHours;
            var loc8:*=this._maxHours;
            var loc9:*=this._minMinute;
            var loc10:*=this._maxMinute;
            var loc11:*=this._value.fullYear;
            var loc12:*=this._value.month;
            var loc13:*=this._value.date;
            var loc14:*=this._value.hours;
            this._minYear = this._minimum.fullYear;
            this._maxYear = this._maximum.fullYear;
            if (loc11 !== this._minYear) 
            {
                this._minMonth = MIN_MONTH_VALUE;
            }
            else 
            {
                this._minMonth = this._minimum.month;
            }
            if (loc11 !== this._maxYear) 
            {
                this._maxMonth = MAX_MONTH_VALUE;
            }
            else 
            {
                this._maxMonth = this._maximum.month;
            }
            if (loc11 === this._minYear && loc12 === this._minimum.month) 
            {
                this._minDate = this._minimum.date;
            }
            else 
            {
                this._minDate = MIN_DATE_VALUE;
            }
            if (loc11 === this._maxYear && loc12 === this._maximum.month) 
            {
                this._maxDate = this._maximum.date;
            }
            else if (loc12 !== 1) 
            {
                this._maxDate = DAYS_IN_MONTH[loc12];
            }
            else 
            {
                HELPER_DATE.setFullYear(loc11, loc12 + 1, -1);
                this._maxDate = HELPER_DATE.date + 1;
            }
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
            {
                this._minHours = this._minimum.hours;
                this._maxHours = this._maximum.hours;
                if (loc14 !== this._minHours) 
                {
                    this._minMinute = MIN_MINUTES_VALUE;
                }
                else 
                {
                    this._minMinute = this._minimum.minutes;
                }
                if (loc14 !== this._maxHours) 
                {
                    this._maxMinute = MAX_MINUTES_VALUE;
                }
                else 
                {
                    this._maxMinute = this._maximum.minutes;
                }
            }
            else 
            {
                if (loc11 === this._minYear && loc12 === this._minimum.month && loc13 === this._minimum.date) 
                {
                    this._minHours = this._minimum.hours;
                }
                else 
                {
                    this._minHours = MIN_HOURS_VALUE;
                }
                if (loc11 === this._maxYear && loc12 === this._maximum.month && loc13 === this._maximum.date) 
                {
                    this._maxHours = this._maximum.hours;
                }
                else 
                {
                    this._maxHours = MAX_HOURS_VALUE_24HOURS;
                }
                if (loc11 === this._minYear && loc12 === this._minimum.month && loc13 === this._minimum.date && loc14 === this._minimum.hours) 
                {
                    this._minMinute = this._minimum.minutes;
                }
                else 
                {
                    this._minMinute = MIN_MINUTES_VALUE;
                }
                if (loc11 === this._maxYear && loc12 === this._maximum.month && loc13 === this._maximum.date && loc14 === this._maximum.hours) 
                {
                    this._maxMinute = this._maximum.minutes;
                }
                else 
                {
                    this._maxMinute = MAX_MINUTES_VALUE;
                }
            }
            var loc15:*=this.yearsList ? this.yearsList.dataProvider : null;
            if (loc15 && (!(loc1 === this._minYear) || !(loc2 === this._maxYear))) 
            {
                loc15.updateAll();
            }
            var loc16:*=this.monthsList ? this.monthsList.dataProvider : null;
            if (loc16 && (!(loc3 === this._minMonth) || !(loc4 === this._maxMonth))) 
            {
                loc16.updateAll();
            }
            var loc17:*=this.datesList ? this.datesList.dataProvider : null;
            if (loc17 && (!(loc5 === this._minDate) || !(loc6 === this._maxDate))) 
            {
                loc17.updateAll();
            }
            var loc18:*=this.dateAndTimeDatesList ? this.dateAndTimeDatesList.dataProvider : null;
            if (loc18 && (!(loc1 === this._minYear) || !(loc2 === this._maxYear) || !(loc3 === this._minMonth) || !(loc4 === this._maxMonth) || !(loc5 === this._minDate) || !(loc6 === this._maxDate))) 
            {
                loc18.updateAll();
            }
            var loc19:*=this.hoursList ? this.hoursList.dataProvider : null;
            if (loc19 && (!(loc7 === this._minHours) || !(loc8 === this._maxHours) || this._showMeridiem && !(this._lastMeridiemValue === this.meridiemList.selectedIndex))) 
            {
                loc19.updateAll();
            }
            var loc20:*=this.minutesList ? this.minutesList.dataProvider : null;
            if (loc20 && (!(loc9 === this._minMinute) || !(loc10 === this._maxMinute))) 
            {
                loc20.updateAll();
            }
            if (this._showMeridiem) 
            {
                this._lastMeridiemValue = this._value.hours <= MAX_HOURS_VALUE_12HOURS ? 0 : 1;
            }
            return;
        }

        public function get maximum():Date
        {
            return this._maximum;
        }

        public function set maximum(arg1:Date):void
        {
            if (this._maximum == arg1) 
            {
                return;
            }
            this._maximum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get itemRendererFactory():Function
        {
            return this._itemRendererFactory;
        }

        public function get minuteStep():int
        {
            return this._minuteStep;
        }

        public function set minuteStep(arg1:int):void
        {
            if (60 % arg1 !== 0) 
            {
                throw new ArgumentError("minuteStep must evenly divide into 60.");
            }
            if (this._minuteStep == arg1) 
            {
                return;
            }
            this._minuteStep = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set itemRendererFactory(arg1:Function):void
        {
            if (this._itemRendererFactory === arg1) 
            {
                return;
            }
            this._itemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_SPINNER_LIST_FACTORY);
            return;
        }

        public function get editingMode():String
        {
            return this._editingMode;
        }

        public function scrollToDate(arg1:Date, arg2:Number=NaN):void
        {
            if (this.pendingScrollToDate && this.pendingScrollToDate.time === arg1.time && this.pendingScrollDuration === arg2) 
            {
                return;
            }
            this.pendingScrollToDate = arg1;
            this.pendingScrollDuration = arg2;
            this.invalidate(INVALIDATION_FLAG_PENDING_SCROLL);
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            if (!this.listGroup) 
            {
                loc1 = new feathers.layout.HorizontalLayout();
                loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
                loc1.verticalAlign = feathers.layout.VerticalAlign.JUSTIFY;
                this.listGroup = new feathers.controls.LayoutGroup();
                this.listGroup.layout = loc1;
                this.addChild(this.listGroup);
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_EDITING_MODE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_LOCALE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_PENDING_SCROLL);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_SPINNER_LIST_FACTORY);
            if (this._todayLabel) 
            {
                this._lastValidate = new Date();
            }
            if (loc2 || loc1) 
            {
                this.refreshLocale();
            }
            if (loc2 || loc1 || loc5) 
            {
                this.refreshLists(loc1 || loc5, loc2);
            }
            if (loc2 || loc1 || loc3 || loc5) 
            {
                this.useDefaultsIfNeeded();
                this.refreshValidRanges();
                this.refreshSelection();
            }
            this.autoSizeIfNeeded();
            this.layoutChildren();
            if (loc4) 
            {
                this.handlePendingScroll();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            this.listGroup.width = this._explicitWidth;
            this.listGroup.height = this._explicitHeight;
            this.listGroup.minWidth = this._explicitMinWidth;
            this.listGroup.minHeight = this._explicitMinHeight;
            this.listGroup.validate();
            return this.saveMeasurements(this.listGroup.width, this.listGroup.height, this.listGroup.minWidth, this.listGroup.minHeight);
        }

        protected function refreshLists(arg1:Boolean, arg2:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1) 
            {
                this.createYearList();
                this.createMonthList();
                this.createDateList();
                this.createHourList();
                this.createMinuteList();
                this.createMeridiemList();
                this.createDateAndTimeDateList();
            }
            else if (this._showMeridiem && !this.meridiemList || !this._showMeridiem && this.meridiemList) 
            {
                this.createMeridiemList();
            }
            if (this._editingMode == feathers.controls.DateTimeMode.DATE) 
            {
                if (this._monthFirst) 
                {
                    this.listGroup.setChildIndex(this.monthsList, 0);
                }
                else 
                {
                    this.listGroup.setChildIndex(this.datesList, 0);
                }
            }
            if (arg2) 
            {
                if (this.monthsList) 
                {
                    loc1 = this.monthsList.dataProvider;
                    if (loc1) 
                    {
                        loc1.updateAll();
                    }
                }
                if (this.dateAndTimeDatesList) 
                {
                    loc2 = this.dateAndTimeDatesList.dataProvider;
                    if (loc2) 
                    {
                        loc2.updateAll();
                    }
                }
            }
            return;
        }

        protected function createYearList():void
        {
            if (this.yearsList) 
            {
                this.listGroup.removeChild(this.yearsList, true);
                this.yearsList = null;
            }
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.yearsList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.yearsList.styleNameList.add(loc2);
            this.yearsList.itemRendererFactory = this.yearsListItemRendererFactory;
            if (this._customItemRendererStyleName !== null) 
            {
                this.yearsList.customItemRendererStyleName = this._customItemRendererStyleName;
            }
            this.yearsList.addEventListener(starling.events.Event.CHANGE, this.yearsList_changeHandler);
            this.listGroup.addChild(this.yearsList);
            return;
        }

        protected function createMonthList():void
        {
            if (this.monthsList) 
            {
                this.listGroup.removeChild(this.monthsList, true);
                this.monthsList = null;
            }
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.monthsList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.monthsList.styleNameList.add(loc2);
            var loc3:*=new IntegerRange(MIN_MONTH_VALUE, MAX_MONTH_VALUE, 1);
            var loc4:*=new feathers.data.ListCollection(loc3);
            loc4.dataDescriptor = new IntegerRangeDataDescriptor();
            this.monthsList.dataProvider = loc4;
            this.monthsList.typicalItem = this._longestMonthNameIndex;
            this.monthsList.itemRendererFactory = this.monthsListItemRendererFactory;
            if (this._customItemRendererStyleName !== null) 
            {
                this.monthsList.customItemRendererStyleName = this._customItemRendererStyleName;
            }
            this.monthsList.addEventListener(starling.events.Event.CHANGE, this.monthsList_changeHandler);
            this.listGroup.addChildAt(this.monthsList, 0);
            return;
        }

        protected function createDateList():void
        {
            if (this.datesList) 
            {
                this.listGroup.removeChild(this.datesList, true);
                this.datesList = null;
            }
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.datesList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.datesList.styleNameList.add(loc2);
            var loc3:*=new IntegerRange(MIN_DATE_VALUE, MAX_DATE_VALUE, 1);
            var loc4:*=new feathers.data.ListCollection(loc3);
            loc4.dataDescriptor = new IntegerRangeDataDescriptor();
            this.datesList.dataProvider = loc4;
            this.datesList.itemRendererFactory = this.datesListItemRendererFactory;
            if (this._customItemRendererStyleName !== null) 
            {
                this.datesList.customItemRendererStyleName = this._customItemRendererStyleName;
            }
            this.datesList.addEventListener(starling.events.Event.CHANGE, this.datesList_changeHandler);
            this.listGroup.addChildAt(this.datesList, 0);
            return;
        }

        protected function createHourList():void
        {
            if (this.hoursList) 
            {
                this.listGroup.removeChild(this.hoursList, true);
                this.hoursList = null;
            }
            if (this._editingMode === feathers.controls.DateTimeMode.DATE) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.hoursList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.hoursList.styleNameList.add(loc2);
            this.hoursList.itemRendererFactory = this.hoursListItemRendererFactory;
            if (this._customItemRendererStyleName !== null) 
            {
                this.hoursList.customItemRendererStyleName = this._customItemRendererStyleName;
            }
            this.hoursList.addEventListener(starling.events.Event.CHANGE, this.hoursList_changeHandler);
            this.listGroup.addChild(this.hoursList);
            return;
        }

        protected function createMinuteList():void
        {
            if (this.minutesList) 
            {
                this.listGroup.removeChild(this.minutesList, true);
                this.minutesList = null;
            }
            if (this._editingMode === feathers.controls.DateTimeMode.DATE) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.minutesList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.minutesList.styleNameList.add(loc2);
            var loc3:*=new IntegerRange(MIN_MINUTES_VALUE, MAX_MINUTES_VALUE, this._minuteStep);
            var loc4:*=new feathers.data.ListCollection(loc3);
            loc4.dataDescriptor = new IntegerRangeDataDescriptor();
            this.minutesList.dataProvider = loc4;
            this.minutesList.itemRendererFactory = this.minutesListItemRendererFactory;
            if (this._customItemRendererStyleName !== null) 
            {
                this.minutesList.customItemRendererStyleName = this._customItemRendererStyleName;
            }
            this.minutesList.addEventListener(starling.events.Event.CHANGE, this.minutesList_changeHandler);
            this.listGroup.addChild(this.minutesList);
            return;
        }

        protected function createMeridiemList():void
        {
            if (this.meridiemList) 
            {
                this.listGroup.removeChild(this.meridiemList, true);
                this.meridiemList = null;
            }
            if (!this._showMeridiem) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.meridiemList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.meridiemList.styleNameList.add(loc2);
            this.meridiemList.itemRendererFactory = this.meridiemListItemRendererFactory;
            this.meridiemList.customItemRendererStyleName = this._customItemRendererStyleName;
            this.meridiemList.addEventListener(starling.events.Event.CHANGE, this.meridiemList_changeHandler);
            this.listGroup.addChild(this.meridiemList);
            return;
        }

        protected function createDateAndTimeDateList():void
        {
            if (this.dateAndTimeDatesList) 
            {
                this.listGroup.removeChild(this.dateAndTimeDatesList, true);
                this.dateAndTimeDatesList = null;
            }
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
            {
                return;
            }
            var loc1:*=this._listFactory === null ? defaultListFactory : this._listFactory;
            this.dateAndTimeDatesList = feathers.controls.SpinnerList(loc1());
            var loc2:*=this._customListStyleName === null ? this.listStyleName : this._customListStyleName;
            this.dateAndTimeDatesList.styleNameList.add(loc2);
            this.dateAndTimeDatesList.itemRendererFactory = this.dateAndTimeDatesListItemRendererFactory;
            if (this._customItemRendererStyleName !== null) 
            {
                this.dateAndTimeDatesList.customItemRendererStyleName = this._customItemRendererStyleName;
            }
            this.dateAndTimeDatesList.addEventListener(starling.events.Event.CHANGE, this.dateAndTimeDatesList_changeHandler);
            this.dateAndTimeDatesList.typicalItem = {};
            this.listGroup.addChildAt(this.dateAndTimeDatesList, 0);
            return;
        }

        protected function refreshLocale():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            if (!this._formatter || !(this._formatter.requestedLocaleIDName == this._locale)) 
            {
                this._formatter = new flash.globalization.DateTimeFormatter(this._locale, flash.globalization.DateTimeStyle.SHORT, flash.globalization.DateTimeStyle.SHORT);
                loc1 = this._formatter.getDateTimePattern();
                loc2 = loc1.indexOf("M");
                loc3 = loc1.indexOf("d");
                this._monthFirst = loc2 < loc3;
                this._showMeridiem = !(this._editingMode === feathers.controls.DateTimeMode.DATE) && loc1.indexOf("a") >= 0;
                if (this._showMeridiem) 
                {
                    this._formatter.setDateTimePattern("a");
                    HELPER_DATE.setHours(1);
                    this._amString = this._formatter.format(HELPER_DATE);
                    HELPER_DATE.setHours(13);
                    this._pmString = this._formatter.format(HELPER_DATE);
                    this._formatter.setDateTimePattern(loc1);
                }
            }
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE) 
            {
                if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
                {
                    this._localeMonthNames = null;
                    this._localeWeekdayNames = null;
                }
                else 
                {
                    this._localeMonthNames = this._formatter.getMonthNames(flash.globalization.DateTimeNameStyle.SHORT_ABBREVIATION);
                    this._localeWeekdayNames = this._formatter.getWeekdayNames(flash.globalization.DateTimeNameStyle.LONG_ABBREVIATION);
                }
            }
            else 
            {
                this._localeMonthNames = this._formatter.getMonthNames(flash.globalization.DateTimeNameStyle.FULL);
                this._localeWeekdayNames = null;
            }
            if (this._localeMonthNames !== null) 
            {
                this._longestMonthNameIndex = 0;
                loc4 = this._localeMonthNames[0];
                loc5 = this._localeMonthNames.length;
                loc6 = 1;
                while (loc6 < loc5) 
                {
                    loc7 = this._localeMonthNames[loc6];
                    if (loc7.length > loc4.length) 
                    {
                        loc4 = loc7;
                        this._longestMonthNameIndex = loc6;
                    }
                    ++loc6;
                }
            }
            return;
        }

        protected function refreshSelection():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=NaN;
            var loc6:*=0;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=null;
            var loc10:*=null;
            var loc11:*=null;
            var loc12:*=null;
            var loc1:*=this._ignoreListChanges;
            this._ignoreListChanges = true;
            if (this._editingMode !== feathers.controls.DateTimeMode.DATE) 
            {
                loc5 = this._maximum.time - this._minimum.time;
                loc6 = loc5 / MS_PER_DAY;
                if (this._editingMode === feathers.controls.DateTimeMode.DATE_AND_TIME) 
                {
                    loc10 = this.dateAndTimeDatesList.dataProvider;
                    if (loc10) 
                    {
                        loc11 = IntegerRange(loc10.data);
                        if (loc11.maximum !== loc6) 
                        {
                            loc11.maximum = loc6;
                            loc4 = IntegerRangeDataDescriptor(loc10.dataDescriptor);
                            loc10.data = null;
                            loc10.data = loc11;
                            loc10.dataDescriptor = loc4;
                        }
                    }
                    else 
                    {
                        loc11 = new IntegerRange(0, loc6, 1);
                        loc10 = new feathers.data.ListCollection(loc11);
                        loc10.dataDescriptor = new IntegerRangeDataDescriptor();
                        this.dateAndTimeDatesList.dataProvider = loc10;
                    }
                }
                loc7 = MIN_HOURS_VALUE;
                loc8 = this._showMeridiem ? MAX_HOURS_VALUE_12HOURS : MAX_HOURS_VALUE_24HOURS;
                loc9 = this.hoursList.dataProvider;
                if (loc9) 
                {
                    loc12 = IntegerRange(loc9.data);
                    if (!(loc12.minimum === loc7) || !(loc12.maximum === loc8)) 
                    {
                        loc12.minimum = loc7;
                        loc12.maximum = loc8;
                        loc4 = IntegerRangeDataDescriptor(loc9.dataDescriptor);
                        loc9.data = null;
                        loc9.data = loc12;
                        loc9.dataDescriptor = loc4;
                    }
                }
                else 
                {
                    loc12 = new IntegerRange(loc7, loc8, 1);
                    loc9 = new feathers.data.ListCollection(loc12);
                    loc9.dataDescriptor = new IntegerRangeDataDescriptor();
                    this.hoursList.dataProvider = loc9;
                }
                if (this._showMeridiem && !this.meridiemList.dataProvider) 
                {
                    new Vector.<String>(2)[0] = this._amString;
                    new Vector.<String>(2)[1] = this._pmString;
                    this.meridiemList.dataProvider = new feathers.data.ListCollection(new Vector.<String>(2));
                }
            }
            else 
            {
                loc2 = this.yearsList.dataProvider;
                if (loc2) 
                {
                    loc3 = IntegerRange(loc2.data);
                    if (!(loc3.minimum === this._listMinYear) || !(loc3.maximum === this._listMaxYear)) 
                    {
                        loc3.minimum = this._listMinYear;
                        loc3.maximum = this._listMaxYear;
                        loc4 = IntegerRangeDataDescriptor(loc2.dataDescriptor);
                        loc2.data = null;
                        loc2.data = loc3;
                        loc2.dataDescriptor = loc4;
                    }
                }
                else 
                {
                    loc3 = new IntegerRange(this._listMinYear, this._listMaxYear, 1);
                    loc2 = new feathers.data.ListCollection(loc3);
                    loc2.dataDescriptor = new IntegerRangeDataDescriptor();
                    this.yearsList.dataProvider = loc2;
                }
            }
            if (this.monthsList && !this.monthsList.isScrolling) 
            {
                this.monthsList.selectedItem = this._value.month;
            }
            if (this.datesList && !this.datesList.isScrolling) 
            {
                this.datesList.selectedItem = this._value.date;
            }
            if (this.yearsList && !this.yearsList.isScrolling) 
            {
                this.yearsList.selectedItem = this._value.fullYear;
            }
            if (this.dateAndTimeDatesList) 
            {
                this.dateAndTimeDatesList.selectedIndex = (this._value.time - this._minimum.time) / MS_PER_DAY;
            }
            if (this.hoursList) 
            {
                if (this._showMeridiem) 
                {
                    this.hoursList.selectedIndex = this._value.hours % 12;
                }
                else 
                {
                    this.hoursList.selectedIndex = this._value.hours;
                }
            }
            if (this.minutesList) 
            {
                this.minutesList.selectedItem = this._value.minutes;
            }
            if (this.meridiemList) 
            {
                this.meridiemList.selectedIndex = this._value.hours <= MAX_HOURS_VALUE_12HOURS ? 0 : 1;
            }
            this._ignoreListChanges = loc1;
            return;
        }

        protected function useDefaultsIfNeeded():void
        {
            if (!this._value) 
            {
                this._value = new Date();
                if (this._minimum && this._value.time < this._minimum.time) 
                {
                    this._value.time = this._minimum.time;
                }
                else if (this._maximum && this._value.time > this._maximum.time) 
                {
                    this._value.time = this._maximum.time;
                }
            }
            if (this._minimum) 
            {
                if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
                {
                    this._listMinYear = this._minimum.fullYear - 10;
                }
                else 
                {
                    this._listMinYear = (this._minimum.fullYear - 1);
                }
            }
            else if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
            {
                HELPER_DATE.time = this._value.time;
                this._listMinYear = feathers.utils.math.roundDownToNearest(HELPER_DATE.fullYear - 100, 50);
                this._minimum = new Date(this._listMinYear, MIN_MONTH_VALUE, MIN_DATE_VALUE, MIN_HOURS_VALUE, MIN_MINUTES_VALUE);
            }
            else 
            {
                HELPER_DATE.time = this._value.time;
                this._listMinYear = (HELPER_DATE.fullYear - 1);
                this._minimum = new Date(this._listMinYear, MIN_MONTH_VALUE, MIN_DATE_VALUE, MIN_HOURS_VALUE, MIN_MINUTES_VALUE);
            }
            if (this._maximum) 
            {
                if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
                {
                    this._listMaxYear = this._maximum.fullYear + 10;
                }
                else 
                {
                    this._listMaxYear = this._maximum.fullYear + 1;
                }
            }
            else if (this._editingMode !== feathers.controls.DateTimeMode.DATE_AND_TIME) 
            {
                HELPER_DATE.time = this._value.time;
                this._listMaxYear = feathers.utils.math.roundUpToNearest(HELPER_DATE.fullYear + 100, 50);
                this._maximum = new Date(this._listMaxYear, MAX_MONTH_VALUE, DAYS_IN_MONTH[MAX_MONTH_VALUE], MAX_HOURS_VALUE_24HOURS, MAX_MINUTES_VALUE);
            }
            else 
            {
                HELPER_DATE.time = this._minimum.time;
                this._listMaxYear = HELPER_DATE.fullYear + 1;
                this._maximum = new Date(this._listMaxYear, MAX_MONTH_VALUE, DAYS_IN_MONTH[MAX_MONTH_VALUE], MAX_HOURS_VALUE_24HOURS, MAX_MINUTES_VALUE);
            }
            return;
        }

        protected function layoutChildren():void
        {
            this.listGroup.width = this.actualWidth;
            this.listGroup.height = this.actualHeight;
            this.listGroup.validate();
            return;
        }

        protected function handlePendingScroll():void
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            if (!this.pendingScrollToDate) 
            {
                return;
            }
            var loc1:*=this.pendingScrollDuration;
            if (loc1 !== loc1) 
            {
                loc1 = this._scrollDuration;
            }
            if (this.yearsList) 
            {
                loc2 = this.pendingScrollToDate.fullYear;
                if (this.yearsList.selectedItem !== loc2) 
                {
                    loc3 = IntegerRange(this.yearsList.dataProvider.data);
                    this.yearsList.scrollToDisplayIndex(loc2 - loc3.minimum, loc1);
                }
            }
            if (this.monthsList) 
            {
                loc4 = this.pendingScrollToDate.month;
                if (this.monthsList.selectedItem !== loc4) 
                {
                    this.monthsList.scrollToDisplayIndex(loc4, loc1);
                }
            }
            if (this.datesList) 
            {
                loc5 = this.pendingScrollToDate.date;
                if (this.datesList.selectedItem !== loc5) 
                {
                    this.datesList.scrollToDisplayIndex((loc5 - 1), loc1);
                }
            }
            if (this.dateAndTimeDatesList) 
            {
                loc6 = (this.pendingScrollToDate.time - this._minimum.time) / MS_PER_DAY;
                if (this.dateAndTimeDatesList.selectedIndex !== loc6) 
                {
                    this.dateAndTimeDatesList.scrollToDisplayIndex(loc6, loc1);
                }
            }
            if (this.hoursList) 
            {
                loc7 = this.pendingScrollToDate.hours;
                if (this._showMeridiem) 
                {
                    loc7 = loc7 % 12;
                }
                if (this.hoursList.selectedItem !== loc7) 
                {
                    this.hoursList.scrollToDisplayIndex(loc7, loc1);
                }
            }
            if (this.minutesList) 
            {
                loc8 = this.pendingScrollToDate.minutes;
                if (this.minutesList.selectedItem !== loc8) 
                {
                    this.minutesList.scrollToDisplayIndex(loc8, loc1);
                }
            }
            if (this.meridiemList) 
            {
                loc9 = this.pendingScrollToDate.hours < MAX_HOURS_VALUE_12HOURS ? 0 : 1;
                if (this.meridiemList.selectedIndex !== loc9) 
                {
                    this.meridiemList.scrollToDisplayIndex(loc9, loc1);
                }
            }
            return;
        }

        protected function meridiemListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            return loc1;
        }

        protected function minutesListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            loc1.labelFunction = this.formatMinutes;
            loc1.enabledFunction = this.isMinuteEnabled;
            loc1.itemHasEnabled = true;
            return loc1;
        }

        protected function hoursListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            loc1.labelFunction = this.formatHours;
            loc1.enabledFunction = this.isHourEnabled;
            loc1.itemHasEnabled = true;
            return loc1;
        }

        protected function dateAndTimeDatesListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            loc1.labelFunction = this.formatDateAndTimeDate;
            loc1.accessoryLabelFunction = this.formatDateAndTimeWeekday;
            return loc1;
        }

        protected function monthsListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            loc1.labelFunction = this.formatMonthName;
            loc1.enabledFunction = this.isMonthEnabled;
            loc1.itemHasEnabled = true;
            return loc1;
        }

        protected function datesListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            loc1.enabledFunction = this.isDateEnabled;
            loc1.itemHasEnabled = true;
            return loc1;
        }

        protected function yearsListItemRendererFactory():feathers.controls.renderers.DefaultListItemRenderer
        {
            var loc1:*=null;
            if (this._itemRendererFactory === null) 
            {
                loc1 = new feathers.controls.renderers.DefaultListItemRenderer();
            }
            else 
            {
                loc1 = feathers.controls.renderers.DefaultListItemRenderer(this._itemRendererFactory());
            }
            loc1.enabledFunction = this.isYearEnabled;
            loc1.itemHasEnabled = true;
            return loc1;
        }

        protected function isMonthEnabled(arg1:int):Boolean
        {
            return arg1 >= this._minMonth && arg1 <= this._maxMonth;
        }

        protected function isYearEnabled(arg1:int):Boolean
        {
            return arg1 >= this._minYear && arg1 <= this._maxYear;
        }

        protected function isDateEnabled(arg1:int):Boolean
        {
            return arg1 >= this._minDate && arg1 <= this._maxDate;
        }

        protected function isHourEnabled(arg1:int):Boolean
        {
            if (this._showMeridiem && !(this.meridiemList.selectedIndex === 0)) 
            {
                arg1 = arg1 + 12;
            }
            return arg1 >= this._minHours && arg1 <= this._maxHours;
        }

        protected function isMinuteEnabled(arg1:int):Boolean
        {
            return arg1 >= this._minMinute && arg1 <= this._maxMinute;
        }

        protected function formatHours(arg1:int):String
        {
            if (this._showMeridiem) 
            {
                if (arg1 === 0) 
                {
                    arg1 = 12;
                }
                return arg1.toString();
            }
            var loc1:*=arg1.toString();
            if (loc1.length < 2) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        protected function formatMinutes(arg1:int):String
        {
            var loc1:*=arg1.toString();
            if (loc1.length < 2) 
            {
                loc1 = "0" + loc1;
            }
            return loc1;
        }

        protected function formatDateAndTimeWeekday(arg1:Object):String
        {
            if (arg1 is int) 
            {
                HELPER_DATE.setTime(this._minimum.time);
                HELPER_DATE.setDate(HELPER_DATE.date + arg1);
                if (this._todayLabel) 
                {
                    if (HELPER_DATE.fullYear === this._lastValidate.fullYear && HELPER_DATE.month === this._lastValidate.month && HELPER_DATE.date === this._lastValidate.date) 
                    {
                        return "";
                    }
                }
                return this._localeWeekdayNames[HELPER_DATE.day] as String;
            }
            return "Wom";
        }

        protected function formatDateAndTimeDate(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is int) 
            {
                HELPER_DATE.setTime(this._minimum.time);
                HELPER_DATE.setDate(HELPER_DATE.date + arg1);
                if (this._todayLabel) 
                {
                    if (HELPER_DATE.fullYear === this._lastValidate.fullYear && HELPER_DATE.month === this._lastValidate.month && HELPER_DATE.date === this._lastValidate.date) 
                    {
                        return this._todayLabel;
                    }
                }
                loc1 = this._localeMonthNames[HELPER_DATE.month] as String;
                if (this._monthFirst) 
                {
                    return loc1 + " " + HELPER_DATE.date;
                }
                return HELPER_DATE.date + " " + loc1;
            }
            return "Wom 30";
        }

        protected function formatMonthName(arg1:int):String
        {
            return this._localeMonthNames[arg1] as String;
        }

        protected function validateNewValue():void
        {
            var loc1:*=this._value.time;
            var loc2:*=this._minimum.time;
            var loc3:*=this._maximum.time;
            var loc4:*=false;
            if (loc1 < loc2) 
            {
                loc4 = true;
                this._value.setTime(loc2);
            }
            else if (loc1 > loc3) 
            {
                loc4 = true;
                this._value.setTime(loc3);
            }
            if (loc4) 
            {
                this.scrollToDate(this._value);
            }
            return;
        }

        protected function updateHoursFromLists():void
        {
            var loc1:*=this.hoursList.selectedItem as int;
            if (this.meridiemList && this.meridiemList.selectedIndex === 1) 
            {
                loc1 = loc1 + 12;
            }
            this._value.setHours(loc1);
            return;
        }

        protected function monthsList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            var loc1:*=this.monthsList.selectedItem as int;
            this._value.setMonth(loc1);
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function datesList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            var loc1:*=this.datesList.selectedItem as int;
            this._value.setDate(loc1);
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function yearsList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            var loc1:*=this.yearsList.selectedItem as int;
            this._value.setFullYear(loc1);
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function dateAndTimeDatesList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            this._value.setFullYear(this._minimum.fullYear, this._minimum.month, this._minimum.date + this.dateAndTimeDatesList.selectedIndex);
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function hoursList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            this.updateHoursFromLists();
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function minutesList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            var loc1:*=this.minutesList.selectedItem as int;
            this._value.setMinutes(loc1);
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected function meridiemList_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreListChanges) 
            {
                return;
            }
            this.updateHoursFromLists();
            this.validateNewValue();
            this.refreshValidRanges();
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public static const DEFAULT_CHILD_STYLE_NAME_LIST:String="feathers-date-time-spinner-list";

        public static const EDITING_MODE_DATE_AND_TIME:String="dateAndTime";

        public static const EDITING_MODE_TIME:String="time";

        public static const EDITING_MODE_DATE:String="date";

        internal static const MIN_MONTH_VALUE:int=0;

        internal static const MAX_MONTH_VALUE:int=11;

        internal static const MIN_DATE_VALUE:int=1;

        internal static const MAX_DATE_VALUE:int=31;

        internal static const MIN_HOURS_VALUE:int=0;

        internal static const MAX_HOURS_VALUE_12HOURS:int=11;

        internal static const MAX_HOURS_VALUE_24HOURS:int=23;

        internal static const MIN_MINUTES_VALUE:int=0;

        internal static const MAX_MINUTES_VALUE:int=59;

        internal static const HELPER_DATE:Date=new Date();

        internal static const DAYS_IN_MONTH:__AS3__.vec.Vector.<int>=new Vector.<int>(0);

        protected static const INVALIDATION_FLAG_LOCALE:String="locale";

        protected static const INVALIDATION_FLAG_EDITING_MODE:String="editingMode";

        protected static const INVALIDATION_FLAG_PENDING_SCROLL:String="pendingScroll";

        protected static const INVALIDATION_FLAG_SPINNER_LIST_FACTORY:String="spinnerListFactory";

        internal static const MS_PER_DAY:int=86400000;

        protected var _ignoreListChanges:Boolean=false;

        protected var _monthFirst:Boolean=true;

        protected var _showMeridiem:Boolean=true;

        protected var _lastMeridiemValue:int=0;

        protected var _listMinYear:int;

        protected var _listMaxYear:int;

        protected var _minYear:int;

        protected var _maxYear:int;

        protected var _minMonth:int;

        protected var _maxMonth:int;

        protected var _minDate:int;

        protected var _maxDate:int;

        protected var _minHours:int;

        protected var _maxHours:int;

        protected var _minMinute:int;

        protected var _maxMinute:int;

        protected var _scrollDuration:Number=0.5;

        protected var _listFactory:Function;

        protected var _customListStyleName:String;

        protected var _customItemRendererStyleName:String;

        protected var _lastValidate:Date;

        protected var _todayLabel:String=null;

        protected var _amString:String;

        protected var _minimum:Date;

        protected var pendingScrollToDate:Date;

        protected var pendingScrollDuration:Number;

        protected var listStyleName:String="feathers-date-time-spinner-list";

        protected var monthsList:feathers.controls.SpinnerList;

        protected var datesList:feathers.controls.SpinnerList;

        protected var _itemRendererFactory:Function;

        protected var yearsList:feathers.controls.SpinnerList;

        protected var dateAndTimeDatesList:feathers.controls.SpinnerList;

        protected var hoursList:feathers.controls.SpinnerList;

        protected var minutesList:feathers.controls.SpinnerList;

        protected var meridiemList:feathers.controls.SpinnerList;

        protected var listGroup:feathers.controls.LayoutGroup;

        protected var _locale:String="i-default";

        protected var _value:Date;

        protected var _maximum:Date;

        protected var _minuteStep:int=1;

        protected var _editingMode:String="dateAndTime";

        protected var _pmString:String;

        protected var _formatter:flash.globalization.DateTimeFormatter;

        protected var _longestMonthNameIndex:int;

        protected var _localeMonthNames:__AS3__.vec.Vector.<String>;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _localeWeekdayNames:__AS3__.vec.Vector.<String>;
    }
}

import feathers.data.*;


class IntegerRange extends Object
{
    public function IntegerRange(arg1:int, arg2:int, arg3:int=1)
    {
        super();
        this.minimum = arg1;
        this.maximum = arg2;
        this.step = arg3;
        return;
    }

    public var minimum:int;

    public var maximum:int;

    public var step:int;
}

class IntegerRangeDataDescriptor extends Object implements feathers.data.IListCollectionDataDescriptor
{
    public function IntegerRangeDataDescriptor()
    {
        super();
        return;
    }

    public function getLength(arg1:Object):int
    {
        var loc1:*=IntegerRange(arg1);
        return 1 + int((loc1.maximum - loc1.minimum) / loc1.step);
    }

    public function getItemAt(arg1:Object, arg2:int):Object
    {
        var loc1:*=IntegerRange(arg1);
        var loc2:*=loc1.maximum;
        var loc3:*=loc1.minimum + arg2 * loc1.step;
        if (loc3 > loc2) 
        {
            loc3 = loc2;
        }
        return loc3;
    }

    public function setItemAt(arg1:Object, arg2:Object, arg3:int):void
    {
        throw "Not implemented";
    }

    public function addItemAt(arg1:Object, arg2:Object, arg3:int):void
    {
        throw "Not implemented";
    }

    public function removeItemAt(arg1:Object, arg2:int):Object
    {
        throw "Not implemented";
    }

    public function getItemIndex(arg1:Object, arg2:Object):int
    {
        if (!(arg2 is int)) 
        {
            return -1;
        }
        var loc1:*=arg2 as int;
        var loc2:*=IntegerRange(arg1);
        return Math.ceil((loc1 - loc2.minimum) / loc2.step);
    }

    public function removeAll(arg1:Object):void
    {
        throw "Not implemented";
    }
}

