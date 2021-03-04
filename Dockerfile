FROM nodecg/nodecg

WORKDIR /opt/nodecg/nodecg-io/

USER root

RUN apt update -qq && apt install -qq build-essential libusb-1.0-0-dev libasound2-dev libudev-dev -y > /dev/null 2> /dev/null && npm i -g npm
#> /dev/null 2> /dev/null

COPY --chown=nodecg:nodecg . .
RUN chown -R nodecg:nodecg /opt/nodecg

USER nodecg
RUN ls -lah /opt/nodecg/nodecg-io/nodecg-io-core/dashboard
RUN npm install && npm run bootstrap && npm run build



COPY --chown=nodecg:nodecg docker-nodecg-config.json /opt/nodecg/cfg/nodecg.json

WORKDIR /opt/nodecg

CMD ["nodecg","start"]

EXPOSE 9090