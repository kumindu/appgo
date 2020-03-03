FROM golang:1.13.0-stretch AS builder

ENV GO111MODULE=on

# Add Maintainer Info
LABEL maintainer="Kumindu Ranawaka<kirlogapanet@gmail.com>"

# Move to working directory /build
RUN mkdir /appgo

# Move to /appgo directory as the place for resulting binary folder
WORKDIR /appgo


# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

# Copy the code into the container
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Export necessary port
EXPOSE 2000

# Command to run when starting the container
CMD ["/appgo/main"]
