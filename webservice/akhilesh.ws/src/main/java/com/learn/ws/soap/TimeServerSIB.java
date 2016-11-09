package com.learn.ws.soap;

import java.util.Date;
import javax.jws.WebService;

@WebService(endpointInterface = "")
public class TimeServerSIB implements TimeServer {
    public String getTimeAsString() {
        return new Date().toString();
    }

    public long getTimeAsElapsed() {
        return new Date().getTime();
    }
}
