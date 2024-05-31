/// <reference types="multer" />
import { items } from './schemas/items.schemas';
import { updateItemDto } from './dto/update-item.dto';
import { ItemsService } from './items.service';
export declare class ItemsController {
    private itemsService;
    constructor(itemsService: ItemsService);
    getAllitems(): Promise<items[]>;
    getItemById(id: string): Promise<items>;
    createItem(description: string, file: Express.Multer.File): Promise<items>;
    updateItem(id: string, updateData: updateItemDto): Promise<items>;
    deleteItem(id: string): Promise<any>;
}
