# beeper-bridges
A Docker Compose file to start most Beeper [self-hosted Bridges](https://github.com/beeper/bridge-manager) as docker containers.

## File structure
The file structure is composed of two provided .yml files - which are provided, and one .env file - which needs to be created. They are as follows:
- common-services.yml: This is a file that provides components used by all Beeper Bridges
- docker-compose.yml: The primary Docker Compose file that creates a container for every Bridge
- .env _(not included in repo)_: An environment file to set your Matrix access token, your base data path for your volume storage, and the parameters for your iMessage bridge, if you're using that bridge

Once you've cloned this repo, the .env text file needs to be created and contain three variables (iMessage variable optional, based on whether you're using the iMessage bridge to BlueBubbles):
```
MATRIX_ACCESS_TOKEN=(set your token here)
DATA_PATH=/path/to/where/your/volumes/are
IMESSAGE_PARAMS=--param 'bluebubbles_url=http://localhost:1234' --param 'bluebubbles_password=YOUR_PASSWORD' --param 'imessage_platform=bluebubbles'
```
For more information on how to set your iMessage parameters for BlueBubbles, see [this write up](https://rentry.org/beeper_bluebubbles_bridge).

### MATRIX_ACCESS_TOKEN
Matrix Access Token is the Access Token your Beeper account is using to access the [Matrix network](https://matrix.org/). 

As of Beeper desktop client v4, the Matrix Access Token is no longer available client-side. The recommended way to extract your Matrix Access Token is using bbctl. Once you locate where bbctl is located, you can run the [get_token.sh](https://github.com/rhinot/beeper-bridges/blob/main/get_token.sh) script in that same directory.

If you're still running Beeper Desktop Client v3, you can still find your "Access Token" by opening "Settings", then clicking on "Help & About". Please note that while this method still works at the time of writing, it is no longer supported by Beeper support or staff.

Using either method, once you locate an access token, copy it after "MATRIX_ACCESS_TOKEN" in the .env file you created from the instructions above. 
*This access token gives full access to your account, so do not share it with anyone.*

## Bridges
The compose file currently includes the following bridges:
- WhatsApp
- Instagram
- Gmessages (SMS & RCS via Google Messages)
- Signal
- Discord
- iMessage (BlueBubbles)

Additional Bridges can be added by following the same template as the sections for each bridge provided in the compose file, which follows the following pattern:
```
*service_name*:
    extends:
      file: ./common-services.yml
      service: beeper-bridge
    container_name: beeper-*service_name*
    volumes:
      - ${DATA_PATH}/beeper-*service_name*:/data
    environment:
        BRIDGE_NAME: sh-*service_name*
```

You can change the top level name of the service, the name of the container, and the name of the volume as you wish. **You must follow the same format for the BRIDGE_NAME**, using the identifiers provided in [the official bridge list table](https://github.com/beeper/bridge-manager).

## Running Docker Compose
Once you have the .env file set up, you can run the Docker Compose stack with the following command:
```
docker compose up
```
To learn more about Docker Componse commands, you can try [Docker's Compose Quickstart guide](https://docs.docker.com/compose/gettingstarted/).


# Thanks
Huge thanks to the [#self-hosting:beeper.com](https://matrix.to/#/#self-hosting:beeper.com) chat room for the support provided to figure the above out. 
A special thanks to [8bithero](https://matrix.to/#/@8bithero:beeper.com) who provided the initial docker compose format.
