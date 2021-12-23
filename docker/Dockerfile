FROM alpine:latest as certs
RUN apk --update add ca-certificates

RUN mkdir -p /tmp

FROM scratch

ARG USER_UID=10001
USER ${USER_UID}

COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY otelcol /otelcol
COPY config.yaml /etc/otel/config.yaml
ENTRYPOINT ["/otelcol"]
CMD ["--config", "/etc/otel/config.yaml"]
EXPOSE 4317 55678 55679
