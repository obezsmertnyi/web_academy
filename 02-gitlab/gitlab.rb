### Job Artifacts
# gitlab_rails['artifacts_enabled'] = true
# gitlab_rails['artifacts_path'] = "/var/opt/gitlab/gitlab-rails/shared/artifacts"
####! Job artifacts Object Store
####! Docs: https://docs.gitlab.com/ee/administration/job_artifacts.html#using-object-storage
gitlab_rails['artifacts_object_store_enabled'] = true
gitlab_rails['artifacts_object_store_direct_upload'] = true
gitlab_rails['artifacts_object_store_background_upload'] = true
gitlab_rails['artifacts_object_store_proxy_download'] = true
gitlab_rails['artifacts_object_store_remote_directory'] = "artifacts"
gitlab_rails['artifacts_object_store_connection'] = {
'provider' => 'AWS',
'region' => 'eu-west-1',
'aws_access_key_id' => 'Z1Xh28dpKo0Oc9Xjjq35n0lCceGYxHmGwpibz2WQ9acLtiUTBHftVTKxcLiISSld',
'aws_secret_access_key' => 'ebRmMNRHh9R9ve869SkspkC3xMOyPBmo0FGhud4JqBZu7zjuiMCu36xn7aEVNEeT',
# # The below options configure an S3 compatible host instead of AWS
'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
'endpoint' => 'http: // minioaddress: 9000', # default: nil-Полезно для S3-совместимых сервисов, таких как DigitalOcean Spaces
'host' => 'localhost', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
'path_style' => true # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
}

### Git LFS
gitlab_rails['lfs_enabled'] = true
gitlab_rails['lfs_storage_path'] = "/var/opt/gitlab/gitlab-rails/shared/lfs-objects"
gitlab_rails['lfs_object_store_enabled'] = true
gitlab_rails['lfs_object_store_direct_upload'] = true
gitlab_rails['lfs_object_store_background_upload'] = true
gitlab_rails['lfs_object_store_proxy_download'] = true
gitlab_rails['lfs_object_store_remote_directory'] = "lfs-objects"
gitlab_rails['lfs_object_store_connection'] = {
'provider' => 'AWS',
'region' => 'eu-west-1',
'aws_access_key_id' => 'Z1Xh28dpKo0Oc9Xjjq35n0lCceGYxHmGwpibz2WQ9acLtiUTBHftVTKxcLiISSld',
'aws_secret_access_key' => 'ebRmMNRHh9R9ve869SkspkC3xMOyPBmo0FGhud4JqBZu7zjuiMCu36xn7aEVNEeT#',
# # The below options configure an S3 compatible host instead of AWS
'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
# 'endpoint' => 'https://s3.amazonaws.com', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
'host' => 'localhost',
 'endpoint' => 'http: // адрес мини-видео: 9000', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
'path_style' => true
# # 'path_style' => false # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
}

### GitLab uploads
###! Docs: https://docs.gitlab.com/ee/administration/uploads.html
gitlab_rails['uploads_storage_path'] = "/var/opt/gitlab/gitlab-rails/public"
gitlab_rails['uploads_base_dir'] = "uploads/-/system"
gitlab_rails['uploads_object_store_enabled'] = true
gitlab_rails['uploads_object_store_direct_upload'] = true
gitlab_rails['uploads_object_store_background_upload'] = true
gitlab_rails['uploads_object_store_proxy_download'] = true
gitlab_rails['uploads_object_store_remote_directory'] = "uploads"
gitlab_rails['uploads_object_store_connection'] = {
'provider' => 'AWS',
'region' => 'eu-west-1',
'aws_access_key_id' => 'Z1Xh28dpKo0Oc9Xjjq35n0lCceGYxHmGwpibz2WQ9acLtiUTBHftVTKxcLiISSld',
'aws_secret_access_key' => 'ebRmMNRHh9R9ve869SkspkC3xMOyPBmo0FGhud4JqBZu7zjuiMCu36xn7aEVNEeT',
# # # The below options configure an S3 compatible host instead of AWS
'host' => 'localhost',
'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
 'endpoint' => 'http: // minioaddress: 9000', # default: nil-Полезно для S3-совместимых сервисов, таких как DigitalOcean Spaces
'path_style' => true # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
}
