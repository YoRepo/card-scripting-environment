--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Alien Stealthbuster  (ID: 58066722)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 4
-- ATK 1700 | DEF 1500
-- Setcode: 0xc
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the GY: You can target 1 face-up monster on the field; place 2 A-Counters on
-- it.
-- During your Main Phase, except the turn this card was sent to the GY: You can banish this card from
-- your GY, then target 1 card with an A-Counter; destroy it.
-- You can only use each effect of "Alien Stealthbuster" once per turn.
--[[ __CARD_HEADER_END__ ]]

--エーリアン・バスター
function c58066722.initial_effect(c)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58066722,0))
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,58066722)
	e1:SetTarget(c58066722.cttg)
	e1:SetOperation(c58066722.ctop)
	c:RegisterEffect(e1)
	--destroy with counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(58066722,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,58066723)
	e2:SetCondition(aux.exccon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c58066722.destg)
	e2:SetOperation(c58066722.desop)
	c:RegisterEffect(e2)
end
c58066722.counter_add_list={0x100e}
function c58066722.ctfilter(c)
	return c:IsFaceup() and c:IsCanAddCounter(0x100e,2)
end
function c58066722.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c58066722.ctfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c58066722.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COUNTER)
	local g=Duel.SelectTarget(tp,c58066722.ctfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0)
end
function c58066722.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x100e,2)
	end
end
function c58066722.desfilter(c)
	return c:GetCounter(0x100e)>0
end
function c58066722.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c58066722.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c58066722.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c58066722.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c58066722.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
