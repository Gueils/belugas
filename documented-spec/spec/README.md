# Beluga (Feature Detection) Engine

This folder contains the definition of the Beluga (Feature Detection) Engine specification. This
includes technical details about how to implement a static analysis engine compatible with the
Beluga (Feature Detection) ecosystem of tools, including the ability to run it locally as well as on [Whales](https://github.com/IcaliaLabs/whales). See [SPEC.md](SPEC.md) for the actual specification.

## What is a Beluga (Feature Detection) Engine?

A _Beluga (Feature Detection) Engine_ is a static analysis module. Static analysis refers to the
act of deriving data from code without actually executing it. Beluga (Feature Detection) Engines
have been created to produce data about the project's features, such as programming languages,
frameworks, service dependencies, and functionality.

### What is the Beluga (Feature Detection) Engine spec?

The Beluga (Feature Detection) Engine spec describes a simple contract that must be followed to
ensure compatability with the rest of the tools in the Beluga (Feature Detection) static analysis
ecosystem. It defines several aspects of Engine operation including input, outputs, packaging, as
well as performance and security restrictions.

## What is the promise of the Beluga (Feature Detection) Engine spec?

Defining a simple specification that any static analysis tool can easily conform to make it possible
to integrate them all into a clear, unified workflow for developers. Engines can be run locally at
any time on developers' laptops on the command line, but can also be set up to run on Whales
automatically after every commit and Pull Request.

## What are some implementations of the spec?

The most mature implementations of the spec are:

* [beluga-linguist](https://github.com/IcaliaLabs/beluga-linguist)

## Working with the spec

To get started implementing an Engine, first install the
**[Beluga (Feature Detection) CLI](https://github.com/IcaliaLabs/beluga)**. Once that is installed,
build your Engine as a Docker image (see the Packaging section of the SPEC). When you are ready to
test it locally, run:

    $ beluga analyze --dev

The `--dev` flag will allow you to use the CLI with docker images that are in your local registry
but not yet officially released.
