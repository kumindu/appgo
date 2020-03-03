FROM golang:1.12.0-alpine3.9

# Move to working directory /build
RUN mkdir /appgo
ADD . /appgo

# Copy and download dependency using go mod
COPY go.src .
COPY go.sum .
RUN go src download

# Copy the code into the container
COPY . .

# Build the application
RUN go build -o main .

# Move to /appgo directory as the place for resulting binary folder
WORKDIR /appgo

# Copy binary from build to main folder
RUN go build -o main .

# Export necessary port
EXPOSE 2000

# Command to run when starting the container
CMD ["/appgo/main"]
