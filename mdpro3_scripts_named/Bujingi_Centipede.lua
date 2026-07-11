--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Bujingi Centipede  (ID: 88940154)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level: 4
-- ATK 1700 | DEF 500
-- Setcode: 0x88
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a Beast-Warrior-Type "Bujin" monster: You can banish this card from your Graveyard,
-- then target 1 Spell/Trap Card your opponent controls; destroy that target.
-- You can only use the effect of "Bujingi Centipede" once per turn.
--[[ __CARD_HEADER_END__ ]]

--武神器－ハチ
function c88940154.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88940154,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,88940154)
	e1:SetCondition(c88940154.descon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c88940154.destg)
	e1:SetOperation(c88940154.desop)
	c:RegisterEffect(e1)
end
function c88940154.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
end
function c88940154.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c88940154.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c88940154.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c88940154.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c88940154.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c88940154.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c88940154.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c88940154.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
