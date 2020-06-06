pipeline {
    agent {label 'fargate-cloudformation-packer-slave'}
    environment {
        PACKER_FILENAME="${WORKSPACE}/packer/config.json"
        PACKER_MANIFEST_FILE_PATH="${WORKSPACE}/packer_manifest.json"
        PARAMETER_NAME="/DeploymentConfig/Dragontail/AmiId"

    }
    options { 
        timestamps () 
        ansiColor('xterm')
    }
    stages {
        stage ('packer-build') {
            steps {
                sh '''
                packer build ${PACKER_FILENAME}
                '''
            }
        }
        stage ('push-ami-ids-parameters') {
            steps {
                sh '''
                #!/usr/bin/env bash
                pip2 install --upgrade pip
                pip2 install -r ${WORKSPACE}/packer/scripts/utils/requirements.txt
                python2 ${WORKSPACE}/packer/scripts/utils/packer_ami_parameter_store.py push-parameter --manifest-path "$PACKER_MANIFEST_FILE_PATH" --parameter-name "$PARAMETER_NAME"
                '''
            }
        }
    }

}