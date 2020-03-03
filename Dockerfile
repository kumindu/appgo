FROM golang:latest


# Add Maintainer Info
LABEL maintainer="Kumindu Ranawaka<kirlogapanet@gmail.com>"

# Move to /appgo directory as the place for resulting binary folder
WORKDIR /appgo

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download


# Copy the code into the container
COPY . .

# Build the application
RUN go build -o main .

# Export necessary port
EXPOSE 2000

# Command to run when starting the container
CMD ["/appgo/main"]
