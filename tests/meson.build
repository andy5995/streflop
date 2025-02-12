test_execs = [
  # 'arithmeticTest',
  'randomTest',
]
foreach test : test_execs
  exe = executable(test, test + '.cpp', dependencies: streflop_dep)
  test(test, exe)
endforeach
