FROM node:alpine as teamalpha
WORKDIR /var/app
COPY .package.json .
RUN npm install
COPY . .
RUN npm run build


FROM nginx as final
#expose is not default in aws and other clouds so we have to mention it explicitly
EXPOSE 80
# teamalpha is a dependency for nginx 
COPY --from=teamalpha /var/app/build /usr/share/nginx/html