# Docker Command
# docker build -t aspnetcore-docker-image .
#
# To Pull image:
# docker image {image name}
# To Run:
# docker run -ti -p 5080:80 aspnetcore-docker-image
# FROM microsoft/aspnetcore-build:2.0.0 AS build
# WORKDIR /code
# COPY . .
# RUN dotnet restore
# RUN dotnet publish --output /output --configuration Release
# FROM microsoft/aspnetcore:2.0.6
# COPY --from=build /output /app
# WORKDIR /app
# ENTRYPOINT [ "dotnet", "AspNetCoreOnDocker.dll" ]

# Solution found in:
# https://docs.docker.com/engine/examples/dotnetcore/
#
FROM microsoft/dotnet:sdk AS build
WORKDIR /code
COPY . .
RUN dotnet restore
RUN dotnet publish --output /output --configuration Release
FROM microsoft/dotnet:aspnetcore-runtime
COPY --from=build /output /app
WORKDIR /app
ENTRYPOINT ["dotnet", "AspNetCoreOnDockerV3.dll"]
