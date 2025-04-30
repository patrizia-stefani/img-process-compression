function traverse = traverseTree(tree, start)
       %node = start;
       code = "";

       result = containers.Map('KeyType','int32', 'ValueType','any');
       
       %calculate tree size
       %count = 1;
       %while tree(node).child1 ~= 0
       %    count = count + 1;
       %    node = tree(node).child1;
       %end
       node = start;
       mapIndex = 1;
       queue(1,1) = -inf;
       
       while ~isempty(queue)
           while node ~= 0
               if(tree(node).child2 ~= 0)
                queue(end+1) = tree(node).child2;
               end
               if(tree(node).intensity ~= -1)
                code = strcat(code, string(tree(node).code));
                end
                keys(mapIndex) = tree(node).intensity;
                values(mapIndex) = code;
                result = containers.Map(keys, values);
                mapIndex = mapIndex + 1;
                if(tree(node).child1 == 0)
                    prev = node;
                end
 
               node = tree(node).child1;
           end
           
           node = queue(end);
         
           if(queue(end) ~= -Inf)
             code = result(tree(tree(queue(end)).parent).intensity);
           end
           %code = "";
           queue(end) = [];
       end
       traverse = result;
end