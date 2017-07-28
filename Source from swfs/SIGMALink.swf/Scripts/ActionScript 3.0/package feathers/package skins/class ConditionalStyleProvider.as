//class ConditionalStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public class ConditionalStyleProvider extends Object implements feathers.skins.IStyleProvider
    {
        public function ConditionalStyleProvider(arg1:Function, arg2:feathers.skins.IStyleProvider=null, arg3:feathers.skins.IStyleProvider=null)
        {
            super();
            this._conditionalFunction = arg1;
            this._trueStyleProvider = arg2;
            this._falseStyleProvider = arg3;
            return;
        }

        public function get trueStyleProvider():feathers.skins.IStyleProvider
        {
            return this._trueStyleProvider;
        }

        public function set trueStyleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            this._trueStyleProvider = arg1;
            return;
        }

        public function get falseStyleProvider():feathers.skins.IStyleProvider
        {
            return this._falseStyleProvider;
        }

        public function set falseStyleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            this._falseStyleProvider = arg1;
            return;
        }

        public function get conditionalFunction():Function
        {
            return this._conditionalFunction;
        }

        public function set conditionalFunction(arg1:Function):void
        {
            this._conditionalFunction = arg1;
            return;
        }

        public function applyStyles(arg1:feathers.core.IFeathersControl):void
        {
            var loc1:*=false;
            if (this._conditionalFunction !== null) 
            {
                loc1 = this._conditionalFunction(arg1) as Boolean;
            }
            if (loc1 !== true) 
            {
                if (this._falseStyleProvider !== null) 
                {
                    this._falseStyleProvider.applyStyles(arg1);
                }
            }
            else if (this._trueStyleProvider !== null) 
            {
                this._trueStyleProvider.applyStyles(arg1);
            }
            return;
        }

        protected var _trueStyleProvider:feathers.skins.IStyleProvider;

        protected var _falseStyleProvider:feathers.skins.IStyleProvider;

        protected var _conditionalFunction:Function;
    }
}


