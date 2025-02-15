FROM node:22-alpine as build

WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

EXPOSE 3000


FROM node:22-alpine as prod

WORKDIR /app
COPY --from=build /app/build ./build
COPY --from=build /app/package.json .
RUN npm install --omit=dev


CMD [ "node","build" ]