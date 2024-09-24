#!/bin/bash
docker compose -f docker compose.yml -f env/dev.yml -f env/selenium.yml ps