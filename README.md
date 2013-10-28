# Git Duo

A git porcelain for duo programming. Changes git-config's user.name and
user.email settings so you can commit as more than one author.

## Installation

Add this line to your application's Gemfile:

    gem 'git-duo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install git-duo

## Usage

```bash
$ git duo --add "teo Teo Ljungberg <teo.ljungberg@mynewsdesk.com>"
$ git duo --add "billskog David Billskog <david.billskog@mynewsdesk.com>"
```

```bash
$ git duo teo billskog
David Billskog and Teo Ljungberg <dev+billskog+teo@mynewsdesk.com>
```

```bash
$ git duo teo billskog markus
David Billskog and Markus Nordin and Teo Ljungberg <dev+billskog+markus+teo@mynewsdesk.com>
```

```bash
$ git duo --email product@mynewsdesk.com
David Billskog and Teo Ljungberg <product+billskog+teo@mynewsdesk.com>
```

```bash
$ cd ../new-project
$ git duo --import ../mynewsdesk
# this will import the authors and email from the `mynewsdesk` project
# into `new-project`
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
