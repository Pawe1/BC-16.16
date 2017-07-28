//class StyleNameFunctionStyleProvider
package feathers.skins 
{
    import feathers.core.*;
    
    public class StyleNameFunctionStyleProvider extends Object implements feathers.skins.IStyleProvider
    {
        public function StyleNameFunctionStyleProvider(arg1:Function=null)
        {
            super();
            this._defaultStyleFunction = arg1;
            return;
        }

        public function get defaultStyleFunction():Function
        {
            return this._defaultStyleFunction;
        }

        public function set defaultStyleFunction(arg1:Function):void
        {
            this._defaultStyleFunction = arg1;
            return;
        }

        public function setFunctionForStyleName(arg1:String, arg2:Function):void
        {
            if (!this._styleNameMap) 
            {
                this._styleNameMap = {};
            }
            this._styleNameMap[arg1] = arg2;
            return;
        }

        public function applyStyles(arg1:feathers.core.IFeathersControl):void
        {
            var loc1:*=false;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            var loc6:*=null;
            if (this._styleNameMap) 
            {
                loc1 = false;
                loc2 = arg1.styleNameList;
                loc3 = loc2.length;
                loc4 = 0;
                while (loc4 < loc3) 
                {
                    loc5 = loc2.item(loc4);
                    loc6 = this._styleNameMap[loc5] as Function;
                    if (loc6 != null) 
                    {
                        loc1 = true;
                        loc6(arg1);
                    }
                    ++loc4;
                }
                if (loc1) 
                {
                    return;
                }
            }
            if (this._defaultStyleFunction != null) 
            {
                this._defaultStyleFunction(arg1);
            }
            return;
        }

        protected var _defaultStyleFunction:Function;

        protected var _styleNameMap:Object;
    }
}


