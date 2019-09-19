package it.unitn.web.centodiciotto.services;

import javax.ws.rs.core.Application;
import java.util.Set;


@javax.ws.rs.ApplicationPath("restricted/services")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    private void addRestResourceClasses(Set<Class<?>> resources) {
        //  resources.add(com.alibaba.fastjson.support.jaxrs.FastJsonProvider.class);
        //resources.add(it.unitn.web.centodiciotto.services.UsersService.class);
        //resources.add(org.glassfish.jersey.server.wadl.internal.WadlResource.class);
    }

}
