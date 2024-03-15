inventoryfile
all:
  hosts:
    web01:
      ansible_host: 172.31.24.215
#      ansible_user: ec2-user
#      ansible_ssh_private_key_file: clientkey.pem
    web02:
      ansible_host: 172.31.16.137
    db01:
      ansible_host: 172.31.24.123

  children:
    webservers:
      hosts:
        web01:
        web02:
    dbservers:
      hosts:
        db01:
    dc_oregon:
      children:
        webservers:
        dbservers:
      vars:
        ansible_user: ec2-user
        ansible_ssh_private_key_file: clientkey.pem



web_db.yaml

---
- name: Webserver setup
  hosts: werservers
  become: yes
  tasks:
    - name: Install httpd
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Start service
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes


- name: DBserver setup
  hosts: dbservers
  become: yes
  tasks:
    - name: Install mariadb-server
      ansible.builtin.yum:
        name: mariadb-server
        state: present



2.yaml

---
- name: Webserver setup
  hosts: werservers
  become: yes
  tasks:
    - name: Install httpd
      ansible.builtin.yum:
        name: httpd
        state: present

    - name: Start service
      ansible.builtin.service:
        name: httpd
        state: started
        enabled: yes

    - name: Copy file
      copy:
        src: files/index.html
        dest: /var/www/html/index.html

3.yaml for AWS

- hosts: localhost
  gather_facts: False
  tasks:
    - name: Create key pair
      ec2_key:
        name: sample
        region: us-west-2
      register: keyout

      #- name: print key
      #debug:
      #  var: keyout


    - name: save key
      copy:
        content: "{{keyout.key.private_key}}"
        dest: ./sample.pem
      when: keyout.changed

    - name: start an instance
      amazon.aws.ec2_instance:
        name: "public-compute-instance"
        key_name: "sample"
        #vpc_subnet_id: subnet-5ca1ab1e
        instance_type: t2.micro
        security_group: default
        #network:
           # assign_public_ip: true
        image_id: ami-02d8bad0a1da4b6fd
        exact_count: 1
        region: us-west-2
        tags:
          Environment: Testing


