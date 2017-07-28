//class NumericStepper
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.math.*;
    import flash.events.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class NumericStepper extends feathers.core.FeathersControl implements feathers.controls.IRange, feathers.core.IAdvancedNativeFocusOwner, feathers.core.ITextBaselineControl
    {
        public function NumericStepper()
        {
            super();
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.numericStepper_removedFromStageHandler);
            return;
        }

        public function set customDecrementButtonStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customDecrementButtonStyleName === arg1) 
            {
                return;
            }
            this._customDecrementButtonStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_DECREMENT_BUTTON_FACTORY);
            return;
        }

        public function set incrementButtonFactory(arg1:Function):void
        {
            if (this._incrementButtonFactory == arg1) 
            {
                return;
            }
            this._incrementButtonFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_INCREMENT_BUTTON_FACTORY);
            return;
        }

        public function get repeatDelay():Number
        {
            return this._repeatDelay;
        }

        public function set repeatDelay(arg1:Number):void
        {
            if (this._repeatDelay == arg1) 
            {
                return;
            }
            this._repeatDelay = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get decrementButtonProperties():Object
        {
            if (!this._decrementButtonProperties) 
            {
                this._decrementButtonProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._decrementButtonProperties;
        }

        public function get buttonLayoutMode():String
        {
            return this._buttonLayoutMode;
        }

        public function set buttonLayoutMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._buttonLayoutMode === arg1) 
            {
                return;
            }
            this._buttonLayoutMode = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set decrementButtonProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._decrementButtonProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._decrementButtonProperties) 
            {
                this._decrementButtonProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._decrementButtonProperties = feathers.core.PropertyProxy(arg1);
            if (this._decrementButtonProperties) 
            {
                this._decrementButtonProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get buttonGap():Number
        {
            return this._buttonGap;
        }

        public function set buttonGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._buttonGap === arg1) 
            {
                return;
            }
            this._buttonGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get incrementButtonFactory():Function
        {
            return this._incrementButtonFactory;
        }

        public function get textInputGap():Number
        {
            return this._textInputGap;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return NumericStepper.globalStyleProvider;
        }

        public function get nativeFocus():Object
        {
            if (this.textInput !== null) 
            {
                return this.textInput.nativeFocus;
            }
            return null;
        }

        protected function incrementButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.incrementButton, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = -1;
                this._repeatTimer.stop();
                this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
            }
            else 
            {
                loc1 = arg1.getTouch(this.incrementButton, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                if (this._textInputHasFocus) 
                {
                    this.parseTextInputValue();
                }
                this.touchPointID = loc1.id;
                this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
                this.increment();
                this.startRepeatTimer(this.increment);
            }
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            if (!(this._step == 0) && !(arg1 == this._maximum) && !(arg1 == this._minimum)) 
            {
                arg1 = feathers.utils.math.roundToPrecision(feathers.utils.math.roundToNearest(arg1 - this._minimum, this._step) + this._minimum, 10);
            }
            arg1 = feathers.utils.math.clamp(arg1, this._minimum, this._maximum);
            if (this._value == arg1) 
            {
                return;
            }
            this._value = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set textInputGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._textInputGap === arg1) 
            {
                return;
            }
            this._textInputGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get minimum():Number
        {
            return this._minimum;
        }

        public function set minimum(arg1:Number):void
        {
            if (this._minimum == arg1) 
            {
                return;
            }
            this._minimum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get decrementButtonLabel():String
        {
            return this._decrementButtonLabel;
        }

        public function get maximum():Number
        {
            return this._maximum;
        }

        public function set maximum(arg1:Number):void
        {
            if (this._maximum == arg1) 
            {
                return;
            }
            this._maximum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get decrementButtonFactory():Function
        {
            return this._decrementButtonFactory;
        }

        public function get step():Number
        {
            return this._step;
        }

        public function set step(arg1:Number):void
        {
            if (this._step == arg1) 
            {
                return;
            }
            this._step = arg1;
            return;
        }

        public function set decrementButtonFactory(arg1:Function):void
        {
            if (this._decrementButtonFactory == arg1) 
            {
                return;
            }
            this._decrementButtonFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_DECREMENT_BUTTON_FACTORY);
            return;
        }

        public function get valueFormatFunction():Function
        {
            return this._valueFormatFunction;
        }

        public function set valueFormatFunction(arg1:Function):void
        {
            if (this._valueFormatFunction == arg1) 
            {
                return;
            }
            this._valueFormatFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set decrementButtonLabel(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._decrementButtonLabel === arg1) 
            {
                return;
            }
            this._decrementButtonLabel = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get valueParseFunction():Function
        {
            return this._valueParseFunction;
        }

        public function set valueParseFunction(arg1:Function):void
        {
            this._valueParseFunction = arg1;
            return;
        }

        public function get customDecrementButtonStyleName():String
        {
            return this._customDecrementButtonStyleName;
        }

        public function get customIncrementButtonStyleName():String
        {
            return this._customIncrementButtonStyleName;
        }

        public function set customIncrementButtonStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customIncrementButtonStyleName === arg1) 
            {
                return;
            }
            this._customIncrementButtonStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_INCREMENT_BUTTON_FACTORY);
            return;
        }

        public function get incrementButtonProperties():Object
        {
            if (!this._incrementButtonProperties) 
            {
                this._incrementButtonProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._incrementButtonProperties;
        }

        public function set incrementButtonProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._incrementButtonProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._incrementButtonProperties) 
            {
                this._incrementButtonProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._incrementButtonProperties = feathers.core.PropertyProxy(arg1);
            if (this._incrementButtonProperties) 
            {
                this._incrementButtonProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get incrementButtonLabel():String
        {
            return this._incrementButtonLabel;
        }

        public function set incrementButtonLabel(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._incrementButtonLabel === arg1) 
            {
                return;
            }
            this._incrementButtonLabel = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get textInputFactory():Function
        {
            return this._textInputFactory;
        }

        public function set textInputFactory(arg1:Function):void
        {
            if (this._textInputFactory == arg1) 
            {
                return;
            }
            this._textInputFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_INPUT_FACTORY);
            return;
        }

        public function get customTextInputStyleName():String
        {
            return this._customTextInputStyleName;
        }

        public function set customTextInputStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customTextInputStyleName === arg1) 
            {
                return;
            }
            this._customTextInputStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_INPUT_FACTORY);
            return;
        }

        public function get textInputProperties():Object
        {
            if (!this._textInputProperties) 
            {
                this._textInputProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._textInputProperties;
        }

        public function set textInputProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._textInputProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._textInputProperties) 
            {
                this._textInputProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._textInputProperties = feathers.core.PropertyProxy(arg1);
            if (this._textInputProperties) 
            {
                this._textInputProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get baseline():Number
        {
            if (!this.textInput) 
            {
                return this.scaledActualHeight;
            }
            return this.scaleY * (this.textInput.y + this.textInput.baseline);
        }

        public function get hasFocus():Boolean
        {
            return this._hasFocus;
        }

        public function setFocus():void
        {
            if (this.textInput === null) 
            {
                return;
            }
            this.textInput.setFocus();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_DECREMENT_BUTTON_FACTORY);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_INCREMENT_BUTTON_FACTORY);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_TEXT_INPUT_FACTORY);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_FOCUS);
            if (loc5) 
            {
                this.createDecrementButton();
            }
            if (loc6) 
            {
                this.createIncrementButton();
            }
            if (loc7) 
            {
                this.createTextInput();
            }
            if (loc5 || loc2) 
            {
                this.refreshDecrementButtonStyles();
            }
            if (loc6 || loc2) 
            {
                this.refreshIncrementButtonStyles();
            }
            if (loc7 || loc2) 
            {
                this.refreshTextInputStyles();
            }
            if (loc7 || loc1) 
            {
                this.refreshTypicalText();
                this.refreshDisplayedText();
            }
            if (loc5 || loc4) 
            {
                this.decrementButton.isEnabled = this._isEnabled;
            }
            if (loc6 || loc4) 
            {
                this.incrementButton.isEnabled = this._isEnabled;
            }
            if (loc7 || loc4) 
            {
                this.textInput.isEnabled = this._isEnabled;
            }
            loc3 = this.autoSizeIfNeeded() || loc3;
            this.layoutChildren();
            if (loc3 || loc8) 
            {
                this.refreshFocusIndicator();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this._explicitWidth;
            var loc6:*=this._explicitHeight;
            var loc7:*=this._explicitMinWidth;
            var loc8:*=this._explicitMinHeight;
            this.decrementButton.validate();
            this.incrementButton.validate();
            var loc9:*=this.decrementButton.width;
            var loc10:*=this.decrementButton.height;
            var loc11:*=this.decrementButton.minWidth;
            var loc12:*=this.decrementButton.minHeight;
            var loc13:*=this.incrementButton.width;
            var loc14:*=this.incrementButton.height;
            var loc15:*=this.incrementButton.minWidth;
            var loc16:*=this.incrementButton.minHeight;
            var loc17:*=this.textInputExplicitWidth;
            var loc18:*=this.textInputExplicitHeight;
            var loc19:*=this.textInputExplicitMinWidth;
            var loc20:*=this.textInputExplicitMinHeight;
            var loc21:*=Number.POSITIVE_INFINITY;
            var loc22:*=Number.POSITIVE_INFINITY;
            if (this._buttonLayoutMode !== feathers.controls.StepperButtonLayoutMode.RIGHT_SIDE_VERTICAL) 
            {
                if (this._buttonLayoutMode !== feathers.controls.StepperButtonLayoutMode.SPLIT_VERTICAL) 
                {
                    if (!loc1) 
                    {
                        loc17 = this._explicitWidth - loc9 - loc13;
                    }
                    if (!loc2) 
                    {
                        loc18 = this._explicitHeight;
                    }
                    if (!loc3) 
                    {
                        loc19 = this._explicitMinWidth - loc11 - loc15;
                        if (loc19 < this.textInputExplicitMinWidth) 
                        {
                            loc19 = this.textInputExplicitMinWidth;
                        }
                    }
                    if (!loc4) 
                    {
                        loc20 = this._explicitMinHeight;
                        if (this.textInputExplicitMinHeight > loc20) 
                        {
                            loc20 = this.textInputExplicitMinHeight;
                        }
                    }
                    loc21 = this._explicitMaxWidth - loc9 - loc13;
                }
                else 
                {
                    if (!loc1) 
                    {
                        loc17 = this._explicitWidth;
                    }
                    if (!loc2) 
                    {
                        loc18 = this._explicitHeight - loc10 - loc14;
                    }
                    if (!loc3) 
                    {
                        loc19 = this._explicitMinWidth;
                        if (this.textInputExplicitMinWidth > loc19) 
                        {
                            loc19 = this.textInputExplicitMinWidth;
                        }
                    }
                    if (!loc4) 
                    {
                        loc20 = this._explicitMinHeight - loc12 - loc16;
                        if (this.textInputExplicitMinHeight > loc20) 
                        {
                            loc20 = this.textInputExplicitMinHeight;
                        }
                    }
                    loc22 = this._explicitMaxHeight - loc10 - loc14;
                }
            }
            else 
            {
                loc23 = loc9;
                if (loc13 > loc23) 
                {
                    loc23 = loc13;
                }
                loc24 = loc11;
                if (loc15 > loc24) 
                {
                    loc24 = loc15;
                }
                if (!loc1) 
                {
                    loc17 = this._explicitWidth - loc23 - this._textInputGap;
                }
                if (!loc2) 
                {
                    loc18 = this._explicitHeight;
                }
                if (!loc3) 
                {
                    loc19 = this._explicitMinWidth - loc24 - this._textInputGap;
                    if (this.textInputExplicitMinWidth > loc19) 
                    {
                        loc19 = this.textInputExplicitMinWidth;
                    }
                }
                if (!loc4) 
                {
                    loc20 = this._explicitMinHeight;
                    if (this.textInputExplicitMinHeight > loc20) 
                    {
                        loc20 = this.textInputExplicitMinHeight;
                    }
                }
                loc21 = this._explicitMaxWidth - loc23 - this._textInputGap;
            }
            if (loc17 < 0) 
            {
                loc17 = 0;
            }
            if (loc18 < 0) 
            {
                loc18 = 0;
            }
            if (loc19 < 0) 
            {
                loc19 = 0;
            }
            if (loc20 < 0) 
            {
                loc20 = 0;
            }
            this.textInput.width = loc17;
            this.textInput.height = loc18;
            this.textInput.minWidth = loc19;
            this.textInput.minHeight = loc20;
            this.textInput.maxWidth = loc21;
            this.textInput.maxHeight = loc22;
            this.textInput.validate();
            if (this._buttonLayoutMode !== feathers.controls.StepperButtonLayoutMode.RIGHT_SIDE_VERTICAL) 
            {
                if (this._buttonLayoutMode !== feathers.controls.StepperButtonLayoutMode.SPLIT_VERTICAL) 
                {
                    if (loc1) 
                    {
                        loc5 = loc9 + this.textInput.width + loc13 + 2 * this._textInputGap;
                    }
                    if (loc2) 
                    {
                        loc6 = this.textInput.height;
                        if (loc10 > loc6) 
                        {
                            loc6 = loc10;
                        }
                        if (loc14 > loc6) 
                        {
                            loc6 = loc14;
                        }
                    }
                    if (loc3) 
                    {
                        loc7 = loc11 + this.textInput.minWidth + loc15 + 2 * this._textInputGap;
                    }
                    if (loc4) 
                    {
                        loc8 = this.textInput.minHeight;
                        if (loc12 > loc8) 
                        {
                            loc8 = loc12;
                        }
                        if (loc16 > loc8) 
                        {
                            loc8 = loc16;
                        }
                    }
                }
                else 
                {
                    if (loc1) 
                    {
                        loc5 = this.textInput.width;
                        if (loc9 > loc5) 
                        {
                            loc5 = loc9;
                        }
                        if (loc13 > loc5) 
                        {
                            loc5 = loc13;
                        }
                    }
                    if (loc2) 
                    {
                        loc6 = loc10 + this.textInput.height + loc14 + 2 * this._textInputGap;
                    }
                    if (loc3) 
                    {
                        loc7 = this.textInput.minWidth;
                        if (loc11 > loc7) 
                        {
                            loc7 = loc11;
                        }
                        if (loc15 > loc7) 
                        {
                            loc7 = loc15;
                        }
                    }
                    if (loc4) 
                    {
                        loc8 = loc12 + this.textInput.minHeight + loc16 + 2 * this._textInputGap;
                    }
                }
            }
            else 
            {
                if (loc1) 
                {
                    loc5 = this.textInput.width + loc23 + this._textInputGap;
                }
                if (loc2) 
                {
                    loc6 = loc10 + this._buttonGap + loc14;
                    if (this.textInput.height > loc6) 
                    {
                        loc6 = this.textInput.height;
                    }
                }
                if (loc3) 
                {
                    loc7 = this.textInput.minWidth + loc24 + this._textInputGap;
                }
                if (loc4) 
                {
                    loc8 = loc12 + this._buttonGap + loc16;
                    if (this.textInput.minHeight > loc8) 
                    {
                        loc8 = this.textInput.minHeight;
                    }
                }
            }
            return this.saveMeasurements(loc5, loc6, loc7, loc8);
        }

        protected function decrement():void
        {
            this.value = this._value - this._step;
            this.validate();
            this.textInput.selectRange(0, this.textInput.text.length);
            return;
        }

        protected function increment():void
        {
            this.value = this._value + this._step;
            this.validate();
            this.textInput.selectRange(0, this.textInput.text.length);
            return;
        }

        protected function toMinimum():void
        {
            this.value = this._minimum;
            this.validate();
            this.textInput.selectRange(0, this.textInput.text.length);
            return;
        }

        protected function toMaximum():void
        {
            this.value = this._maximum;
            this.validate();
            this.textInput.selectRange(0, this.textInput.text.length);
            return;
        }

        protected function createDecrementButton():void
        {
            if (this.decrementButton) 
            {
                this.decrementButton.removeFromParent(true);
                this.decrementButton = null;
            }
            var loc1:*=this._decrementButtonFactory == null ? defaultDecrementButtonFactory : this._decrementButtonFactory;
            var loc2:*=this._customDecrementButtonStyleName == null ? this.decrementButtonStyleName : this._customDecrementButtonStyleName;
            this.decrementButton = feathers.controls.Button(loc1());
            this.decrementButton.styleNameList.add(loc2);
            this.decrementButton.addEventListener(starling.events.TouchEvent.TOUCH, this.decrementButton_touchHandler);
            this.addChild(this.decrementButton);
            return;
        }

        protected function createIncrementButton():void
        {
            if (this.incrementButton) 
            {
                this.incrementButton.removeFromParent(true);
                this.incrementButton = null;
            }
            var loc1:*=this._incrementButtonFactory == null ? defaultIncrementButtonFactory : this._incrementButtonFactory;
            var loc2:*=this._customIncrementButtonStyleName == null ? this.incrementButtonStyleName : this._customIncrementButtonStyleName;
            this.incrementButton = feathers.controls.Button(loc1());
            this.incrementButton.styleNameList.add(loc2);
            this.incrementButton.addEventListener(starling.events.TouchEvent.TOUCH, this.incrementButton_touchHandler);
            this.addChild(this.incrementButton);
            return;
        }

        protected function createTextInput():void
        {
            if (this.textInput) 
            {
                this.textInput.removeFromParent(true);
                this.textInput = null;
            }
            var loc1:*=this._textInputFactory == null ? defaultTextInputFactory : this._textInputFactory;
            var loc2:*=this._customTextInputStyleName == null ? this.textInputStyleName : this._customTextInputStyleName;
            this.textInput = feathers.controls.TextInput(loc1());
            this.textInput.styleNameList.add(loc2);
            this.textInput.addEventListener(feathers.events.FeathersEventType.ENTER, this.textInput_enterHandler);
            this.textInput.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.textInput_focusInHandler);
            this.textInput.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.textInput_focusOutHandler);
            this.textInput.isFocusEnabled = !this._focusManager;
            this.addChild(this.textInput);
            this.textInput.initializeNow();
            this.textInputExplicitWidth = this.textInput.explicitWidth;
            this.textInputExplicitHeight = this.textInput.explicitHeight;
            this.textInputExplicitMinWidth = this.textInput.explicitMinWidth;
            this.textInputExplicitMinHeight = this.textInput.explicitMinHeight;
            return;
        }

        protected function refreshDecrementButtonStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._decrementButtonProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._decrementButtonProperties[loc1];
                this.decrementButton[loc1] = loc2;
            }
            this.decrementButton.label = this._decrementButtonLabel;
            return;
        }

        protected function refreshIncrementButtonStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._incrementButtonProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._incrementButtonProperties[loc1];
                this.incrementButton[loc1] = loc2;
            }
            this.incrementButton.label = this._incrementButtonLabel;
            return;
        }

        protected function refreshTextInputStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._textInputProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._textInputProperties[loc1];
                this.textInput[loc1] = loc2;
            }
            return;
        }

        protected function refreshDisplayedText():void
        {
            if (this._valueFormatFunction == null) 
            {
                this.textInput.text = this._value.toString();
            }
            else 
            {
                this.textInput.text = this._valueFormatFunction(this._value);
            }
            return;
        }

        protected function refreshTypicalText():void
        {
            var loc1:*="";
            var loc2:*=Math.max(int(this._minimum).toString().length, int(this._maximum).toString().length, int(this._step).toString().length);
            var loc3:*=Math.max(feathers.utils.math.roundToPrecision(this._minimum - int(this._minimum), 10).toString().length, feathers.utils.math.roundToPrecision(this._maximum - int(this._maximum), 10).toString().length, feathers.utils.math.roundToPrecision(this._step - int(this._step), 10).toString().length) - 2;
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            var loc4:*=loc2 + loc3;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc1 = loc1 + "0";
                ++loc5;
            }
            if (loc3 > 0) 
            {
                loc1 = loc1 + ".";
            }
            this.textInput.typicalText = loc1;
            return;
        }

        protected function layoutChildren():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this._buttonLayoutMode !== feathers.controls.StepperButtonLayoutMode.RIGHT_SIDE_VERTICAL) 
            {
                if (this._buttonLayoutMode !== feathers.controls.StepperButtonLayoutMode.SPLIT_VERTICAL) 
                {
                    this.decrementButton.x = 0;
                    this.decrementButton.y = 0;
                    this.decrementButton.height = this.actualHeight;
                    this.decrementButton.validate();
                    this.incrementButton.y = 0;
                    this.incrementButton.height = this.actualHeight;
                    this.incrementButton.validate();
                    this.incrementButton.x = this.actualWidth - this.incrementButton.width;
                    this.textInput.x = this.decrementButton.width + this._textInputGap;
                    this.textInput.width = this.actualWidth - this.decrementButton.width - this.incrementButton.width - 2 * this._textInputGap;
                    this.textInput.height = this.actualHeight;
                }
                else 
                {
                    this.incrementButton.x = 0;
                    this.incrementButton.y = 0;
                    this.incrementButton.width = this.actualWidth;
                    this.incrementButton.validate();
                    this.decrementButton.x = 0;
                    this.decrementButton.width = this.actualWidth;
                    this.decrementButton.validate();
                    this.decrementButton.y = this.actualHeight - this.decrementButton.height;
                    this.textInput.x = 0;
                    this.textInput.y = this.incrementButton.height + this._textInputGap;
                    this.textInput.width = this.actualWidth;
                    this.textInput.height = Math.max(0, this.actualHeight - this.decrementButton.height - this.incrementButton.height - 2 * this._textInputGap);
                }
            }
            else 
            {
                loc1 = (this.actualHeight - this._buttonGap) / 2;
                this.incrementButton.y = 0;
                this.incrementButton.height = loc1;
                this.incrementButton.validate();
                this.decrementButton.y = loc1 + this._buttonGap;
                this.decrementButton.height = loc1;
                this.decrementButton.validate();
                loc2 = Math.max(this.decrementButton.width, this.incrementButton.width);
                loc3 = this.actualWidth - loc2;
                this.decrementButton.x = loc3;
                this.incrementButton.x = loc3;
                this.textInput.x = 0;
                this.textInput.y = 0;
                this.textInput.width = loc3 - this._textInputGap;
                this.textInput.height = this.actualHeight;
            }
            this.textInput.validate();
            return;
        }

        protected function startRepeatTimer(arg1:Function):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.touchPointID >= 0) 
            {
                loc1 = feathers.events.ExclusiveTouch.forStage(this.stage);
                loc2 = loc1.getClaim(this.touchPointID);
                if (loc2 != this) 
                {
                    if (loc2) 
                    {
                        return;
                    }
                    loc1.claimTouch(this.touchPointID, this);
                }
            }
            this.currentRepeatAction = arg1;
            if (this._repeatDelay > 0) 
            {
                if (this._repeatTimer) 
                {
                    this._repeatTimer.reset();
                    this._repeatTimer.delay = this._repeatDelay * 1000;
                }
                else 
                {
                    this._repeatTimer = new flash.utils.Timer(this._repeatDelay * 1000);
                    this._repeatTimer.addEventListener(flash.events.TimerEvent.TIMER, this.repeatTimer_timerHandler);
                }
                this._repeatTimer.start();
            }
            return;
        }

        protected function parseTextInputValue():void
        {
            var loc1:*=NaN;
            if (this._valueParseFunction == null) 
            {
                loc1 = parseFloat(this.textInput.text);
            }
            else 
            {
                loc1 = this._valueParseFunction(this.textInput.text);
            }
            if (loc1 === loc1) 
            {
                this.value = loc1;
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:Object):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function numericStepper_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.touchPointID = -1;
            return;
        }

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this.textInput.setFocus();
            this.textInput.selectRange(0, this.textInput.text.length);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            super.focusOutHandler(arg1);
            this.textInput.clearFocus();
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        protected function textInput_enterHandler(arg1:starling.events.Event):void
        {
            this.parseTextInputValue();
            return;
        }

        protected function textInput_focusInHandler(arg1:starling.events.Event):void
        {
            this._textInputHasFocus = true;
            return;
        }

        protected function textInput_focusOutHandler(arg1:starling.events.Event):void
        {
            this._textInputHasFocus = false;
            this.parseTextInputValue();
            return;
        }

        protected function decrementButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.decrementButton, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = -1;
                this._repeatTimer.stop();
                this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
            }
            else 
            {
                loc1 = arg1.getTouch(this.decrementButton, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                if (this._textInputHasFocus) 
                {
                    this.parseTextInputValue();
                }
                this.touchPointID = loc1.id;
                this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
                this.decrement();
                this.startRepeatTimer(this.decrement);
            }
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode != flash.ui.Keyboard.HOME) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.END) 
                {
                    if (arg1.keyCode != flash.ui.Keyboard.UP) 
                    {
                        if (arg1.keyCode == flash.ui.Keyboard.DOWN) 
                        {
                            arg1.preventDefault();
                            this.decrement();
                        }
                    }
                    else 
                    {
                        arg1.preventDefault();
                        this.increment();
                    }
                }
                else 
                {
                    arg1.preventDefault();
                    this.toMaximum();
                }
            }
            else 
            {
                arg1.preventDefault();
                this.toMinimum();
            }
            return;
        }

        protected function repeatTimer_timerHandler(arg1:flash.events.TimerEvent):void
        {
            if (this._repeatTimer.currentCount < 5) 
            {
                return;
            }
            this.currentRepeatAction();
            return;
        }

        protected static function defaultTextInputFactory():feathers.controls.TextInput
        {
            return new feathers.controls.TextInput();
        }

        protected static function defaultDecrementButtonFactory():feathers.controls.Button
        {
            return new feathers.controls.Button();
        }

        protected static function defaultIncrementButtonFactory():feathers.controls.Button
        {
            return new feathers.controls.Button();
        }

        public static const DEFAULT_CHILD_STYLE_NAME_DECREMENT_BUTTON:String="feathers-numeric-stepper-decrement-button";

        public static const DEFAULT_CHILD_STYLE_NAME_INCREMENT_BUTTON:String="feathers-numeric-stepper-increment-button";

        public static const DEFAULT_CHILD_STYLE_NAME_TEXT_INPUT:String="feathers-numeric-stepper-text-input";

        public static const BUTTON_LAYOUT_MODE_SPLIT_HORIZONTAL:String="splitHorizontal";

        public static const BUTTON_LAYOUT_MODE_SPLIT_VERTICAL:String="splitVertical";

        public static const BUTTON_LAYOUT_MODE_RIGHT_SIDE_VERTICAL:String="rightSideVertical";

        protected static const INVALIDATION_FLAG_INCREMENT_BUTTON_FACTORY:String="incrementButtonFactory";

        protected static const INVALIDATION_FLAG_TEXT_INPUT_FACTORY:String="textInputFactory";

        protected static const INVALIDATION_FLAG_DECREMENT_BUTTON_FACTORY:String="decrementButtonFactory";

        protected var _buttonLayoutMode:String="splitHorizontal";

        protected var _buttonGap:Number=0;

        protected var _textInputGap:Number=0;

        protected var _decrementButtonFactory:Function;

        protected var _customDecrementButtonStyleName:String;

        protected var _decrementButtonProperties:feathers.core.PropertyProxy;

        protected var _decrementButtonLabel:String=null;

        protected var _incrementButtonFactory:Function;

        protected var _value:Number=0;

        protected var decrementButtonStyleName:String="feathers-numeric-stepper-decrement-button";

        protected var incrementButtonStyleName:String="feathers-numeric-stepper-increment-button";

        protected var _incrementButtonProperties:feathers.core.PropertyProxy;

        protected var textInputStyleName:String="feathers-numeric-stepper-text-input";

        protected var decrementButton:feathers.controls.Button;

        protected var _incrementButtonLabel:String=null;

        protected var incrementButton:feathers.controls.Button;

        protected var textInput:feathers.controls.TextInput;

        protected var _textInputFactory:Function;

        protected var textInputExplicitWidth:Number;

        protected var textInputExplicitHeight:Number;

        protected var _customIncrementButtonStyleName:String;

        protected var _customTextInputStyleName:String;

        protected var textInputExplicitMinWidth:Number;

        protected var textInputExplicitMinHeight:Number;

        protected var _textInputProperties:feathers.core.PropertyProxy;

        protected var touchPointID:int=-1;

        protected var _textInputHasFocus:Boolean=false;

        protected var _minimum:Number=0;

        protected var _maximum:Number=0;

        protected var _step:Number=0;

        protected var _valueFormatFunction:Function;

        protected var _valueParseFunction:Function;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var currentRepeatAction:Function;

        protected var _repeatTimer:flash.utils.Timer;

        protected var _repeatDelay:Number=0.05;
    }
}


