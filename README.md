# beeper-bridges
A Docker Compose file to start most Beeper [self-hosted Bridges](https://github.com/beeper/bridge-manager) as docker containers.

## File structure
The file structure is composed of two provided .yml files - which are provided, and one .env file - which needs to be created. They are as follows:
- common-services.yml: This is a file that provides components used by all Beeper Bridges
- docker-compose.yml: The primary Docker Compose file that creates a container for every Bridge
- .env: An environment file to set your Matrix access token and your base data path for your volume storage _[Needs to be created]_

Once you've cloned this repo, the .env text file needs to be created and contain two variables:
```
MATRIX_ACCESS_TOKEN=(set your token here)
DATA_PATH=/path/to/where/your/volumes/are
```

### MATRIX_ACCESS_TOKEN
Matrix Access Token is the Access Token your Beeper account is using to access the [Matrix network](https://matrix.org/). To find this token, open your Beeper desktop client, open "Settings", then click on "Help & Abount". Scroll the bottom of the Help & Abount Section, where you'll see a "Access Token" section you'll need to expand. There you'll see your access token, which you should copy after "MATRIX_ACCESS_TOKEN" in the .env file. *This access token gives full access to your account, so do not share it with anyone.*

## Bridges
The compose file currently includes the following bridges:
- WhatsApp
- Instagram
- Gmessages (SMS & RCS via Google Messages)
- Signal
- Discord

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
