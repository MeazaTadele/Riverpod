/// <reference types="mongoose/types/aggregate" />
/// <reference types="mongoose/types/callback" />
/// <reference types="mongoose/types/collection" />
/// <reference types="mongoose/types/connection" />
/// <reference types="mongoose/types/cursor" />
/// <reference types="mongoose/types/document" />
/// <reference types="mongoose/types/error" />
/// <reference types="mongoose/types/expressions" />
/// <reference types="mongoose/types/helpers" />
/// <reference types="mongoose/types/middlewares" />
/// <reference types="mongoose/types/indexes" />
/// <reference types="mongoose/types/models" />
/// <reference types="mongoose/types/mongooseoptions" />
/// <reference types="mongoose/types/pipelinestage" />
/// <reference types="mongoose/types/populate" />
/// <reference types="mongoose/types/query" />
/// <reference types="mongoose/types/schemaoptions" />
/// <reference types="mongoose/types/schematypes" />
/// <reference types="mongoose/types/session" />
/// <reference types="mongoose/types/types" />
/// <reference types="mongoose/types/utility" />
/// <reference types="mongoose/types/validation" />
/// <reference types="mongoose/types/virtuals" />
/// <reference types="mongoose/types/inferschematype" />
import mongoose from 'mongoose';
import { updateItemDto } from './dto/update-item.dto';
import { items } from './schemas/items.schemas';
export declare class ItemsService {
    private itemsModel;
    constructor(itemsModel: mongoose.Model<items>);
    findAll(): Promise<(mongoose.Document<unknown, {}, items> & items & {
        _id: mongoose.Types.ObjectId;
    })[]>;
    findById(id: string): Promise<items>;
    create(items: items): Promise<items>;
    update(id: string, updateData: updateItemDto): Promise<items>;
    remove(id: string): Promise<any>;
}
