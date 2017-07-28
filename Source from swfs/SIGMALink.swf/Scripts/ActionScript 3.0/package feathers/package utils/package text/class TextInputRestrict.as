//class TextInputRestrict
package feathers.utils.text 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public class TextInputRestrict extends Object
    {
        public function TextInputRestrict(arg1:String=null)
        {
            super();
            this.restrict = arg1;
            return;
        }

        public function get restrict():String
        {
            return this._restrict;
        }

        public function set restrict(arg1:String):void
        {
            var loc1:*=0;
            var loc2:*=false;
            var loc3:*=0;
            var loc4:*=null;
            if (this._restrict === arg1) 
            {
                return;
            }
            this._restrict = arg1;
            if (arg1) 
            {
                if (this._restricts) 
                {
                    this._restricts.length = 0;
                }
                else 
                {
                    this._restricts = new Vector.<RegExp>(0);
                }
                if (this._restrict !== "") 
                {
                    if (this._restrict) 
                    {
                        loc1 = 0;
                        loc2 = arg1.indexOf("^") == 0;
                        this._restrictStartsWithExclude = loc2;
                        do 
                        {
                            loc3 = arg1.indexOf("^", loc1 + 1);
                            if (loc3 >= 0) 
                            {
                                loc4 = arg1.substr(loc1, loc3 - loc1);
                                this._restricts.push(this.createRestrictRegExp(loc4, loc2));
                            }
                            else 
                            {
                                loc4 = arg1.substr(loc1);
                                this._restricts.push(this.createRestrictRegExp(loc4, loc2));
                            }
                            loc1 = loc3;
                            loc2 = !loc2;
                        }
                        while (true);
                    }
                }
                else 
                {
                    this._restricts.push(new RegExp("^$"));
                }
            }
            else 
            {
                this._restricts = null;
            }
            return;
        }

        public function isCharacterAllowed(arg1:int):Boolean
        {
            var loc6:*=null;
            if (!this._restricts) 
            {
                return true;
            }
            var loc1:*=String.fromCharCode(arg1);
            var loc2:*=this._restrictStartsWithExclude;
            var loc3:*=loc2;
            var loc4:*=this._restricts.length;
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc6 = this._restricts[loc5];
                if (loc2) 
                {
                    loc3 = loc3 && loc6.test(loc1);
                }
                else 
                {
                    loc3 = loc3 || loc6.test(loc1);
                }
                loc2 = !loc2;
                ++loc5;
            }
            return loc3;
        }

        public function filterText(arg1:String):String
        {
            var loc4:*=null;
            var loc5:*=false;
            var loc6:*=false;
            var loc7:*=0;
            var loc8:*=null;
            if (!this._restricts) 
            {
                return arg1;
            }
            var loc1:*=arg1.length;
            var loc2:*=this._restricts.length;
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                loc4 = arg1.charAt(loc3);
                loc5 = this._restrictStartsWithExclude;
                loc6 = loc5;
                loc7 = 0;
                while (loc7 < loc2) 
                {
                    loc8 = this._restricts[loc7];
                    if (loc5) 
                    {
                        loc6 = loc6 && loc8.test(loc4);
                    }
                    else 
                    {
                        loc6 = loc6 || loc8.test(loc4);
                    }
                    loc5 = !loc5;
                    ++loc7;
                }
                if (!loc6) 
                {
                    arg1 = arg1.substr(0, loc3) + arg1.substr(loc3 + 1);
                    --loc3;
                    --loc1;
                }
                ++loc3;
            }
            return arg1;
        }

        protected function createRestrictRegExp(arg1:String, arg2:Boolean):RegExp
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (!arg2 && arg1.indexOf("^") == 0) 
            {
                arg1 = arg1.substr(1);
            }
            arg1 = arg1.replace(new RegExp("\\\\", "g"), "\\\\");
            var loc4:*=0;
            var loc5:*=REQUIRES_ESCAPE;
            for (loc1 in loc5) 
            {
                loc2 = loc1 as RegExp;
                loc3 = REQUIRES_ESCAPE[loc2] as String;
                arg1 = arg1.replace(loc2, loc3);
            }
            return new RegExp("[" + arg1 + "]");
        }

        
        {
            REQUIRES_ESCAPE[new RegExp("\\[", "g")] = "\\[";
            REQUIRES_ESCAPE[new RegExp("\\]", "g")] = "\\]";
            REQUIRES_ESCAPE[new RegExp("\\{", "g")] = "\\{";
            REQUIRES_ESCAPE[new RegExp("\\}", "g")] = "\\}";
            REQUIRES_ESCAPE[new RegExp("\\(", "g")] = "\\(";
            REQUIRES_ESCAPE[new RegExp("\\)", "g")] = "\\)";
            REQUIRES_ESCAPE[new RegExp("\\|", "g")] = "\\|";
            REQUIRES_ESCAPE[new RegExp("\\/", "g")] = "\\/";
            REQUIRES_ESCAPE[new RegExp("\\.", "g")] = "\\.";
            REQUIRES_ESCAPE[new RegExp("\\+", "g")] = "\\+";
            REQUIRES_ESCAPE[new RegExp("\\*", "g")] = "\\*";
            REQUIRES_ESCAPE[new RegExp("\\?", "g")] = "\\?";
            REQUIRES_ESCAPE[new RegExp("\\$", "g")] = "\\$";
        }

        protected static const REQUIRES_ESCAPE:flash.utils.Dictionary=new flash.utils.Dictionary();

        protected var _restrictStartsWithExclude:Boolean=false;

        protected var _restricts:__AS3__.vec.Vector.<RegExp>;

        internal var _restrict:String;
    }
}


