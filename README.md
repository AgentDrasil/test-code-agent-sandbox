# Code Agent Sandbox

This repository is used to evaluate different coding agents using sandbox while running inside docker environments.

## Scenarios

Coding agents will run inside a Docker container. We will then evaluate the following sandbox approaches:

1. Replacing `bash` inside the Docker container with a wrapper script.
2. Using the official sandbox provided by the coding agent.

### Why these scenarios?

Most coding agents verify authentication during execution. Re-injecting authentication credentials might lead to your account being banned. Therefore, we must store the authentication within the coding agent's container. However, for security reasons, we cannot put both the tools and the authentication in the same container.

## Supported Coding Agents

- [Gemini CLI](https://geminicli.com/)
    - Tool Sandbox: Bubblewrap based, allow read only from "root". Not what we want. [link](https://github.com/google-gemini/gemini-cli/blob/6d7974f1/packages/core/src/sandbox/linux/bwrapArgsBuilder.ts#L54-L58)
    - Docker / Podman / Runsc: they all mount `~/.gemini` to sandbox, auth credentials still at risk. [link](https://github.com/google-gemini/gemini-cli/blob/6d7974f1effbe2a349e8d766e5cc5bd1874e1307/packages/cli/src/utils/sandbox.ts#L345-L348)
    - LXC: Only support use API Key to auth, and it will pass the key to container via Env.
    - fake bash:
        - gemini cli only try to resolve `bash` and use `bash` to run commands. [link](https://github.com/google-gemini/gemini-cli/blob/6d7974f1effbe2a349e8d766e5cc5bd1874e1307/packages/core/src/utils/shell-utils.ts#L663)
        - This works well for our usecase.
- [Claude Code](https://claude.com/product/claude-code)
    - fake bash:
        - claude code only try to resolve `bash` or `zsh`. Add the fake `bash` to PATH, or use `CLAUDE_CODE_SHELL` env to specify the shell. When claude code wants to run commands, it will execute `bash -c -l "..."`  to run commands.
    - Bubblewrap: can use `sandbox.filesystem.denyRead` to exclude unwanted file/dir.
- [OpenCode](https://github.com/anomalyco/opencode)
    - fake bash: works for opencode
- TODO: [Kilocode CLI](https://kilo.ai/docs/code-with-ai/platforms/cli)

## License

Apache License 2.0
