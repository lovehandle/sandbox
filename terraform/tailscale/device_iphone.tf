data "tailscale_device" "iphone" {
  name = "ryan-iphone.tailbebc53.ts.net"
}

resource "tailscale_device_authorization" "iphone" {
  device_id  = data.tailscale_device.iphone.id
  authorized = true
}

resource "tailscale_device_key" "iphone" {
  device_id           = data.tailscale_device.iphone.id
  key_expiry_disabled = true
}