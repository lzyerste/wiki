---
title: valgrind
---

# valgrind

[How do I use valgrind to find memory leaks?](https://stackoverflow.com/questions/5134891/how-do-i-use-valgrind-to-find-memory-leaks)

```jsx
sudo apt install valgrind  # Ubuntu, Debian, etc.
sudo yum install valgrind  # RHEL, CentOS, Fedora, etc.
```

```jsx
valgrind --leak-check=full \
         --show-leak-kinds=all \
         --track-origins=yes \
         --verbose \
         --log-file=valgrind-out.txt \
         ./executable exampleParam1
```