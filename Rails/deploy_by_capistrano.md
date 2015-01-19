#### set up server env
* 下面的均为可以直接复制粘贴的Linux命令

#### 设置部署用户
* ``` useradd -m -s /bin/bash deploy ```
* ``` adduser deploy sudo ```
* ``` passwd deploy ```
* ``` sudo apt-get update ```
* ``` sudo apt-get install openssh-server ```
* 使用 __deploy__ 登录 (实现公钥登录)
* ``` ssh deploy@xxx.xxx.xxx.xxx```
* ``` sshkey-gen -t rsa ```
* ``` touch /home/deploy/.ssh/authorized_keys ```
* 将自己本机的 **id_rsa.pub** 的内容粘贴到上述文件中

#### 配置服务器环境

* ``` ssh deploy@xxx.xxx.xxx.xxx ```
* ``` sudo apt-get install vim git curl ```
* ``` sudo apt-get install mysql-server mysql-client libmysql++-dev ```
* ``` \curl -sSL https://get.rvm.io | bash ```
* ``` source .bashrc ```
* ``` sourec .bash_profile ```
* ``` rvm use --install --default 2.2.0  ``` __ruby版本请自行更改__

### 安装passenger

* ``` gem install bundler passenger --no-ri --no-rdoc ```
* ``` rvmsudo passenger-install-nginx-module ``` __ 若其rewrite模块没有安装 请自行wget提示文件自行编译 然后**重新执行**此命令
* ``` wget -O init-deb.sh http://www.linode.com/docs/assets/1139-init-deb.sh ```
* ``` sudo mv init-deb.sh /etc/init.d/nginx ```
* ``` sudo chmod +x /etc/init.d/nginx ```
* ``` sudo /usr/sbin/update-rc.d -f nginx defaults ```

### 配置nginx

* nginx.conf
```
worker_processes  auto;
events {
    worker_connections  4096;
    use epoll;
}

http {
    # .....
    client_max_body_size 100m;
      
    gzip                on;
    gzip_disable        "msie6";
    include /opt/nginx/conf/vhost/*.conf;
}
```
* your.conf
```
server {
    listen 80;
    server_name exercise.ihower.tw;
    root /home/deploy/rails-exercise/current//public; 
    passenger_enabled on;
            
    passenger_min_instances 1;
    passenger_show_version_in_header off;
    server_tokens       off;
    
    location ~ ^/assets/ {
        expires 1y;
        add_header Cache-Control public;
        add_header ETag "";
        break;
    }    
}
```

### 最后记得清理 log

* ``` config.logger = Logger.new(config.paths["log"].first, 'daily') # 或 weekly,monthly  ``` __/config/environments/production.rb__