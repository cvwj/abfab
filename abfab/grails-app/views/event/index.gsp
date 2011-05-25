<%--
  Created by IntelliJ IDEA.
  User: csj
  Date: 24/01/2011
  Time: 7:05 PM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.6.1.min.js"></script>

    <script type="text/javascript">

        // Constructor for event objects
        function event(sourceId, data, ts) {
            this.sourceId = sourceId;
            this.data = data;
            this.ts = ts;

        }

        function eventToString(event) {
            return "sourceId: " + event.sourceId + ", data.message: " + event.data.message + ", ts: " + event.ts;
        }

        var eventManager = new Object();
        eventManager.listeners = [];
        eventManager.registerListener = function(sourceId, onEventCallback, eventsOfInterest) {
            this.listeners.push({sourceId:sourceId, callback: onEventCallback, eventsOfInterest: eventsOfInterest});
        };

        eventManager.raise = function(myevent) {
            // Always relay message to server:
            try {
                console.debug("Raising event for server - event from: " + myevent.sourceId)
                this.serverNotifier({event:myevent})
            } catch (e) {
                console.error("Caught exception when notifying server: " + e)
            }

            // Notify listeners
            $.each(this.listeners,
                    function (intIndex, objValue) {
                        var matchedByFilter = $.inArray(myevent.sourceId, objValue.eventsOfInterest) > -1;
                        var hasNoFilter = objValue.eventsOfInterest == undefined;
                        if (matchedByFilter || hasNoFilter) {
                            try {
                                console.debug("Raising event for " + objValue.sourceId + " - event from: " + myevent.sourceId)
                                objValue.callback(myevent)
                            } catch (e) {
                                console.error("Caught exception when notifying " + objValue.sourceId + ": " + e)
                            }
                        }
                        else {
                            console.log("Skipping " + objValue.sourceId)
                        }
                    }
            )
        }

        eventManager.serverNotifier = function(myevent) {
            console.log ("Sending event to Server: " + myevent)
            $.ajax({
              type: 'POST',
              url: '${g.createLink(controller: "event", action: "onMessage")}',
              data: JSON.stringify(myevent),
              contentType: "text/json",
              dataType: "text"
            });

        }


    </script>

    <title>Simple GSP page</title></head>

<body>

<div id="page1">
    <g:each in="${elements}" var="element">
        <g:include view="elements/${element}.gsp"/>
    </g:each>
</div>

</body>
</html>