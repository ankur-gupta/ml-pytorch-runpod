FROM ankurio/ml-pytorch

USER root

# Expose ports for Jupyter and SSH
EXPOSE 8888
EXPOSE 22

# Set the default command for the container
COPY start.sh /start.sh
CMD [ "/start.sh"]
