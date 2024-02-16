# Lythar Docker

## Setup

1. `git clone` the backend and frontend repos and configure it in `.env` like so
```env
BACKEND_PATH=C:\Projects\lythar-backend
FRONTEND_PATH=C:\Projects\lythar-frontend
```
2. Secrets
    1. `secrets/db_password.txt` - The password for the database`
    2. `secrets/jwt_private.pem` - The private key for the JWT
    3. `secrets/jwt_public.pem` - The public key for the JWT
2. Use `docker-compose up` to start the server

