//function execute
package starling.utils 
{
    public function execute(arg1:Function, ... rest):void
    {
        var loc1:*=0;
        var loc2:*=0;
        if (arg1 != null) 
        {
            loc2 = arg1.length;
            loc1 = rest.length;
            while (loc1 < loc2) 
            {
                rest[loc1] = null;
                ++loc1;
            }
            var loc3:*=loc2;
            switch (loc3) 
            {
                case 0:
                {
                    arg1();
                    break;
                }
                case 1:
                {
                    arg1(rest[0]);
                    break;
                }
                case 2:
                {
                    arg1(rest[0], rest[1]);
                    break;
                }
                case 3:
                {
                    arg1(rest[0], rest[1], rest[2]);
                    break;
                }
                case 4:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3]);
                    break;
                }
                case 5:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4]);
                    break;
                }
                case 6:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5]);
                    break;
                }
                case 7:
                {
                    arg1(rest[0], rest[1], rest[2], rest[3], rest[4], rest[5], rest[6]);
                    break;
                }
                default:
                {
                    arg1.apply(null, rest.slice(0, loc2));
                    break;
                }
            }
        }
        return;
    }
}


