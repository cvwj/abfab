package dk.cooldev.abfab.controller

class EventController {

    def index = {
        [elements: ["Element1", "Element2"]]
    }

    // Receive messages from the client
    def onMessage = {
        println "Got message: $params"
        def event = request.JSON.event
        println "Event: ${event}"
        println "SourceId: ${event.sourceId}"
        println "Data: ${event.data}"
        println "TS: ${event.ts}"
        render text: "ok"
    }
}
