CONFIG_PATH="#{Rails.root}/config/config.yml"
GLOBAL = YAML.load_file(CONFIG_PATH)[Rails.env]