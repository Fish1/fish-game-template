const std = @import("std");

pub fn say() void {
    std.debug.print("This is raylib zig audio player!", .{});
}

test "example" {
    try std.testing.expect(1 == 1);
}
