FROM node
WORKDIR /appFolder
COPY . /appFolder
RUN npm install express
RUN npm install n-readlines
EXPOSE 5000
CMD ["node", "api.js"]