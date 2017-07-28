//class VertexDataAttribute
package starling.rendering 
{
    internal class VertexDataAttribute extends Object
    {
        public function VertexDataAttribute(arg1:String, arg2:String, arg3:int)
        {
            super();
            if (!(arg2 in FORMAT_SIZES)) 
            {
                throw new ArgumentError("Invalid attribute format: " + arg2 + ". " + "Use one of the following: \'float1\'-\'float4\', \'bytes4\'");
            }
            this.name = arg1;
            this.format = arg2;
            this.offset = arg3;
            this.size = FORMAT_SIZES[arg2];
            this.isColor = !(arg1.indexOf("color") == -1) || !(arg1.indexOf("Color") == -1);
            return;
        }

        internal static const FORMAT_SIZES:Object={"bytes4":4, "float1":4, "float2":8, "float3":12, "float4":16};

        public var name:String;

        public var format:String;

        public var isColor:Boolean;

        public var offset:int;

        public var size:int;
    }
}


