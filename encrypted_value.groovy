import hudson.util.Secret
def secret = Secret.fromString("password")
println(secret.getEncryptedValue())
