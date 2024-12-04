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

You will need [a GitHub account](https://github.com/join).

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
