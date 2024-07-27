ARG IMAGE_NAME=alpine
ARG IMAGE_VERSION=3.20

ARG PROJECT_NAME=guess_number
ARG PROJECT_PATH=/root/$PROJECT_NAME
ARG DEBUG_BIN=$PROJECT_PATH/target/debug/$PROJECT_NAME
ARG RELEASE_BIN=$PROJECT_PATH/target/release/$PROJECT_NAME

# ---------------------------------------------------------------
FROM $IMAGE_NAME:$IMAGE_VERSION AS build_base
ENV PATH="/root/.cargo/bin/:$PATH"
RUN set -euo pipefail && \
    apk update && \
    apk add curl gcc && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
CMD [ "/bin/sh" ]

# ---------------------------------------------------------------
FROM build_base AS build_release
ARG PROJECT_PATH
WORKDIR $PROJECT_PATH
COPY Cargo.toml Cargo.lock ./
COPY src/ ./src/
RUN cargo build --release
CMD [ "/bin/sh" ]

# ---------------------------------------------------------------
FROM $IMAGE_NAME:$IMAGE_VERSION
ARG PROJECT_NAME
ARG RELEASE_BIN
ENV _PROJECT_PATH=/usr/bin/$PROJECT_NAME
COPY --from=build_release $RELEASE_BIN $_PROJECT_PATH
CMD $_PROJECT_PATH
