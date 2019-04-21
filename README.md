# docker-airconnect
AirConnect container for turning Chromecast into Airplay targets

This is a containerized build of the fantastics program by [philippe44](https://github.com/philippe44) called AirConnect. It allows you to be able to use AirPlay to push audio to Chromecast and UPNP based devices. There are some advanced details and information that you should review on his [GitHub Project](https://github.com/philippe44/AirConnect). For the most part this container needs nothing more than to launch it using Host networking.

The main purpose for building this container over the others out there, is that this will always update to the latest version of the app as pulled from the original GitHub page. Currently there is another popular container that is not updated. This uses runtime scripting to ensure it will always pull the latest version of the binary before running - without intervention by me.

# Running

This can be run using a docker compose file or a standard docker run command.

Sample Docker run config:

`docker run -d --net=host 1activegeek/airconnect`

# Troubleshooting

If you need to attempt to dig into troubleshooting and see the logs realtime in the container, use the following examples to help dig into diagnosis.

`docker exec -it <name of container> bash`

Once inside the container, you can use standard config options to run the app as outlined by the creator. The app is located in the `/bin` directory. Both the UPNP and Cast versions of the file are being run in this container.

`./aircast-x86-64 --h` - will provide you a list of commands that can be run via the app

`./aircast-x86-64 -d all=debug` - will run the app and output a debug based log in an interactive mode

If you perform any realtime testing, it is suggested to completely restart the container after testing to be sure there are no incompatibilities that arise with running it in daemon mode while also running it interactively. 
