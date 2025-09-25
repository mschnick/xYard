# justfile

# Run dev DB and apply migrations
dev-db: start_podman
  podman-compose up -d
  dotnet ef database update --startup-project backend/EveSilo.Api -- --environment Development

# Run prod DB and apply migrations
prod-db: start_podman
  podman-compose up -d
  dotnet ef database update --startup-project backend/EveSilo.Api -- --environment Production

# Reset für DEV-Datenbank (idempotent)
db-reset-dev:
  @echo "⛏️  Resetting DEV database volume…"
  # 1) DEV-Container stoppen/entfernen (ignoriert Fehler, falls nicht vorhanden)
  -podman stop evesilo_db_dev
  -podman rm -f evesilo_db_dev
  # 2) Alle Container killen, die das Volume noch halten (falls der Name anders war)
  -for id in $$(podman ps -a -q --filter volume=evesilo_db_data_dev); do podman rm -f $$id; done
  # 3) Volume löschen (jetzt sollte es frei sein)
  -podman volume rm evesilo_db_data_dev
  # 4) DEV-DB frisch starten
  podman-compose up -d db-dev
  # 5) Optional: DB migrieren / seeden
  just dev-db

# 🛑 Sicherungsabfrage vor dem Zurücksetzen der PROD-Datenbank
db-reset-prod CONFIRM='':
  @echo "DEBUG: Got CONFIRM='{{CONFIRM}}'"
  @if [ '{{CONFIRM}}' != 'DELETE_PROD' ]; then \
    echo "🛑 To reset the production DB, run:"; \
    echo "    just db-reset-prod DELETE_PROD"; \
    echo "❌ Aborting."; \
    exit 1; \
  fi
  @echo "✅ Confirmation received. Resetting production database volume..."
  podman-compose stop db-prod
  podman volume rm evesilo_db_data_prod
  podman-compose up -d db-prod

# Apply migrations
migrate MIGRATION:
  echo "Creating EF migration: {{MIGRATION}}"
  dotnet ef migrations add {{MIGRATION}} \
    --project Core.Data \
    --startup-project backend/EveSilo.Api

update-db:
  echo "Updating database"
  dotnet ef database update \
    --project Core.Data \
    --startup-project backend/EveSilo.Api

# Startet die Podman-VM nur, wenn sie nicht läuft
start_podman:
  podman machine inspect podman-machine-default | grep "State" | grep running > /dev/null || podman machine start
  

backend-dev: start_podman
  ASPNETCORE_ENVIRONMENT=Development ASPNETCORE_URLS=http://localhost:5123 dotnet run --no-launch-profile --project backend/EveSilo.Api

backend-prod:
  bash -c 'podman machine start || [ $$? -eq 125 ]'
  echo "Updating database"
  ASPNETCORE_ENVIRONMENT=Production  dotnet ef database update     --project Core.Data     --startup-project backend/EveSilo.Api
  echo "Starting backend"
  ASPNETCORE_ENVIRONMENT=Production ASPNETCORE_URLS=http://localhost:5123 dotnet run --no-launch-profile --project backend/EveSilo.Api



frontend:
    npm --prefix frontend run dev
