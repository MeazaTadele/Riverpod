"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CommentSchema = void 0;
const mongoose = require("mongoose");
exports.CommentSchema = new mongoose.Schema({
    postId: mongoose.Schema.Types.ObjectId,
    content: String,
}, { timestamps: true });
//# sourceMappingURL=comment.schema.js.map