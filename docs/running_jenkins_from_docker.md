# running_jenkins

```
mkdir /home/akhilesh/jenkins_data
sudo chown -R 1000:1000 /home/akhilesh/jenkins_data
docker run -d -p 8088:8080 -p 50000:50000 -v /home/akhilesh/jenkins_data:/var/jenkins_home jenkins
```
Once Jenkins came up, while I tried to install plugins, i got below error

> An error occurred during installation: No such plugin: cloudbees-folder 

Apparently doing http://my-domain-where-jenkins-is-running:8080/restart did the trick.


