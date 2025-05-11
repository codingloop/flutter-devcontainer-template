### Creating new image version
1. In order to build new image, make changes to `Dockerfile` and push the changes
2. Create a tag and push it with corresponding version number
```
git tag version_number
git push origin version_number
```
Example:
```
git tag v1.0.0
git push origin v1.0.0
```
Above commands will create a new docker image and publish it with the version number `v1.0.0`