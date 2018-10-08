# Buzzwords

## About

Buzzwords is a very simple IRB tool that quickly displays a current list of up to 20 of the most frequently used terms in the American media's headlines.

## Installation

Install this gem via the console:

```
gem install buzzwords
```

## Usage

To generate the current buzzwords, open up IRB and require the Buzzwords gem.

`Buzzwords.generate_buzz` will display a current list of up to 20 of the top buzzwords found in headlines of major news outlets including The New York Times, Washington Post, CNN, and Reuters.

```
$ irb
irb(main):001:0> require 'buzzwords'
=> true
irb(main):002:0> Buzzwords.generate_buzz
Loading current buzzwords...
Today's top buzzwords are:
 - kavanaugh
 - trump
 - michael
 - hurricane
 # ... etc.
```

## License

The Buzzwords gem is available under the [MIT License](https://opensource.org/licenses/MIT).
