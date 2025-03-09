pipeline {
agent any
stages {
stage(&#39;Checkout&#39;) {
steps {
checkout([$class: &#39;GitSCM&#39;, branches: [[name: &#39;*/main&#39;]], extensions: [],
userRemoteConfigs: [[url: &#39;https://github.com/stelford261/Three-tier-architecture-project.git&#39;]]])
}

}
stage (&quot;terraform init&quot;) {
steps {
sh (&#39;terraform init&#39;)
}
}
stage (&quot;terraform Action&quot;) {
steps {
echo &quot;Terraform action is --&gt; ${action}&quot;
sh (&#39;terraform ${action} --auto-approve&#39;)
}
}
}
}
