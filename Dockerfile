FROM ruby:1.9.3

# Repair error with public key of jessie
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://archive.debian.org/debian-security/ jessie/updates main\ndeb-src http://archive.debian.org/debian-security/ jessie/updates main" > /etc/apt/sources.list
# Update and install required packages.
RUN apt-get update && \
    apt-get install -y --force-yes build-essential libpq-dev nodejs webp \
    postgresql postgresql-contrib redis-server

# Modificar la autenticación temporalmente para permitir conexión sin contraseña
RUN sed -i "s/local   all             postgres                                peer/local   all             postgres                                trust/" /etc/postgresql/9.4/main/pg_hba.conf

# Iniciar PostgreSQL y establecer la contraseña para el usuario 'postgres'
RUN service postgresql start && \
    psql -U postgres -c "ALTER USER postgres PASSWORD 'postgres';"

# Revertir la autenticación a 'md5' para conexiones seguras
RUN sed -i "s/local   all             postgres                                trust/local   all             postgres                                md5/" /etc/postgresql/9.4/main/pg_hba.conf

# Crear un script SQL para crear las bases de datos
RUN echo "CREATE DATABASE puntospoint_ecommerce_development;" > /tmp/create_dbs.sql && \
    echo "CREATE DATABASE puntospoint_ecommerce_test;" >> /tmp/create_dbs.sql

# Ejecutar el script para crear las bases de datos
RUN service postgresql start && \
    PGPASSWORD=postgres psql -U postgres -f /tmp/create_dbs.sql

# Instalar Bundler versión 1.0.22, compatible con Rails 3.0
RUN gem install bundler -v '1.0.22'

# Crear directorio de trabajo para la aplicación
ENV APP_HOME /code
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copiar el Gemfile y el Gemfile.lock para instalar las dependencias
COPY Gemfile Gemfile.lock $APP_HOME/

# Instalar las gemas
RUN bundle install

# Copiar el código de la aplicación al directorio de trabajo
COPY . $APP_HOME

# Ejecutar Redis y PostgreSQL, luego ejecutar los seeds
CMD service postgresql start && \
    redis-server & \
    rails server -b 0.0.0.0
