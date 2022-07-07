---
title: getopt，参数解析
---

# getopt，参数解析

[Getopt Long Option Example (The GNU C Library)](https://www.gnu.org/software/libc/manual/html_node/Getopt-Long-Option-Example.html)

[Mead's Guide To getopt](https://azrael.digipen.edu/~mmead/www/Courses/CS180/getopt.html)

```c
static int parse_reset_cmd(struct reset_cmd *cmd, int argc, char *argv[])
{
	int option_index = 0;
	static struct option long_options[] = {
		{"start-lba", required_argument, NULL, RESET_CMD_FIELD_ZSLBA},
		{"select-all", no_argument, NULL, RESET_CMD_FIELD_SELECT_ALL},
		{"pcie-addr", required_argument, NULL, RESET_CMD_FIELD_PCIE_ADDR},

		{"help", no_argument, NULL, RESET_CMD_FIELD_HELP},
		{NULL, 0, NULL, 0}
	};

	memset(cmd, 0, sizeof(*cmd));

	while (true) {
		int c = getopt_long(argc, argv, "", long_options, &option_index);

		if (c == -1) {
			break;
		}

		switch (c) {
		case RESET_CMD_FIELD_ZSLBA:
			cmd->zslba = spdk_strtoll(optarg, 0);
			break;
		case RESET_CMD_FIELD_SELECT_ALL:
			cmd->select_all = true;
			break;
		case RESET_CMD_FIELD_PCIE_ADDR:
			snprintf(cmd->pcie_addr, PCIE_ADDR_LEN, "%s", optarg);
			break;
		case RESET_CMD_FIELD_HELP:
			usage_reset_cmd();
			return 1;
		default:
			SPDK_ERRLOG("unknown code=%d\n", c);
			return -1;
		}
	}

	return 0;
}
```