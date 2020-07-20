pipelineJob('testing_tools') {
    definition {
        cps {
            script(readFileFromWorkspace('testing_tools_pipeline.groovy'))
            sandbox()
        }
    }
}
