/*
 * See LICENSE file in distribution for copyright and licensing information.
 */
package ioke.extensions.json;

import java.util.ArrayList;
import java.util.HashMap;

import ioke.lang.exceptions.ControlFlow;

import ioke.lang.IokeObject;
import ioke.lang.NativeMethod;
import ioke.lang.Runtime;
import ioke.lang.Text;
import ioke.lang.extensions.Extension;

/**
 * Adds native methods needed to support JSON parsing and serialization to Ioke.
 *
 * author: <a href="mailto:bragi@ragnarson.com">Łukasz Piestrzeniewicz</a>
 */
public class JSON extends Extension {
  public void Extension() {
    
  }

  @Override
  public void init(Runtime runtime) throws ControlFlow {
    runtime.text.registerMethod(runtime.newNativeMethod("Returns JSON representation of the object", new NativeMethod.WithNoArguments("toJson") {
        @Override
        public Object activate(IokeObject method, IokeObject context, IokeObject message, Object on) throws ControlFlow {
            getArguments().getEvaluatedArguments(context, message, on, new ArrayList<Object>(), new HashMap<String, Object>());
            return method.runtime.newText((org.svenson.JSON.defaultJSON()).forValue(Text.getText(on)));
        }
    }));
  }
}