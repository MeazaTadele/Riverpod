import { CommentService } from './comment.service';
export declare class CommentController {
    private readonly commentService;
    constructor(commentService: CommentService);
    addComment(postId: string, content: string): Promise<import("./schema/comment.schema").Comment>;
    testRoute(): {
        message: string;
    };
    getComments(postId: string): Promise<import("./schema/comment.schema").Comment[]>;
}
