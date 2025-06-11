package com.companyx.leavemanagement;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/example")
public class JakartaEE10Resource {

    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getMessage() {
        return "Hello from Jakarta EE 10 REST API!";
    }
}