var group__RoutineManagerInterface =
[
    [ "IRoutineManager", "classNuguClientKit_1_1IRoutineManager.html", [
      [ "TextRequester", "classNuguClientKit_1_1IRoutineManager.html#a83624ee829dd1cd2b69441c0357ecadb", null ],
      [ "DataRequester", "classNuguClientKit_1_1IRoutineManager.html#ac4782bb43a3eb49abf0b8b0dcac463e2", null ],
      [ "~IRoutineManager", "classNuguClientKit_1_1IRoutineManager.html#a74bc4d960cc81a2747936bdc28aaa601", null ],
      [ "addListener", "classNuguClientKit_1_1IRoutineManager.html#a8b6f876be3d2ced614b566ff4fa9912b", null ],
      [ "removeListener", "classNuguClientKit_1_1IRoutineManager.html#afa0a8131fdeb730c77869d8880f86704", null ],
      [ "setTextRequester", "classNuguClientKit_1_1IRoutineManager.html#a2074339702aa578b30eee8921f0ab90e", null ],
      [ "setDataRequester", "classNuguClientKit_1_1IRoutineManager.html#a2cbeee626f3e73eeccf3e65cc7262221", null ],
      [ "start", "classNuguClientKit_1_1IRoutineManager.html#a78203edfd61613b9d4adacf4b888c4e0", null ],
      [ "stop", "classNuguClientKit_1_1IRoutineManager.html#a6ef7941d23fcdaf25819e7fff310d9a3", null ],
      [ "interrupt", "classNuguClientKit_1_1IRoutineManager.html#a02586cd365a1392a8c986960c5944c14", null ],
      [ "resume", "classNuguClientKit_1_1IRoutineManager.html#a467252066e021d0aee8276793a22ebc0", null ],
      [ "move", "classNuguClientKit_1_1IRoutineManager.html#a4194d720eed29a44487747d7bce18e80", null ],
      [ "finish", "classNuguClientKit_1_1IRoutineManager.html#ac6b7f5ef7913297b8a7111afca29cb20", null ],
      [ "getCurrentActionToken", "classNuguClientKit_1_1IRoutineManager.html#aae1ccb8962c748fc1b042b85ff58a0ea", null ],
      [ "getCurrentActionIndex", "classNuguClientKit_1_1IRoutineManager.html#ad6cfa4115e6c35ad68d338d3651fe7b5", null ],
      [ "getCountableActionSize", "classNuguClientKit_1_1IRoutineManager.html#afdc8f6870a0e771682c92e3ffbc728b7", null ],
      [ "getCountableActionIndex", "classNuguClientKit_1_1IRoutineManager.html#aae0a1d3b2246cb289dda798f9633866e", null ],
      [ "isActionValid", "classNuguClientKit_1_1IRoutineManager.html#a7a4aa3d6bf296530d3d110d8f09509de", null ],
      [ "isRoutineProgress", "classNuguClientKit_1_1IRoutineManager.html#a53e27e28fb0c378aa6a709d1562bb1d9", null ],
      [ "isRoutineAlive", "classNuguClientKit_1_1IRoutineManager.html#ad5d4ef321390a7bef9b8b34810e5d9cc", null ],
      [ "isActionProgress", "classNuguClientKit_1_1IRoutineManager.html#a1a7b0b30ecf6f11a233bd78bb16e0121", null ],
      [ "hasRoutineDirective", "classNuguClientKit_1_1IRoutineManager.html#a49b8da040ea7e86f563decfbe5d7a818", null ],
      [ "isConditionToStop", "classNuguClientKit_1_1IRoutineManager.html#adae0e052169017ee40925cb78f2b6a4e", null ],
      [ "isConditionToFinishAction", "classNuguClientKit_1_1IRoutineManager.html#af84dbe9a7219ac1b2c958a931db63da2", null ],
      [ "isConditionToCancel", "classNuguClientKit_1_1IRoutineManager.html#a741e18d36405d7b1adf2341c273ce055", null ],
      [ "isMuteDelayed", "classNuguClientKit_1_1IRoutineManager.html#a7f366178e2a51c359d3329e7dd6923c7", null ],
      [ "presetActionTimeout", "classNuguClientKit_1_1IRoutineManager.html#a339850ef47edf1bca2e01f567ac34b5d", null ],
      [ "setPendingStop", "classNuguClientKit_1_1IRoutineManager.html#a49b5256364b757b89f8f06202b775d5c", null ],
      [ "hasToSkipMedia", "classNuguClientKit_1_1IRoutineManager.html#af0cb143954c46dbcebd3da4e630ddaab", null ]
    ] ],
    [ "IRoutineManagerListener", "classNuguClientKit_1_1IRoutineManagerListener.html", [
      [ "~IRoutineManagerListener", "classNuguClientKit_1_1IRoutineManagerListener.html#a8b79025e61ea96d4821fb10324c5e965", null ],
      [ "onActivity", "classNuguClientKit_1_1IRoutineManagerListener.html#afe81fe525f181a9c20220bc5a5b13728", null ],
      [ "onActionTimeout", "classNuguClientKit_1_1IRoutineManagerListener.html#a64880e64da6f64ed52c6096897b4ebdf", null ]
    ] ],
    [ "RoutineActivity", "group__RoutineManagerInterface.html#ga85ba501685094b1c1d34f42229ed227b", [
      [ "IDLE", "group__RoutineManagerInterface.html#gga85ba501685094b1c1d34f42229ed227baa5daf7f2ebbba4975d61dab1c40188c7", null ],
      [ "PLAYING", "group__RoutineManagerInterface.html#gga85ba501685094b1c1d34f42229ed227ba50366a49630a416ab3ccaa004196027e", null ],
      [ "INTERRUPTED", "group__RoutineManagerInterface.html#gga85ba501685094b1c1d34f42229ed227ba658f2cadfdf09b6046246e9314f7cd43", null ],
      [ "FINISHED", "group__RoutineManagerInterface.html#gga85ba501685094b1c1d34f42229ed227ba2c616b2713e2e0aed04b4c4752c88133", null ],
      [ "STOPPED", "group__RoutineManagerInterface.html#gga85ba501685094b1c1d34f42229ed227ba09d4d696b4e935115b9313e3c412509a", null ],
      [ "SUSPENDED", "group__RoutineManagerInterface.html#gga85ba501685094b1c1d34f42229ed227ba0cb707127aebaa0023eb38363993843a", null ]
    ] ]
];