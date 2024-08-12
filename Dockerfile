FROM node:lts AS build
WORKDIR /app
COPY package*.json ./
RUN npm install -g pnpm
COPY . .

RUN pnpm install
RUN pnpm run build


FROM nginx:alpine AS runtime
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
