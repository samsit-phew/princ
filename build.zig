const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("princ", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib = b.addLibrary(.{
        .name = "princ",
        .root_module = mod,
    });

    b.installArtifact(lib);

    const tests = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/root.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_tests.step);
    // in build.zig
    const preview = b.addExecutable(.{
        .name = "preview",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/preview.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_preview = b.addRunArtifact(preview);
    const preview_step = b.step("preview", "Preview all colors");
    preview_step.dependOn(&run_preview.step);
}
