---
created: 2025-11-12T08:05:25 (UTC -05:00)
tags: []
source: https://kodekloud.com/blog/docker-create-image-from-container/
author: Hemanta Sundaray
---

# How to Create Docker Image From a Container

In this post, we'll guide you on how to create a custom Docker image from a container.

## The Process of Creating Docker Images From Containers

At a high level, the process of creating a Docker image from a container involves three steps:

1.  **Create a container from an existing image:** The first step is to choose a base image you want to customize and [run it as a container](https://kodekloud.com/blog/run-docker-image/).
2.  **Make changes to the container**: Once the container is up and running, you change it. You could modify files, install additional software, or do whatever you need to meet your requirements.
3.  **Commit the changes to create a new image**: After you’ve made the desired changes to the container, the next step is to commit those changes to create a brand-new Docker image. Now, you can use the new image to spin up new containers with your customizations.

And that’s it! Now that you're familiar with the basic steps for creating a Docker image from a container let's dive into an example to see it in action!

**Note that the commands provided in the examples below have been tested on KodeKloud’s Docker playground.**

## 3 Steps to Build a Docker Image From a Container

As discussed earlier, we’ll go through the following three steps to build a Docker image from a container, using the popular "nginx" web server as an example.

### #1 Create a Container From an Existing Image

The first step in creating a Docker image from a container is to create a container from an existing image. Run the following command to create a container from the "nginx" image.

```shell
docker container run -d --name mynginx nginx
```

This command will create a container named `mynginx` using the "nginx" image and run it in detached mode (indicated by the `-d` flag), which means the container will run in the background.

Executing the command above will give you an output similar to this:

![](https://kodekloud.com/blog/content/images/2023/04/data-src-image-67597121-c90a-484d-aa89-fc94ea3d0833.png)

The long string that you see printed in the terminal window is the container ID.

Next, let’s verify that the `mynginx` container is up and running using the `docker ps` command.

![](https://kodekloud.com/blog/content/images/2023/04/data-src-image-23cfed6d-1610-417f-8b01-ee6ee8441db2.png)

As you can see, the `mynginx` container is running successfully, as expected.

**Note**: For all the upcoming commands you’ll be running, make sure to swap out `mynginx` with the name of your container. Alternatively, you can use the container ID as a replacement for the container name. However, using an easy-to-remember container name is way more convenient.

### #2 Make Changes to the Container

#### Step 1: Import the Optimizely CMS and Commerce DB's
Using SSMS import both DB's using import data-tier application
Set Options to simple
Run SQL command on CMS DB to create epiuser
Run SQL command on CMS DB to reset version number so assembly version is lower than ongoing builds

#### Step 2: Configure CMS environemnt for development
Run website from Visual Studio
Run Environment Sync scheduled job
Verify website works

#### Step 3: Exit the container


### #3 Commit the changes to create a new image

Once you have made changes to a container, you can commit those changes to create a new Docker image using the `docker container commit` command. Think of this command as making a commit in a version control system like [Git](https://kodekloud.com/courses/git-for-beginners/?ref=kodekloud.com).

Run the following command:

```shell
docker container commit -a "KodeKloud" -m "Changed default NGINX welcome message" mynginx nginx-kodekloud
```

This command will create a new Docker image named `nginx-kodekloud` from the modified `mynginx` container. Note that it's considered best practice to use the `-a` flag to sign the image with an author and include a commit message using the `-m` flag.

Executing the command above will give you an output like this:

![](https://kodekloud.com/blog/content/images/2023/04/data-src-image-b6543e69-8fac-40c0-b575-faa2f2ecae2b.png)

Let’s verify that the new image has been created and is listed among the existing Docker images. Run the following command:

```shell
docker images
```

You’ll get an output as shown below:

![](https://kodekloud.com/blog/content/images/2023/04/data-src-image-21ac7aa8-1ac6-4443-99ae-f37e7b245155.png)

You should see the `nginx-kodekloud` image listed, indicating that the image has been successfully created. You can now use this newly created Docker image to create containers as needed, just like you would with any other Docker image.

Let’s run the `nginx-kodekloud` image as a container using the following command:

```shell
docker container run -d --name=hello-nginx-kodekloud nginx-kodekloud
```

This command will create a container named `hello-nginx-kodekloud` using the `nginx-kodekloud` image, which includes the changes made to the "nginx" configuration file.

Running the command above will give you the following output:

![](https://kodekloud.com/blog/content/images/2023/04/data-src-image-fdbbe109-f1d5-4d52-9027-5d9b862c4e7e.png)

Let’s verify that the `hello-nginx-kodekloud` container is up and running with the `docker ps` command.

![](https://kodekloud.com/blog/content/images/2023/04/data-src-image-7ec26739-4fc5-49fb-9a4f-abe5e03552cf.png)

As highlighted in the screenshot above, the container is running successfully.

Next, run the website from Visual Studio to verify the website is working as expected.

Congratulations! You have successfully created a Docker image from a container running the "nginx" web server.
___