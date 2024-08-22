#####     S3 TESTS     #####

#   - Connects to the S3 bucket via AWS CLI and validates the content


S3_BUCKET_NAME="emr-mrjex"

CONTAINED_FILES=("files" "input" "output")
INCORRECT_FILES=("thisFolderIsInvalid" "NonExistentFolder" "MyInvalid3")


GREEN='\033[0;32m'
RED='\033[0;31m'
NO_COLOR='\033[0m'


getFolderStructure() {
    aws s3 ls "${S3_BUCKET_NAME}"
}


validateFolderStructure() {
    runTests "${CONTAINED_FILES[@]}"
    runTests "${INCORRECT_FILES[@]}"
}


# Takes an array as an argument --> Read all arguments into one
runTests() {
    ARR=("$@")

    for CURRENT_FILE in "${ARR[@]}"
        do
        OUTPUT=$(getFolderStructure | grep "${CURRENT_FILE}")
        
        # If the folder was found in the S3 bucket
        if [ ${#OUTPUT} -ge 1 ]; then
            echo -e "${GREEN}TEST PASSED:   File '${CURRENT_FILE}' was found${NO_COLOR}"
        else
            echo -e "${RED}TEST FAILED:   File '${CURRENT_FILE}' was not found${NO_COLOR}"
        fi
    done
}


validateFolderStructure
