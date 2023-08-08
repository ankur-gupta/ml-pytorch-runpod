FROM ankurio/ml-pytorch:0.0.16

USER root

# Expose ports for Jupyter and SSH
EXPOSE 8888
EXPOSE 22

# Set the default command for the container
COPY start.sh /start.sh
CMD [ "/start.sh"]
