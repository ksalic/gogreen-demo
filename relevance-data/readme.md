1) download or generate: [GENERATING DEMO RELEVANCE DATA](https://code.onehippo.org/cms-enterprise/hippo-addon-targeting/blob/13.0/demo-support/data-generator/README) relevance data files into: ```src/main/resources``` directory
2) run:

```mvn clean package```

3) run:

```
mvn deploy:deploy-file -DgroupId=com.onehippo.gogreen \
  -DartifactId=gogreen-two-relevance-data \
  -Dversion=1.0.0 \
  -Dpackaging=war \
  -Dfile=target/gogreen-two-relevance-data-1.0.0.war \
  -DrepositoryId=hippo-maven2-enterprise \
  -Durl=https://maven.onehippo.com/content/repositories/enterprise-releases/
```  