# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/spec'
require 'camalian'

PALLET_IMAGE_COLORS = %w[#4dd915 #49cc23 #45c031 #41b43f #3da84d #399c5b #359069 #318478 #2d7886 #296c94 #2560a2
                         #2154b0 #1d48be #193ccc #1530db].freeze
