package com.vorozco;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/")
public class GreetingResource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String hello() {
        String deadText = doSpotBugsDemo();
        return "Hello from Quarkus REST";
    }

    private String doSpotBugsDemo(){
        String deadText = "This is a dead text as well";
        return "SpotBugs demo";
    }
}
