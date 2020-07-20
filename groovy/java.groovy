#!/usr/bin/env groovy

import jenkins.model.*
import hudson.model.*
import hudson.tools.*

def instance = Jenkins.getInstance()

/**
 * Install jdk
 * https://download.oracle.com/otn/java/jdk/8u221-b11/230deb18db3e4014bb8e3e8324f81b43/jdk-8u221-linux-x64.tar.gz"
 */
def javaDescriptor = instance.getDescriptor(hudson.model.JDK.class)
def javaInstallations = []
def javaVersions = ["jdk8":"jdk-8u221-oth-JPR"]

for (version in javaVersions) {
    def installer = new JDKInstaller(version.value, true)
    def installerProps = new InstallSourceProperty([installer])
    def installation = new JDK(version.key, "", [installerProps])
    installer.getDescriptor().doPostCredential('EmailID', 'PASSWORD')
    javaInstallations.push(installation)
}

javaDescriptor.setInstallations(javaInstallations.toArray(new JDK[0]))
javaDescriptor.save()
