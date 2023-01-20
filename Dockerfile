FROM python:3.11.1-slim as base
# Base Apt
RUN apt-get update && apt-get install -y --no-install-recommends gcc

# Setup pipenv
FROM base AS python-deps
RUN pip install pipenv
COPY Pipfile .
COPY Pipfile.lock .
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy

# App
FROM base AS migration-app
COPY --from=python-deps /.venv /.venv
ENV PATH="/.venv/bin:$PATH"

ENV PYTHONDONTWRITEBYTECODE=1

WORKDIR /app
COPY . /app