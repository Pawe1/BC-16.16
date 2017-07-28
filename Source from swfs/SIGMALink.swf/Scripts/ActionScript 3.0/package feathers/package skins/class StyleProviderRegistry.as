//class StyleProviderRegistry
package feathers.skins 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public class StyleProviderRegistry extends Object
    {
        public function StyleProviderRegistry(arg1:Boolean=true, arg2:Function=null)
        {
            this._classToStyleProvider = new flash.utils.Dictionary(true);
            super();
            this._registerGlobally = arg1;
            if (arg2 !== null) 
            {
                this._styleProviderFactory = arg2;
            }
            else 
            {
                this._styleProviderFactory = defaultStyleProviderFactory;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._classToStyleProvider;
            for (loc1 in loc4) 
            {
                loc2 = Class(loc1);
                this.clearStyleProvider(loc2);
            }
            this._classToStyleProvider = null;
            return;
        }

        public function hasStyleProvider(arg1:Class):Boolean
        {
            if (this._classToStyleProvider === null) 
            {
                return false;
            }
            return arg1 in this._classToStyleProvider;
        }

        public function getRegisteredClasses(arg1:__AS3__.vec.Vector.<Class>=null):__AS3__.vec.Vector.<Class>
        {
            var loc2:*=null;
            if (arg1 === null) 
            {
                arg1 = new Vector.<Class>(0);
            }
            else 
            {
                arg1.length = 0;
            }
            var loc1:*=0;
            var loc3:*=0;
            var loc4:*=this._classToStyleProvider;
            for (loc2 in loc4) 
            {
                arg1[loc1] = loc2 as Class;
                ++loc1;
            }
            return arg1;
        }

        public function getStyleProvider(arg1:Class):feathers.skins.IStyleProvider
        {
            this.validateComponentClass(arg1);
            var loc1:*=feathers.skins.IStyleProvider(this._classToStyleProvider[arg1]);
            if (!loc1) 
            {
                loc1 = this._styleProviderFactory();
                this._classToStyleProvider[arg1] = loc1;
                if (this._registerGlobally) 
                {
                    arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] = loc1;
                }
            }
            return loc1;
        }

        public function clearStyleProvider(arg1:Class):feathers.skins.IStyleProvider
        {
            var loc1:*=null;
            this.validateComponentClass(arg1);
            if (arg1 in this._classToStyleProvider) 
            {
                loc1 = feathers.skins.IStyleProvider(this._classToStyleProvider[arg1]);
                delete this._classToStyleProvider[arg1];
                if (this._registerGlobally && arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] === loc1) 
                {
                    arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] = null;
                }
                return loc1;
            }
            return null;
        }

        protected function validateComponentClass(arg1:Class):void
        {
            if (!this._registerGlobally || Object(arg1).hasOwnProperty(GLOBAL_STYLE_PROVIDER_PROPERTY_NAME)) 
            {
                return;
            }
            throw ArgumentError("Class " + arg1 + " must have a " + GLOBAL_STYLE_PROVIDER_PROPERTY_NAME + " static property to support themes.");
        }

        protected static function defaultStyleProviderFactory():feathers.skins.IStyleProvider
        {
            return new feathers.skins.StyleNameFunctionStyleProvider();
        }

        protected static const GLOBAL_STYLE_PROVIDER_PROPERTY_NAME:String="globalStyleProvider";

        protected var _registerGlobally:Boolean;

        protected var _styleProviderFactory:Function;

        protected var _classToStyleProvider:flash.utils.Dictionary;
    }
}


