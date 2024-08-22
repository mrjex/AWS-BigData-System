# Development Process

The implementation followed a structured approach:

### 1. Infrastructure Setup
- **VPC Configuration**
  ![vpc-emr](readme-pictures/1.%20vpc-emr-instance.PNG)

- **Security Group Rules**
  ![inbound-rules-ec2](readme-pictures/2.%20Add%20Inbound%20Rules%20for%20the%20Security%20group%20of%20EC2-instance.PNG)

### 2. S3 Integration
- **Bucket Organization**
  ![s3-connect-cloud](readme-pictures/4.%20s3-permission-fix.PNG)

### 3. Spark Processing
- **Output Generation**
  ![spark-output](readme-pictures/5.%20s3-spark-generated-output.PNG)

### 4. EMR Automation
- **Custom JAR Configuration**
  ![emr-custom-jar](readme-pictures/6.%20emr-custom-jar-step.PNG)

- **Processing Results**
  ![emr-step-completed](readme-pictures/7.%20emr-step-completed.PNG)
  ![emr-artifacts](readme-pictures/8.%20s3-generated-artifacts.PNG)
