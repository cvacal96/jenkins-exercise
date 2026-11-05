#### This project is for the DevOps bootcamp exercise for

#### "Build Automation with Jenkins"

##### Test
The project uses jest library for tests. (see "test" script in package.json)
There is 1 test (server.test.js) in the project that checks whether the main index.html file exists in the project. 

To run the nodejs test:

    npm run test

Make sure to download jest library before running test, otherwise jest command defined in package.json won't be found.

    npm install

In order to see failing test, remove index.html or rename it and run tests.

##### Jenkins versioning

For builds not triggered by a `ci: version bump` commit, the Jenkins pipeline increments the patch version in `app/package.json` and sets `IMAGE_NAME` to `<version>-<build number>`. It commits the version update on non-PR branches; the resulting commit is skipped by the pipeline to prevent a build loop.
