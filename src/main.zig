const std = @import("std");
const raylib = @import("raylib");

pub fn main() void {
    std.debug.print("Hello World!", .{});

    const width = 800;
    const height = 450;

    raylib.initWindow(width, height, "Raylib Game!");
    defer raylib.closeWindow();

    raylib.setTargetFPS(60);

    while (raylib.windowShouldClose() == false) {
        raylib.beginDrawing();
        raylib.clearBackground(.black);
        raylib.drawText("Raylib Game!", 32, 32, 32, .white);
        raylib.endDrawing();
    }
}
