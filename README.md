# Camalian

[![Gem Version](https://badge.fury.io/rb/camalian.svg)](https://badge.fury.io/rb/camalian)
![Ruby](https://github.com/nazarhussain/camalian/workflows/build/badge.svg?branch=master) 
[![Maintainability](https://api.codeclimate.com/v1/badges/5495a2c122469d81b6c5/maintainability)](https://codeclimate.com/github/nazarhussain/camalian/maintainability)

Ruby gem to extract color palettes from images and play with their saturation

## Installation

Add this line to your application's Gemfile:

    gem 'camalian', '~> 0.1.1'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install camalian

## Usage

```ruby
image = Camalian::load('file_path')
colors = image.prominent_colors(15)
colors = colors.sort_similar_colors
colors.light_colors(0, 40)
```

You can find a working example with detail explanation and reference code here on [this link](https://basicdrift.com/color-extraction-library-build-color-search-engine-fdf369678d5a). Here we will build a functional color based image search engine in Ruby on Rails.

NOTE: Since its a compute intensive operation so for production use its suggested to use under a background job and not within a request/response cycle.

## Quantization Algorithms

Currently following algorithms are implemented.

### Histogram

Its a most common algorithm for color quantization and used different bucket technique to group the colors together. You can read more about this [technique here](https://en.wikipedia.org/wiki/Color_histogram). It can be accessed by `Camalian::QUANTIZATION_HISTOGRAM` constant. This is used as default method as well.

### K Means

This algorithm uses color distancing in RGB space to group the similar colors. You can learn more about this [technique here](https://en.wikipedia.org/wiki/K-means_clustering). It can be accessed by `Camalian::QUANTIZATION_K_MEANS` constant.  

### Median Cut

This algorithm uses color highest color range to determine the median and split colors to groups. The output consists of average color of such color groups.  Since these algorithm don't use actual colors and instead average, so you will may not exact matching pixel in the image. This algorithm is nice to be used with image compression, where similarity and compression is important than having same pixel colors. You can learn more about this [technique here](https://tpgit.github.io/UnOfficialLeptDocs/leptonica/color-quantization.html) . It can be accessed by `Camalian::QUANTIZATION_MEDIAN_CUT` constant.  


You can set default quantization method globally as: 

```ruby
Camalian.options[:quantization] = Camalian::QUANTIZATION_K_MEANS
```

or you can set at the time of extracting colors by.

```ruby
image = Camalian::load('file_path')
colors = image.prominent_colors(15, quantization: Camalian::QUANTIZATION_K_MEANS)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
