FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["eOpcina/eOpcina.csproj", "eOpcina/"]
RUN dotnet restore "eOpcina/eOpcina.csproj"
COPY . .
WORKDIR "/src/eOpcina"
RUN dotnet build "eOpcina.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "eOpcina.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "eOpcina.dll"]