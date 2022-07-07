---
title: "ALGO_ALL_IN_ONE"
---

[TOC]

| URL      |      |
| -------- | ---- |
| **难度** |      |
| **标签** |      |



# 资源

* 《算法导论》
* 《算法4》
* https://cp-algorithms.com/
* http://jeffe.cs.illinois.edu/teaching/algorithms/

# ---------------- 数据结构 ----------------

# 链表，list

# 栈，stack

# 树，tree

## 字典树，trie

### 实现

### 720. 词典中最长的单词

| URL      | https://leetcode-cn.com/problems/longest-word-in-dictionary/ |
| -------- | ------------------------------------------------------------ |
| **难度** | 简单                                                         |
| **标签** | Trie, Hash Table                                             |

给出一个字符串数组words组成的一本英语词典。从中找出最长的一个单词，该单词是由words词典中其他单词逐步添加一个字母组成。若其中有多个可行的答案，则返回答案中字典序最小的单词。

若无答案，则返回空字符串。



示例 1：

```python
输入：
words = ["w","wo","wor","worl", "world"]
输出："world"
解释： 
单词"world"可由"w", "wo", "wor", 和 "worl"添加一个字母组成。
```

示例 2：

```python
输入：
words = ["a", "banana", "app", "appl", "ap", "apply", "apple"]
输出："apple"
解释：
"apply"和"apple"都能由词典中的单词组成。但是"apple"的字典序小于"apply"。
```


提示：

所有输入的字符串都只包含小写字母。
words数组长度范围为[1,1000]。
words[i]的长度范围为[1,30]。

---

思路一：暴力法

```python
class Solution:
    def longestWord(self, words: List[str]) -> str:
        G = set(words)
        words.sort(key=lambda x: (len(x), x))
        H = set()
        for w in words:
            if len(w) == 1:
                H.add(w)
            elif w[:-1] in H:
                H.add(w)
        
        def cmp(x, y):
            if len(x) != len(y):
                return len(x) - len(y)
            if x == y:
                return 0
            return 1 if x < y else -1
        
        if len(H) == 0:
            return ""
 
        H = list(H)
        MAX = H[0]
        for w in H:
            if cmp(MAX, w) < 0:
                MAX = w
        return MAX
```

简短写法：

```python
class Solution(object):
    def longestWord(self, words):
        wordset = set(words)
        words.sort(key = lambda c: (-len(c), c))
        for word in words:
            if all(word[:k] in wordset for k in xrange(1, len(word))):
                return word
 
        return ""
```

---

思路二：字典树

# 堆，heap

# 哈希表，hash table

# 字符串，string

# 图，graph

# 并查集，UF，union find

# ---------------- 算法部分----------------

# 排序，sort

# 分治法，divide & conquer

# 贪心法，greedy

# 动态规划，DP，dynamic programming

# 回溯算法，backtracking

# 二分搜索，binary search

# 双指针，two pointers

# 滑动窗口，sliding window

# 位运算，binary

# 数学，math

## 几何

### 线段重叠：1282A. Temporarily unavailable

| URL      | http://codeforces.com/contest/1282/problem/A |
| -------- | -------------------------------------------- |
| **难度** | 简单，900                                    |
| **标签** | math                                         |

题目见原文链接，最终就是线段重叠问题。

题解：

> To get an answer, we need to subtract from the whole time the time that we will be in the coverage area. Let the left boundary of the cover be $L=c−r$, and the right boundary of the cover be $R=c+r$. Then the intersection boundaries will be $st=max(L,min(a,b))$, $ed=min(R,max(a,b))$. Then the answer is calculated by the formula $|b−a|−max(0,ed−st)$.


