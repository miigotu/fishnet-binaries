FROM rust:1.62.1 AS builder
WORKDIR /fishnet
COPY $FISHNET_SOURCE .
RUN cargo build --release -vv && mkdir -p /output/$TARGETPLATFORM && mv /fishnet/target/release/fishnet /output/$TARGETPLATFORM/fishnet

FROM scratch as export-stage
COPY --from=builder /output .
