module VersionsHelper
  def yaml(y)
    YAML.load(y) if y
  end
end