This role is used to create containers with any custom options

Important notice: please only use the variables you actually want and dont put any empty vars in the playbook


usage template:

  roles:
    - role: docker_container_create            # Include the Ansible role created for managing Docker containers
      vars:                                    # Define variables specific to this role invocation
        container_name: ""                     # The name to assign to the container
        container_image: ""                   ## MANDATORY # Docker image to use for the container       
        container_state: ""                   ## MANDATORY # Desired state: "present" (create) or "absent" (remove)
        container_restart_policy: ""           # Restart policy: "no", "always", "unless-stopped", or "on-failure"
        container_network_mode: ""             # Network mode: "bridge", "host", "none", or a custom network name
        container_workdir: ""                  # Working directory inside the container
        container_cpu_period: ""               # CPU period in microseconds
        container_cpu_quota: ""                # Total available CPU time in microseconds
        container_memory: ""                   # Memory limit for the container (e.g., "512m" or "1g")
        container_detach: ""                   # Run in detached mode: true or false
        container_exposed_ports:               # List of ports that the container exposes
          - ""                                 # Example internal port exposed by the container
        container_published_ports:             # List of ports to publish on the host
          - ""                                 # Example: Map host port 8080 to container port 80
        container_envs:                        # Environment variables to set in the container
          ENV_VAR1: ""                         # Example environment variable
          ENV_VAR2: ""                         # Another example
        container_volumes:                     # List of volumes to mount into the container
          - "/host/path:/container/path"       # Example: Mount host directory to container directory
