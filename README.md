Running locally
===============

Optionally, enable the URLRewriteFilter
---------------------------------------
The URL Rewriter has been set up in this project on the CMS and site part, however the site's URLRewriteFilter has been
commented out so the redirecting functionality is off on production, preventing users to add malicious redirects.

If you want to demo URL rewriting on your local machine, uncomment out in the site's web.xml
the <filter-mapping> element for RewriteFilter. Do not commit this change.

Run it
------
Hippo Go Green uses the Maven Cargo plugin to run the CMS and site locally in Tomcat.
From the project root folder, execute:

    mvn clean install
    mvn -P cargo.run

Storages on when running locally with Cargo:
  The repo.path system property is predefined in the root pom as 'storage', relative to project directory.
  The es.path system property, used by the embedded elasticsearch.war, is predefined as 'elasticsearch', relative to the
  repo.path

  Note: (on Windows at least) when the repo.path property is supplied on the command line, the Elasticsearch data will
  be 'elasticsearch' in the Tomcat8x directory.

Access the CMS at [http://localhost:8080/cms](http://localhost:8080/cms), and the site at [http://localhost:8080/site](http://localhost:8080/site)
Logs are located in target/tomcat8x/logs

Building distribution
=====================

To build a Tomcat distribution tarball containing only deployable artifacts:

    mvn clean install
    mvn -P dist

See also src/main/assembly/distribution.xml

Using JRebel
============

Set the environment variable REBEL_HOME to the directory containing jrebel.jar.
Build with:

    mvn -Djrebel

or add -Djrebel to your MAVEN_OPTS environment variable:

    export MAVEN_OPTS="$MAVEN_OPTS -Djrebel"

Note: the latter *always* enables JRebel. To disable temporarily (e.g. when building/deploying a release) use

    mvn -P -jrebel

Do *not* activate JRebel using "mvn -P jrebel", as it then deactivates the "default" profile.

Hot deploy
==========

To hot deploy, redeploy or undeploy the CMS or site:

    cd cms (or site)
    mvn cargo:redeploy (or cargo:undeploy, or cargo:deploy)


Special thanks:
===============
- To the PugPig team (PugPig.com) about the help we got from them for the IPad magazine support
  (@see site/src/main/webapp/WEB-INF/jsp/ipadmag/events/detail.jsp)