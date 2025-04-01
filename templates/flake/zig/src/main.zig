const std = @import("std");
const lib = @import("zig_lib");

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}
