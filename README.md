# Kirinoha - 桐の葉

[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)
[![Website](https://img.shields.io/website-up-down-green-red/http/shields.io.svg?maxAge=2592000)](https://rubygems.org/gems/kirinoha)
[![GitHub issues](https://img.shields.io/github/issues/himkt/kirinoha.svg)](https://github.com/himkt/kirinoha/issues)
[![GitHub stars](https://img.shields.io/github/stars/himkt/kirinoha.svg)](https://github.com/himkt/kirinoha/stargazers) 
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg?maxAge=2592000)](https://github.com/himkt/kirinoha) 
[![GitHub commits](https://img.shields.io/github/commits-since/SubtitleEdit/subtitleedit/3.4.7.svg?maxAge=2592000)](https://github.com/himkt/kirinoha)


## What is Kirinoha

Kirinoha is __UNOFFICIAL__ Course Search System for students at University of Tsukuba.

## More Information

[This article](http://himkt.hatenablog.com/entry/2016/04/07/135817) describes about kirinoha.

## For Use

Kirinoha is available on [here](https://kirinoha.herokuapp.com/).

I use heroku for production enviroment.

## Query Field

- title

Title stands for the title of a course.

You can use by

```
title: プログラミング演習
```

---

- code

Code indicates the course number (科目番号).

You can use by

```
code: GE3
```

or

```
code: GE31053
```

---

- credits

Credits indicate a number of credits (単位数) of a course.

You can use by

```
credits: 3
```

or

```
credits > 3
```

---

- terms

Terms indicates when a course is open.

You can use by

```
terms: 春A
```

---

- daytimes

Daytimes indicate times when course is open more speccifically

You can use by

```
daytimes: 月5
```

---

- instructors

Instructors show you a list of lecturers.

You can use by

```
instructors: 照井
```

---

- location

Location tells you a place where course is open.

You can use by

```
location: 7A
```

---

- info

Info describes a course.

You can use by

```
info: ラムダ計算
```
