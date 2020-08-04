item = Jenkins.instance.getItemByFullName("pipeline-tutorial")
item.builds.each() { build ->
  build.delete()
}
item.updateNextBuildNumber(1)
