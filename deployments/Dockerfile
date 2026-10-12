FROM node:22 AS builder 

WORKDIR /app 

COPY corui-react-apps /app/

RUN npm install

RUN npm run build 

FROM nginx:latest 

COPY --from=builder /app/build/ /usr/share/nginx/html/ 

EXPOSE 80 

