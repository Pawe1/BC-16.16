//class FontStylesSet
package feathers.text 
{
    import feathers.core.*;
    import starling.events.*;
    import starling.text.*;
    
    public class FontStylesSet extends starling.events.EventDispatcher
    {
        public function FontStylesSet()
        {
            super();
            return;
        }

        public function get format():starling.text.TextFormat
        {
            return this._format;
        }

        public function set format(arg1:starling.text.TextFormat):void
        {
            if (this._format === arg1) 
            {
                return;
            }
            if (arg1 === null && !(this._format === null)) 
            {
                this._format.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                this._format = null;
            }
            else if (arg1 !== null) 
            {
                if (this._format !== null) 
                {
                    this._format.copyFrom(arg1);
                }
                else 
                {
                    this._format = arg1.clone();
                    this._format.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get disabledFormat():starling.text.TextFormat
        {
            return this._disabledFormat;
        }

        public function set disabledFormat(arg1:starling.text.TextFormat):void
        {
            if (this._disabledFormat === arg1) 
            {
                return;
            }
            if (arg1 === null && !(this._disabledFormat === null)) 
            {
                this._disabledFormat.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                this._disabledFormat = null;
            }
            else if (arg1 !== null) 
            {
                if (this._disabledFormat !== null) 
                {
                    this._disabledFormat.copyFrom(arg1);
                }
                else 
                {
                    this._disabledFormat = arg1.clone();
                    this._disabledFormat.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get selectedFormat():starling.text.TextFormat
        {
            return this._selectedFormat;
        }

        public function set selectedFormat(arg1:starling.text.TextFormat):void
        {
            if (this._selectedFormat === arg1) 
            {
                return;
            }
            if (arg1 === null && !(this._selectedFormat === null)) 
            {
                this._selectedFormat.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                this._selectedFormat = null;
            }
            else if (arg1 !== null) 
            {
                if (this._selectedFormat !== null) 
                {
                    this._selectedFormat.copyFrom(arg1);
                }
                else 
                {
                    this._selectedFormat = arg1.clone();
                    this._selectedFormat.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                }
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function getFormatForState(arg1:String):starling.text.TextFormat
        {
            if (this._stateToFormat === null) 
            {
                return null;
            }
            return starling.text.TextFormat(this._stateToFormat[arg1]);
        }

        public function setFormatForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            var loc1:*=null;
            if (arg2 === null) 
            {
                if (this._stateToFormat !== null) 
                {
                    loc1 = starling.text.TextFormat(this._stateToFormat[arg1]);
                    if (loc1 !== null) 
                    {
                        loc1.removeEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                        delete this._stateToFormat[arg1];
                    }
                }
            }
            else 
            {
                if (this._stateToFormat !== null) 
                {
                    loc1 = starling.text.TextFormat(this._stateToFormat[arg1]);
                }
                else 
                {
                    this._stateToFormat = {};
                }
                if (loc1 !== null) 
                {
                    loc1.copyFrom(arg2);
                }
                else 
                {
                    loc1 = arg2.clone();
                    loc1.addEventListener(starling.events.Event.CHANGE, this.format_changeHandler);
                    this._stateToFormat[arg1] = loc1;
                }
            }
            return;
        }

        public function getTextFormatForTarget(arg1:feathers.core.IFeathersControl):starling.text.TextFormat
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (arg1 is feathers.core.IStateObserver) 
            {
                loc2 = feathers.core.IStateObserver(arg1).stateContext;
            }
            if (loc2 === null) 
            {
                if (!(this._disabledFormat === null) && !arg1.isEnabled) 
                {
                    loc1 = this._disabledFormat;
                }
            }
            else 
            {
                if (this._stateToFormat !== null) 
                {
                    loc3 = loc2.currentState;
                    if (loc3 in this._stateToFormat) 
                    {
                        loc1 = starling.text.TextFormat(this._stateToFormat[loc3]);
                    }
                }
                if (loc1 === null && !(this._disabledFormat === null) && loc2 is feathers.core.IFeathersControl && !feathers.core.IFeathersControl(loc2).isEnabled) 
                {
                    loc1 = this._disabledFormat;
                }
                if (loc1 === null && !(this._selectedFormat === null) && loc2 is feathers.core.IToggle && feathers.core.IToggle(loc2).isSelected) 
                {
                    loc1 = this._selectedFormat;
                }
            }
            if (loc1 === null) 
            {
                loc1 = this._format;
            }
            return loc1;
        }

        protected function format_changeHandler(arg1:starling.events.Event):void
        {
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _stateToFormat:Object;

        protected var _format:starling.text.TextFormat;

        protected var _disabledFormat:starling.text.TextFormat;

        protected var _selectedFormat:starling.text.TextFormat;
    }
}


