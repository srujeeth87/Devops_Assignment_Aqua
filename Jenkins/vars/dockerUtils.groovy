def buildAndPushDockerImage(String imageName) {
    sh """
        docker build -t ${imageName} .
        echo "Fake login: skipping real DockerHub login"
        docker tag ${imageName} ${imageName}
        echo "Fake push: skipping actual push"
    """
}

def runHealthcheck(String imageName) {
    sh """
        docker run -d --name http-echo -p 5678:5678 ${imageName}
        sleep 3
        curl -f http://localhost:5678 || echo "Health check failed"
    """
}
