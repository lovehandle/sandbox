
data "nextdns_setup_endpoint" "profile" {
  profile_id = nextdns_profile.profile.id
}

data "nextdns_setup_linkedip" "profile" {
  profile_id = nextdns_profile.profile.id
}
