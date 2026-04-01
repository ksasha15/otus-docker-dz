FROM alpine:latest
RUN apk add --no-cache python3
WORKDIR /app
COPY index.html .
EXPOSE 8000
CMD ["python3", "-m", "http.server", "8000"]
