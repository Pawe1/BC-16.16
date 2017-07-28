//class AddOnFunctionStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public class AddOnFunctionStyleProvider extends Object implements feathers.skins.IStyleProvider
    {
        public function AddOnFunctionStyleProvider(arg1:feathers.skins.IStyleProvider=null, arg2:Function=null)
        {
            super();
            this._originalStyleProvider = arg1;
            this._addOnFunction = arg2;
            return;
        }

        public function get originalStyleProvider():feathers.skins.IStyleProvider
        {
            return this._originalStyleProvider;
        }

        public function set originalStyleProvider(arg1:feathers.skins.IStyleProvider):void
        {
            this._originalStyleProvider = arg1;
            return;
        }

        public function get addOnFunction():Function
        {
            return this._addOnFunction;
        }

        public function set addOnFunction(arg1:Function):void
        {
            this._addOnFunction = arg1;
            return;
        }

        public function get callBeforeOriginalStyleProvider():Boolean
        {
            return this._callBeforeOriginalStyleProvider;
        }

        public function set callBeforeOriginalStyleProvider(arg1:Boolean):void
        {
            this._callBeforeOriginalStyleProvider = arg1;
            return;
        }

        public function applyStyles(arg1:feathers.core.IFeathersControl):void
        {
            if (this._callBeforeOriginalStyleProvider && !(this._addOnFunction === null)) 
            {
                this._addOnFunction(arg1);
            }
            if (this._originalStyleProvider) 
            {
                this._originalStyleProvider.applyStyles(arg1);
            }
            if (!this._callBeforeOriginalStyleProvider && !(this._addOnFunction === null)) 
            {
                this._addOnFunction(arg1);
            }
            return;
        }

        protected var _originalStyleProvider:feathers.skins.IStyleProvider;

        protected var _addOnFunction:Function;

        protected var _callBeforeOriginalStyleProvider:Boolean=false;
    }
}


