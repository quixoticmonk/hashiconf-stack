output "bucket_suffix" {
  description = "Random hex suffix for bucket names"
  value       = random_id.bucket_suffix.hex
}
