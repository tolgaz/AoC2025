#!/bin/bash

# Watch mode for running tests on file changes
echo "👀 Watching for changes... (Press Ctrl+C to stop)"
/opt/homebrew/lib/ruby/gems/3.4.0/bin/rerun --pattern "**/*.rb" --no-notify ruby solution_test.rb
