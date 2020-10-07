# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## Unreleased
### Changed
- Use shallow clone with truncated history ([#6](https://github.com/graphsense/btc-client/issues/6))
- Changed Docker base image to Ubuntu 20.04
- Updated Bitcoin Cash client to v0.22.3

## [0.4.4] 2020-06-12
### Changed
- Updated Bitcoin Cash client to v0.21.8

## [0.4.3] 2020-05-11
### Changed
- Removed deprecated `autotools` build system, replaced by `cmake`
- Upgraded Alpine Linux base image
- Added Docker Compose file

## [0.4.2] - 2019-12-19
### Changed
- Updated Bitcoin Cash client to v0.20.8
- Using --cap-drop all option in docker run command
- Removed invalid configuration value rpcclienttimeout

## [0.4.1] - 2019-06-28
### Changed
- Updated Alpine Linux base image (CVE-2019-5021)
- Updated Bitcoin Cash client to v0.19.8

## [0.4.0] - 2019-02-01
### Changed
- Updated Bitcoin Cash client to v0.18.7

## [0.3.3] - 2018-11-30
### Changed
- Updated Bitcoin Cash client to v0.18.5
