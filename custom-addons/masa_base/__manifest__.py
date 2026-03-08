# -*- coding: utf-8 -*-
# Example Masa Technology custom addon
{
    'name': 'Masa Base',
    'version': '18.0.1.0.0',
    'category': 'Custom',
    'summary': 'Masa Technology base customizations',
    'description': 'Core customizations for Masa Technology Odoo deployment',
    'author': 'Masa Technology',
    'website': 'https://masa.tech',
    'license': 'LGPL-3',
    'depends': ['base', 'web'],
    'data': [
        # 'security/ir.model.access.csv',
        # 'views/your_view.xml',
    ],
    'installable': True,
    'auto_install': False,
    'application': False,
}
