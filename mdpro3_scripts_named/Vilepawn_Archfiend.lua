--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Vilepawn Archfiend  (ID: 73219648)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level: 2
-- ATK 1200 | DEF 200
-- Setcode: 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Standby Phase, you must pay 500 LP (this is not optional), or this card
-- is destroyed.
-- When resolving an opponent's card effect that targets this card, roll a six-sided die and negate
-- that effect if you roll a 3, and if you do, destroy that card.
-- Your opponent's monsters cannot attack any "Archfiend" monsters you control, except "Vilepawn
-- Archfiend".
--[[ __CARD_HEADER_END__ ]]

--ヘルポーンデーモン
function c73219648.initial_effect(c)
	--maintain
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c73219648.mtcon)
	e1:SetOperation(c73219648.mtop)
	c:RegisterEffect(e1)
	--disable and destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DICE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c73219648.disop)
	c:RegisterEffect(e2)
	--cannot be battle target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c73219648.atktg)
	c:RegisterEffect(e3)
end
function c73219648.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c73219648.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,500) or Duel.IsPlayerAffectedByEffect(tp,94585852) then
		if not Duel.IsPlayerAffectedByEffect(tp,94585852)
			or not Duel.SelectEffectYesNo(tp,e:GetHandler(),aux.Stringid(94585852,1)) then
			Duel.PayLPCost(tp,500)
		end
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
function c73219648.disop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg or not tg:IsContains(e:GetHandler()) or not Duel.IsChainDisablable(ev) then return false end
	local rc=re:GetHandler()
	local dc=Duel.TossDice(tp,1)
	if dc~=3 then return end
	if Duel.NegateEffect(ev,true) and rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
function c73219648.atktg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x45) and not c:IsCode(73219648)
end
