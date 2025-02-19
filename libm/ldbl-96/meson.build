ldbl96_sources = [
  'e_acoshl.cpp',
  'e_asinl.cpp',
  'e_atan2l.cpp',
  'e_atanhl.cpp',
  'e_coshl.cpp',
  'e_gammal_r.cpp',
  'e_hypotl.cpp',
  'e_j0l.cpp',
  'e_j1l.cpp',
  'e_jnl.cpp',
  'e_lgammal_r.cpp',
  'e_remainderl.cpp',
  'e_sinhl.cpp',
  's_asinhl.cpp',
  's_cbrtl.cpp',
  's_ceill.cpp',
  's_copysignl.cpp',
  's_cosl.cpp',
  's_erfl.cpp',
  's_fabsl.cpp',
  's_finitel.cpp',
  's_floorl.cpp',
  's_fpclassifyl.cpp',
  's_frexpl.cpp',
  's_ilogbl.cpp',
  's_isinfl.cpp',
  's_isnanl.cpp',
  's_ldexpl.cpp',
  's_llrintl.cpp',
  's_llroundl.cpp',
  's_logbl.cpp',
  's_lrintl.cpp',
  's_lroundl.cpp',
  's_modfl.cpp',
  's_nearbyintl.cpp',
  's_nextafterl.cpp',
  's_remquol.cpp',
  's_rintl.cpp',
  's_roundl.cpp',
  's_scalblnl.cpp',
  's_scalbnl.cpp',
  's_signbitl.cpp',
  's_sincosl.cpp',
  's_sinl.cpp',
  's_tanhl.cpp',
  's_tanl.cpp',
  's_truncl.cpp',
  'w_expl.cpp',
]

foreach conf : streflop_configurations
  message('conf:')
  message(conf)
endforeach

_ldbl96_lib = []
foreach conf : streflop_configurations
  if conf['fpu'] != 'sse'
    _ldbl96_lib += static_library(
      'ldbl96' + conf['suffix'],
      [ldbl96_sources],
      cpp_args: [
        #'-Wno-narrowing',
        '-DLIBM_COMPILING_LDBL96',
        conf['flags'],
        conf['defs'],
      ],
      include_directories: [inc_dirs],
      pic: true,
      build_by_default: false,
    )
  endif
endforeach

