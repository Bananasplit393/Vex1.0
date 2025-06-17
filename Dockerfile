FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY TrivyAppTest/*.csproj ./TrivyAppTest/
RUN dotnet restore TrivyAppTest/TrivyAppTest.csproj
COPY TrivyAppTest/. ./TrivyAppTest/
WORKDIR /src/TrivyAppTest

# Publish the application. This compiles the project and prepares it for deployment.
# -c Release: Builds in Release configuration for optimized performance.
# -o out: Specifies the output directory for the published application within the container.
# --no-restore: Skips the restore step because we already did it.
RUN dotnet publish -c Release -o out --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS final
WORKDIR /app
COPY --from=build /src/TrivyAppTest/out .
ENTRYPOINT ["dotnet", "TrivyAppTest.dll"]
