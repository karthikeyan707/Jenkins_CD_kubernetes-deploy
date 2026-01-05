pipeline {
    agent {label 'agent1'}

    environment {
        AWS_REGION = "us-west-2"
    }
	parameters {
    string(name: 'CLUSTER_NAME', defaultValue: 'devcluster', description: 'EKS Cluster Name')
	}

    stages {
		stage ('checkout') {
			steps {
				git branch: 'main' , url:'https://github.com/karthikeyan707/Jenkins_CD_kubernetes-deploy.git'
			}
		}

		stage ('terraform init & plan') {
			steps {
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: 'aws-creds']]) {
					dir('terraform'){
						sh '''
							terraform init -no-color
							terraform plan -no-color -out=tfplan
						'''
					}
				}
			}
		}

	    stage ('terraform approve'){
			steps {
				script {
					input message:'click proceed to apply the terraform code', ok:'Proceed'
				}
			}
		}

		stage ('terraform apply') {
			steps {
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: 'aws-creds']]) {
					dir('terraform') {
						sh '''
							terraform apply tfplan
						'''
					}
				}
			}
		}

        stage('Deploy to EKS') {
            steps {
				withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId: 'aws-creds']]) {
					dir('kubernetes') {
						sh '''
							aws eks update-kubeconfig --name $CLUSTER_NAME --region $AWS_REGION
							kubectl get nodes
							kubectl apply -f ns.yaml
							kubectl apply -f onlydep.yaml
						'''
					}
				}
            }
        }
    }
}