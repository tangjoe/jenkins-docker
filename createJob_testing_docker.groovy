pipelineJob('testing_docker') {
    definition {
        cps {
            script(readFileFromWorkspace('testing_docker_pipeline.groovy'))
            sandbox()
        }
    }
}
