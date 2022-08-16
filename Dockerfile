FROM nager/nager-date:latest AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Install cultures (same approach as Alpine SDK image)
RUN apk add --no-cache icu-libs

# Disable the invariant mode (set in base image)
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["src/Nager.Date/Nager.Date.csproj", "Nager.Date/"]
RUN dotnet restore "Nager.Date/Nager.Date.csproj"
COPY ./src/ .
WORKDIR "/src/Nager.Date"
RUN dotnet build "Nager.Date.csproj" -c Release -o /app/build

FROM base AS final
WORKDIR /app
COPY --from=build /app/build .
ENTRYPOINT ["dotnet", "Nager.Date.Website.dll"]
