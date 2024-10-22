This role is for creating users in mariadb and mysql databases

usage template:

    
    
    - role: mysql_add_user
      vars:
        database_user: ""
        database_password: ""
        database_name: ""
        database_privileges: ""
        database_host: ""
        login_username: ""
        login_password: ""
