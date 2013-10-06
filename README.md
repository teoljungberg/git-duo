# Git duet

A git porcelain for duet programming. Changes git-config's user.name and
user.email settings so you can commit as more than one author.

## Installation

Add this line to your application's Gemfile:

    gem 'git-duet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-duet

## Usage

```bash
$ git duet -add "teo Teo Ljungberg <teo.ljungberg@mynewsdesk.com>"
$ git duet -add "billskog David Billskog <david.billskog@mynewsdesk.com>"
```

```bash
$ git duet teo billskog
David Billskog and Teo Ljungberg <dev+billskog+teo@mynewsdesk.com>
```

```bash
$ git duet --email product@mynewsdesk.com
David Billskog and Teo Ljungberg <product+billskog+teo@mynewsdesk.com>
```

```bash
$ git solo
Teo Ljungberg <teo.ljungberg@gmail.com>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
