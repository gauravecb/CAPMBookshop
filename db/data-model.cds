namespace my.bookshop;

using { cuid } from '@sap/cds/common';

entity Books : cuid {
title: String;
stock: String;
author: String;
}