# PuntosPoint E-commerce

This project is a backend application designed for managing an e-commerce platform. It is built with Ruby 1.9.3 and Rails 3.0 and uses PostgreSQL as the [Database](#database-structure).

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Build the Docker Image](#2-build-the-docker-image)
  - [3. Run the Container](#3-run-the-container)
  - [4. Run Database Migrations](#4-run-database-migrations)
  - [5. Seed the Initial Data](#5-seed-the-initial-data)
- [Running Tests](#running-tests)
  - [1. RSpec Tests](#1-rspec-tests)
- [API Testing with Postman](#api-testing-with-postman)
  - [1. Import the Postman Collection](#1-import-the-postman-collection)
  - [2. Available Endpoints in the Collection](#2-available-endpoints-in-the-collection)
- [API Documentation](#api-documentation)
- [Database Structure](#database-structure)

## Overview

The application provides the following key functionalities:

- **Product Management**: Manage products, including multiple categories and images.
- **Category Management**: Create and manage product categories.
- **Purchase Tracking**: Record and track customer purchases.
- **Admin Users**: Admin users can manage resources and view reports of product purchases.
- **JWT Authentication**: Secure access to APIs using JSON Web Tokens (JWT).
- **Daily Reports**: Automatic daily reports for sales are generated using background jobs with Resque.
- **Change History Tracking**: Track and maintain a history of changes for models, allowing detailed versioning of records.

## Prerequisites

Ensure that the following software is installed on your system:

- **Docker**: Used for building and running the containers.
- **WSL (Windows Subsystem for Linux)**: Optional, but recommended for Windows users to improve compatibility and performance when working with Docker and Rails.

## Getting Started

Follow these steps to set up and run the project in a Docker container:

### 1. Clone the Repository

First, clone this repository:

```bash
git clone https://github.com/DavidRCHS/puntospoint-ecommerce.git
```
And navigate to the project directory
```bash
cd puntospoint-ecommerce
```

### 2. Build the Docker Image

Run the following command to build the Docker image:

```bash
docker build -t puntospoint_ecommerce .
```

This command will create an image named puntospoint_ecommerce with all necessary dependencies, including Ruby, PostgreSQL, and Redis.

### 3. Run the Container

Start the container by running:

```bash
docker run -d -p 3000:3000 -p 5432:5432 -p 6379:6379 --name puntospoint_container puntospoint_ecommerce
```
```bash
docker exec -it puntospoint_container /bin/bash
```
When the container starts, it will automatically
- Set up the PostgreSQL database, including creating the development and test databases.
- Start the Rails server on port 3000.
- Start Redis on port 6379 for background jobs.
- This means that most of the setup and configuration, including database seeding, is handled automatically. You can access the application directly at http://localhost:3000/.
Once the container is running, open a new terminal and execute the following commands to run the database migrations and seed the initial data:

### 4. Run database migrations:
Once the container is running, open a new terminal and execute the following commands inside the running container:
```bash
rake db:migrate
```
### 5. Seed the initial data:
Once the database migrations have been executed, you need to seed the initial data. This step populates the database with essential sample data such as admin users, products, categories, and other records necessary for testing and demonstrating the application’s functionality.

```bash
rake db:seed
```

## Running Tests
### 1. RSpec Tests
The project includes automated tests written in RSpec to ensure the functionality of various endpoints and models. To run the RSpec tests, use the following command inside the container:

Before running the tests, ensure that the test database is prepared:

```bash
RAILS_ENV=test rake db:migrate
```
To run the RSpec tests, use:

```bash
bundle exec rspec
```
This will execute the test suite and provide results for each test case, verifying that the application behaves as expected.

## API Testing with Postman
### 1. Import the Postman Collection
To test the API endpoints using Postman, a Postman collection has been provided. Follow these steps to import and run the collection:

Locate the Postman collection file in the repository at:

[docs/Ecommerce.postman_collection.json](https://github.com/DavidRCHS/puntospoint-ecommerce/tree/main/docs)

Open Postman, click on Import, and select the JSON file to import the collection.

Once the collection is imported, set up a collection variable named api-token.

You can generate the token by making a POST request to the /api/v1/auth/login endpoint using the provided login credentials.
Use the imported collection to test endpoints like product management, category management, purchases, and reports.

### 2. Available Endpoints in the Collection
The following endpoints are included in the Postman collection:

* Products
  - GET /api/v1/products: List all products.
  - GET /api/v1/products/most_purchased: Get the most purchased products.
  - GET /api/v1/products/top_revenue: Get the top revenue-generating products.
  - PUT /api/v1/products/
    : Update product details.
* Purchases
  - GET /api/v1/purchases: Filter purchases by date, category, customer, or admin.
  - GET /api/v1/purchases/count_by_granularity: Get purchase count by granularity.
* Categories
  - GET /api/v1/categories: List all categories.
* Model Record
  - GET /api/v1/versions: Get the history of changes for models like products.

## API Documentation

The API documentation is available on SwaggerHub. You can explore the endpoints, request/response formats, and other details at the following link:

[API Documentation on SwaggerHub](https://app.swaggerhub.com/apis-docs/DavidRobinsonSuclupeChamorro/Ecommerce/1.0.0)

## Database Structure
The above image represents the current structure of the database, including tables for products, categories, purchases, and other entities.
![db](https://github.com/user-attachments/assets/f2c679b2-48ef-45ac-ab72-e2a6ea2aa095)


