const std = @import("std");
const raylib = @import("raylib");
const builtin = @import("builtin");

const screen_width = 800;
const screen_height = 450;
const target_fps = 60;
const title = "Raylib Game!";

pub fn main() void {
    raylib.initWindow(screen_width, screen_height, "Raylib Game!");
    defer raylib.closeWindow();
    raylib.setTargetFPS(target_fps);

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
