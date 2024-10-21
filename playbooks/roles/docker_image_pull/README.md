This role is used to pull images from dockerhub or any custom registry

usage template:

- role: docker_image_pull
  vars:
    docker_image: "my_custom_image"  # Replace with your image name
    docker_image_tag: "my_desired_tag"  # Replace with your desired tag