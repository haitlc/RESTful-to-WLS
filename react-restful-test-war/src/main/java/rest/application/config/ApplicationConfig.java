package rest.application.config;

import java.util.Set;
import javax.ws.rs.core.Application;

public class ApplicationConfig extends Application {

	public Set<Class<?>> getClasses() {
		System.out.println("Rest Application GetClass");
        return getRestClasses();
    }
    
	//Auto-generated from RESTful web service wizard
    private Set<Class<?>> getRestClasses() {
		Set<Class<?>> resources = new java.util.HashSet<Class<?>>();
		
		resources.add(hk.org.ha.sample.webservice.CalculatorRest.class);
		return resources;    
    }
}