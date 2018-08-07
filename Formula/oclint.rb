class Oclint < Formula
  desc "OCLint static code analysis tool for C, C++, and Objective-C"
  homepage "http://oclint.org"
  version '0.13.1'
  sha256 'c67f014a1ce997e62a242fe9154a9ac0a4ea50ad07b0417f3fb8b13f20e1ab90'
  url "https://github.com/oclint/oclint/releases/download/v#{version}/oclint-#{version}-x86_64-darwin-17.4.0.tar.gz"
  head "https://github.com/oclint/oclint.git"

  depends_on "cmake" => :build
  depends_on "llvm@5" => :build
  depends_on "ninja" => :build

  def install
    base_dir = '*'
    if build.head?
      Dir.chdir('oclint-scripts') {
        system './build', "-llvm-root=#{Formula["llvm@5"].opt_prefix}", '-no-analytics', '-release', '-use-system-compiler'
        system './bundle', "-llvm-root=#{Formula["llvm@5"].opt_prefix}", '-release'
      }

      base_dir = 'build/oclint-release/*'
    end

    prefix.install Dir[base_dir]
  end

  test do
    system "#{bin}/oclint", "-version"
  end
end
