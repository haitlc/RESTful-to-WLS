package hk.org.ha.view.sample.biz;
import javax.ejb.Remote;

@Remote
public interface SampleSession {
	String sayHello();
	int add(int x, int y);
}
