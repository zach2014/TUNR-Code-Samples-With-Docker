# TUNR-Code-Samples-With-Docker
Code samples of the book "Terraform: Up and Running" translated within docker provider

## Terraform CLI
**terraform** cli is provided from docker image of [broadinstitute/terraform](https://hub.docker.com/r/broadinstitute/terraform)
### get terraform image 
```docker pull broadinstitute/terraform:0.12.6```
[versioned 0.12.6]()

### how to use the image
- run terraform with the code
```shell script
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 init
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 plan
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 apply
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 show 
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 graph
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 destroy 
```
- resource targeting
```shell script
terraform -target some_resource.target_name -out setup_some_resource.plan plan 
# or destroy with target 
terraform -target some_resource.target_name destroy 
```
dive into [the project github home](https://github.com/broadinstitute/docker-terraform) to get more detailed info 
---
## Hello World in Terraform

### init [Hello World](./code/terraform/00-preface/hello-world)
```shell script
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 init
```

### setup docker engine by leveraging [resource targeting](https://www.hashicorp.com/blog/resource-targeting-in-terraform/) feature
```shell script
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 plan -target null_resource.target_host  -out setup-docker.plan
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 apply setup-docker.plan
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 show 
```

### complete hello world
```shell script
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 plan 
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 apply
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 show
```

### destroy resources
```shell script
# one by one 
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 destroy -target docker_container.hello-world
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 destroy -target docker_image.hello-world
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 destroy -target null_resource.target_host
# OR
docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.25 destroy
```
