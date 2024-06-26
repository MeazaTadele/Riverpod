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
exports.ItemsController = void 0;
const common_1 = require("@nestjs/common");
const file_interceptor_1 = require("@nestjs/platform-express/multer/interceptors/file.interceptor");
const role_decorator_1 = require("../auth/roles/role.decorator");
const update_item_dto_1 = require("./dto/update-item.dto");
const items_service_1 = require("./items.service");
let ItemsController = class ItemsController {
    constructor(itemsService) {
        this.itemsService = itemsService;
    }
    async getAllitems() {
        return this.itemsService.findAll();
    }
    async getItemById(id) {
        return this.itemsService.findById(id);
    }
    async createItem(description, file) {
        const createdItem = await this.itemsService.create({
            description, picture: file.buffer,
            category: ''
        });
        return createdItem;
    }
    async updateItem(id, updateData) {
        return this.itemsService.update(id, updateData);
    }
    async deleteItem(id) {
        return this.itemsService.remove(id);
    }
};
exports.ItemsController = ItemsController;
__decorate([
    (0, common_1.Get)(),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", []),
    __metadata("design:returntype", Promise)
], ItemsController.prototype, "getAllitems", null);
__decorate([
    (0, common_1.Get)(':id'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], ItemsController.prototype, "getItemById", null);
__decorate([
    (0, common_1.Post)(),
    (0, common_1.UseInterceptors)((0, file_interceptor_1.FileInterceptor)('picture')),
    __param(0, (0, common_1.Body)('description')),
    __param(1, (0, common_1.UploadedFile)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, Object]),
    __metadata("design:returntype", Promise)
], ItemsController.prototype, "createItem", null);
__decorate([
    (0, common_1.Put)(':id'),
    (0, role_decorator_1.Roles)('admin'),
    __param(0, (0, common_1.Param)('id')),
    __param(1, (0, common_1.Body)()),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String, update_item_dto_1.updateItemDto]),
    __metadata("design:returntype", Promise)
], ItemsController.prototype, "updateItem", null);
__decorate([
    (0, common_1.Delete)(':id'),
    (0, role_decorator_1.Roles)('admin'),
    __param(0, (0, common_1.Param)('id')),
    __metadata("design:type", Function),
    __metadata("design:paramtypes", [String]),
    __metadata("design:returntype", Promise)
], ItemsController.prototype, "deleteItem", null);
exports.ItemsController = ItemsController = __decorate([
    (0, common_1.Controller)('items'),
    __metadata("design:paramtypes", [items_service_1.ItemsService])
], ItemsController);
//# sourceMappingURL=items.controller.js.map