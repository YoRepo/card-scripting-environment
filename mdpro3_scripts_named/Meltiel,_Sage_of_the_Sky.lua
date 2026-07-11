--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Meltiel, Sage of the Sky  (ID: 49905576)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1600 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a Counter Trap Card is activated, immediately after it resolves, gain 1000 LP, and if you
-- do, if "The Sanctuary in the Sky" is on the field, destroy 1 card your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--天空聖者メルティウス
function c49905576.initial_effect(c)
	aux.AddCodeList(c,56433456)
	--recover&destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c49905576.drop)
	c:RegisterEffect(e1)
end
function c49905576.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_COUNTER) or not c:IsLocation(LOCATION_MZONE) or c:IsFacedown() then return end
	Duel.Recover(tp,1000,REASON_EFFECT)
	if not Duel.IsEnvironment(56433456) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
