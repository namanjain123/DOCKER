#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SQLPluginBot/SQLPluginBot/HindalcoGPT.Bot.csproj", "SQLPluginBot/SQLPluginBot/"]
COPY ["BusinessLayer/HindalcoGPT.BusinessLayer.csproj", "BusinessLayer/"]
COPY ["DatabaseLayer/HindalcoGPT.DataBase.csproj", "DatabaseLayer/"]
COPY ["SementicKernelLayer/HindalcoGPT.SementicKernelLayer.csproj", "SementicKernelLayer/"]
RUN dotnet restore "SQLPluginBot/SQLPluginBot/HindalcoGPT.Bot.csproj"
COPY . .
WORKDIR "/src/SQLPluginBot/SQLPluginBot"
RUN dotnet build "HindalcoGPT.Bot.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HindalcoGPT.Bot.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HindalcoGPT.Bot.dll"]