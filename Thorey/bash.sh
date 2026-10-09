#!/bin/bash

LOG_DIR="/home/ec2-user/services/admin-service/logs"
S3_BASE="s3://pfl-los-app-logs/pfl-los-prod-app2"

# Yesterday's date
LOG_DATE=$(date -d "yesterday" +%Y-%m-%d)

echo "=========================================="
echo "$(date)"
echo "Processing logs for: $LOG_DATE"
echo "=========================================="

aws s3 mv "$LOG_DIR/" \
    "$S3_BASE/admin-service/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "admin-service.${LOG_DATE}.*"

if [ $? -eq 0 ]; then
    echo "$(date) - Logs moved successfully to S3"
else
    echo "$(date) - ERROR: Failed to move logs to S3"
    exit 1
fi

############Api-gateway s3 logs rotates ################

API_GATEWAY_LOG_DIR="/home/ec2-user/services/api-gateway-service/logs"

echo "Processing api-gateway..."

aws s3 mv "$API_GATEWAY_LOG_DIR/" \
    "$S3_BASE/api-gateway/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "api-gateway.${LOG_DATE}.*.log.gz"

if [ $? -eq 0 ]; then
    echo "api-gateway: SUCCESS"
else
    echo "api-gateway: FAILED"
fi


echo "=========================================="
echo "Completed: $(date)"
echo "=========================================="


# ------------------------------------------
# Auth Service
# ------------------------------------------

AUTH_LOG_DIR="/home/ec2-user/services/auth-service/logs"

echo "Processing auth-service..."

aws s3 mv "$AUTH_LOG_DIR/" \
    "$S3_BASE/auth-service/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "auth-service.${LOG_DATE}.*.log.gz"

if [ $? -eq 0 ]; then
    echo "auth-service: SUCCESS"
else
    echo "auth-service: FAILED"
fi


echo "=========================================="
echo "Completed: $(date)"
echo "=========================================="


# ------------------------------------------
# Backend Service
# ------------------------------------------

AUTH_LOG_DIR="/home/ec2-user/services/backend-service/logs"

echo "Processing backend-service..."

aws s3 mv "$AUTH_LOG_DIR/" \
    "$S3_BASE/backend-service/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "backend-service.${LOG_DATE}.*.log.gz"

if [ $? -eq 0 ]; then
    echo "backend-service: SUCCESS"
else
    echo "backend-service: FAILED"
fi


echo "=========================================="
echo "Completed: $(date)"
echo "=========================================="


# ------------------------------------------
# Notfication Service
# ------------------------------------------

AUTH_LOG_DIR="/home/ec2-user/services/notification-service/logs"

echo "Processing notification-service..."

aws s3 mv "$AUTH_LOG_DIR/" \
    "$S3_BASE/notification-service/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "notification-service.${LOG_DATE}.*.log.gz"

if [ $? -eq 0 ]; then
    echo "notification-service: SUCCESS"
else
    echo "notification-service: FAILED"
fi


echo "=========================================="
echo "Completed: $(date)"
echo "=========================================="

# ------------------------------------------
# user-management-service
# ------------------------------------------

AUTH_LOG_DIR="/home/ec2-user/services/user-management-service/logs"

echo "Processing user-management-service..."

aws s3 mv "$AUTH_LOG_DIR/" \
    "$S3_BASE/user-management-service/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "UserService.${LOG_DATE}.*.log.gz"

if [ $? -eq 0 ]; then
    echo "UserService: SUCCESS"
else
    echo "UserService: FAILED"
fi


echo "=========================================="
echo "Completed: $(date)"
echo "=========================================="


# ------------------------------------------
# integration-service
# ------------------------------------------

AUTH_LOG_DIR="/home/ec2-user/services/integration-service/logs"

echo "Processing integration-service..."

aws s3 mv "$AUTH_LOG_DIR/" \
    "$S3_BASE/integration-service/$LOG_DATE/" \
    --recursive \
    --exclude "*" \
    --include "integration-service.${LOG_DATE}.*.log.gz"

if [ $? -eq 0 ]; then
    echo "integration-service: SUCCESS"
else
    echo "integration-service: FAILED"
fi


echo "=========================================="
echo "Completed: $(date)"
echo "=========================================="