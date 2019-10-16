# TUNR-Code-Samples-With-Docker
Code samples of the book "Terraform: Up and Running" translated within docker provider

# Terraform CLI
**terraform** cli is provided from docker image of [broadinstitute/terraform](https://hub.docker.com/r/broadinstitute/terraform)
## get terraform image 
```docker pull broadinstitute/terraform:0.12.6```
[versioned 0.12.6]()

## how to use the image
- ####run terraform with the code
`docker run -it --rm -v $(pwd)/code:/data --net=host --entrypoint=/bin/sh broadinstitute/terraform:0.12.6`
- ####terraform init
`docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.6 init`
- ####terraform plan 
`docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.6 plan`
- ####terraform apply
`docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.6 apply`
- ####terraform destroy
`docker run -it --rm -v $(pwd)/code/terraform/00-preface/hello-world:/data --net=host broadinstitute/terraform:0.12.6 destroy`

dive into [the project github home](https://github.com/broadinstitute/docker-terraform) to get more detailed info 