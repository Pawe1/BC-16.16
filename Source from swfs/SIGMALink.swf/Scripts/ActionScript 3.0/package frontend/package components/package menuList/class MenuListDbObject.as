//class MenuListDbObject
package frontend.components.menuList 
{
    public class MenuListDbObject extends Object
    {
        public function MenuListDbObject()
        {
            super();
            return;
        }

        public function getSqlUpdateStatement():String
        {
            if (!(this.table && this.keyField && this.keyValue && this.updateField && !(this.updateValue == null))) 
            {
                return ERROR_STATEMENT_MISSING_PARAMETERS;
            }
            var loc1:*="UPDATE " + this.table + " SET " + this.updateField + " = :updateValue";
            if (this.updateField2 != "") 
            {
                loc1 = loc1 + (", " + this.updateField2 + " = :updateValue2");
            }
            if (this.updateModificationDate) 
            {
                loc1 = loc1 + (", modificationDate = \'" + new Date().time + "\'");
            }
            loc1 = loc1 + (" WHERE " + this.keyField + " = :keyValue");
            return loc1;
        }

        public function getParams():Object
        {
            var loc1:*=new Object();
            if (this.dateAsString) 
            {
                loc1[":updateValue"] = (this.updateValue as Date).toString();
            }
            else 
            {
                loc1[":updateValue"] = this.updateValue;
            }
            if (this.updateField2 != "") 
            {
                loc1[":updateValue2"] = this.updateValue2;
            }
            loc1[":keyValue"] = this.keyValue;
            return loc1;
        }

        
        {
            ERROR_STATEMENT_MISSING_PARAMETERS = "ERROR_STATEMENT_MISSING_PARAMETERS";
        }

        public var classAttributeName:String="";

        public var completeCallback:Function;

        public var dateAsString:Boolean=false;

        public var errorCallback:Function;

        public var keyField:String;

        public var keyValue:String;

        public var table:String;

        public var updateField:String;

        public var updateField2:String="";

        public var updateModificationDate:Boolean=true;

        public var updateValue:Object;

        public var updateValue2:Object;

        public static var ERROR_STATEMENT_MISSING_PARAMETERS:String="ERROR_STATEMENT_MISSING_PARAMETERS";
    }
}


