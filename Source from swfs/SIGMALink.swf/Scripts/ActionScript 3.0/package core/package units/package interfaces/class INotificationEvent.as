//class INotificationEvent
package core.units.interfaces 
{
    import core.notification.*;
    
    public dynamic interface INotificationEvent
    {
        function get notificationEvent():core.notification.NotificationEvent;

        function set notificationEvent(arg1:core.notification.NotificationEvent):void;
    }
}


