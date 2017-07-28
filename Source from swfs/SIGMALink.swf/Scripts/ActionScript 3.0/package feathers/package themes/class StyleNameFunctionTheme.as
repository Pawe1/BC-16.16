//class StyleNameFunctionTheme
package feathers.themes 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.skins.*;
    import starling.core.*;
    import starling.events.*;
    
    public class StyleNameFunctionTheme extends starling.events.EventDispatcher
    {
        public function StyleNameFunctionTheme()
        {
            super();
            if (this.starling === null) 
            {
                this.starling = starling.core.Starling.current;
            }
            this.createRegistry();
            this._conditionalRegistry = new feathers.skins.StyleProviderRegistry(true, this.createConditionalStyleProvider);
            return;
        }

        public function dispose():void
        {
            if (this._registry !== null) 
            {
                this._registry.dispose();
                this._registry = null;
            }
            if (this._conditionalRegistry !== null) 
            {
                this.disposeConditionalRegistry();
            }
            return;
        }

        public function getStyleProviderForClass(arg1:Class):feathers.skins.StyleNameFunctionStyleProvider
        {
            var loc3:*=null;
            var loc1:*=feathers.skins.IStyleProvider(arg1[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME]);
            var loc2:*=feathers.skins.ConditionalStyleProvider(this._conditionalRegistry.getStyleProvider(arg1));
            if (loc2.trueStyleProvider === null) 
            {
                loc3 = feathers.skins.StyleNameFunctionStyleProvider(this._registry.getStyleProvider(arg1));
                loc2.trueStyleProvider = loc3;
                loc2.falseStyleProvider = loc1;
            }
            return feathers.skins.StyleNameFunctionStyleProvider(loc2.trueStyleProvider);
        }

        protected function createRegistry():void
        {
            this._registry = new feathers.skins.StyleProviderRegistry(false);
            return;
        }

        protected function starlingConditional(arg1:feathers.core.IFeathersControl):Boolean
        {
            var loc1:*=arg1.stage === null ? starling.core.Starling.current : arg1.stage.starling;
            return loc1 === this.starling;
        }

        protected function createConditionalStyleProvider():feathers.skins.ConditionalStyleProvider
        {
            return new feathers.skins.ConditionalStyleProvider(this.starlingConditional);
        }

        protected function disposeConditionalRegistry():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=this._conditionalRegistry.getRegisteredClasses();
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                loc5 = feathers.skins.IStyleProvider(loc4[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME]);
                loc6 = feathers.skins.ConditionalStyleProvider(this._conditionalRegistry.clearStyleProvider(loc4));
                loc7 = loc5 as feathers.skins.ConditionalStyleProvider;
                loc8 = null;
                do 
                {
                    if (loc7 === null) 
                    {
                        loc6.conditionalFunction = null;
                        loc6.trueStyleProvider = null;
                        break;
                    }
                    loc9 = loc7.falseStyleProvider;
                    if (loc7 === loc6) 
                    {
                        if (loc8 === null) 
                        {
                            loc4[GLOBAL_STYLE_PROVIDER_PROPERTY_NAME] = loc9;
                        }
                        else 
                        {
                            loc8.falseStyleProvider = loc9;
                        }
                        break;
                    }
                    loc8 = loc7;
                    loc7 = loc9 as feathers.skins.ConditionalStyleProvider;
                }
                while (true);
                ++loc3;
            }
            this._conditionalRegistry = null;
            return;
        }

        protected static const GLOBAL_STYLE_PROVIDER_PROPERTY_NAME:String="globalStyleProvider";

        protected var starling:starling.core.Starling;

        protected var _registry:feathers.skins.StyleProviderRegistry;

        protected var _conditionalRegistry:feathers.skins.StyleProviderRegistry;
    }
}


