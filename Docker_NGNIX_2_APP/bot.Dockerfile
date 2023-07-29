#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 3978
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["AnaplanProject_Bot/AnaplanProject_Bot.csproj", "AnaplanProject_Bot/"]
COPY ["AnaplanProject_AzureServices/AnaplanProject_AzureServices.csproj", "AnaplanProject_AzureServices/"]
COPY ["AnaplanProject_Business/AnaplanProject_Business.csproj", "AnaplanProject_Business/"]
COPY ["AnaplanProject_AnaplanDB_DataAccess/AnaplanProject_AnaplanDB_DataAccess.csproj", "AnaplanProject_AnaplanDB_DataAccess/"]
COPY ["AnaplanProject_Common/AnaplanProject_Common.csproj", "AnaplanProject_Common/"]
COPY ["AnaplanProject_Models/AnaplanProject_Models.csproj", "AnaplanProject_Models/"]
RUN dotnet restore "AnaplanProject_Bot/AnaplanProject_Bot.csproj"
COPY . .
WORKDIR "/src/AnaplanProject_Bot"
RUN dotnet build "AnaplanProject_Bot.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "AnaplanProject_Bot.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AnaplanProject_Bot.dll"]