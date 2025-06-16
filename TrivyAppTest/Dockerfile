# Stage 1: Build application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.csproj ./

RUN dotnet restore
COPY . .

# Publish the application. This compiles the project and prepares it for deployment.
# -c Release: Builds in Release configuration for optimized performance.
# -o out: Specifies the output directory for the published application within the container.
# --no-restore: Skips the restore step because we already did it.
RUN dotnet publish -c Release -o out --no-restore

# Stage 2: Create the final runtime image
# Use a smaller, production-ready .NET ASP.NET Runtime image.
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final
WORKDIR /app
COPY --from=build /src/out .

ENTRYPOINT ["dotnet", "TrivyAppTest.dll"]