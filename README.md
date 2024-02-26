# Lythar Docker

## Setup

1. `git clone` the backend and frontend repos and configure it in `.env` like so
```env
# Make sure to use your own passwords!!
BACKEND_PATH=C:\Projects\lythar-backend
FRONTEND_PATH=C:\Projects\lythar-frontend
DB_PASSWORD=MVyZftfNhq4DAAVvSEpRPRi9m8oKNvrX

# LDAP Configuration
LDAP_ORGANISATION=Lythar
LDAP_DOMAIN=kyiro.me
LDAP_ADMIN_PASSWORD=FmrmFyBQdvseT3FNdHYNi4E9ZDXZ6djv
LDAP_ADMIN_DN="cn=admin,dc=kyiro,dc=me"
```
2. Secrets
    2. `secrets/jwt_private.pem` - The private key for the JWT
    3. `secrets/jwt_public.pem` - The public key for the JWT
3. Use `docker-compose up` to start the server
4. Configure LDAP using a tool like [Apache Directory Studio](https://directory.apache.org/studio/)
