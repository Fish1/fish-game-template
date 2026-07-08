const std = @import("std");
const raylib = @import("raylib");

const builtin = @import("builtin");
pub const is_web = builtin.cpu.arch.isWasm();

pub const std_options: std.Options = if (is_web) .{
    .networking = false,
    .logFn = null,
} else .{};

pub const panic = if (is_web) std.debug.no_panic else std.debug.FullPanic(std.debug.defaultPanic);
pub const main = if (is_web) web_main else native_main;

pub fn web_main() !void {
    const width = 800;
    const height = 450;
    raylib.initWindow(width, height, "Raylib Game!");
    std.os.emscripten.emscripten_set_main_loop(frame, 0, 0);
}

pub fn native_main() !void {
    const width = 800;
    const height = 450;

    raylib.initWindow(width, height, "Raylib Game!");
    defer raylib.closeWindow();

    raylib.setTargetFPS(60);

    while (raylib.windowShouldClose() == false) {
        frame();
    }
}

fn frame() callconv(.c) void {
    raylib.beginDrawing();
    raylib.clearBackground(.black);
    raylib.drawText("Raylib Game!", 32, 32, 32, .white);
    raylib.endDrawing();
}
