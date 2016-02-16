package com.practice.dropwizard;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.dropwizard.Configuration;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * Created by developer on 2/16/16.
 */
public class HelloWorldConfiguration extends Configuration {

    @NotEmpty
    @JsonProperty
    private String template;

    @NotEmpty
    @JsonProperty
    private String defaultName = "Guest";

    public String getTemplate() {
        return this.template;
    }

    public String getDefaultName() {
        return  this.defaultName;
    }

    public void setTemplate(final String template) {
        this.template = template;
    }

    public void setDefaultName(final String defaultName) {
        this.defaultName = defaultName;
    }
 }
