# AWS BigData System

> Large-scale data processing with AWS EMR, Hadoop and Apache Spark

[![AWS](https://img.shields.io/badge/AWS-Cloud-orange)](https://aws.amazon.com/)
[![EMR](https://img.shields.io/badge/EMR-Big_Data-yellow)](https://aws.amazon.com/emr/)
[![Hadoop](https://img.shields.io/badge/Hadoop-Framework-blue)](https://hadoop.apache.org/)
[![Spark](https://img.shields.io/badge/Spark-Processing-red)](https://spark.apache.org/)
[![S3](https://img.shields.io/badge/S3-Storage-green)](https://aws.amazon.com/s3/)

## Table of Contents
- [AWS BigData System](#aws-bigdata-system)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [System Architecture](#system-architecture)
  - [Getting Started](#getting-started)
    - [Connect via Cloud9](#connect-via-cloud9)
    - [AWS EMR Step](#aws-emr-step)
  - [🔧 Automation Tools](#-automation-tools)
    - [Test Scripts](#test-scripts)
    - [Fetch Bucket Content](#fetch-bucket-content)
    - [Connection Utilities](#connection-utilities)
  - [💡 Technical Implementation](#-technical-implementation)
    - [ETL Process](#etl-process)
    - [IAM Configuration](#iam-configuration)
    - [Performance Considerations](#performance-considerations)

## Overview

This project, developed in August 2024, demonstrates the implementation of a scalable big data processing system using Amazon Web Services. It processes a dataset of 20000 records through an *ETL (Extract, Transform, Load)* pipeline.


## System Architecture

![architecture](readme-pictures/Y.%20Project%20Architecture.png)

Core Components:
- **Amazon S3**: Stores input data, code files, and processed output
- **Amazon EMR**: Manages the Hadoop ecosystem and executes Spark jobs
- **Apache Spark**: Performs data processing and transformation
- **AWS Cloud9**: Provides a development and management environment
- **Custom JAR Steps**: Enables automated processing workflow

## Getting Started

The system can be operated through two distinct approaches:

### Connect via Cloud9

Amazon Cloud9 provides a terminal environment for connecting to the EMR cluster's primary node:

![emr-ec2-cloud9-part1](readme-videos/1.A%20emr-ec2-cloud9-intro.mp4)

**Step-by-Step Process:**

1. **Open Cloud9 shell**
   - Navigate to AWS Cloud9 in your AWS Management Console
   - Open your environment

2. **Import EC2 key-pair**
   - Upload your `.pem` file to the Cloud9 environment
   - Set proper permissions: `chmod 400 emr-mrjex-keypair.pem`

3. **Connect to primary node**
   ```bash
   ssh -i emr-mrjex-keypair.pem hadoop@ec2-51-20-251-32.eu-north-1.compute.amazonaws.com
   ```

4. **Create Spark script**
   ```bash
   nano spark-etl.py
   ```
   - Add your ETL code to the file

![emr-ec2-cloud9-part2](readme-videos/1.B%20cloud9-artifacts.mp4)

5. **Submit Spark job**
   ```bash
   spark-submit spark-etl.py s3://emr-mrjex/input/tripdata.csv s3://emr-mrjex/output/spark
   ```

6. **Verify results**
   - Check the S3 bucket's `/output` directory for processed data

### AWS EMR Step

For automated processing, you can configure an EMR Step using a custom JAR:

![emr-step-artifacts](readme-videos/2.%20EMR-Step-Artifacts.mp4)

**Configuration Details:**

1. **Create a custom JAR Step**
   - Navigate to your EMR cluster in AWS Console
   - Add a step with the following command:

   ```
   spark-submit s3://emr-mrjex/files/spark-etl.py s3://emr-mrjex/input/tripdata.csv s3://emr-mrjex/output/spark-EMR-Step
   ```

2. **Monitor execution**
   - Track the step's progress in the EMR console
   - Check for success/failure status

## 🔧 Automation Tools

The project includes several bash scripts to streamline development and testing:

### Test Scripts
Validate S3 bucket connectivity and content structure:

![tests-2](readme-videos/4.%20S3-tests-shell-script.mp4)

### Fetch Bucket Content
Download S3 artifacts to your local environment:

![tests-1](readme-videos/3.%20Fetch-s3-shell-script.mp4)

### Connection Utilities
- `connect.sh`: Automates the SSH connection process
- `connect.txt`: Provides detailed connection instructions


## 💡 Technical Implementation

### ETL Process
The Spark ETL script performs several key operations:
- Data extraction from S3
- Schema validation and transformation
- Aggregation and analysis
- Results storage back to S3

### IAM Configuration
- EC2 instance roles configured with S3 access
- Permission boundaries for secure operation
- Cross-service authentication

### Performance Considerations
- Cluster sizing based on data volume
- Executor memory allocation
- Partition optimization
