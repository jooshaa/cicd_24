FROM node:alpine as Builder
WORKDIR /app
ADD package*.json ./
RUN npm ci
ADD . .
RUN npm run build --prod

FROM FROM node:alpine as Builder
WORKDIR /app
COPY --from=Builder /app/dist ./dist
ADD package*.json ./
RUN nmp ci --omit=dev
CMD ["node", "./dist/main.js"]