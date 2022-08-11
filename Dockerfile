FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Install cultures (same approach as Alpine SDK image)
RUN apk add --no-cache icu-libs

# Disable the invariant mode (set in base image)
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-alpine AS build
WORKDIR /src
COPY ["src/Nager.Date/Nager.Date.csproj", "Nager.Date/"]
RUN dotnet restore "Nager.Date/Nager.Date.csproj"
#COPY ["src/Nager.Date.Website/Nager.Date.Website.csproj", "Nager.Date.Website/"]
#RUN dotnet restore "Nager.Date.Website/Nager.Date.Website.csproj"
#COPY ./src/ .
#WORKDIR "/src/Nager.Date.Website"
#RUN dotnet build "Nager.Date.Website.csproj" -c Release -o /app/build

#FROM build AS publish
#RUN dotnet publish "Nager.Date.Website.csproj" --runtime alpine-x64 -c Release -o /app/publish /p:PublishTrimmed=true

#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "Nager.Date.Website.dll"]
