--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Shreddder  (ID: 3603242)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1600 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can send 1 Machine-Type monster from your hand to the Graveyard, then target 1
-- monster your opponent controls with a Level less than or equal to the sent monster's; destroy that
-- target.
--[[ __CARD_HEADER_END__ ]]

--シュレツダー
function c3603242.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(3603242,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c3603242.descost)
	e1:SetTarget(c3603242.destg)
	e1:SetOperation(c3603242.desop)
	c:RegisterEffect(e1)
end
function c3603242.cfilter(c,tp)
	return c:IsRace(RACE_MACHINE) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingTarget(c3603242.dfilter,tp,0,LOCATION_MZONE,1,nil,c:GetLevel())
end
function c3603242.dfilter(c,lv)
	return c:IsFaceup() and c:IsLevelBelow(lv)
end
function c3603242.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c3603242.cfilter,tp,LOCATION_HAND,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c3603242.cfilter,tp,LOCATION_HAND,0,1,1,nil,tp)
	local lv=g:GetFirst():GetLevel()
	e:SetLabel(lv)
	Duel.SendtoGrave(g,REASON_COST)
end
function c3603242.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c3603242.dfilter(chkc,e:GetLabel()) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c3603242.dfilter,tp,0,LOCATION_MZONE,1,1,nil,e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c3603242.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsControler(1-tp) and tc:IsRelateToEffect(e) and tc:IsLevelBelow(e:GetLabel()) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
