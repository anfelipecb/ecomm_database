# E-Commerce Database

PostgreSQL schema and initialization scripts for the e-commerce platform.

## Structure

```
ecomm_database/
├── config/        # Schema and init scripts (init.sql)
├── src/           # Additional scripts (if needed)
├── tests/         # Test files
└── README.md
```

## Getting Started

1. Create a PostgreSQL database named `ecommerce`
2. Run the init script: `psql -U postgres -d ecommerce -f config/init.sql`

Or use Docker:

```bash
docker run -d --name ecomm-db -e POSTGRES_DB=ecommerce -e POSTGRES_PASSWORD=password -p 5432:5432 postgres:15
# Then run init.sql against the container
```

## Schema

- **products** - Product catalog (id, name, price, description, created_at)
- **orders** - Orders (id, product_id, quantity, total_price, status, created_at)

Line that adds a security patch to the database.