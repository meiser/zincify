LDAP_CONFIG = YAML.load_file("#{Rails.root.join("config/ldap.yml")}")[Rails.env]

