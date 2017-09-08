# frozen_string_literal: true

$redis = Redis::Namespace.new('randyurl', redis: Redis.new)
