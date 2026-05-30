
package com.vorozco;

import org.eclipse.microprofile.metrics.annotation.Counted;
import org.eclipse.microprofile.metrics.annotation.Timed;
import jakarta.ws.rs.PathParam;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import org.eclipse.microprofile.config.inject.ConfigProperty;

/**
 * A simple JAX-RS resource to greet you. Examples:
 *
 * Get default greeting message:
 * curl -X GET http://localhost:8080/simple-greet
 *
 * The message is returned as a JSON object.
 */
@Path("/hello")
public class SimpleGreetResource {

    private static final String PERSONALIZED_GETS_COUNTER_NAME = "personalizedGets";
    private static final String PERSONALIZED_GETS_COUNTER_DESCRIPTION = "Counts personalized GET operations";
    private static final String GETS_TIMER_NAME = "allGets";
    private static final String GETS_TIMER_DESCRIPTION = "Tracks all GET operations";
    private final String message;
    private final String platform;

    @Inject
    public SimpleGreetResource(@ConfigProperty(name = "app.greeting") String message, @ConfigProperty(name = "app.platform") String platform) {
        this.message = message;
        this.platform = platform;
    }

    /**
     * Return a worldly greeting message.
     *
     * @return {@link Message}
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Message getDefaultMessage() {
        // var phrase = this.doSpotBugsDemo();
        String msg = String.format("%s %s running within %s!", message, "World", platform);
        Message message = new Message();
        message.setMessage(msg);
        return message;
    }


    @Path("/{name}")
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Counted(name = PERSONALIZED_GETS_COUNTER_NAME, description = PERSONALIZED_GETS_COUNTER_DESCRIPTION, absolute = true)
    @Timed(name = GETS_TIMER_NAME, description = GETS_TIMER_DESCRIPTION, absolute = true)
    public Message getMessage(@PathParam("name") String name) {
        String message = String.format("Hello %s", name);
        return new Message(message);
    }

    private String doSpotBugsDemo() {
        // var deadVar = "This is a dead variable";
        return "SpotBugs demo";
    }

}
