# CHANGELOG

Issues are tracked at https://github.com/roberts1000/rubocop_plus/issues. Changes marked as **(Internal)** support development/refactoring.

## Next Release

1. [#87](../../issues/87): Add GitHub action workflow to check pull requests. **(Internal)**

## 1.4.0 (May 16, 2021)

1. [#64](../../issues/64): Use `pry` `~> 0.14.0`. **(Internal)**
1. [#66](../../issues/66): Update ruby & bundler versions in `.travis.yml`. **(Internal)**
1. [#68](../../issues/68): Make Ruby 2.6 the minimum supported version.
1. [#73](../../issues/73): Use `rake` `~> 13.0`. **(Internal)**
1. [#78](../../issues/78): Require `Pathname`.
1. [#83](../../issues/83): Use `rubocop_plus` `~> 2.0`. **(Internal)**

## 1.3.0 (Jan 13, 2020)

1. [#49](../../issues/49): Make `--order project` work.
1. [#55](../../issues/55): Add `--dir` and `--timestamp` output options.
1. [#57](../../issues/57): Redesign the `CHANGELOG.md`.

## 1.2.2 (Jun 22, 2019)

1. [#36](../../issues/36): Add instructions for installing `rspec_n` in project Gemfiles.
1. [#38](../../issues/38): Stop `--order rand` from being added to the final command when a custom order is specified.
1. [#41](../../issues/41): Remove locking to a specify version of Ruby in development. **(Internal)**
1. [#43](../../issues/43): Use pry 0.12.x for development. **(Internal)**

## 1.2.1 (Mar 06, 2019)

1. [#30](../../issues/30): Make `-v` and `--version` work again.

## 1.2.0 (Mar 03, 2019)

1. [#26](../../issues/26): Write the command that was used to run rspec_n to the output files.

## 1.1.0 (Mar 03, 2019)

1. [#19](../../issues/19): Add **Result Counts** column which shows the result counts for each run (e.g. "400 examples, 2 failures, 3 pending").
1. [#20](../../issues/20): Accept an optional path argument, that is passed to RSpec, to target specs (e.g. `rspec_n 3 spec/features/example_spec.rb`, `rspec_n spec/features/example_spec.rb:5`, `rspec_n spec/features 4`).
1. [#23](../../issues/23): Rename the `Result Counts` column to `Results` and remove the existing `Results` column.

## 1.0.0 (Feb 18, 2019)

1. [#1](../../issues/1): Add initial core logic.
1. [#4](../../issues/4): Add initial CLI.
1. [#5](../../issues/5): Write results of each iteration to a separate file.
1. [#6](../../issues/6): Add `-s` option to stop on first failure.
