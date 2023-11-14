package com.wia.enigma.configuration.application;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

@Configuration
public class ValidationConfiguration {

    /**
     * Gets the validation messages from the file validation-messages.properties.
     *
     * @return LocalValidatorFactoryBean
     */
    @Bean
    public LocalValidatorFactoryBean getValidator() {
        LocalValidatorFactoryBean bean = new LocalValidatorFactoryBean();
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("classpath:validation-messages");
        messageSource.setDefaultEncoding("UTF-8");
        bean.setValidationMessageSource(messageSource);
        return bean;
    }
}
