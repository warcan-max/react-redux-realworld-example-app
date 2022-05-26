FROM node:alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY  . .
RUN npm run build

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder  /app/build/* /usr/share/nginx/html/
RUN mkdir /usr/share/nginx/html/static/
RUN mv /usr/share/nginx/html/js/ /usr/share/nginx/html/static/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

