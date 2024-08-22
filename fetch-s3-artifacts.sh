#####     FETCH S3 ARTIFACTS     #####

#   - Description here



S3_BUCKET_NAME="emr-masterclass-code-with-yu"
S3_OUTPUT_URI="s3://emr-masterclass-code-with-yu/output/"
S3_INPUT_URI="s3://emr-masterclass-code-with-yu/input/tripdata.csv"
S3_FILES_URI="s3://emr-masterclass-code-with-yu/files/spark-etl.py"
EMR_STEP_NAME="spark-step"



# As a practice for myself with the purpose of improving my Bash proficiencies,
# I coded two solutions for cloning the content of S3 buckets. Setting this variable
# to "Automatic" indicates that the 'aws s3 sync' command will be used (Amazon's CLI for
# cloning all content with ease). On the other hand, assigning this variable to "Manual"
# implies that each folder's content will be manually cloned
BUCKET_FETCH_TYPE="Automatic"



fetchInputArtifacts() {
    aws s3 cp "${S3_INPUT_URI}" input/trapdata.csv
}

fetchFileArtifacts() {
    aws s3 cp "${S3_FILES_URI}" files/spark-etl.py
}


fetchOutputArtifacts() {
    aws s3 cp "${S3_OUTPUT_URI}${EMR_STEP_NAME}/_SUCCESS" output/_SUCCESS
    aws s3 cp "${S3_OUTPUT_URI}${EMR_STEP_NAME}/part-00000-32e16303-acf7-494d-9601-7aee41219805-c000.snappy.parquet" output/part-00000-32e16303-acf7-494d-9601-7aee41219805-c000.snappy.parquet
}


# Copy the content of /output and save it as local files in this project
fetchArtifactsAutomatic() {
    aws s3 sync "s3://${S3_BUCKET_NAME}" .
}


fetchArtifactsManual() {
    fetchInputArtifacts
    fetchFileArtifacts
    fetchOutputArtifacts
}


fetchArtifacts() {
    cd s3-bucket && rm -rf *

    if [[ "${BUCKET_FETCH_TYPE}" == "Automatic" ]]; then
        fetchArtifactsAutomatic
    else
        fetchArtifactsManual
    fi

    cd ..
}



fetchArtifacts