//class GVFacebookFriend
package com.milkmangames.nativeextensions 
{
    public class GVFacebookFriend extends Object
    {
        public function GVFacebookFriend(arg1:String, arg2:String, arg3:Object)
        {
            super();
            this.name = arg1;
            this.id = arg2;
            this.properties = arg3;
            return;
        }

        public function toString():String
        {
            return "GVFacebookFriend(name=\'" + this.name + "\',id=\'" + this.id + "\')";
        }

        public function getPropertyString(arg1:String):String
        {
            if (this.properties == null) 
            {
                return null;
            }
            if (this.properties[arg1] != null) 
            {
                if (this.properties[arg1] is String) 
                {
                    return this.properties[arg1];
                }
            }
            return null;
        }

        public function get gender():String
        {
            return this.getPropertyString("gender");
        }

        public function get link():String
        {
            return this.getPropertyString("link");
        }

        public function get installed():Boolean
        {
            if (this.properties == null) 
            {
                return false;
            }
            if (this.properties["installed"]) 
            {
                return true;
            }
            return false;
        }

        public function get locationName():String
        {
            var loc1:*=null;
            if (this.properties == null) 
            {
                return null;
            }
            if (this.properties["location"]) 
            {
                loc1 = this.properties["location"];
                return loc1["name"];
            }
            return null;
        }

        public function get bio():String
        {
            return this.getPropertyString("bio");
        }

        public function get about():String
        {
            return this.getPropertyString("about");
        }

        public function get email():String
        {
            return this.getPropertyString("email");
        }

        public var name:String;

        public var id:String;

        public var properties:Object;
    }
}


