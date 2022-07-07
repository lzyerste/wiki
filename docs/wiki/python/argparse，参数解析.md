---
title: argparse，参数解析
---

# argparse，参数解析

- 注意bool不能直接解析
    - [https://stackoverflow.com/questions/52403065/argparse-optional-boolean](https://stackoverflow.com/questions/52403065/argparse-optional-boolean)
    - [https://stackoverflow.com/questions/41655897/why-is-argparse-not-parsing-my-boolean-flag-correctly](https://stackoverflow.com/questions/41655897/why-is-argparse-not-parsing-my-boolean-flag-correctly)
- args转dict
    - vars(args)
    - [https://stackoverflow.com/questions/27181084/how-to-iterate-over-arguments](https://stackoverflow.com/questions/27181084/how-to-iterate-over-arguments)
- parse_known_args，解析一部分，剩余一部分，比如交给unittest。
- 别名，alias
    - [https://stackoverflow.com/questions/50896992/argparse-add-argument-alias](https://stackoverflow.com/questions/50896992/argparse-add-argument-alias)
    
    ```python
    # 实际内部使用的是第一个参数foo
    parser.add_argument('--foo', '--bar', ...)
    ```