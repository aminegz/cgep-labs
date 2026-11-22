output "bucket_arn" {
  description = "ARN of the primary data bucket."
  value       = aws_s3_bucket.primary.arn
}

output "bucket_name" {
  description = "Name of the primary data bucket."
  value       = aws_s3_bucket.primary.id
}

output "log_bucket_arn" {
  description = "ARN of the bucket that receives server access logs."
  value       = aws_s3_bucket.log.arn
}

output "encryption_algorithm" {
  description = "Server-side encryption algorithm in effect (SC-28 attestation)."
  value = one([
    for rule in aws_s3_bucket_server_side_encryption_configuration.primary.rule :
    rule.apply_server_side_encryption_by_default[0].sse_algorithm
  ])
}


output "control_mapping" {
  description = "NIST 800-53 control to implementing Terraform resource address."
  value = {
    "SC-28" = [
      "aws_s3_bucket_server_side_encryption_configuration.primary",
      "aws_s3_bucket_server_side_encryption_configuration.log",
    ]
    "SC-8" = [
      "aws_s3_bucket_policy.primary",
      "aws_s3_bucket_policy.log",
    ]
    "AC-3" = [
      "aws_s3_bucket_public_access_block.primary",
      "aws_s3_bucket_public_access_block.log",
      "aws_s3_bucket_ownership_controls.primary",
      "aws_s3_bucket_ownership_controls.log",
    ]
    "CP-9" = [
      "aws_s3_bucket_versioning.primary",
    ]
    "AU-2" = [
      "aws_s3_bucket_logging.primary",
      "aws_s3_bucket_policy.log",
    ]
  }
}