package hk.org.ha.view.sample.biz;
import javax.ejb.Local;

@Local
public interface SampleSessionLocal {
	String sayHello();
	int add(int x, int y);
}
