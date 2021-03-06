# Start with fully-featured Node.js base image
FROM node:14.4.0-alpine AS build

WORKDIR /home/node/app

# Copy dependency information and install all dependencies
COPY --chown=node:node package*.json ./

RUN npm ci && npm cache clean --force

# Copy source code (and all other relevant files)
COPY --chown=node:node . .

# Build code
RUN npm run build

# Run-time stage
FROM node:14.4.0-alpine

EXPOSE 8000

WORKDIR /home/node/app

ENV NODE_ENV=production

# Copy dependency information and install production-only dependencies
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=build /home/node/app/node_modules ./node_modules

RUN npm prune

# Copy results from previous stage
COPY --chown=node:node --from=build /home/node/app/build ./build

USER node

CMD [ "node", "build/index.js" ]