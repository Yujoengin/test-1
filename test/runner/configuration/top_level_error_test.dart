// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")

import 'dart:convert';

import 'package:scheduled_test/descriptor.dart' as d;
import 'package:scheduled_test/scheduled_test.dart';
import 'package:test/src/util/exit_codes.dart' as exit_codes;

import '../../io.dart';

void main() {
  useSandbox();

  test("rejects an invalid verbose_trace", () {
    d.file("dart_test.yaml", JSON.encode({
      "verbose_trace": "flup"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "verbose_trace must be a boolean",
      "^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid js_trace",
      () {
    d.file("dart_test.yaml", JSON.encode({
      "js_trace": "flup"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "js_trace must be a boolean",
      "^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid reporter type", () {
    d.file("dart_test.yaml", JSON.encode({
      "reporter": 12
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "reporter must be a string",
      "^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid reporter name", () {
    d.file("dart_test.yaml", JSON.encode({
      "reporter": "non-existent"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      'Unknown reporter "non-existent"',
      "^^^^^^^^^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid pub serve port", () {
    d.file("dart_test.yaml", JSON.encode({
      "pub_serve": "foo"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "pub_serve must be an int",
      "^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid concurrency", () {
    d.file("dart_test.yaml", JSON.encode({
      "concurrency": "foo"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "concurrency must be an int",
      "^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid timeout type", () {
    d.file("dart_test.yaml", JSON.encode({
      "timeout": 12
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "timeout must be a string",
      "^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid timeout format", () {
    d.file("dart_test.yaml", JSON.encode({
      "timeout": "12p"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "Invalid timeout: expected unit",
      "^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid platforms list type", () {
    d.file("dart_test.yaml", JSON.encode({
      "platforms": "vm"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "platforms must be a list",
      "^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid platforms member type", () {
    d.file("dart_test.yaml", JSON.encode({
      "platforms": [12]
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "Platforms must be strings",
      "^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid platforms member name", () {
    d.file("dart_test.yaml", JSON.encode({
      "platforms": ["foo"]
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      'Unknown platform "foo"',
      "^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid paths list type", () {
    d.file("dart_test.yaml", JSON.encode({
      "paths": "test"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "paths must be a list",
      "^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid paths member type", () {
    d.file("dart_test.yaml", JSON.encode({
      "paths": [12]
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      "Paths must be strings",
      "^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an absolute path", () {
    d.file("dart_test.yaml", JSON.encode({
      "paths": ["/foo"]
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      'Paths must be relative.',
      "^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid path URI", () {
    d.file("dart_test.yaml", JSON.encode({
      "paths": ["[invalid]"]
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      'Invalid path: Invalid character',
      "^^^^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid filename type", () {
    d.file("dart_test.yaml", JSON.encode({
      "filename": 12
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      'filename must be a string.',
      "^^"
    ]));
    test.shouldExit(exit_codes.data);
  });

  test("rejects an invalid filename format", () {
    d.file("dart_test.yaml", JSON.encode({
      "filename": "{foo"
    })).create();

    var test = runTest(["test.dart"]);
    test.stderr.expect(containsInOrder([
      'Invalid filename: expected ",".',
      "^^^^^^"
    ]));
    test.shouldExit(exit_codes.data);
  });
}
