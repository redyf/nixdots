{pkgs, ...}: {
  home.packages = with pkgs; [
    cmake
    gnumake

    # C/C++ Packages
    astyle # Source code indenter, formatter, and beautifier for C, C++, C# and Java
    cpplint # Static code checker for C/C++
    clang-tools # Standalone command line tools for C++ development
    # uncrustify # Source code beautifier for C, C++, C#, ObjectiveC, D, Java, Pawn and VALA
  ];
}
