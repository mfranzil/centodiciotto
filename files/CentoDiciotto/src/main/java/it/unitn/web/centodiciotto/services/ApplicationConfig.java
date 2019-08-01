
package it.unitn.web.centodiciotto.services;

import javax.ws.rs.core.Application;
import java.util.Set;

/**
 * @author Stefano Chirico &lt;stefano dot chirico at unitn dot it&gt;
 * @since 2019.05.19
 */
@javax.ws.rs.ApplicationPath("restricted/services")
public class ApplicationConfig extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> resources = new java.util.HashSet<>();
        addRestResourceClasses(resources);
        return resources;
    }

    /**
     * Do not modify addRestResourceClasses() method.
     * It is automatically populated with
     * all resources defined in the project.
     * If required, comment out calling this method in getClasses().
     */
    private void addRestResourceClasses(Set<Class<?>> resources) {
        resources.add(com.alibaba.fastjson.support.jaxrs.FastJsonProvider.class);
        resources.add(it.unitn.web.centodiciotto.services.UsersService.class);
        resources.add(org.glassfish.jersey.server.wadl.internal.WadlResource.class);
    }

}
