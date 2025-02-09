test_execs = [
  'test001',
  #'arithmeticTest',
  'randomTest',
]
foreach test : test_execs
  exe = executable(
    test,
    test + '.cpp',
    dependencies: streflop_dep,
    cpp_args: [type_arg],
  )
  test(test, exe)
endforeach
