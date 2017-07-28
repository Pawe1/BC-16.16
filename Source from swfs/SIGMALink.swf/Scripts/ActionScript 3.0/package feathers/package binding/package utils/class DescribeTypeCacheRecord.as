//class DescribeTypeCacheRecord
package feathers.binding.utils 
{
    import flash.utils.*;
    
    use namespace flash_proxy;
    
    public dynamic class DescribeTypeCacheRecord extends flash.utils.Proxy
    {
        public function DescribeTypeCacheRecord()
        {
            this.cache = {};
            super();
            return;
        }

        flash_proxy override function getProperty(arg1:*):*
        {
            var loc1:*=this.cache[arg1];
            if (loc1 === undefined) 
            {
                loc1 = feathers.binding.utils.DescribeTypeCache.extractValue(arg1, this);
                this.cache[arg1] = loc1;
            }
            return loc1;
        }

        flash_proxy override function hasProperty(arg1:*):Boolean
        {
            if (arg1 in this.cache) 
            {
                return true;
            }
            var loc1:*=feathers.binding.utils.DescribeTypeCache.extractValue(arg1, this);
            if (loc1 === undefined) 
            {
                return false;
            }
            this.cache[arg1] = loc1;
            return true;
        }

        internal var cache:Object;

        public var typeDescription:XML;

        public var typeName:String;
    }
}


