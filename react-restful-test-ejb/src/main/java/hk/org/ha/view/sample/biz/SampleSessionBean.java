package hk.org.ha.view.sample.biz;

import hk.org.ha.sample.Calculator;

import javax.ejb.Stateless;

/**
 * Session Bean implementation class SampleSessionBean
 */
@Stateless
public class SampleSessionBean implements SampleSession, SampleSessionLocal {

    /**
     * Default constructor. 
     */
    public SampleSessionBean() {
        // TODO Auto-generated constructor stub
    }
    
    public String sayHello() {
    	return "SampleSessionBean.sayHello() method is called.";
    }

	@Override
	public int add(int x, int y) {
		// TODO Auto-generated method stub
		return Calculator.add(x, y);
	}

}
