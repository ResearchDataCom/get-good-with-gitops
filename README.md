# Get Good with GitOps

This tutorial will survey the technologies and techniques used in
GitOps, a versioned and immutable declaration of an information
system's desired state that's automatically deployed and continuously
reconciled.

Attendees will start by creating a small serverless web app using
Python, AWS Lambda, and AWS DynamoDB.  After deploying the first
version by hand, they will re-define the web app as an
infrastructure-as-code project using OpenTofu.  Attendees will review
pre-commit hooks, atomic commits, Conventional Commits, and Semantic
Versioning as they build their first continuous integration/continuous
delivery (CI/CD) pipeline in GitHub Actions.

To avoid breaking their new production web app, attendees will isolate
further development in Git feature branches.  They'll follow the
red-green-refactor pattern of test-driven development, and they'll
make sure that their production deployments reproduce what they
tested.  At each step, attendees will rely on their build tooling and
their CI/CD pipeline to reduce development and operational effort.
And at the end of the tutorial, attendees will evaluate different
deployment strategies and explore how they might adapt their test
scripts to continuously validate their production environments.

## Prerequisites

You will need [a GitHub account](https://github.com/signup).

You will need
[administrator access](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_administrator)
to an AWS account.  You should know how to use the
[AWS Management Console](https://aws.amazon.com/getting-started/hands-on/getting-started-with-aws-management-console/).

> [!CAUTION]
> This workshop should not exceed the limits of
> [the GitHub free plan](https://github.com/pricing#compare-features)
> or [the AWS Free Tier](https://aws.amazon.com/free/), but make sure
> to track and remove (or make private) the resources it creates.

It will help (but isn't required) to know
[how to program in Python](https://docs.python.org/3/tutorial/) and
[how to write HTML](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web).
It might also help to know
[how HTTP works](https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview).

You should be familiar with
[the Linux command line](https://ubuntu.com/tutorials/command-line-for-beginners)
and with [nano](https://youtu.be/DLeATFgGM-A) or
[vim](https://danielmiessler.com/p/vim/).  It will help (but isn't
required) to know
[how to use AWS CloudShell](https://youtu.be/p7POrgCbKWw).

You should know [how to use Git](https://gitimmersion.com/)
(init/add/commit) with GitHub (clone/push/pull).

## Tooling

Package managers aren't necessarily required, but they make installing
everything easier.

- Windows: [Chocolatey](https://chocolatey.org/),
  [WinGet](https://github.com/microsoft/winget-cli)

- macOS: [Hombrew](https://brew.sh/),
  [MacPorts](https://www.macports.org/)

  These require the Command Line Tools for Xcode, available from
  [the Apple Developer web site](https://developer.apple.com/download/all/),
  or Xcode, available from
  [the Mac App Store](https://itunes.apple.com/us/app/xcode/id497799835).

- Linux: Use the built-in package manager, e.g. APT on Debian/Ubuntu.

You will need to
[install and configure the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).
While not ideal,
[an IAM user with long-term credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html)
is easiest to set up.  Whatever you do, make sure the credentials you
use have
[administrator access](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_job-functions.html#jf_administrator).

Install [Git](https://git-scm.com/downloads) if you haven't already.

Install [the GitHub CLI](https://cli.github.com/) and log into your
account with the command `gh auth login`.  You can use the GitHub CLI
as [a Git credential helper](https://git-scm.com/docs/gitcredentials)
if you choose HTTPS as your preferred protocol for Git operations.
Complete the credential helper setup by running the command `gh auth
setup-git`.  Refer to GitHub's
[Authentication documentation](https://docs.github.com/en/authentication)
for more information.

This workshop specifically uses Python 3.12, the second most recent
Python release at the time this was written.  For further
instructions, refer to
[Relieving Your Python Packaging Pain](https://www.bitecode.dev/p/relieving-your-python-packaging-pain).

This workshop also uses
[OpenTofu](https://opentofu.org/docs/intro/install/), a
free/libre/open source software fork of Terraform.

While any OCI-compliant container runtime should work, this workshop
is designed around [Docker Desktop](https://www.docker.com/) (on
Windows and macOS) or
[Docker Engine](https://docs.docker.com/engine/install/) (on Linux).

Install [act](https://nektosact.com/installation/), which uses Docker
to simulate a GitHub Actions runner.  Download the included
[.actrc](.actrc) file and save it to your Windows user profile (e.g.,
`C:\Users\matthew`) or your macOS/Linux home directory (e.g.,
`/Users/matthew` or `/home/matthew`).

Download the `ubuntu-latest` container image ahead of the workshop by
running the command `docker pull --platform linux/amd64
ghcr.io/catthehacker/ubuntu:act-latest`.

Finally, install your favorite code editor.
[VSCodium](https://vscodium.com/) is a community-driven,
freely-licensed binary distribution of Microsoft Visual Studio Code.
