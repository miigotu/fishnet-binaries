FROM --platform=$TARGETPLATFORM rust:1.64.0 AS builder
COPY . .
WORKDIR /fishnet

ENV CARGO_TARGET_DIR=/output/$TARGETPLATFORM
ENV RUSTFLAGS="-C target-cpu=native"

RUN mkdir -p $CARGO_TARGET_DIR &&\
 cargo install cargo-auditable \

RUN [[ -e sde-external-9.0.0-2021-11-07-lin/sde64 ]] && env SDE_PATH="$PWD/sde-external-9.0.0-2021-11-07-lin/sde64" cargo auditable build --release -vv || cargo auditable build --release -vv

FROM --platform=$TARGETPLATFORM scratch as export-stage
COPY --from=builder /output /
