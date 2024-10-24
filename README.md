# PuntosPoint E-commerce

This project is a backend application designed for managing an e-commerce platform. It is built with Ruby on Rails 3.0 and uses PostgreSQL as the database.

## Overview

The application provides the following key functionalities:

- **Product Management**: Manage products, including multiple categories and images.
- **Category Management**: Create and manage product categories.
- **Purchase Tracking**: Record and track customer purchases.
- **Admin Users**: Admin users can manage resources and view reports of product purchases.
- **JWT Authentication**: Secure access to APIs using JSON Web Tokens (JWT).
- **Daily Reports**: Automatic daily reports for sales are generated using background jobs with Resque.

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
docker run -p 3000:3000 -p 5432:5432 puntospoint_ecommerce
```

When the container starts, it will automatically
- Set up the PostgreSQL database, including creating the development and test databases.
- Start the Rails server on port 3000.
- Start Redis on port 6379 for background jobs.
- This means that most of the setup and configuration, including database seeding, is handled automatically. You can access the application directly at http://localhost:3000/.
Once the container is running, open a new terminal and execute the following commands to run the database migrations and seed the initial data:

### 4. Start Redis
Redis must be started manually in a separate terminal. To start Redis, run the following command:

```bash
redis-server
```
### 5. Run database migrations:
Once the container is running, open a new terminal and execute the following commands inside the running container:
```bash
rake db:migrate
```
### 6. Seed the initial data:
Once the database migrations have been executed, you need to seed the initial data. This step populates the database with essential sample data such as admin users, products, categories, and other records necessary for testing and demonstrating the application’s functionality.

```bash
rake db:seed
```
