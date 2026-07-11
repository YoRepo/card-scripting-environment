--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: test-release.cdb
-- Card: Jinzo - Energy Shocker  (ID: 101306003)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 7
-- ATK 2400 | DEF 1500
-- Setcode: 0xbc
-- Scope: OCG
--
-- Effect Text:
-- This card's name becomes "Jinzo" while in the field or GY. If this card is Normal or Special
-- Summoned: You can destroy as many Traps your opponent controls as possible (if a card is Set, reveal
-- it), then this card gains 300 ATK for each card destroyed this way. You can only use this effect of
-- "Jinzo - Energy Shocker" once per turn. Your opponent cannot activate Trap Cards or effects while
-- you have another monster in your field or GY that mentions "Dark Time Wizard".
--[[ __CARD_HEADER_END__ ]]

--人造人間－サイコ・エナジー・ショッカー
local s,id,o=GetID()
function s.initial_effect(c)
	--change
	aux.EnableChangeCode(c,77585513,LOCATION_MZONE+LOCATION_GRAVE)
	aux.AddCodeList(c,101306052)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.destg)
	e1:SetOperation(s.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--cannot trigger, normal version
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,0xff)
	e3:SetCondition(s.condition)
	e3:SetTarget(s.distg)
	c:RegisterEffect(e3)
end
function s.desfilter(c)
	return c:IsType(TYPE_TRAP) or c:IsFacedown() and c:IsLocation(LOCATION_SZONE) and c:GetSequence()~=5
end
function s.qdesfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TRAP)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.desfilter,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(s.qdesfilter,tp,0,LOCATION_ONFIELD,nil)
	if sg:GetCount()>0 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	end
end
function s.cffilter(c)
	return c:IsFacedown() and c:IsLocation(LOCATION_SZONE) and c:GetSequence()~=5
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(s.cffilter,tp,0,LOCATION_ONFIELD,nil)
	if sg:GetCount()>0 then Duel.ConfirmCards(tp,sg) end
	local dg=Duel.GetMatchingGroup(Card.IsType,tp,0,LOCATION_ONFIELD,nil,TYPE_TRAP)
	if dg:GetCount()>0 then
		local atk=Duel.Destroy(dg,REASON_EFFECT)
		if atk>0 and c:IsRelateToChain() and c:IsFaceup() then
			Duel.BreakEffect()
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetValue(atk*300)
			c:RegisterEffect(e2)
		end
	end
end
function s.cfilter(c)
	return c:IsFaceupEx() and aux.IsCodeListed(c,101306052) and c:IsType(TYPE_MONSTER)
end
function s.condition(e)
	return Duel.IsExistingMatchingCard(s.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE+LOCATION_GRAVE,0,1,e:GetHandler())
end
function s.distg(e,c)
	return c:IsType(TYPE_TRAP)
end
