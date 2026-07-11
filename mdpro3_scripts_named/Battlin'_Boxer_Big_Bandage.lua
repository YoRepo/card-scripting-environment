--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Battlin' Boxer Big Bandage  (ID: 86325573)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 2
-- ATK 1100 | DEF 1400
-- Setcode: 0x1084
-- Scope: OCG / TCG
--
-- Effect Text:
-- The first time this card would be destroyed by battle each turn, it is not destroyed.
-- Once per turn: You can target 1 of your "Battlin' Boxer" monsters that is banished or in your GY,
-- that has a Level; all "Battlin' Boxer" monsters you currently control become that monster's current
-- Level.
--[[ __CARD_HEADER_END__ ]]

--BK ビッグバンテージ
function c86325573.initial_effect(c)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c86325573.valcon)
	c:RegisterEffect(e1)
	--level
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86325573,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c86325573.lvtg)
	e2:SetOperation(c86325573.lvop)
	c:RegisterEffect(e2)
end
function c86325573.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c86325573.filter(c)
	return c:GetLevel()>0 and c:IsSetCard(0x1084) and (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup())
end
function c86325573.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1084) and c:GetLevel()>0
end
function c86325573.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and chkc:IsControler(tp) and c86325573.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c86325573.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil)
		and Duel.IsExistingMatchingCard(c86325573.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c86325573.filter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil)
end
function c86325573.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local lv=tc:GetLevel()
	local g=Duel.GetMatchingGroup(c86325573.lvfilter,tp,LOCATION_MZONE,0,nil)
	local lc=g:GetFirst()
	while lc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		lc:RegisterEffect(e1)
		lc=g:GetNext()
	end
end
