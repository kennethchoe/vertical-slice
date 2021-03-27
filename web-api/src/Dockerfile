#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY [".", "."]
RUN dotnet restore "web-api.sln"
WORKDIR "/src/web-api"
RUN dotnet build "web-api.csproj" -c Release -o /app/build
RUN dotnet publish "web-api.csproj" -c Release -o /app/publish


FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=build /app/publish .

# https://github.com/dotnet/dotnet-docker/issues/1109, allow connecting to lower TLS version
RUN sed -i 's/TLSv1.2/TLSv1.0/g' /etc/ssl/openssl.cnf

# if you can install certificate on final image, you can expose https also.
# ENV ASPNETCORE_URLS=https://+:443;http://+:80

ENTRYPOINT ["dotnet", "web-api.dll"]