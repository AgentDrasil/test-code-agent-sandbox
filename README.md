# Code Agent Sandbox

This repository is used to evaluate different coding agents using sandbox while running inside docker environments.

## Scenarios

Coding agents will run inside a Docker container. We will then evaluate the following sandbox approaches:

1. Replacing `bash` inside the Docker container with a wrapper script.
2. Using the official sandbox provided by the coding agent.

### Why these scenarios?

Most coding agents verify authentication during execution. Re-injecting authentication credentials might lead to your account being banned. Therefore, we must store the authentication within the coding agent's container. However, for security reasons, we cannot put both the tools and the authentication in the same container.

## Supported Coding Agents

1. [Gemini CLI](https://geminicli.com/)
    - Docker / Podman / Runsc: they all mount `~/.gemini` to sandbox, auth credentials still at risk. [link](https://github.com/google-gemini/gemini-cli/blob/6d7974f1effbe2a349e8d766e5cc5bd1874e1307/packages/cli/src/utils/sandbox.ts#L345-L348)
    - LXC: TODO
2. TODO: [Claude Code](https://claude.com/product/claude-code)
3. TODO: [OpenCode](https://github.com/anomalyco/opencode)
4. TODO: [Kilocode CLI](https://kilo.ai/docs/code-with-ai/platforms/cli)

## License

Apache License 2.0
