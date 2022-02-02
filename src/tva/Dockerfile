# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /app

# For db migration
ENV EF_VERSION 6.0.0
RUN dotnet tool install --global dotnet-ef --version $EF_VERSION
ENV PATH="/root/.dotnet/tools:${PATH}"

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . .
RUN dotnet publish -c Release -o out

# Creates an executable called efbundle 
RUN dotnet ef migrations bundle --self-contained

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 as aspnet
RUN apt update && apt install -y curl
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "LogApi.dll"]

FROM mcr.microsoft.com/dotnet/runtime:6.0 as db-migrator
COPY --from=build-env /app/efbundle /app/
ENTRYPOINT [ "/bin/bash", "-c", "./app/efbundle --verbose --connection \"${ConnectionStrings__KDVManagerChildManagementConnectionString}\" " ]

