##        ##
## SHARED ##
##        ##
oci_config_profile = "/home/chad/.oci/config"
oci_root_compartment = "ocid1.tenancy.oc1..aaaaaaaaCHANGE_ME_CHANGE_ME_CHANGE_ME"
oci_region = "us-ashburn-1"
oci_adnumber = 1
ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCNCHANGE_ME_CHANGE_ME_CHANGE_ME"
client_cidrs = []
vcn_cidr = "10.10.12.0/24"

##            ##
## CLOUDBLOCK ##
##            ##
# The cb_mgmt_cidr permits firewall access to pihole web console, ssh, and direct DNS lookups (if dns_novpn = 1) without wireguard
cb_mgmt_cidr = "1.2.3.4/32"
ph_prefix = "cloudblock"
ph_password = "changeme0"
wireguard_peers = 20
doh_provider = "opendns"
vpn_traffic = "dns"
dns_novpn = 1
# See image ID note at bottom of this page
cb_oci_instance_shape = "VM.Standard.E2.1.Micro"
cb_oci_instance_ocpus = 1
cb_oci_instance_memgb = 1
cb_oci_instance_diskgb = 50
cb_oci_imageid = "ocid1.image.oc1.iad.aaaaaaaascyqvxuxse7kgqtu4go2fazlxqjhq4p4p2rromclajqglaqfyhlq"
cb_project_url = "https://github.com/chadgeary/cloudblock"
cb_docker_network = "172.18.0.0"
cb_docker_gw = "172.18.0.1"
cb_docker_doh = "172.18.0.2"
cb_docker_pihole = "172.18.0.3"
cb_docker_wireguard = "172.18.0.4"
cb_docker_webproxy = "172.18.0.5"
cb_wireguard_network = "172.19.0.0"

##             ##
## CLOUDOFFICE ##
##             ##
# The co_mgmt_cidr permits firewall access to nextcloud/onlyoffice and ssh. 0.0.0.0/0 makes this accessible anywhere.
co_mgmt_cidr = "1.2.3.4/32"
nc_prefix = "cloudoffice"
admin_password = "changeme1"
db_password = "changeme2"
oo_password = "changeme3"
web_port = "443"
oo_port = "8443"
# See image ID note at bottom of this page
co_oci_imageid = "ocid1.image.oc1.iad.aaaaaaaayat6mdwvukpjnffxjwcfgbrq7qehcydfnjdhyyuosq6awzqucdia"
co_oci_instance_shape = "VM.Standard.A1.Flex"
co_oci_instance_ocpus = 4
co_oci_instance_memgb = 24
co_oci_instance_diskgb = 150
co_project_url = "https://github.com/chadgeary/cloudoffice"
co_docker_network = "172.18.1.0"
co_docker_gw = "172.18.1.1"
co_docker_nextcloud = "172.18.1.2"
co_docker_webproxy = "172.18.1.3"
co_docker_db = "172.18.1.4"
co_docker_onlyoffice = "172.18.1.6"
co_docker_duckdnsupdater = "172.18.1.7"

# Optionally create a domain (and token) @ duckdns.org for LetsEncrypt signed/auto-renewed HTTPS certificates.
# enable_duckdns must be set to 1
# duckdns_domain should be something like "mycloudoffice.duckdns.org"
# use a valid email address to get alerts if your certificate renewal ever encounters problems.
enable_duckdns    = 0
duckdns_domain    = ""
duckdns_token     = "123456789-XXXX-XXXX-XXXX-XXXXXXXXX"
letsencrypt_email = "changeme@changeme.com"

# image ID note - run this command to get image ids in your region:
# OCI_TENANCY_OCID=$(oci iam compartment list --all --compartment-id-in-subtree true --access-level ACCESSIBLE --include-root --raw-output --query "data[?contains(\"id\",'tenancy')].id | [0]") && oci compute image list --compartment-id $OCI_TENANCY_OCID --all --lifecycle-state 'AVAILABLE' --operating-system "Canonical Ubuntu" --operating-system-version "20.04" --sort-by "TIMECREATED" | grep 'display-name\|ocid'

# keep in mind OnlyOffice does not work on ARM and will not be installed if that image id is chosen for cloudoffice but nextcloud runs very well on 4 ocpu/24 memgb compared to 1 ocpu/1 memgb.
# For free tier, VM.Standard.E2.1.Micro is always 1 ocpu and 1 memgb. VM.Standard.A1.Flex (ARM) can be up to 4 ocpu and 24 memgb.
