# frozen_string_literal: true

class AccessJob
  include SuckerPunch::Job

  def perform(minified_url)
    Url.increase_access(minified_url)
  end
end
