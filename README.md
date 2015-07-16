## Bastet

[![Build Status](https://travis-ci.org/constXife/bastet.svg?branch=master)](https://travis-ci.org/constXife/bastet)
[![Code Climate](https://codeclimate.com/github/constXife/bastet/badges/gpa.svg)](https://codeclimate.com/github/constXife/bastet)
[![Test Coverage](https://codeclimate.com/github/constXife/bastet/badges/coverage.svg)](https://codeclimate.com/github/constXife/bastet/coverage)
[![Dependency Status](https://gemnasium.com/constXife/bastet.svg)](https://gemnasium.com/constXife/bastet)
[![Inline docs](http://inch-ci.org/github/constXife/bastet.png?branch=master)](http://inch-ci.org/github/constXife/bastet)

## Description

Web-interface for Intelligent House.

## Getting Started

1. Clone the project at the command prompt if you haven't yet:

        git clone https://github.com/constXife/bastet.git

2. At the command prompt, run the setup script:

        bin/setup

3. Modify config files in config folder. Then run db migrations:

        bin/rake db:create db:migrate db:seed

4. Run server:

        bin/rails s

5. Using a browser, go to `http://localhost:3000`

## License

[<img src="http://i.creativecommons.org/p/zero/1.0/88x31.png">](http://creativecommons.org/publicdomain/zero/1.0/).
