pipeline{
    agent any
   environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages{
        stage('checkout from GIT'){
            steps{
               git branch: 'main', credentialsId: 'testpipeline', url: 'https://github.com/nitishdadapuram10/test_pipeline_2.git'
            }
        }

  stage('Terraform '){
            steps{
               bat 'terraform state rm aws_lb_target_group.p2_ec2_target_group'
            }
       }

        stage('Terraform Init'){
            steps{
                bat 'terraform init'
            }
        }
        stage('Terraform Plan'){
            steps{
                bat 'terraform plan'
            }
        }



        stage('Terraform Apply'){
            steps{
               bat 'terraform apply --auto-approve'
            }
       }
        // stage('Terraform Destroy'){
         // steps{
         //     bat   'terraform destroy --auto-approve'
          //  }
       // }
       
    }
}
