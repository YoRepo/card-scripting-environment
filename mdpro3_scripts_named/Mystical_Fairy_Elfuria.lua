--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Mystical Fairy Elfuria  (ID: 85239662)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level: 3
-- ATK 1500 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can reveal 1 WIND monster in your hand; until the end of your opponent's next
-- turn, neither player can Xyz Summon using monsters with a different Level from the revealed monster
-- as Xyz Material.
--[[ __CARD_HEADER_END__ ]]

--神秘の妖精 エルフィリア
function c85239662.initial_effect(c)
	--xyz limit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85239662,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c85239662.cost)
	e2:SetOperation(c85239662.operation)
	c:RegisterEffect(e2)
end
function c85239662.cfilter(c)
	return c:IsAttribute(ATTRIBUTE_WIND) and not c:IsPublic()
end
function c85239662.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c85239662.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c85239662.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	e:SetLabel(g:GetFirst():GetLevel())
	Duel.ShuffleHand(tp)
end
function c85239662.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c85239662.target)
	e1:SetLabel(e:GetLabel())
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	e1:SetValue(1)
	Duel.RegisterEffect(e1,tp)
end
function c85239662.target(e,c)
	return not c:IsLevel(e:GetLabel()) and c:IsLevelAbove(1)
end
