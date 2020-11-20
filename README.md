# Camalian

Ruby gem to extract color palettes from images and play with their saturation

## Installation

Add this line to your application's Gemfile:

    gem 'camalian', '~> 0.1.0'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install camalian

## Usage

    image = Camalian::load('file_path')
    colors = image.prominent_colors(15)
    colors = colors.sort_similar_colors
    colors.light_colors(0, 40)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
