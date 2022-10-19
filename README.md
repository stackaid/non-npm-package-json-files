# non-npm-package-json-files
Get a collection of package.json files for non-NPM packages

## Why?

We needed `package.json` files from real projects that aren't packages published to NPM. While
NPM can tell you the absolute usage of NPM packages in terms of download numbers, we were
interested in the set of dependencies that people were using together in a given project.

More details about how we used a sample of these package.json files to simulation for StackAid:
[StackAid in Beta](https://www.stackaid.us/blog/stackaid-in-beta)

## Requirements

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

## Get a Sourcegraph access token

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

## Query Sourcegraph

To query for all package.json files on GitHub that aren't in `node_modules` or directories such
as `test`, `fixture` or `examples`:

```shell
task src:query
```

The command will take about 1 minute and return just over 1M results. The results file in the data
directory: `./data/src_github_results.jsonl` and it should look like this:

```json lines
{"type":"path","path":"package.json","repository":"freeCodeCamp/freeCodeCamp","branches":[""],"commit":"382717cce4ea5593eb623ba5ef0bd47c534411d1"}
{"type":"path","path":"web/package.json","repository":"freeCodeCamp/freeCodeCamp","branches":[""],"commit":"382717cce4ea5593eb623ba5ef0bd47c534411d1"}
{"type":"path","path":"curriculum/package.json","repository":"freeCodeCamp/freeCodeCamp","branches":[""],"commit":"382717cce4ea5593eb623ba5ef0bd47c534411d1"}
{"type":"path","path":"tools/crowdin/package.json","repository":"freeCodeCamp/freeCodeCamp","branches":[""],"commit":"382717cce4ea5593eb623ba5ef0bd47c534411d1"}
{"type":"path","path":"tools/scripts/seed/package.json","repository":"freeCodeCamp/freeCodeCamp","branches":[""],"commit":"382717cce4ea5593eb623ba5ef0bd47c534411d1"}
```

To convert the file to a CSV:

```shell
task src:query:csv
```

The results will be in `./data/src_github_results.csv` and it should looks this this:

```csv
repo,commit_sha,path
freeCodeCamp/freeCodeCamp,382717cce4ea5593eb623ba5ef0bd47c534411d1,package.json
freeCodeCamp/freeCodeCamp,382717cce4ea5593eb623ba5ef0bd47c534411d1,web/package.json
freeCodeCamp/freeCodeCamp,382717cce4ea5593eb623ba5ef0bd47c534411d1,curriculum/package.json
freeCodeCamp/freeCodeCamp,382717cce4ea5593eb623ba5ef0bd47c534411d1,tools/crowdin/package.json
freeCodeCamp/freeCodeCamp,382717cce4ea5593eb623ba5ef0bd47c534411d1,tools/scripts/seed/package.json
```

## Debug Sourcegraph query

Try the [query](https://sourcegraph.com/search?q=context:global+file:%28%5E%7C/%29package.json%24+fork:no+-file:%28%5E%7C/%29%5C.+-file:%28%5E%7C/%29%28node_modules%7Ctest%7Ctests%7Cfixture%7Cfixtures%7Cexamples%29/+count:all+archived:no+-file:%28%5E%7C/%29vendor/+&patternType=standard) on Sourcegraph!
