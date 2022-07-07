---
title: json
---

## bash输出简单json

[Output JSON from Bash script](https://stackoverflow.com/questions/12524437/output-json-from-bash-script)

```bash
printf '{"hostname":"%s","distro":"%s","uptime":"%s"}\n' "$hostname" "$distro" "$uptime"
```