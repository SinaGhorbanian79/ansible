This is a role to push images to a custom registry

example usage:
    - role: docker_image_push
      vars:
        source_registry: ""
        target_registry: ""
        image_name: ""
        image_tag: ""
