//class Memory
package com.hurlant.util 
{
    import flash.net.*;
    import flash.system.*;
    
    public class Memory extends Object
    {
        public function Memory()
        {
            super();
            return;
        }

        public static function gc():void
        {
            var loc1:*;
            try 
            {
                new flash.net.LocalConnection().connect("foo");
                new flash.net.LocalConnection().connect("foo");
            }
            catch (e:*)
            {
            };
            return;
        }

        public static function get used():uint
        {
            return flash.system.System.totalMemory;
        }
    }
}


