{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 0,
            "revision": 0,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [
            687.0,
            133.0,
            891.0,
            436.0
        ],
        "openrect": [
            0.0,
            0.0,
            152.0,
            147.0
        ],
        "bglocked": 0,
        "openinpresentation": 1,
        "default_fontsize": 10.0,
        "default_fontface": 0,
        "default_fontname": "Arial Bold",
        "gridonopen": 1,
        "gridsize": [
            8.0,
            8.0
        ],
        "gridsnaponopen": 1,
        "objectsnaponopen": 1,
        "statusbarvisible": 2,
        "toolbarvisible": 1,
        "lefttoolbarpinned": 0,
        "toptoolbarpinned": 0,
        "righttoolbarpinned": 0,
        "bottomtoolbarpinned": 0,
        "toolbars_unpinned_last_save": 0,
        "tallnewobj": 0,
        "boxanimatetime": 500,
        "enablehscroll": 1,
        "enablevscroll": 1,
        "devicewidth": 152.0,
        "description": "Generate an ascending arpeggio from the selected root and scale.",
        "digest": "",
        "tags": "",
        "style": "",
        "subpatcher_template": "",
        "assistshowspatchername": 0,
        "boxes": [
            {
                "box": {
                    "id": "in",
                    "maxclass": "newobj",
                    "patching_rect": [
                        250.0,
                        10.0,
                        100.0,
                        22.0
                    ],
                    "text": "live.miditool.in"
                }
            },
            {
                "box": {
                    "id": "gen",
                    "maxclass": "newobj",
                    "patching_rect": [
                        250.0,
                        70.0,
                        120.0,
                        22.0
                    ],
                    "text": "js scale_arp.js",
                    "numinlets": 2,
                    "numoutlets": 2
                }
            },
            {
                "box": {
                    "id": "out",
                    "maxclass": "newobj",
                    "patching_rect": [
                        250.0,
                        120.0,
                        100.0,
                        22.0
                    ],
                    "text": "live.miditool.out"
                }
            },
            {
                "box": {
                    "id": "bang",
                    "maxclass": "newobj",
                    "patching_rect": [
                        250.0,
                        40.0,
                        30.0,
                        22.0
                    ],
                    "text": "t b"
                }
            },
            {
                "box": {
                    "id": "ratelabel",
                    "maxclass": "comment",
                    "patching_rect": [
                        6.0,
                        2.0,
                        64.0,
                        17.0
                    ],
                    "text": "Step",
                    "fontsize": 9.0,
                    "textcolor": [
                        0.75,
                        0.8,
                        0.88,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        2.0,
                        64.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "id": "rate",
                    "maxclass": "live.dial",
                    "patching_rect": [
                        6.0,
                        21.0,
                        64.0,
                        41.0
                    ],
                    "parameter_enable": 1,
                    "varname": "rate",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Step",
                            "parameter_shortname": "Step",
                            "parameter_type": 2,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                1
                            ],
                            "parameter_enum": [
                                "1/8",
                                "1/16",
                                "1/32",
                                "1/8 triplet"
                            ],
                            "parameter_mmax": 3
                        }
                    },
                    "annotation": "Step",
                    "activebgcolor": [
                        0.23,
                        0.27,
                        0.39,
                        1.0
                    ],
                    "activetextcolor": [
                        0.94,
                        0.95,
                        1.0,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        21.0,
                        64.0,
                        41.0
                    ],
                    "showname": 0,
                    "shownumber": 1
                }
            },
            {
                "box": {
                    "id": "ratemsg",
                    "maxclass": "newobj",
                    "patching_rect": [
                        400.0,
                        67.0,
                        120.0,
                        22.0
                    ],
                    "text": "prepend rate"
                }
            },
            {
                "box": {
                    "id": "patternlabel",
                    "maxclass": "comment",
                    "patching_rect": [
                        78.0,
                        2.0,
                        68.0,
                        17.0
                    ],
                    "text": "Motion",
                    "fontsize": 9.0,
                    "textcolor": [
                        0.75,
                        0.8,
                        0.88,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        78.0,
                        2.0,
                        68.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "id": "pattern",
                    "maxclass": "live.menu",
                    "patching_rect": [
                        78.0,
                        25.0,
                        68.0,
                        20.0
                    ],
                    "parameter_enable": 1,
                    "varname": "pattern",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Motion",
                            "parameter_shortname": "Motion",
                            "parameter_type": 2,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                0
                            ],
                            "parameter_enum": [
                                "Rise",
                                "Fall",
                                "Bounce",
                                "Wander"
                            ],
                            "parameter_mmax": 3
                        }
                    },
                    "annotation": "Motion",
                    "activebgcolor": [
                        0.23,
                        0.27,
                        0.39,
                        1.0
                    ],
                    "activetextcolor": [
                        0.94,
                        0.95,
                        1.0,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        78.0,
                        25.0,
                        68.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "id": "patternmsg",
                    "maxclass": "newobj",
                    "patching_rect": [
                        400.0,
                        67.0,
                        120.0,
                        22.0
                    ],
                    "text": "prepend pattern"
                }
            },
            {
                "box": {
                    "id": "octaveslabel",
                    "maxclass": "comment",
                    "patching_rect": [
                        6.0,
                        60.0,
                        64.0,
                        17.0
                    ],
                    "text": "Octaves",
                    "fontsize": 9.0,
                    "textcolor": [
                        0.75,
                        0.8,
                        0.88,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        60.0,
                        64.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "id": "octaves",
                    "maxclass": "live.numbox",
                    "patching_rect": [
                        6.0,
                        79.0,
                        64.0,
                        20.0
                    ],
                    "parameter_enable": 1,
                    "varname": "octaves",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Octaves",
                            "parameter_shortname": "Octaves",
                            "parameter_type": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                2
                            ],
                            "parameter_mmin": 1,
                            "parameter_mmax": 4
                        }
                    },
                    "annotation": "Octaves",
                    "activebgcolor": [
                        0.23,
                        0.27,
                        0.39,
                        1.0
                    ],
                    "activetextcolor": [
                        0.94,
                        0.95,
                        1.0,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        79.0,
                        64.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "id": "octavesmsg",
                    "maxclass": "newobj",
                    "patching_rect": [
                        400.0,
                        121.0,
                        120.0,
                        22.0
                    ],
                    "text": "prepend octaves"
                }
            },
            {
                "box": {
                    "id": "registerlabel",
                    "maxclass": "comment",
                    "patching_rect": [
                        78.0,
                        60.0,
                        68.0,
                        17.0
                    ],
                    "text": "Base octave",
                    "fontsize": 9.0,
                    "textcolor": [
                        0.75,
                        0.8,
                        0.88,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        78.0,
                        60.0,
                        68.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "id": "register",
                    "maxclass": "live.numbox",
                    "patching_rect": [
                        78.0,
                        79.0,
                        68.0,
                        20.0
                    ],
                    "parameter_enable": 1,
                    "varname": "register",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Base octave",
                            "parameter_shortname": "Base octave",
                            "parameter_type": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                4
                            ],
                            "parameter_mmin": 0,
                            "parameter_mmax": 8
                        }
                    },
                    "annotation": "Base octave",
                    "activebgcolor": [
                        0.23,
                        0.27,
                        0.39,
                        1.0
                    ],
                    "activetextcolor": [
                        0.94,
                        0.95,
                        1.0,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        78.0,
                        79.0,
                        68.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "id": "registermsg",
                    "maxclass": "newobj",
                    "patching_rect": [
                        400.0,
                        121.0,
                        120.0,
                        22.0
                    ],
                    "text": "prepend register"
                }
            },
            {
                "box": {
                    "id": "variationlabel",
                    "maxclass": "comment",
                    "patching_rect": [
                        6.0,
                        104.0,
                        68.0,
                        17.0
                    ],
                    "text": "Variation %",
                    "fontsize": 9.0,
                    "textcolor": [
                        0.75,
                        0.8,
                        0.88,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        104.0,
                        68.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "id": "variation",
                    "maxclass": "live.numbox",
                    "patching_rect": [
                        6.0,
                        123.0,
                        64.0,
                        20.0
                    ],
                    "parameter_enable": 1,
                    "varname": "variation",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Variation %",
                            "parameter_shortname": "Variation %",
                            "parameter_type": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                35
                            ],
                            "parameter_mmin": 0,
                            "parameter_mmax": 100
                        }
                    },
                    "annotation": "Variation %",
                    "activebgcolor": [
                        0.23,
                        0.27,
                        0.39,
                        1.0
                    ],
                    "activetextcolor": [
                        0.94,
                        0.95,
                        1.0,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        6.0,
                        123.0,
                        64.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "id": "variationmsg",
                    "maxclass": "newobj",
                    "patching_rect": [
                        400.0,
                        175.0,
                        120.0,
                        22.0
                    ],
                    "text": "prepend variation"
                }
            },
            {
                "box": {
                    "id": "gatelabel",
                    "maxclass": "comment",
                    "patching_rect": [
                        78.0,
                        104.0,
                        68.0,
                        17.0
                    ],
                    "text": "Length %",
                    "fontsize": 9.0,
                    "textcolor": [
                        0.75,
                        0.8,
                        0.88,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        78.0,
                        104.0,
                        68.0,
                        17.0
                    ]
                }
            },
            {
                "box": {
                    "id": "gate",
                    "maxclass": "live.numbox",
                    "patching_rect": [
                        78.0,
                        123.0,
                        68.0,
                        20.0
                    ],
                    "parameter_enable": 1,
                    "varname": "gate",
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "Length %",
                            "parameter_shortname": "Length %",
                            "parameter_type": 1,
                            "parameter_initial_enable": 1,
                            "parameter_initial": [
                                75
                            ],
                            "parameter_mmin": 10,
                            "parameter_mmax": 100
                        }
                    },
                    "annotation": "Length %",
                    "activebgcolor": [
                        0.23,
                        0.27,
                        0.39,
                        1.0
                    ],
                    "activetextcolor": [
                        0.94,
                        0.95,
                        1.0,
                        1.0
                    ],
                    "presentation": 1,
                    "presentation_rect": [
                        78.0,
                        123.0,
                        68.0,
                        20.0
                    ]
                }
            },
            {
                "box": {
                    "id": "gatemsg",
                    "maxclass": "newobj",
                    "patching_rect": [
                        400.0,
                        175.0,
                        120.0,
                        22.0
                    ],
                    "text": "prepend gate"
                }
            },
            {
                "box": {
                    "id": "parameter-update",
                    "maxclass": "newobj",
                    "text": "t b l",
                    "patching_rect": [
                        400.0,
                        260.0,
                        45.0,
                        22.0
                    ]
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "source": [
                        "in",
                        1
                    ],
                    "destination": [
                        "gen",
                        1
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "in",
                        0
                    ],
                    "destination": [
                        "bang",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "bang",
                        0
                    ],
                    "destination": [
                        "gen",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "gen",
                        0
                    ],
                    "destination": [
                        "out",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "rate",
                        0
                    ],
                    "destination": [
                        "ratemsg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "ratemsg",
                        0
                    ],
                    "destination": [
                        "parameter-update",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "pattern",
                        0
                    ],
                    "destination": [
                        "patternmsg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "patternmsg",
                        0
                    ],
                    "destination": [
                        "parameter-update",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "octaves",
                        0
                    ],
                    "destination": [
                        "octavesmsg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "octavesmsg",
                        0
                    ],
                    "destination": [
                        "parameter-update",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "register",
                        0
                    ],
                    "destination": [
                        "registermsg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "registermsg",
                        0
                    ],
                    "destination": [
                        "parameter-update",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "variation",
                        0
                    ],
                    "destination": [
                        "variationmsg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "variationmsg",
                        0
                    ],
                    "destination": [
                        "parameter-update",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "gate",
                        0
                    ],
                    "destination": [
                        "gatemsg",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "gatemsg",
                        0
                    ],
                    "destination": [
                        "parameter-update",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "parameter-update",
                        1
                    ],
                    "destination": [
                        "gen",
                        0
                    ]
                }
            },
            {
                "patchline": {
                    "source": [
                        "parameter-update",
                        0
                    ],
                    "destination": [
                        "in",
                        0
                    ]
                }
            }
        ],
        "dependency_cache": [
            {
                "name": "scale_arp.js",
                "type": "TEXT",
                "implicit": 1
            }
        ],
        "latency": 0,
        "is_mpe": 0,
        "minimum_live_version": "",
        "minimum_max_version": "",
        "platform_compatibility": 0,
        "project": {
            "version": 1,
            "creationdate": 3590052493,
            "modificationdate": 3590052493,
            "viewrect": [
                25.0,
                124.0,
                300.0,
                500.0
            ],
            "autoorganize": 1,
            "hideprojectwindow": 1,
            "showdependencies": 1,
            "autolocalize": 0,
            "contents": {
                "patchers": {}
            },
            "layout": {},
            "searchpath": {},
            "detailsvisible": 0,
            "amxdtype": 1851877223,
            "readonly": 0,
            "devpathtype": 0,
            "devpath": ".",
            "sortmode": 0,
            "viewmode": 0,
            "includepackages": 0
        },
        "autosave": 0,
        "saved_attribute_attributes": {
            "default_plcolor": {
                "expression": ""
            }
        },
        "bgcolor": [
            0.12,
            0.14,
            0.19,
            1.0
        ],
        "editing_bgcolor": [
            0.12,
            0.14,
            0.19,
            1.0
        ]
    }
}
