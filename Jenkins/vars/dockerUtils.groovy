def buildAndPushDockerImage(String imageName) {
    withCredentials([usernamePassword(credentialsId: '4a0089bb-e1b8-4ded-8f6a-3562c48483b1', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) 
           {
    sh """
        echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin 
        docker build -t ${imageName} .
        docker tag ${imageName} ${imageName}
        docker push ${imageName}
    """
           }
}


def runHealthcheck(String imageName) {
    sh """
        docker run -d --name http-echo -p 5678:5678 ${imageName}
        sleep 5
        curl -f http://localhost:5678 || echo 'Healthcheck failed'
    """
}
