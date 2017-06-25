package championship;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.firefox.FirefoxDriver;

public class Test {

	@org.junit.Test
	public void createNewUserTest(){
		
		WebDriver driver = new FirefoxDriver();
		driver.get("http://localhost:8080/championship/");
		
		WebElement users = driver.findElement(By.linkText("Users"));
		users.click();
		
		driver.findElement(By.partialLinkText("Hello,")).click();
		driver.findElement(By.partialLinkText("Register")).click();
		driver.findElement(By.linkText("Register")).click();
		
	}
	
}
