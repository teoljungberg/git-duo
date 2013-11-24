# Git Duo

A git porcelain for duo programming. Changes git-config's user.name and
user.email settings so you can commit as more than one author.

## Installation

* Clone down this repository
* Run `rake install`
* Good to go

## Usage

```bash
$ git duo --email "board+%names@mynewsdesk.com"
```

```bash
$ git duo --add "bruce Bruce Wayne <bruce@gotham.travel>"
$ git duo --add "alfred Alfred Pennyworth <alfred@gotham.travel>"
```

```bash
$ git duo alfred bruce
Alfred Pennyworth + Bruce Wayne <board+alfred+bruce@gotham.travel>
```

```bash
$ git duo alfred bruce jim
Alfred Pennyworth + Bruce Wayne + Jim Gordon <dev+alfred+bruce+jim@gotham.traval>
```

```bash
$ git duo --email "law+%names@gotham.travel"
Alfred Pennyworth + Bruce Wayne <law+alfred+bruce@gotham.travel>
```

```bash
$ cd ../new-project
$ git duo --import ../old-project
# this will import the authors and email from the `old-project` project
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
