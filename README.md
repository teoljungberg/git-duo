# Git Duo

https://github.com/teoljungberg/git-duo

# Description

A git porcelain for duo programming. Changes git-config's user.name and
user.email settings so you can commit as more than one author.

# Features/problems:

* Keep pairs per repository
* Import pairs between different repositories
* Pairing made easy(-ier)

# Synopsis
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
$ git duo --add "jim Jim Gordon <jim@gotham.travel>"
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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

# License

(The MIT License)

Copyright (c) 2013 FIX

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
S
