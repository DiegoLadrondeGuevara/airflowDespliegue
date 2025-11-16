# Imagen base oficial de Airflow
FROM apache/airflow:2.5.0-python3.9

# Cambiar al usuario root para instalar paquetes del sistema
USER root

# Instalar SQLite (por si no está incluido)
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev

# Volver al usuario airflow
USER airflow

# Establece el directorio de trabajo
WORKDIR /opt/airflow

# Copiar los DAGs y requirements
COPY ./dags /opt/airflow/dags
COPY ./requirements.txt /opt/airflow/requirements.txt

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r /opt/airflow/requirements.txt

# Establecer Airflow Home
ENV AIRFLOW_HOME=/opt/airflow

# Exponer el puerto de la UI
EXPOSE 8080

# Importante: NO ejecutar webserver y scheduler aquí
# Se ejecutarán en ECS Task Definitions
