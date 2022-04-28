const {runServer} = require('saml-idp');
//  acsUrl: `https://jenskooij.okta.com/auth/saml20/assertion-consumer`,
  //acsUrl: `http://localhost:8089/auth/saml20/assertion-consumer`,
runServer({
  acsUrl: `http://localhost:8089/auth/saml20/assertion-consumer`,
  audience: `http://localhost:8080/cms/saml/metadata`,
  port: 7001,
  config: {
    user: "test@rijksportaal.nl",
    metadata: [{
      "id": "urn:rijksoverheid.nl:emailAddress",
      "optional": false,
      "displayName": "E-Mail Address",
      "description": "The e-mail address of the user",
      "multiValue": false
    }],
    user: {
      email: 'test@rijksportaal.nl',
    }
  }
});
