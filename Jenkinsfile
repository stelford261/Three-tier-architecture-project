pipeline {
agent any
stages {
stage('Checkout') {
steps {
checkout([$class:'GitSCM', branches: [[name:'*/main']], extensions: [],
userRemoteConfigs: [[url: 'https://github.com/stelford261/Three-tier-architecture-project.git']]])
}

}
stage ("terraform init") {
steps {
sh ("terraform init")
}
}
stage ("terraform Action") {
steps {
echo "Terraform action is --${action}"
sh ('terraform ${action} --auto-approve')
}
}
}
}
