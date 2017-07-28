//class StravaApiBase
package core.strava 
{
    public class StravaApiBase extends Object
    {
        public function StravaApiBase()
        {
            super();
            return;
        }

        public function fromObject(arg1:Object, arg2:Array=null):core.strava.StravaApiBase
        {
            var loc1:*=null;
            var loc3:*=0;
            if (arg1 != null) 
            {
                if (arg2 == null) 
                {
                    var loc6:*=0;
                    var loc5:*=arg1;
                    for (var loc4:* in loc5) 
                    {
                        setVarFromObject(this, arg1, loc4);
                    }
                }
                else 
                {
                    loc3 = 0;
                    var loc2:*=arg2.length;
                    while (loc3 < loc2) 
                    {
                        loc1 = arg2[loc3] as String;
                        setVarFromObject(this, arg1, loc1);
                        ++loc3;
                    }
                }
            }
            return this;
        }

        protected function setVarFromObject(arg1:Object, arg2:Object, arg3:String):void
        {
            var loc1:*=null;
            if (arg1.hasOwnProperty(arg3) && arg2.hasOwnProperty(arg3)) 
            {
                arg1[arg3] = arg2[arg3];
            }
            return;
        }
    }
}


