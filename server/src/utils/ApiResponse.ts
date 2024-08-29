class ApiResponse {

    status:string;
    statusCode:number;
    result:any;
    data:any;

    constructor(status:string, statusCode:number, result:any, data:any) {
        this.status = status;
        this.statusCode = statusCode;
        this.result = result;
        this.data = data;        
    }

    static success(data:any,message:string) {
        return new ApiResponse('success', 200, message, data);
    }
}