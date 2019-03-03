# CHANGELOG

## Next Release

1. (New) Add **Result Counts** column which shows the result counts for each run (e.g. "400 examples, 2 failures, 3 pending" ).  (Issue #19)
1. (New) Allow an optional path argument, that is passed to RSpec, to target specs (e.g. `rspec_n 3 spec/features/example_spec.rb`, `rspec_n spec/features/example_spec.rb:5`, `rspec_n spec/features 4`).  (Issue #20)

## 1.0.0 (Sep 18, 2019)

1. (New) Add initial core logic. (Issue #1)
1. (New) Add initial CLI. (Issue #4)
1. (New) Write results of each iteration to a separate file.  (Issue #5)
1. (New) Add `-s` option to stop on first failure.  (Issue #6)
