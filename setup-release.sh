#login to openshift cluster
oc login -u developer -p developer

# create new project for 'helloworld' application release 'v1' 
oc new-project helloworld-v1

# Run Jenkins pod inside the project
oc new-app jenkins-ephemeral

# Import Release Management Template,
oc create -f https://raw.githubusercontent.com/SagarOnline/openshift-devops-simple-global-config/master/release/release-management-template.yaml

# Checkout helloworld-config project
git clone https://github.com/SagarOnline/openshift-devops-helloworld-config.git helloworld-config

# Process Release Management Template to create a release for helloworld v1. This will create a "helloworld-v1-dev-rollout" pipeline in cluster to deploy a helloworld application in cluster.
oc process release-management-template --param-file=helloworld-config/release/release.properties --ignore-unknown-parameters=true | oc create -f -

# Start "helloworld-v1-dev-rollout" 
oc start-build helloworld-v1-dev-rollout