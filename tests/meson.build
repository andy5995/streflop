md5sum = []
if host_sys != 'windows'
  md5sum = find_program('md5sum', required: false)
endif

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
    if host_sys != 'windows'  # TODO: Replace md5sum-wrapper.sh with a python script
      if test == 'arithmeticTest' and md5sum.found()
        test(
          '-md5sum_' + name,
          files('md5sum-wrapper.sh'),
          env: [
            'MESON_CURRENT_BUILD_DIR=' + meson.current_build_dir(),
            'MESON_CURRENT_SOURCE_DIR=' + meson.current_source_dir(),
            'MESON_TEST=' + name,
          ],
          # Using an object returned by find_program is only supported by meson >= 1.6.0
          # args: md5sum,
          is_parallel: false,
        )
      endif
    endif
  endforeach
  i = i + 1
endforeach
