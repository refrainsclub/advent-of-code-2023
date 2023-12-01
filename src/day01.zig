const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");
const nums = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

fn searchText(i: usize, line: []const u8, first: *?u8, last: *?u8) void {
    for (nums, 1..) |num, j| {
        if (!std.mem.startsWith(u8, line[i..], num)) {
            continue;
        }

        const digit: u8 = @intCast(j);

        if (first.* == null) {
            first.* = digit;
        }

        last.* = digit;
    }
}

fn searchDigits(c: u8, first: *?u8, last: *?u8) void {
    if (!std.ascii.isDigit(c)) {
        return;
    }

    const digit = std.fmt.charToDigit(c, 10);

    if (first.* == null) {
        first.* = digit;
    }

    last.* = digit;
}

pub fn solve(digits: bool, text: bool) !u32 {
    var sum: u32 = 0;
    var lines = splitAny(u8, data, "\n");

    while (lines.next()) |line| {
        var first: ?u8 = null;
        var last: ?u8 = null;

        for (line, 0..) |c, i| {
            if (digits) {
                searchDigits(c, &first, &last);
            }

            if (text) {
                searchText(i, line, &first, &last);
            }
        }

        // multiply by 10 to put first in tens column
        const val = first.? * 10 + last.?;
        sum += val;
    }

    return sum;
}

pub fn main() !void {
    print("Part 1: {}\n", .{try solve(true, false)});
    print("Part 2: {}\n", .{try solve(true, true)});
}

test "test input" {
    try std.testing.expectEqual(solve(true, false), 54597);
    try std.testing.expectEqual(solve(true, true), 54504);
}

// Useful stdlib functions
const tokenizeAny = std.mem.tokenizeAny;
const tokenizeSeq = std.mem.tokenizeSequence;
const tokenizeSca = std.mem.tokenizeScalar;
const splitAny = std.mem.splitAny;
const splitSeq = std.mem.splitSequence;
const splitSca = std.mem.splitScalar;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.block;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
