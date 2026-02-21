package com.vorozco;

import jakarta.inject.Inject;
import jakarta.ws.rs.client.WebTarget;
import jakarta.ws.rs.core.GenericType;
import jakarta.ws.rs.core.Response;
import java.util.List;

import io.helidon.microprofile.testing.junit5.HelidonTest;

import org.junit.jupiter.api.Test;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.contains;
import static org.hamcrest.Matchers.is;
import static org.junit.jupiter.api.Assertions.assertEquals;

@HelidonTest
class FibonacciResourceTest {

    @Inject
    private WebTarget target;

    @Test
    void testFibonacciWithExplicitParam() {
        Response response = target
                .path("fibonacci")
                .queryParam("fibo", 7)
                .request()
                .get();

        assertEquals(200, response.getStatus());

        List<Long> sequence = response.readEntity(new GenericType<List<Long>>() {});

        assertThat(sequence.size(), is(7));
        assertThat(sequence, contains(0L, 1L, 1L, 2L, 3L, 5L, 8L));
    }

    @Test
    void testFibonacciDefaultWhenParamMissing() {
        Response response = target
                .path("fibonacci")
                .request()
                .get();

        assertEquals(200, response.getStatus());

        List<Long> sequence = response.readEntity(new GenericType<List<Long>>() {});

        assertThat(sequence.size(), is(5));
        assertThat(sequence, contains(0L, 1L, 1L, 2L, 3L));
    }

    @Test
    void testFibonacciDefaultsWhenParamNonPositive() {
        // Test with fibo=0
        Response responseZero = target
                .path("fibonacci")
                .queryParam("fibo", 0)
                .request()
                .get();

        assertEquals(200, responseZero.getStatus());

        List<Long> sequenceZero = responseZero.readEntity(new GenericType<List<Long>>() {});

        assertThat(sequenceZero.size(), is(5));
        assertThat(sequenceZero, contains(0L, 1L, 1L, 2L, 3L));

        // Test with fibo=-3
        Response responseNegative = target
                .path("fibonacci")
                .queryParam("fibo", -3)
                .request()
                .get();

        assertEquals(200, responseNegative.getStatus());

        List<Long> sequenceNegative = responseNegative.readEntity(new GenericType<List<Long>>() {});

        assertThat(sequenceNegative.size(), is(5));
        assertThat(sequenceNegative, contains(0L, 1L, 1L, 2L, 3L));
    }

    @Test
    void testFibonacciSmallValues() {
        // fibo=1 -> [0]
        Response responseOne = target
                .path("fibonacci")
                .queryParam("fibo", 1)
                .request()
                .get();

        assertEquals(200, responseOne.getStatus());

        List<Long> sequenceOne = responseOne.readEntity(new GenericType<List<Long>>() {});

        assertThat(sequenceOne.size(), is(1));
        assertThat(sequenceOne, contains(0L));

        // fibo=2 -> [0, 1]
        Response responseTwo = target
                .path("fibonacci")
                .queryParam("fibo", 2)
                .request()
                .get();

        assertEquals(200, responseTwo.getStatus());

        List<Long> sequenceTwo = responseTwo.readEntity(new GenericType<List<Long>>() {});

        assertThat(sequenceTwo.size(), is(2));
        assertThat(sequenceTwo, contains(0L, 1L));
    }
}

