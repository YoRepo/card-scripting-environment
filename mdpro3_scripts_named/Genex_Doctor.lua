--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Genex Doctor  (ID: 89211486)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 3
-- ATK 1500 | DEF 1000
-- Setcode: 0x2
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Tribute 1 face-up "Genex Controller" to select and destroy 1 card on the field.
--[[ __CARD_HEADER_END__ ]]

--ジェネクス・ドクター
function c89211486.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89211486,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c89211486.cost)
	e1:SetTarget(c89211486.target)
	e1:SetOperation(c89211486.operation)
	c:RegisterEffect(e1)
end
function c89211486.cfilter(c)
	return c:IsFaceup() and c:IsCode(68505803)
end
function c89211486.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c89211486.cfilter,1,e:GetHandler()) end
	local sg=Duel.SelectReleaseGroup(tp,c89211486.cfilter,1,1,e:GetHandler())
	Duel.Release(sg,REASON_COST)
end
function c89211486.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c89211486.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
