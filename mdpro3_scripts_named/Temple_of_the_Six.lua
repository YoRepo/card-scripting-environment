--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Temple of the Six  (ID: 53819808)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a "Six Samurai" monster(s) is Normal or Special Summoned, place 1 Bushido Counter on this
-- card.
-- Monsters your opponent controls lose 100 ATK for each Bushido Counter on this card.
--[[ __CARD_HEADER_END__ ]]

--六武院
function c53819808.initial_effect(c)
	c:EnableCounterPermit(0x3)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c53819808.ctop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--atk down
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetValue(c53819808.val)
	c:RegisterEffect(e4)
end
c53819808.counter_add_list={0x3}
function c53819808.ctfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x103d)
end
function c53819808.ctop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c53819808.ctfilter,1,nil) then
		e:GetHandler():AddCounter(0x3,1)
	end
end
function c53819808.val(e)
	return e:GetHandler():GetCounter(0x3)*-100
end
