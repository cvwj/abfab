<div id="e2">
    <button id="e2_button" name="Event2">Event 2</button>
</div>

<script type="text/javascript">
    function eventCallbackE2(event)
    {
        console.log("E2 Got event from: " + eventToString(event))
    }

    eventManager.registerListener("e2", eventCallbackE2);

    $("#e2_button").bind('click',  raise);

    function raise()
    {
        console.log("e2 is raising")
        eventManager.raise({sourceId: "e2", data: {message: "button clicked"}, ts: new Date()})
    }
</script>