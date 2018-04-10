 
package hk.org.ha.sample.webservice;

import hk.org.ha.sample.Calculator;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;


@Path("")
public class CalculatorRest {
	/**
     * Default constructor. 
     */
    public CalculatorRest() {
        // TODO Auto-generated constructor stub
    }

    
    /**
     * Retrieves representation of an instance of TimeoutRest
     * @return an instance of String
     */
	@GET
	@Produces("text/plain")
	public String resourceMethodGET() { 
		// TODO Auto-generated method stub
		throw new UnsupportedOperationException();
	}
	
	/**
     * Retrieves representation of an instance of TimeoutRest
     * @return an instance of String
     */
	@GET
	@Path("/hello")
	public String hello() { 
		// TODO Auto-generated method stub
		return "{\"result\": \"Hello RESTFUL!\"}";
	}
	
	@GET
	@Path("/add")
	public String add(@QueryParam("x") int x, @QueryParam("y") int y) {
		return "{\"result\": " + Calculator.add(x, y)+"}";
	}

}