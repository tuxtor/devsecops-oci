package com.vorozco;

import jakarta.inject.Inject;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.Response;

import io.helidon.microprofile.testing.junit5.HelidonTest;

import org.junit.jupiter.api.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.isEmptyOrNullString;
import static org.hamcrest.Matchers.not;
import static org.junit.jupiter.api.Assertions.assertEquals;

@HelidonTest
class IpResourceTest {

    @Inject
    private WebTarget target;

    @Test
    void testIpReturnsNonEmptyString() {
        Response response = target
                .path("ip")
                .request()
                .get();

        assertEquals(200, response.getStatus());

        String body = response.readEntity(String.class);

        assertThat(body, not(isEmptyOrNullString()));
    }
}

