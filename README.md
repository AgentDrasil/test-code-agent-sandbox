# Code Agent Sandbox

Evaluating and securing AI coding agents within isolated Docker environments.

## Overview

This repository explores different methods for sandboxing AI coding agents while they operate within Docker containers. The primary goal is to ensure that these agents can execute tools and commands safely without compromising the host environment or sensitive authentication credentials.

## The Security Challenge: Authentication vs. Isolation

Most modern coding agents (like Claude Code or Gemini CLI) require local authentication to function. They often store sensitive credentials (e.g., API keys, session tokens) in local directories like `~/.claude` or `~/.gemini`.

**The Dilemma:**
1.  **Risk of Exposure:** If the agent runs in a standard environment, it has access to these credentials. If the agent executes a malicious or buggy command, those credentials could be leaked or misused.
2.  **Sandbox Limitations:** Official sandboxes provided by some agents often attempt to mount the user's home directory to provide tools, which inadvertently exposes the very credentials we want to protect.
3.  **Credential Persistence:** Re-injecting credentials using a proxy for every execution is often blocked by agents to prevent automated abuse or account banning.

### Our Solution: The "Fake Bash" Strategy

To solve this, we implement a **Fake Bash Wrapper**. Instead of providing the real shell to the agent, we place a custom script named `bash` (or `zsh`) in the agent's `PATH`.

When the agent attempts to run a command (e.g., `bash -c "npm test"`), our wrapper:
1.  Intercepts the command.
2.  Proxies the execution to a separate, strictly isolated "tool sandbox" container.
3.  Returns the output back to the agent.

This ensures the agent (which holds the credentials) never actually executes code in its own environment.

## Supported Coding Agents

| Agent | Sandbox Strategy | Notes |
| :--- | :--- | :--- |
| **[Gemini CLI](https://geminicli.com/)** | Fake Bash | Gemini CLI resolves `bash` from `PATH` for command execution. Our wrapper effectively intercepts all tool calls. |
| **[Claude Code](https://claude.com/product/claude-code)** | Fake Bash / Bwrap | Claude Code uses `bash` or `zsh` (configurable via `CLAUDE_CODE_SHELL`). It also supports Bubblewrap for additional filesystem restrictions. |
| **[OpenCode](https://github.com/anomalyco/opencode)** | Fake Bash | A minimalist agent that works seamlessly with the shell wrapper approach. |
| **[Kilocode CLI](https://kilo.ai/docs/code-with-ai/platforms/cli)** | Fake Bash | A fork of OpenCode; inherits the same shell-based execution model. |

## Detailed Analysis

### Gemini CLI
- **Official Sandbox:** Uses Bubblewrap, but defaults to a read-only "root" which is often too restrictive or insufficiently isolated for specific workflows. [[Ref]](https://github.com/google-gemini/gemini-cli/blob/6d7974f1/packages/core/src/sandbox/linux/bwrapArgsBuilder.ts#L54-L58)
- **Docker/Podman:** Official implementations often mount `~/.gemini` into the sandbox, creating a credential leak risk. [[Ref]](https://github.com/google-gemini/gemini-cli/blob/6d7974f1effbe2a349e8d766e5cc5bd1874e1307/packages/cli/src/utils/sandbox.ts#L345-L348)
- **LXC:** Primarily relies on environment variables for API keys, which are still visible to processes within the container.
- **Fake Bash Support:** Gemini CLI resolves `bash` and uses it to run commands, making it ideal for our interception strategy. [[Ref]](https://github.com/google-gemini/gemini-cli/blob/6d7974f1effbe2a349e8d766e5cc5bd1874e1307/packages/core/src/utils/shell-utils.ts#L663)

### Claude Code
- **Shell Execution:** Executes commands via `bash -c -l "..."`.
- **Advanced Isolation:** Supports `sandbox.filesystem.denyRead` to explicitly blacklist sensitive directories within its own internal sandbox.

## Repository Structure

Each agent has its own directory containing:
- `docker/`: Dockerfiles for the agent's primary environment.
- `fake-bash/`: Implementation of the shell wrapper and the isolated tool sandbox.
- `no-sandbox-example/`: Reference implementation without additional security layers.

## License

Apache License 2.0
