# Mock SAML
Mock SAML Identity Provider (idP), which will run on:
* Site: localhost:7000
* CMS: localhost:7001

This will work with the mentioned SSO_ENABLED="true" environment variable as 
explained in root readme.MD.
```
npm install
node run-cms.js
```

## Source
This mock server uses saml-idp repo, borrowed from here: https://github.com/mcguinness/saml-idp