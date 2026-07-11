--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Demise, King of Armageddon  (ID: 72426662)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 2400 | DEF 2000
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "End of the World".
-- You can pay 2000 LP; destroy all other cards on the field.
--[[ __CARD_HEADER_END__ ]]

--終焉の王デミス
function c72426662.initial_effect(c)
	aux.AddCodeList(c,8198712)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(72426662,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c72426662.cost)
	e1:SetTarget(c72426662.target)
	e1:SetOperation(c72426662.operation)
	c:RegisterEffect(e1)
end
function c72426662.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000)
	else Duel.PayLPCost(tp,2000) end
end
function c72426662.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c72426662.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	Duel.Destroy(sg,REASON_EFFECT)
end
