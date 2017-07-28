//class DatabaseUpdate
package backend.database 
{
    import database.update.*;
    import debug.*;
    import flash.events.*;
    import handler.*;
    
    public class DatabaseUpdate extends database.update.CommonDatabaseUpdate
    {
        public function DatabaseUpdate()
        {
            super();
            return;
        }

        protected override function startUpdate():void
        {
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateOkay);
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateError);
            backend.database.DatabaseDefinition.getInstance().addEventListener(database.update.CommonDatabaseUpdate.PROGRESS, onUpdateProgress);
            backend.database.DatabaseDefinition.getInstance().createDatabaseUpdate(newDatabase.file, oldDatabase, newDatabase);
            return;
        }

        internal function onUpdateOkay(arg1:flash.events.Event):void
        {
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateOkay);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateError);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.PROGRESS, onUpdateProgress);
            dispatchEvent(new flash.events.Event(database.update.CommonDatabaseUpdate.DATABASE_OKAY));
            return;
        }

        internal function onUpdateError(arg1:flash.events.Event):void
        {
            debug.Debug.error("DatabaseUpdate > onUpdateError............");
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_OKAY, this.onUpdateOkay);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.DATABASE_ERROR, this.onUpdateError);
            backend.database.DatabaseDefinition.getInstance().removeEventListener(database.update.CommonDatabaseUpdate.PROGRESS, onUpdateProgress);
            backend.database.DatabaseDefinition.getInstance().stopUpdate();
            backend.database.DatabaseDefinition.getInstance().currentDatabase.deleteDatabase();
            handler.AppDBHandler.getInstance().validateDatabase();
            dispatchEvent(new flash.events.Event(database.update.CommonDatabaseUpdate.DATABASE_ERROR));
            return;
        }

        public static function getInstance():backend.database.DatabaseUpdate
        {
            if (!_instance) 
            {
                _instance = new DatabaseUpdate();
                database.update.CommonDatabaseUpdate.setInstance(_instance);
            }
            return _instance;
        }

        internal static var _instance:backend.database.DatabaseUpdate;
    }
}


