These instructions describe how to encrypt the internal `Credentials.plist` file. These credentials are required to build all test targets.

By following the steps below, you will commit an encrypted version of the credentials to the repository. This makes it safely accessibly to the Travis build environment for continuous integration.

#### Set Up Travis Utility

1. Install travis: `sudo gem install travis`
2. Login with travis: `travis login --org`

#### Encrypt File

1. Remove current decryption command in `.travis.yml`.
2. Encrypt credentials file: `travis encrypt-file Credentials.plist`
3. Add the command generated by `travis` to `.travis.yml`.
4. Verify the `.travis.yml` build settings. You may need to update the file path (e.g. `Credentials.plist` to `Source/SupportingFiles/Credentials.plist`).
5. Verify that `Credentials.plist.enc` is encrypted.
6. Commit changes. Be careful not to accidentally commit `Credentials.plist`!