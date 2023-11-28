import { zxcvbn, zxcvbnOptions } from "@zxcvbn-ts/core";
import * as zxcvbnCommonPackage from "@zxcvbn-ts/language-common";

const options = {
  dictionary: {
    ...zxcvbnCommonPackage.dictionary,
  },
  graphs: zxcvbnCommonPackage.adjacencyGraphs,
};

zxcvbnOptions.setOptions(options);

export default class FieldValidator {
  public static password(password: string): boolean {
    let isPasswordStrong = false;

    if (password.length >= 7) {
      const result = zxcvbn(password);
      isPasswordStrong = result.score > 2;
    }

    return isPasswordStrong;
  }
}
