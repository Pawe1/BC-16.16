//class Inflater
package nochump.util.zip 
{
    import flash.utils.*;
    
    public class Inflater extends Object
    {
        public function Inflater()
        {
            super();
            return;
        }

        public function setInput(arg1:flash.utils.ByteArray):void
        {
            inbuf = arg1;
            inbuf.endian = "littleEndian";
            return;
        }

        public function inflate(arg1:flash.utils.ByteArray):uint
        {
            var loc2:*=0;
            var loc3:*=0;
            incnt = bitbuf = bitcnt = 0;
            var loc1:*=0;
            loc2 = bits(1);
            if ((loc3 = bits(2)) != 0) 
            {
                if (loc3 == 3) 
                {
                    throw new Error("invalid block type (type == 3)", -1);
                }
                lencode = {"count":[], "symbol":[]};
                distcode = {"count":[], "symbol":[]};
                if (loc3 != 1) 
                {
                    if (loc3 == 2) 
                    {
                        loc1 = constructDynamicTables();
                    }
                }
                else 
                {
                    constructFixedTables();
                }
                if (loc1 != 0) 
                {
                    return loc1;
                }
                loc1 = codes(arg1);
            }
            else 
            {
                stored(arg1);
            }
        }

        internal function bits(arg1:int):int
        {
            var loc1:*=bitbuf;
            while (bitcnt < arg1) 
            {
                if (incnt == inbuf.length) 
                {
                    throw new Error("available inflate data did not terminate", 2);
                }
                incnt = (incnt + 1);
                loc1 = loc1 | inbuf[incnt] << bitcnt;
                bitcnt = bitcnt + 8;
            }
            bitbuf = loc1 >> arg1;
            bitcnt = bitcnt - arg1;
            return loc1 & (1 << arg1 - 1);
        }

        internal function construct(arg1:Object, arg2:Array, arg3:int):int
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=[];
            loc3 = 0;
            while (loc3 <= 15) 
            {
                arg1.count[loc3] = 0;
                ++loc3;
            }
            loc2 = 0;
            while (loc2 < arg3) 
            {
                var loc5:*;
                var loc6:*;
                var loc7:*=((loc5 = arg1.count)[loc6 = arg2[loc2]] + 1);
                loc5[loc6] = loc7;
                ++loc2;
            }
            if (arg1.count[0] == arg3) 
            {
                return 0;
            }
            var loc4:*=1;
            loc3 = 1;
            while (loc3 <= 15) 
            {
                if ((loc4 = (loc4 = loc4 << 1) - arg1.count[loc3]) < 0) 
                {
                    return loc4;
                }
                ++loc3;
            }
            loc1[1] = 0;
            loc3 = 1;
            while (loc3 < 15) 
            {
                loc1[loc3 + 1] = loc1[loc3] + arg1.count[loc3];
                ++loc3;
            }
            loc2 = 0;
            while (loc2 < arg3) 
            {
                if (arg2[loc2] != 0) 
                {
                    loc7 = ((loc5 = loc1)[loc6 = arg2[loc2]] + 1);
                    loc5[loc6] = loc7;
                    arg1.symbol[(loc5 = loc1)[loc6 = arg2[loc2]]] = loc2;
                }
                ++loc2;
            }
            return loc4;
        }

        internal function decode(arg1:Object):int
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc1:*=0;
            var loc5:*=0;
            var loc4:*=0;
            loc2 = 1;
            while (loc2 <= 15) 
            {
                loc1 = loc1 | bits(1);
                loc3 = arg1.count[loc2];
                if (loc1 < loc5 + loc3) 
                {
                    return arg1.symbol[loc4 + (loc1 - loc5)];
                }
                loc4 = loc4 + loc3;
                loc5 = (loc5 = loc5 + loc3) << 1;
                loc1 = loc1 << 1;
                ++loc2;
            }
            return -9;
        }

        internal function codes(arg1:flash.utils.ByteArray):int
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            loc1 = decode(lencode);
            if (loc1 < 0) 
            {
                return loc1;
            }
            if (loc1 < 256) 
            {
                arg1[arg1.length] = loc1;
            }
            else if (loc1 > 256) 
            {
                loc1 = loc1 - 257;
                if (loc1 >= 29) 
                {
                    throw new Error("invalid literal/length or distance code in fixed or dynamic block", -9);
                }
                loc2 = LENS[loc1] + bits(LEXT[loc1]);
                loc1 = decode(distcode);
                if (loc1 < 0) 
                {
                    return loc1;
                }
                if ((loc3 = DISTS[loc1] + bits(DEXT[loc1])) > arg1.length) 
                {
                    throw new Error("distance is too far back in fixed or dynamic block", -10);
                }
                for (;;) 
                {
                    --loc2;
                    if (!loc2) 
                    {
                        break;
                    }
                    arg1[arg1.length] = arg1[arg1.length - loc3];
                }
            }
        }

        internal function stored(arg1:flash.utils.ByteArray):void
        {
            bitbuf = 0;
            bitcnt = 0;
            if (incnt + 4 > inbuf.length) 
            {
                throw new Error("available inflate data did not terminate", 2);
            }
            incnt = (incnt + 1);
            var loc1:*=inbuf[incnt];
            incnt = (incnt + 1);
            loc1 = loc1 | inbuf[incnt] << 8;
            incnt = (incnt + 1);
            if (!!(inbuf[incnt] == (~loc1 & 255))) 
            {
                !(inbuf[incnt] == (~loc1 & 255));
                incnt = (incnt + 1);
            }
            if (!(inbuf[incnt] == (~loc1 & 255))) 
            {
                throw new Error("stored block length did not match one\'s complement", -2);
            }
            if (incnt + loc1 > inbuf.length) 
            {
                throw new Error("available inflate data did not terminate", 2);
            }
            while (loc1--) 
            {
                incnt = (incnt + 1);
                arg1[arg1.length] = inbuf[incnt];
            }
            return;
        }

        internal function constructFixedTables():void
        {
            var loc1:*=0;
            var loc2:*=[];
            loc1 = 0;
            while (loc1 < 144) 
            {
                loc2[loc1] = 8;
                ++loc1;
            }
            while (loc1 < 256) 
            {
                loc2[loc1] = 9;
                ++loc1;
            }
            while (loc1 < 280) 
            {
                loc2[loc1] = 7;
                ++loc1;
            }
            while (loc1 < 288) 
            {
                loc2[loc1] = 8;
                ++loc1;
            }
            construct(lencode, loc2, 288);
            loc1 = 0;
            while (loc1 < 30) 
            {
                loc2[loc1] = 5;
                ++loc1;
            }
            construct(distcode, loc2, 30);
            return;
        }

        internal function constructDynamicTables():int
        {
            var loc8:*=0;
            var loc1:*=0;
            var loc5:*=0;
            var loc2:*=[];
            var loc9:*=[16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];
            var loc3:*=bits(5) + 257;
            var loc7:*=bits(5) + 1;
            var loc6:*=bits(4) + 4;
            if (loc3 > 286 || loc7 > 30) 
            {
                throw new Error("dynamic block code description: too many length or distance codes", -3);
            }
            loc8 = 0;
            while (loc8 < loc6) 
            {
                loc2[loc9[loc8]] = bits(3);
                ++loc8;
            }
            while (loc8 < 19) 
            {
                loc2[loc9[loc8]] = 0;
                ++loc8;
            }
            var loc4:*;
            if ((loc4 = construct(lencode, loc2, 19)) != 0) 
            {
                throw new Error("dynamic block code description: code lengths codes incomplete", -4);
            }
            loc8 = 0;
            while (loc8 < loc3 + loc7) 
            {
                loc1 = decode(lencode);
                if (loc1 < 16) 
                {
                    ++loc8;
                    loc2[loc8] = loc1;
                    continue;
                }
                loc5 = 0;
                if (loc1 != 16) 
                {
                    if (loc1 != 17) 
                    {
                        loc1 = 11 + bits(7);
                    }
                    else 
                    {
                        loc1 = 3 + bits(3);
                    }
                }
                else 
                {
                    if (loc8 == 0) 
                    {
                        throw new Error("dynamic block code description: repeat lengths with no first length", -5);
                    }
                    loc5 = loc2[(loc8 - 1)];
                    loc1 = 3 + bits(2);
                }
                if (loc8 + loc1 > loc3 + loc7) 
                {
                    throw new Error("dynamic block code description: repeat more than specified lengths", -6);
                }
                for (;;) 
                {
                    --loc1;
                    if (!loc1) 
                    {
                        break;
                    }
                    ++loc8;
                    loc2[loc8] = loc5;
                }
            }
            if ((loc4 = construct(lencode, loc2, loc3)) < 0 || loc4 > 0 && !(loc3 - lencode.count[0] == 1)) 
            {
                throw new Error("dynamic block code description: invalid literal/length code lengths", -7);
            }
            if ((loc4 = construct(distcode, loc2.slice(loc3), loc7)) < 0 || loc4 > 0 && !(loc7 - distcode.count[0] == 1)) 
            {
                throw new Error("dynamic block code description: invalid distance code lengths", -8);
            }
            return loc4;
        }

        internal static const MAXBITS:int=15;

        internal static const MAXLCODES:int=286;

        internal static const MAXDCODES:int=30;

        internal static const MAXCODES:int=316;

        internal static const FIXLCODES:int=288;

        internal static const LENS:Array=[3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258];

        internal static const LEXT:Array=[0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0];

        internal static const DISTS:Array=[1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];

        internal static const DEXT:Array=[0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13];

        internal var inbuf:flash.utils.ByteArray;

        internal var incnt:uint;

        internal var bitbuf:int;

        internal var bitcnt:int;

        internal var lencode:Object;

        internal var distcode:Object;
    }
}


