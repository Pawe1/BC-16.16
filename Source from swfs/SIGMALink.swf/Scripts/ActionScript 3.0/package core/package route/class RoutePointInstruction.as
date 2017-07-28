//class RoutePointInstruction
package core.route 
{
    import core.route.interfaces.*;
    import database.*;
    import flash.events.*;
    
    public class RoutePointInstruction extends flash.events.EventDispatcher implements core.route.interfaces.IPointInstruction
    {
        public function RoutePointInstruction(arg1:flash.events.IEventDispatcher=null)
        {
            super(arg1);
            return;
        }

        public function get comment():String
        {
            return _comment;
        }

        public function set comment(arg1:String):void
        {
            if (arg1 != _comment) 
            {
                _comment = arg1;
                dispatchEvent(new flash.events.Event("commentChange"));
            }
            return;
        }

        public function get commentNumber():int
        {
            return _commentNumber;
        }

        public function set commentNumber(arg1:int):void
        {
            if (arg1 != _commentNumber) 
            {
                _commentNumber = arg1;
                dispatchEvent(new flash.events.Event("commentNumberChange"));
            }
            return;
        }

        public function get distance():Number
        {
            return _distance;
        }

        public function set distance(arg1:Number):void
        {
            if (arg1 != _distance) 
            {
                _distance = arg1;
                dispatchEvent(new flash.events.Event("distanceChange"));
            }
            return;
        }

        public function get routePointId():int
        {
            return _routePointId;
        }

        public function set routePointId(arg1:int):void
        {
            _routePointId = arg1;
            return;
        }

        public function get routePointInstructionId():int
        {
            return _routePointInstructionId;
        }

        public function set routePointInstructionId(arg1:int):void
        {
            _routePointInstructionId = arg1;
            return;
        }

        public function setPrimaryKey(arg1:int):void
        {
            if (routePointInstructionId == 0) 
            {
                routePointInstructionId = arg1;
            }
            return;
        }

        public function fromDB(arg1:Object, arg2:Boolean):void
        {
            routePointInstructionId = arg1.routePointInstructionId;
            routePointId = arg1.routePointId;
            comment = arg1.comment;
            commentNumber = arg1.commentNumber;
            distance = arg1.distance;
            return;
        }

        public function generateDBInsert():Array
        {
            var loc3:*="routePointInstructionId, routePointId, comment, commentNumber, distance";
            var loc1:*=routePointInstructionId > 0 ? "\"" + routePointInstructionId + "\"," : "NULL,";
            loc1 = loc1 + ("\"" + routePointId + "\", \"" + comment.toString() + "\", \"" + isNaN(commentNumber) ? 0 : commentNumber + "\", \"" + isNaN(distance) ? 0 : distance + "\"");
            var loc2:*=new database.DCSQLStatement();
            loc2.text = "insert or replace into RoutePointInstruction (" + loc3 + ") values (" + loc1 + ")";
            return [loc2];
        }

        public function generateDBSelect():Array
        {
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "select routePointInstructionId as pk, * from RoutePointInstruction where routePointId = @fk";
            return [loc1];
        }

        public function generateDBDelete():Array
        {
            var loc2:*=[];
            var loc1:*=new database.DCSQLStatement();
            loc1.text = "delete from RoutePointInstruction where RoutePointInstruction.routePointInstructionId = " + routePointInstructionId;
            loc2.push(loc1);
            return loc2;
        }

        public function getLoggingInfo():String
        {
            return "\t-routePointInstructionId " + routePointInstructionId.toString() + "\t-routePointId " + routePointId.toString();
        }

        public override function toString():String
        {
            return "[RoutePointInstruction extends EventDispatcher implements IPointInstruction]";
        }

        public static function generateDBCreateTable():database.DatabaseTable
        {
            var loc1:*=new database.DatabaseTable("RoutePointInstruction");
            loc1.addColumns([["routePointInstructionId", "INTEGER", false, true, true], ["routePointId", "INTEGER", false], ["comment", "TEXT", false], ["commentNumber", "INTEGER", false], ["distance", "NUMERIC", false]]);
            return loc1;
        }

        public static function generateDBCreateIndex():String
        {
            var loc1:*="CREATE INDEX IF NOT EXISTS RoutePointIdOnRoutePointInstruction ON RoutePointInstruction (routePointId)";
            return loc1;
        }

        public static const col_comment:String="comment";

        public static const col_commentNumber:String="commentNumber";

        public static const col_distance:String="distance";

        public static const col_routePointId:String="routePointId";

        public static const col_routePointInstructionId:String="routePointInstructionId";

        public static const table_name:String="RoutePointInstruction";

        protected var _comment:String="";

        protected var _commentNumber:int=0;

        protected var _distance:Number=0;

        protected var _routePointId:int;

        protected var _routePointInstructionId:int;
    }
}


