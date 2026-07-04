const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
        .linux_display_backend = .Wayland,
    });
    const raylib_module = raylib_dep.module("raylib");
    const raylib_artifact = raylib_dep.artifact("raylib");

    const root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    root_module.linkLibrary(raylib_artifact);
    root_module.addImport("raylib", raylib_module);

    const exe = b.addExecutable(.{
        .name = "raylib",
        .root_module = root_module,
    });

    b.installArtifact(exe);
    const run_step = b.step("run", "Run the application.");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
}
