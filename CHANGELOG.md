# CHANGELOG

## Next Release

1. (Fix) Make `-v` and `--version` work again.  ([Issue #30](https://github.com/roberts1000/rspec_n/issues/30))

## 1.2.0 (Mar 03, 2019)

1. (New) Write the command that was used to run rspec_n to the output files.  ([Issue #26](https://github.com/roberts1000/rspec_n/issues/26))

## 1.1.0 (Mar 03, 2019)

1. (New) Add **Result Counts** column which shows the result counts for each run (e.g. "400 examples, 2 failures, 3 pending" ).  ([Issue #19](https://github.com/roberts1000/rspec_n/issues/19))
1. (New) Allow an optional path argument, that is passed to RSpec, to target specs (e.g. `rspec_n 3 spec/features/example_spec.rb`, `rspec_n spec/features/example_spec.rb:5`, `rspec_n spec/features 4`).  ([Issue #20](https://github.com/roberts1000/rspec_n/issues/20))
1. (New) Rename the `Result Counts` column to `Results` and remove the existing `Results` column.  ([Issue #23](https://github.com/roberts1000/rspec_n/issues/23))

## 1.0.0 (Feb 18, 2019)

1. (New) Add initial core logic. ([Issue #1](https://github.com/roberts1000/rspec_n/issues/1))
1. (New) Add initial CLI. ([Issue #4](https://github.com/roberts1000/rspec_n/issues/4))
1. (New) Write results of each iteration to a separate file.  ([Issue #5](https://github.com/roberts1000/rspec_n/issues/5))
1. (New) Add `-s` option to stop on first failure.  ([Issue #6](https://github.com/roberts1000/rspec_n/issues/6))
