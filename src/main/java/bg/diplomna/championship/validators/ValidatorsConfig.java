package bg.diplomna.championship.validators;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
@ComponentScan(basePackageClasses = UserValidator.class)
public class ValidatorsConfig {

}
