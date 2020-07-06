local string = require("string")

local _M = {}

local X_IP_METADATA_HEADER = 'X-IP-Metadata'

local function build_header()
  return string.format(
    'asn:%s;anon:%s;anonVpn:%s;hostProvider:%s;pubProxy:%s;torExit:%s;countryCode:%s',
    ngx.var.geoip2_asn,
    ngx.var.geoip2_is_anonymous,
    ngx.var.geoip2_is_anonymous_vpn,
    ngx.var.geoip2_is_hosting_provider,
    ngx.var.geoip2_is_public_proxy,
    ngx.var.geoip2_is_tor_exit_node,
    ngx.var.geoip2_city_country_code
  )
end

function _M.rewrite()
  if ngx.var.geoip2_asn ~= nil and ngx.var.geoip2_asn ~= '' then
    local metadata_header = build_header()
    ngx.req.set_header(X_IP_METADATA_HEADER, metadata_header)
  end
end

return _M
