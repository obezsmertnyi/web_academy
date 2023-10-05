# wget https://dl.minio.io/client/mc/release/linux-amd64/mc -O /usr/bin/mc
# chmod +x /usr/bin/mc
# mc --help
#!/bin/sh
# minio/mc container has Busybox Ash, be sure to be POSIX compliant and avoid Bash-isms
set -e ; # Have script exit in the event of a failed command.

# connectToMinio
# Use a check-sleep-check loop to wait for Minio service to be available
connectToMinio() {
  set -e ; # fail if we can't read the keys.
  MINIO_ENDPOINT="172.17.0.5" ;  # IP контейнера minio
  MINIO_PORT=9000 ;
  ACCESS="Z1Xh28dpKo0Oc9Xjjq35n0lCceGYxHmGwpibz2WQ9acLtiUTBHftVTKxcLiISSld" ;
  SECRET="ebRmMNRHh9R9ve869SkspkC3xMOyPBmo0FGhud4JqBZu7zjuiMCu36xn7aEVNEeT" ;
  set +e ; # The connections to minio are allowed to fail.
  echo "Connecting to Minio server: http://$MINIO_ENDPOINT:$MINIO_PORT" ;
  MC_COMMAND="mc config host add myminio http://$MINIO_ENDPOINT:$MINIO_PORT $ACCESS $SECRET" ;
  $MC_COMMAND ;
  STATUS=$? ;
  until [ $STATUS -eq 0 ] ;
  do
    sleep 1 ; # 1 second intervals between attempts
    $MC_COMMAND ;
    STATUS=$? ;
  done ;
  set -e ; # reset `e` as active
  return 0
}

# checkBucketExists ($bucket)
# Check if the bucket exists, by using the exit code of `mc ls`
checkBucketExists() {
  BUCKET=$1
  CMD=$(/usr/bin/mc ls myminio/$BUCKET > /dev/null 2>&1)
  return $?
}

# createBucket ($bucket, $policy, $purge)
# Ensure bucket exists, purging if asked to
createBucket() {
  BUCKET=$1
  POLICY=$2
  PURGE=$3


  # Purge the bucket, if set & exists
  # Since PURGE is user input, check explicitly for `true`
  if [ $PURGE = true ]; then
    if checkBucketExists $BUCKET ; then
      echo "Purging bucket '$BUCKET'."
      set +e ; # don't exit if this fails
      /usr/bin/mc rm -r --force myminio/$BUCKET
      set -e ; # reset `e` as active
    else
      echo "Bucket '$BUCKET' does not exist, skipping purge."
    fi
  fi

  # Create the bucket if it does not exist
  if ! checkBucketExists $BUCKET ; then
    echo "Creating bucket '$BUCKET'"
    /usr/bin/mc mb myminio/$BUCKET
  else
    echo "Bucket '$BUCKET' already exists."
  fi

  # At this point, the bucket should exist, skip checking for existance
  # Set policy on the bucket
  echo "Setting policy of bucket '$BUCKET' to '$POLICY'."
  /usr/bin/mc policy $POLICY myminio/$BUCKET
}

# connectToMinio
# createBucket registry none false
# createBucket git-lfs none false
# createBucket runner-cache none false
# createBucket uploads none false
# createBucket artifacts none false
# createBucket backups none false
# createBucket packages none false
# createBucket tmp none false
# createBucket pseudo none false
