# Usar una imagen base de Go
FROM golang:1.18 AS builder

# Establecer directorio de trabajo dentro de la imagen
WORKDIR /app

# Copiar los archivos go.mod y go.sum y descargar dependencias
COPY go.mod go.sum ./
RUN go mod download

# Copiar el código fuente de la aplicación
COPY . .

# Compilar la aplicación
RUN go build -o manager cmd/main.go

# Crear una imagen ligera para producción
FROM gcr.io/distroless/base

# Copiar el binario desde la imagen de compilación
COPY --from=builder /app/manager /manager

# Comando por defecto al ejecutar el contenedor
CMD ["/manager"]
