# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Ruby gem that extends ActiveRecord with scope methods for ordering records by an explicit list of values. Adds `.order_by_ids` (for primary key ordering) and `.order_by` (for arbitrary column ordering) to ActiveRecord::Base.

## Commands

```bash
# Install dependencies
bin/setup

# Run tests
bundle exec rspec

# Run a single test file
bundle exec rspec spec/active_record/order_by_ids_spec.rb

# Run a specific test by line number
bundle exec rspec spec/active_record/order_by_ids_spec.rb:19

# Interactive console
bin/console

# Test against specific Rails versions (via Appraisal)
bundle exec appraisal rails-6.1 rspec
```

## Architecture

The gem is a single-file implementation (`lib/active_record/order_by_ids.rb`) that:
- Defines a module `ActiveRecord::OrderByIds` with two methods
- Extends `ActiveRecord::Base` with this module at load time
- Uses SQL `ORDER BY` with multiple fragments: first pushes non-matching/NULL values to the end, then orders matching values via reverse-mapped equality comparisons

Tests use an in-memory SQLite database with a dynamically-defined `User` model.
