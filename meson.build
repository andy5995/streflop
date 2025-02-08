project('streflop-ng', ['c','cpp'],
  default_options: ['cpp_std=c++11'],
  version: '0.1.0'
)

cc = meson.get_compiler('c')
cxx = meson.get_compiler('cpp')

extra_flags = [
  '-frounding-math',
  '-fsignaling-nans',
  '-fno-strict-aliasing',
  '-mieee-fp',
  '-mfpmath=sse',
  '-msse',
  '-msse2',
  '-fPIC'
  ]

# Compiler definitions
if get_option('streflop_x87')
  extra_flags += ['-DSTREFLOP_X87']
endif
if get_option('streflop_sse')
  extra_flags += ['-DSTREFLOP_SSE']
endif
if get_option('streflop_soft')
  extra_flags += ['-DSTREFLOP_SOFT']
endif
if get_option('streflop_no_denormals')
  extra_flags += ['-DSTREFLOP_NO_DENORMALS']
endif

add_project_arguments(cxx.get_supported_arguments(extra_flags), language: 'cpp')

# Dependencies
libm_dep = cxx.find_library('m', required: true)

incdir = include_directories('.')

sources = [
  'Math.cpp',
#  'Random.cpp',
#  'libm/e_expf.c',
#  'libm/w_expf.c'
  ]

Random_lib = static_library('Random', 'Random.cpp',include_directories : include_directories(['.']))

libm_flt32_sources = [
  'e_acosf.cpp',
  'e_acoshf.cpp',
  'e_asinf.cpp',
  'e_atan2f.cpp',
  'e_atanhf.cpp',
  'e_coshf.cpp',
  'e_exp2f.cpp',
  'e_expf.cpp',
  'e_fmodf.cpp',
  'e_gammaf_r.cpp',
  'e_hypotf.cpp',
  'e_j0f.cpp',
  'e_j1f.cpp',
  'e_jnf.cpp',
  'e_lgammaf_r.cpp',
  'e_log10f.cpp',
  'e_log2f.cpp',
  'e_logf.cpp',
  'e_powf.cpp',
  'e_remainderf.cpp',
  'e_rem_pio2f.cpp',
  'e_sinhf.cpp',
  'e_sqrtf.cpp',
  'k_cosf.cpp',
  'k_rem_pio2f.cpp',
  'k_sinf.cpp',
  'k_tanf.cpp',
  's_asinhf.cpp',
  's_atanf.cpp',
  's_cbrtf.cpp',
  's_ceilf.cpp',
  's_copysignf.cpp',
  's_cosf.cpp',
  's_erff.cpp',
  's_expm1f.cpp',
  's_fabsf.cpp',
  's_finitef.cpp',
  's_floorf.cpp',
  's_fpclassifyf.cpp',
  's_frexpf.cpp',
  's_ilogbf.cpp',
  's_isinff.cpp',
  's_isnanf.cpp',
  's_ldexpf.cpp',
  's_llrintf.cpp',
  's_llroundf.cpp',
  's_log1pf.cpp',
  's_logbf.cpp',
  's_lrintf.cpp',
  's_lroundf.cpp',
  's_modff.cpp',
  's_nearbyintf.cpp',
  's_nextafterf.cpp',
  's_remquof.cpp',
  's_rintf.cpp',
  's_roundf.cpp',
  's_scalblnf.cpp',
  's_scalbnf.cpp',
  's_signbitf.cpp',
  's_sincosf.cpp',
  's_sinf.cpp',
  's_tanf.cpp',
  's_tanhf.cpp',
  's_truncf.cpp',
  'w_expf.cpp',
  ]

libm_flt32_sources_full = []
foreach file : libm_flt32_sources
  libm_flt32_sources_full += join_paths('libm/flt-32', file)
endforeach

flt32_lib = static_library('flt32', libm_flt32_sources_full,
   cpp_args: '-DLIBM_COMPILING_FLT32=1',
   include_directories : ['.', 'libm', 'libm/headers'])

#libm_dbl64_sources = [
#  'branred.cpp',
#  'doasin.cpp',
#  'dosincos.cpp',
#  'e_acos.cpp',
#  'e_acosh.cpp',
#  'e_asin.cpp',
#  'e_atan2.cpp',
#  'e_atanh.cpp',
#  'e_cosh.cpp',
#  'e_exp2.cpp',
#  'e_exp.cpp',
#  'e_fmod.cpp',
#  'e_gamma_r.cpp',
#  'e_hypot.cpp',
#  'e_j0.cpp',
#  'e_j1.cpp',
#  'e_jn.cpp',
#  'e_lgamma_r.cpp',
#  'e_log10.cpp',
#  'e_log2.cpp',
#  'e_log.cpp',
#  'e_pow.cpp',
#  'e_remainder.cpp',
#  'e_rem_pio2.cpp',
#  'e_sinh.cpp',
#  'e_sqrt.cpp',
#  'halfulp.cpp',
#  'k_cos.cpp',
#  'k_rem_pio2.cpp',
#  'k_sin.cpp',
#  'k_tan.cpp',
#  'mpa.cpp',
#  'mpatan2.cpp',
#  'mpatan.cpp',
#  'mpexp.cpp',
#  'mplog.cpp',
#  'mpsqrt.cpp',
#  'mptan.cpp',
#  's_asinh.cpp',
#  's_atan.cpp',
#  's_cbrt.cpp',
#  's_ceil.cpp',
#  's_copysign.cpp',
#  's_cos.cpp',
#  's_erf.cpp',
#  's_expm1.cpp',
#  's_fabs.cpp',
#  's_finite.cpp',
#  's_floor.cpp',
#  's_fpclassify.cpp',
#  's_frexp.cpp',
#  's_ilogb.cpp',
#  'sincos32.cpp',
#  's_isinf.cpp',
#  's_isnan.cpp',
#  's_ldexp.cpp',
#  's_llrint.cpp',
#  's_llround.cpp',
#  's_log1p.cpp',
#  's_logb.cpp',
#  'slowexp.cpp',
#  'slowpow.cpp',
#  's_lrint.cpp',
#  's_lround.cpp',
#  's_modf.cpp',
#  's_nearbyint.cpp',
#  's_nextafter.cpp',
#  's_nexttoward.cpp',
#  's_remquo.cpp',
#  's_rint.cpp',
#  's_round.cpp',
#  's_scalbln.cpp',
#  's_scalbn.cpp',
#  's_signbit.cpp',
#  's_sincos.cpp',
#  's_sin.cpp',
#  's_tan.cpp',
#  's_tanh.cpp',
#  's_trunc.cpp',
#  'w_exp.cpp',
#  ]

#foreach file : libm_dbl64_sources
#  sources += join_paths('libm/dbl-64', file)
#endforeach

## Conditional sources
#soft_sources = files(
#  'SoftFloatWrapper.cpp',
#  'SoftFloatWrapperDouble.cpp',
#  'SoftFloatWrapperExtended.cpp',
#  'softfloat/softfloat.cpp',
#)
#if get_option('streflop_soft')
#  sources += soft_sources
#endif

lib_streflop_ng = library(meson.project_name(),
  sources,
  # dependencies: libm_dep,
  version : meson.project_version(),
  include_directories : include_directories(['.', 'libm', 'libm/headers']),
  link_with: [Random_lib, flt32_lib],
  install: not meson.is_subproject(),
)

# How to use in a superproject and other info
# https://mesonbuild.com/Subprojects.html
streflop_dep = declare_dependency(
  link_with : lib_streflop_ng,
  include_directories: ['.', 'libm', 'libm/headers']
  )


# Executables
#test_execs = ['arithmeticTest', 'randomTest']
#foreach test : test_execs
#  executable(test,
#    test + '.cpp',
#    dependencies: streflop_ng_dep,
#    cpp_args: cpp_args
#  )
#endforeach

headers = [
  'FPUSettings.h',
  'IntegerTypes.h',
  'Math.h',
  'Random.h',
  'SoftFloatWrapper.h',
  'streflop.h',
  'System.h',
  'X87DenormalSquasher.h'
]

if not meson.is_subproject()
  install_headers(['FPUSettings.h', 'Math.h', 'Random.h', 'SoftFloatWrapper.h', 'streflop.h'], subdir: 'streflop')
endif
