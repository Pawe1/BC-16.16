//class IDatabase
package core.general.interfaces 
{
    public dynamic interface IDatabase
    {
        function generateDBInsert():Array;

        function generateDBSelect():Array;

        function generateDBDelete():Array;
    }
}


