resource "tailscale_dns_preferences" "prefs" {
  magic_dns = true
}

resource "tailscale_dns_nameservers" "ns" {
  nameservers = [
    "45.90.28.27",
    "45.90.30.27",
    "2a07:a8c0::b2:7451",
    "2a07:a8c1::b2:7451"
  ]
}

resource "tailscale_dns_search_paths" "sp" {
  search_paths = []
}
