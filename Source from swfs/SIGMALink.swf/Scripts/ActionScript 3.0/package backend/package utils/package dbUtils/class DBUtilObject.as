//class DBUtilObject
package backend.utils.dbUtils 
{
    import database.*;
    import flash.utils.*;
    
    public class DBUtilObject extends Object
    {
        public function DBUtilObject(arg1:Object=null, arg2:Function=null, arg3:Function=null, arg4:flash.utils.ByteArray=null, arg5:Object=null)
        {
            super();
            this.data = arg1;
            this.completeCallback = arg2;
            this.errorCallback = arg3;
            this.workerTarget = arg4;
            this.parameters = arg5;
            return;
        }

        public static function fromObject(arg1:Object):backend.utils.dbUtils.DBUtilObject
        {
            var loc2:*=undefined;
            var loc1:*=new DBUtilObject();
            var loc3:*=0;
            var loc4:*=arg1;
            for (loc2 in loc4) 
            {
                if (loc2 == "preparedStmt") 
                {
                    loc1[loc2] = arg1[loc2] as database.DCSQLStatement;
                    continue;
                }
                loc1[loc2] = arg1[loc2];
            }
            return loc1;
        }

        public var completeCallback:Function;

        public var data:Object;

        public var errorCallback:Function;

        public var guid:String;

        public var lastInsertRowId:int;

        public var parameters:Object;

        public var preparedStmt:database.DCSQLStatement;

        public var result:Object;

        public var sqlMode:String;

        public var stmt:String;

        public var stmts:Array;

        public var workerTarget:flash.utils.ByteArray;
    }
}


