import { HubConnectionBuilder } from '@microsoft/signalr';

const connection = new HubConnectionBuilder().withUrl("/chatHub").build();