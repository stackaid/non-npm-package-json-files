# non-npm-package-json-files
Get a collection of package.json files for non-NPM packages

# Requirements

* [Brew](https://brew.sh) (MacOSX)
* [Task](https://taskfile.dev)
* [SourceGraph CLI](https://docs.sourcegraph.com/cli)
* [SQLite](https://sqlite.org)
* [jq](https://stedolan.github.io/jq/)
* [xsv](https://github.com/BurntSushi/xsv)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

On MacOS:
```shell
brew install brew install go-task/tap/go-task && task brew:requirements
```

# Get Sourcegraph Access Token

Use the `src` CLI to see if you're authenticated:
```shell
task src:login
```

If you're not logged in, then you should see a link in the output for creating
an access token. Once you have an access token, put it in the `.env` file. It
should look like this:

```env
SRC_ACCESS_TOKEN=<your access token>
```

Once configured correctly, rerun `src:login` task to confirm your
configuration.

