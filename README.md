# Git Duo

- [home](https://github.com/teoljungberg/git-duo)
- [code](https://github.com/teoljungberg/git-duo)
- [bugs](https://github.com/teoljungberg/git-duo/issues)

# Description

A git porcelain for duo programming. Changes git-config's user.name and
user.email settings so you can commit as more than one author.

# Features/problems:

* Keep pairs per repository
* Import pairs between repositories
* Pairing made easy(-ier)
* Guess the base email from the paired users' email addresses

# Synopsis
```bash
$ git duo --email "board+%names@gotham.travel"
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
$ git duo --add "jim Jim Gordon <jim@gotham.travel>"
$ git duo alfred bruce jim
Alfred Pennyworth + Bruce Wayne + Jim Gordon <dev+alfred+bruce+jim@gotham.travel>
```

```bash
$ git duo --add "Jim Gordon <jim@gotham.travel>"
$ git duo jim alfred
Alfred Pennyworth + Jim Gordin <dev+alfred+jim@gotham.travel>
```

```bash
$ git duo alfred
Alfred Pennyworth <alfred@gotham.travel>
```

```bash
$ git duo --list
Bruce Wayne <bruce@gotham.travel>
Alfred Pennyworth <alfred@gotham.travel>
Jim Gordon <jim@gotham.travel>
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

# Requirements

* Ruby 1.9 and above
* Rake

# Install

* Clone down this repository
* Run `rake install`
* Good to go

# Developers

After checking out the source, run:

```bash
$ rake newb
```

This task will install any missing dependencies, the gem itself and
run the tests

## Autotest
* Install autotest (as a part of [ZenTest][zentest])
* Install [autotest-suffix][autotest-suffix] (since I prefer `foo_test.rb` to `test_foo.rb`)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[zentest]: https://github.com/seattlerb/ZenTest
[autotest-suffix]: https://github.com/blowmage/autotest-suffix/
