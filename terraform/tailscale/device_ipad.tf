data "tailscale_device" "ipad" {
  name = "ryan-ipad.tailbebc53.ts.net"
}

resource "tailscale_device_authorization" "ipad" {
  device_id  = data.tailscale_device.ipad.id
  authorized = true
}

resource "tailscale_device_key" "ipad" {
  device_id           = data.tailscale_device.ipad.id
  key_expiry_disabled = true
}