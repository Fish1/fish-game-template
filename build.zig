const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
        .linux_display_backend = .Wayland,
    });
    const raylib_module = raylib_dep.module("raylib");

    const box2d_dep = b.dependency("box2d_zig", .{
        .target = target,
        .optimize = optimize,
    });
    const box2d_module = box2d_dep.module("box2d");

    const root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    root_module.addImport("raylib", raylib_module);
    root_module.addImport("box2d", box2d_module);

    const exe = b.addExecutable(.{
        .name = "raylib",
        .root_module = root_module,
    });
    b.installArtifact(exe);

    const run_step = b.step("run", "Run the application.");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
}
