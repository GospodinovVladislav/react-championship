package bg.diplomna.championship;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.context.annotation.ImportResource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;

import bg.diplomna.championship.dao.HibernateConfig;
import bg.diplomna.championship.service.LogicConfig;
import bg.diplomna.championship.validators.ValidatorsConfig;

@Configuration()
@PropertySource("classpath:application.properties")
@Import({ HibernateConfig.class, LogicConfig.class,ValidatorsConfig.class})
@ImportResource("classpath:SecurityConfig.xml")
public class ApplicationConfig {
	
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertyPlaceholderConfigurer() {
	    return new PropertySourcesPlaceholderConfigurer();
	}
	
	
}
