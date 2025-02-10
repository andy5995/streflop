project(
  'streflop-ng',
  ['cpp'],
  default_options: ['cpp_std=c++11', 'warning_level=2'],
  version: '0.3.1',
)

cxx = meson.get_compiler('cpp')
#cc = meson.get_compiler('c')

extra_flags = [
  '-frounding-math',
  '-fsignaling-nans',
  '-fno-strict-aliasing',
  '-mieee-fp',
]

#add_project_arguments(, language: 'cpp')
lib_args = cxx.get_supported_arguments(extra_flags)

sources = []
_softwrapper_static_libs = []
type_arg = []
flags = []
fpu = get_option('fpu')
if fpu == 'x87'
  type_arg += ['-DSTREFLOP_X87']
  flags += ['-mfpmath=387']
endif
if fpu == 'sse'
  type_arg += ['-DSTREFLOP_SSE']
  flags += ['-msse', '-msse2', '-mfpmath=sse']
endif
if fpu == 'soft'
  type_arg += ['-DSTREFLOP_SOFT']
endif
if get_option('no_denormals')
  type_arg += ['-DSTREFLOP_NO_DENORMALS']
endif

lib_args += cxx.get_supported_arguments([flags, type_arg])

if fpu == 'soft'
  sources += 'softfloat/softfloat.cpp'
  configurations = [
    {'defs': ['-DN_SPECIALIZED=32'], 'name': 'SoftFloatWrapperSimple'},
    {'defs': ['-DN_SPECIALIZED=64'], 'name': 'SoftFloatWrapperDouble'},
    {'defs': ['-DN_SPECIALIZED=96'], 'name': 'SoftFloatWrapperExtended'},
  ]
  foreach conf : configurations
    _softwrapper_static_libs += static_library(
      conf['name'],
      ['SoftFloatWrapper.cpp'],
      # include_directories: '.',
      cpp_args: [conf['defs'], lib_args],
    )
  endforeach
endif

incdir = include_directories('libm')

sources += ['Math.cpp', 'Random.cpp']

subdir('libm')

lib_streflop_ng = library(
  meson.project_name(),
  [sources],
  version: meson.project_version(),
  include_directories: incdir,
  cpp_args: [lib_args],
  link_with: [
    _flt32_lib,
    _dbl64_lib,
    _ldbl96_lib,
    _libm,
    _softwrapper_static_libs,
  ],
  install: not meson.is_subproject(),
  pic: true,
)

# How to use in a superproject and other info
# https://mesonbuild.com/Subprojects.html
streflop_dep = declare_dependency(
  link_with: lib_streflop_ng,
  include_directories: '.',
)

subdir('tests')

headers = [
  'FPUSettings.h',
  'IntegerTypes.h',
  'Math.h',
  'Random.h',
  'SoftFloatWrapper.h',
  'streflop.h',
  'System.h',
  'X87DenormalSquasher.h',
]

if not meson.is_subproject()
  install_headers(
    ['FPUSettings.h', 'Math.h', 'Random.h', 'SoftFloatWrapper.h', 'streflop.h'],
    subdir: 'streflop',
  )
endif
