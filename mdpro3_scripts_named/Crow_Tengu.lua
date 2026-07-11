--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Crow Tengu  (ID: 64806765)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Zombie
-- Level: 4
-- ATK 1400 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card in your possession is destroyed by an opponent's card effect and sent to your GY, or if
-- this card is Special Summoned from the GY: You can target 1 Attack Position monster your opponent
-- controls; destroy it.
-- You can only use this effect of "Crow Tengu" once per turn.
--[[ __CARD_HEADER_END__ ]]

--破魔のカラス天狗
function c64806765.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,64806765)
	e1:SetCondition(c64806765.descon1)
	e1:SetTarget(c64806765.destg)
	e1:SetOperation(c64806765.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c64806765.descon2)
	c:RegisterEffect(e2)
end
function c64806765.descon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousControler(tp) and c:IsReason(REASON_DESTROY)
		and c:IsReason(REASON_EFFECT) and rp==1-tp
end
function c64806765.descon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_GRAVE)
end
function c64806765.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsAttackPos() and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsAttackPos,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c64806765.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then Duel.Destroy(tc,REASON_EFFECT) end
end
