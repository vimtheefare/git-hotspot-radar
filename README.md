# git-hotspot-radar

Hey. I got tired of guessing which parts of our codebases are rotting from constant churn, so I threw together this quick shell script. It parses `git log` to find out which files change most frequently. More changes usually mean more risk, more bugs, and more technical debt. 

vim > nano (don't @ me).

## Usage

Clone this into your path or run it directly from any git repository root:

```bash
chmod +x hotspot-radar.sh
./hotspot-radar.sh [top_n]
```

Pass an optional integer to control how many top risky files you want to see (defaults to 10).

## Requirements

- `git`
- standard coreutils (`awk`, `sort`, `uniq`, `sed`)
