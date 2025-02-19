md5sum = find_program('md5sum')

i = 0
foreach conf : streflop_configurations
  new_dep = fpu_opt.contains('all') ? streflop_dep[i] : streflop_dep
  test_execs = []
  if conf['fpu'] != 'soft'  # stack-smashing error when built with meson
    test_execs += ['randomTest', 'arithmeticTest']
  endif
  foreach test : test_execs
    name = test + conf['suffix']
    exe = executable(name, [test + '.cpp'], dependencies: new_dep)
    args = []
    if test == 'arithmeticTest'
      args = join_paths(meson.current_build_dir(), name)
    endif
    test(name, exe, args: args, timeout: 360)
    if test == 'arithmeticTest' and md5sum.found() and conf['suffix'] != '-x87'
      test(
        name + '-md5sum',
        files('md5sum-wrapper.sh'),
        env: [
          'MESON_CURRENT_BUILD_DIR=' + meson.current_build_dir(),
          'MESON_CURRENT_SOURCE_DIR=' + meson.current_source_dir(),
          'MESON_TEST=' + name,
        ],
        args: md5sum,
        is_parallel: false,
      )
    endif
  endforeach
  i = i + 1
endforeach
