#####     CONNECT     #####


EC2_KEY_PAIR="emr-mrjex-keypair.pem"
HADOOP_IP="hadoop@ec2-13-60-69-9"
REGION="eu-north-1"

SPARK_SCRIPT="spark-etl.py"

S3_BUCKET="emr-mrjex"
S3_OUTPUT_URI="s3://emr-mrjex/output/"



# Function:
#   - Text
#
# Context:
#   - Text
#
cloud9CLI() {
    ssh -i "${EC2_KEY_PAIR}" "${HADOOP_IP}.${REGION}.compute.amazonaws.com" # Enter primary node using SSH

    nano "${SPARK_SCRIPT}" # Create a .py file in the Cloud9CLI with the corresponding content
    ls && cat "${SPARK_SCRIPT}" # Double check that the file and its contents are valid

    spark-submit "${SPARK_SCRIPT}" "s3://${S3_BUCKET}/input/" "s3://${S3_BUCKET}/output/spark-cloud9CLI"
}



# Function:
#   - You as a developer need to create a 'Step' in the AWS Management Console as a 'Custom .jar' file
#     to invoke the spark submission via the corresponding S3 bucket's contained .py file
#
# Context:
#   - Open AWS Management Console and navigate to your desired EMR cluster. Create a new 'Step' as a
#     custom .jar file. This file will invoke the spark submission via the corresponding S3 bucket's
#     contained .py file. Lastly, paste the command below
s3ToEMR() {
    # spark-submit s3://emr-masterclass-code-with-yu/files/spark-etl.py s3://emr-masterclass-code-with-yu/input/tripdata.csv s3://emr-masterclass-code-with-yu/output/spark-EMR-Step
    spark-submit s3://${S3_BUCKET}/files/spark-etl.py s3://${S3_BUCKET}/input/tripdata.csv s3://${S3_BUCKET}/output/spark-EMR-Step
}



# Function:
#   - Eradicates all previously stored artifacts in a subfolder of a S3 bucket.
#     This function is useful when applied to the "/output" directory in the
#     context of this project, to avoid overriding new instances in prospective
#     executions that refer to the same output directory
#
deletePreviousOutput() {
    aws s3 rm "${S3_OUTPUT_URI}" --recursive
}