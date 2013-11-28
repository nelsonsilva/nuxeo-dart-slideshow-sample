import 'dart:async';
import 'dart:io';
import 'package:hop/hop.dart';
import 'package:hop/hop_tasks.dart';

void main(args) {

  addTask('pages', _ghPages);
  addTask('build',  new Task((ctx) => _startProcess(ctx, "pub", ["build"]), description: "pub build"));

  runHop(args);
}

/// Custom startProcess that ignores the exit code
Future _startProcess(TaskContext ctx, String command,
    [List<String> args = null]) {

  if(args == null) {
    args = [];
  }

  ctx.fine("Starting process:");
  ctx.fine("$command ${args.join(' ')}");
  return Process.start(command, args)
      .then((process) {
        return pipeProcess(process,
            stdOutWriter: ctx.info,
            stdErrWriter: ctx.severe);
      })
      .then((int exitCode) {
        if(exitCode != 0) ctx.warning('Process exit code: $exitCode');
      });
}

Future<bool> _ghPages(TaskContext ctx) {
  final sourceDir = 'build';
  final targetBranch = 'gh-pages';
  final sourceBranch = 'master';

  return branchForDir(ctx, sourceBranch, sourceDir, targetBranch);
}