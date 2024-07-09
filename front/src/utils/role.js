import store from '@/store'

export function role(val){
    let role = store.state.userRole;
    if(val == role){
        return true
    }else{
        return false
    }
    
}