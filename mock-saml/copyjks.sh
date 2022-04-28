#!/usr/bin/env bash

DEV_JKS=cms/src/main/resources/saml/dev.jks
SSOCIRCLE_JKS=cms/src/main/resources/saml/samlKeystore.jks

cp ${DEV_JKS} cms/target/cms/WEB-INF/classes/saml/
cp ${DEV_JKS} cms/target/cms/WEB-INF/classes/saml/
cp ${DEV_JKS} site/webapp/target/site/WEB-INF/classes/saml/
cp ${DEV_JKS} site/webapp/target/classes/saml/

exit 0