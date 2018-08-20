def prob_to_succeed (dc, modifier, adv = false)
  
  dice_type = 20; # d20
  
  if(adv)
    num_dice = 2.0;
  else
    num_dice = 1.0;
  end
  
  dc = dc.to_f;
  modifier = modifier.to_f;
  
  return (1 - ((dice_type - (dice_type - dc + 1 + modifier)) / dice_type) ** num_dice);
  
end

############## Testing below ###################
#
#dc = 20.0;
#modifier = 0.0;
#
#print(prob_to_succeed(dc, modifier));