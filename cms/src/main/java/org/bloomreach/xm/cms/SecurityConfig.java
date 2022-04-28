package org.bloomreach.xm.cms;

import com.onehippo.gogreen.security.LoginSuccessFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.context.annotation.PropertySource;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.access.intercept.FilterSecurityInterceptor;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

import static com.onehippo.gogreen.security.CustomSamlConfigurer.saml;


@EnableWebSecurity
@Configuration
@PropertySource("classpath:application.properties")
@Profile("!no-sso")
class SecurityConfig extends WebSecurityConfigurerAdapter {
    private static final Logger log = LoggerFactory.getLogger(SecurityConfig.class);

    public static final String CMS = "/cms";

    @Value("${security.sso.enabled}")
    boolean ssoEnabled;

    @Value("${security.saml2.metadata-url}")
    String metadataUrl;

    @Value("${server.ssl.key-alias}")
    String keyAlias;

    @Value("${server.ssl.key-store-password}")
    String password;

    @Value("${server.ssl.key-store}")
    String keyStoreFilePath;

    @Value("${security.saml2.hostname}")
    String hostname;

    @Value("${security.saml2.protocol}")
    String protocol;


    @Override
    protected void configure(HttpSecurity http) throws Exception {
        if (!ssoEnabled) {
            http.csrf().disable().authorizeRequests().anyRequest().permitAll()
                    .and().headers().frameOptions().sameOrigin();
            log.warn("CMS SSO has been disabled by running with the environment variable SSO_ENABLED set to false in application.properties");

        } else {
            log.info("Enabling CMS SSO with environment");
            log.debug("CMS SSO params - hostname: {}, metadataUrl: {}, protocol: {}, keyAlias: {}, keystore: {}, password: ***", hostname, metadataUrl, protocol, keyAlias, keyStoreFilePath);

            http
                    .csrf()
                    .disable()
                    .authorizeRequests()
                    //.requestMatchers(request -> request.getParameterMap().containsKey("_hn:type")).permitAll()
                    .antMatchers("/saml*", "/*.gif", "/*.jpg", "/*.jpeg", "/*.png", "/*.jsp", "/*.js", "/*.css", "/*.map", "/console*").permitAll()
                    .anyRequest().authenticated()
                    .and()
                    .headers().frameOptions().sameOrigin()
                    .and()
                    .addFilterAfter(new LoginSuccessFilter(), FilterSecurityInterceptor.class)
                    .apply(saml(hostname, protocol))
                    .serviceProvider()
                    .keyStore()
                    .storeFilePath(keyStoreFilePath)
                    .password(password)
                    .keyname(keyAlias)
                    .keyPassword(password)
                    .and()
                    .protocol(protocol)
                    .hostname(hostname)
                    .basePath(CMS)
                    .and()
                    .identityProvider()
                    .metadataFilePath(metadataUrl);
        }

        http.cors().configurationSource(corsConfigurationSource());
    }

    @Override
    public void configure(WebSecurity web) throws Exception {

        web.ignoring()
                //.requestMatchers(request -> request.getParameterMap().containsKey("_hn:type"))
                .antMatchers("/ws/indexexport*");
    }

    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOriginPatterns(Arrays.asList("*"));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "OPTIONS", "DELETE", "PUT", "PATCH"));
        configuration.setAllowCredentials(true);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

}


