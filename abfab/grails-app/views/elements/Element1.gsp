<div id="e1">
    <button id="e1_button" name="Event1">Event 1</button>
</div>

<script type="text/javascript">
    function eventCallbackE1(event)
    {
        console.log("E1 Got event from: " + eventToString(event))
    }

    eventManager.registerListener("e1", eventCallbackE1, ["e2"]);

    $("#e1_button").click(raise);

    function raise()
    {
        console.log("e1 is raising")
        eventManager.raise(({"sourceId": "e1", "data": {"message": "button clicked", "message2": "Hey"}, "ts": new Date()}))
    }
</script>