# PuntosPoint E-commerce

This project is a backend application designed for managing an e-commerce platform. It is built with Ruby on Rails 3.0 and uses PostgreSQL as the database.

## Overview

The application provides the following key functionalities:

- **Product Management**: Manage products, including multiple categories and images.
- **Category Management**: Create and manage product categories.
- **Purchase Tracking**: Record and track customer purchases.
- **Admin Users**: Admin users can manage resources and view reports of product purchases.
- **JWT Authentication**: Secure access to APIs using JSON Web Tokens (JWT).
- **Daily Reports**: Automatic daily reports for sales are generated using background jobs with Sidekiq.

## Prerequisites

Ensure that the following software is installed on your system:

- **Docker**: Used for building and running the containers.

## Getting Started

Follow these steps to set up and run the project in a Docker container:

### 1. Clone the Repository

First, clone this repository and navigate to the project directory:

```bash
git clone
cd puntospoint-ecommerce

### 2. Build the Docker Image

Run the following command to build the Docker image:

docker build -t puntospoint_ecommerce .

This command will create an image named puntospoint_ecommerce with all necessary dependencies, including Ruby, PostgreSQL, and Redis.

### 3. Run the Container

Start the container by running:

docker run -p 3000:3000 -p 5432:5432 -p 6379:6379 puntospoint_ecommerce

When the container starts, it will automatically:

- Set up the PostgreSQL database, including creating the development and test databases.
- Run database migrations.
- Seed the initial data, populating the database with sample data like admin users, products, and categories.
- Start the Rails server on port 3000.
- Start Redis on port 6379 for background jobs.
- This means that most of the setup and configuration, including database seeding, is handled automatically. You can access the application directly at http://localhost:3000/.