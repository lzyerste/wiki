---
title: gtest指南_3daafdfbed4c4bd8b11c7574d6cf0b63
---

# gtest指南

[google/googletest](https://github.com/google/googletest/blob/master/googletest/docs/primer.md)

使用文档

## 输出消息

[How to send custom message in Google C++ Testing Framework?](https://stackoverflow.com/questions/16491675/how-to-send-custom-message-in-google-c-testing-framework)

```c
EXPECT_TRUE(false) << "diagnostic message";
```

## 只运行特定测试

[How to run specific test cases in GoogleTest](https://stackoverflow.com/questions/12076072/how-to-run-specific-test-cases-in-googletest)

```jsx
--gtest_filter=Test_Cases1*
```

## 失败时立即停止

[How to stop GTest test-case execution, when first test failed](https://stackoverflow.com/questions/50255739/how-to-stop-gtest-test-case-execution-when-first-test-failed)

```jsx
--gtest_break_on_failure
```