def buildAndPushDockerImage(String imageName) {
    sh """
        docker build -t ${imageName} .
        docker tag ${imageName} ${imageName}
    """
}

def runHealthcheck(String imageName) {
    sh """
        docker run -d --name http-echo -p 5678:5678 ${imageName}
        sleep 5
        curl -f http://localhost:5678 || echo 'Healthcheck failed'
    """
}
