"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __param = (this && this.__param) || function (paramIndex, decorator) {
    return function (target, key) { decorator(target, key, paramIndex); }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ItemsService = void 0;
const common_1 = require("@nestjs/common");
const mongoose_1 = require("@nestjs/mongoose");
const mongoose_2 = require("mongoose");
const items_schemas_1 = require("./schemas/items.schemas");
let ItemsService = class ItemsService {
    constructor(itemsModel) {
        this.itemsModel = itemsModel;
    }
    async findAll() {
        const items = await this.itemsModel.find();
        return items;
    }
    async findById(id) {
        return this.itemsModel.findById(id).exec();
    }
    async create(items) {
        const res = await this.itemsModel.create(items);
        return res;
    }
    async update(id, updateData) {
        const updatedItem = await this.itemsModel.findByIdAndUpdate(id, updateData, { new: true }).exec();
        if (!updatedItem) {
            throw new common_1.NotFoundException(`Item with ID "${id}" not found`);
        }
        return updatedItem;
    }
    async remove(id) {
        const result = await this.itemsModel.findByIdAndDelete(id).exec();
        if (!result) {
            throw new common_1.NotFoundException(`Item with ID "${id}" not found`);
        }
        return result;
    }
};
exports.ItemsService = ItemsService;
exports.ItemsService = ItemsService = __decorate([
    (0, common_1.Injectable)(),
    __param(0, (0, mongoose_1.InjectModel)(items_schemas_1.items.name)),
    __metadata("design:paramtypes", [mongoose_2.default.Model])
], ItemsService);
//# sourceMappingURL=items.service.js.map