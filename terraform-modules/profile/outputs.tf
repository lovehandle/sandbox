output "id" {
  description = "The ID of the profile"
  value       = nextdns_profile.profile.id
}

output "profile_doh" {
  description = "The DNS over HTTPS address the profile is reachable at"
  value       = data.nextdns_setup_endpoint.profile.dot
}

output "profile_dot" {
  description = "The DNS over TLS address the profile is reachable at"
  value       = data.nextdns_setup_endpoint.profile.dot
}

output "profile_ipv6" {
  description = "The IPv6 address the profile is reachable at"
  value       = data.nextdns_setup_endpoint.profile.ipv6
}

output "profile_servers" {
  description = "The DNS servers available for the profile"
  value       = data.nextdns_setup_linkedip.profile.servers
}