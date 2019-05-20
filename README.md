# ecs-cf-deploy

> Dockerized script to deploy an ECS service based on cloudformation stacks (while assuming a role to access a sub-account).

It's meant to be used in a CI environment.

## Usage

Inside the container, run:

`ecs-cf-deploy -s $SERVICE -c $CLUSTER -a $ACCOUNT -ar $ROLE -r $AWS_DEFAULT_REGION`

An example can be found on the [manual-api repo](https://github.com/mycsHQ/manual-api/blob/master/.circleci/config.yml#L58-L82).
The AWS credentials will be passed by circleci automatically to the container.

## Deployment

This container is deployed in [docker hub](https://cloud.docker.com/u/mycs/repository/docker/mycs/ecs-cf-deploy).
Currently, all apis are using the image tagged with `lastest`.

You can deploy manually by doing this (permissions are required to push on this docker hub repo)

```bash
docker build . -t mycs/ecs-cf-deploy
docker push mycs/ecs-cf-deploy
```

## Workflow

1. Assume role on given account
2. Get the unique name of the cluster from the output of the cloudformation stack
3. Get the service name from the output of the cloudformation stack
4. Force a redeployment of the service on the given ecs cluster
5. The deployment takes a few minutes as it's waiting for the new tasks to run successfuly before deleting the old ones

## Contribution

If you want to contribute to this repo, feel free to submit a pull request.
Here are some ideas if improvement we'd like to have:

- tests (automated on circleci)
- a solution to run this script as a docker container (`docker run -it mycs/ecs-cf-deploy -e ''...`)
- 