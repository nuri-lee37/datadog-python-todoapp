FROM python:3.10.11
WORKDIR /demo
COPY --from=datadog/serverless-init:1 /datadog-init /app/datadog-init
COPY . .
RUN pip install -r requirements.txt
RUN pip install --target /dd_tracer/python/ ddtrace
ENV DD_SERVICE=datadog-demo-run-python
ENV DD_PROFILING_ENABLED=true
ENV DD_ENV=datadog-demo
ENV DD_VERSION=1
ENTRYPOINT ["/app/datadog-init"]
CMD ["/dd_tracer/python/bin/ddtrace-run", "python", "main.py"]
